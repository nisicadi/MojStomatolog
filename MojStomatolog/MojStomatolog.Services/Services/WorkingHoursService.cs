﻿using AutoMapper;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using iText.Layout.Properties;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.WorkingHours;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class WorkingHoursService(MojStomatologContext context, IMapper mapper)
        : BaseCrudService<WorkingHoursResponse, WorkingHours, BaseSearchObject, AddWorkingHoursRequest,
            UpdateWorkingHoursRequest>(context, mapper), IWorkingHoursService
    {
        private readonly IMapper _mapper = mapper;

        public override async Task<WorkingHoursResponse> Update(int id, UpdateWorkingHoursRequest update)
        {
            var workingHours = await Context.WorkingHours.FindAsync(id) ?? throw new Exception("Working hours not found");
            _mapper.Map(update, workingHours);

            Context.WorkingHours.Update(workingHours);

            List<Appointment> futureAppointments = await Context.Appointments
                .Where(a => a.AppointmentDateTime > DateTime.Now)
                .ToListAsync();

            List<Appointment> appointmentsToDelete = futureAppointments
                .Where(a => a.AppointmentDateTime.DayOfWeek == update.DayOfWeek)
                .ToList();

            if (!appointmentsToDelete.IsNullOrEmpty())
            {
                Context.Appointments.RemoveRange(appointmentsToDelete);
            }

            await Context.SaveChangesAsync();

            return _mapper.Map<WorkingHoursResponse>(workingHours);
        }

        public override async Task<bool> Delete(int id)
        {
            var workingHours = await Context.WorkingHours.FindAsync(id) ?? throw new Exception("Working hours not found");

            List<Appointment> futureAppointments = await Context.Appointments
                .Where(a => a.AppointmentDateTime > DateTime.Now)
                .ToListAsync();

            List<Appointment> appointmentsToDelete = futureAppointments
                .Where(a => a.AppointmentDateTime.DayOfWeek == workingHours.DayOfWeek)
                .ToList();

            if (!appointmentsToDelete.IsNullOrEmpty())
            {
                Context.Appointments.RemoveRange(appointmentsToDelete);
            }

            Context.WorkingHours.Remove(workingHours);

            await Context.SaveChangesAsync();

            return true;
        }


        public override IQueryable<WorkingHours> AddFilter(IQueryable<WorkingHours> query, BaseSearchObject? search = null)
        {
            return query.OrderBy(x => x.DayOfWeek);
        }

        public async Task<byte[]> GetPdfReportBytes()
        {
            var employees = await Context.Employees.CountAsync();
            var users = await Context.Users.CountAsync();
            var noOfAppointments = await Context.Appointments.CountAsync();
            var noOfOrders = await Context.Orders.CountAsync();

            var topSellingProductsData = await Context.OrderItems
                .Where(x => x.Product.Active)
                .GroupBy(x => x.ProductId)
                .Select(group => new
                {
                    ProductId = group.Key,
                    TotalQuantitySold = group.Sum(item => item.Quantity)
                })
                .OrderByDescending(x => x.TotalQuantitySold)
                .Take(3)
                .ToListAsync();

            var topSellingProductIds = topSellingProductsData.Select(x => x.ProductId).ToList();

            List<(Product Product, int TotalQuantitySold)> topSellingProducts = Context.Products
                .Where(x => topSellingProductIds.Contains(x.ProductId))
                .ToList()
                .Select(x => (
                    Product: x,
                    topSellingProductsData.First(data => data.ProductId == x.ProductId).TotalQuantitySold))
                .ToList();

            using MemoryStream stream = new();
            PdfWriter writer = new(stream);
            PdfDocument pdf = new(writer);

            using (Document document = new(pdf))
            {
                var title = new Paragraph("Izvještaj")
                    .SetTextAlignment(TextAlignment.CENTER)
                    .SetFontSize(20f);
                document.Add(title);

                var sectionTitleStyle = new Style()
                    .SetFontSize(16f)
                    .SetBold();
                document.Add(new Paragraph("Informacije o kompaniji").AddStyle(sectionTitleStyle));
                document.Add(new Paragraph("Broj zaposlenih: " + employees));
                document.Add(new Paragraph("Broj korisnika: " + users));
                document.Add(new Paragraph("Broj zakazanih termina: " + noOfAppointments));
                document.Add(new Paragraph("Broj narudžbi: " + noOfOrders));

                document.Add(new Paragraph("Top 3 bestsellera:").AddStyle(sectionTitleStyle));

                var table = new Table(UnitValue.CreatePercentArray([3, 2]))
                    .UseAllAvailableWidth();
                table.AddHeaderCell("Naziv").SetBold();
                table.AddHeaderCell("Prodano komada").SetBold();
                foreach ((Product Product, int TotalQuantitySold) productTuple in topSellingProducts)
                {
                    table.AddCell(productTuple.Product.Name);
                    table.AddCell(productTuple.TotalQuantitySold.ToString());
                }

                document.Add(table);
            }

            pdf.Close();
            writer.Close();

            return stream.ToArray();
        }
    }
}