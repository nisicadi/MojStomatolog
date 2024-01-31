using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using iText.Layout.Properties;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class CompanySettingService : ICompanySettingService
    {
        private readonly MojStomatologContext _context;

        public CompanySettingService(MojStomatologContext context)
        {
            _context = context;
        }
        public async Task<CompanySetting> AddOrUpdate(CompanySetting request)
        {
            var entity = await _context.CompanySettings
                .FirstOrDefaultAsync(x => x.SettingName == request.SettingName);

            if (entity == null)
            {
                await _context.CompanySettings.AddAsync(request);
            }
            else
            {
                entity.SettingValue = request.SettingValue;
                _context.CompanySettings.Update(entity);
            }

            await _context.SaveChangesAsync();
            return await GetBySettingName(request.SettingName);
        }

        public async Task<CompanySetting> GetBySettingName(string name)
        {
            return await _context.CompanySettings.FirstOrDefaultAsync(x => x.SettingName == name) ?? new CompanySetting();
        }

        public async Task<byte[]> GetPdfReportBytes()
        {
            var employees = await _context.Employees.CountAsync();
            var users = await _context.Users.CountAsync();
            var noOfAppointments = await _context.Appointments.CountAsync();
            var noOfOrders = await _context.Orders.CountAsync();

            var topSellingProductsData = await _context.OrderItems
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

            var topSellingProducts = _context.Products
                .Where(x => topSellingProductIds.Contains(x.ProductId))
                .ToList()
                .Select(x => (
                    Product: x,
                    TotalQuantitySold: topSellingProductsData.First(data => data.ProductId == x.ProductId).TotalQuantitySold))
                .ToList();

            using var stream = new MemoryStream();
            var writer = new PdfWriter(stream);
            var pdf = new PdfDocument(writer);

            using (var document = new Document(pdf))
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

                var table = new Table(UnitValue.CreatePercentArray(new float[] { 3, 2 }))
                    .UseAllAvailableWidth();
                table.AddHeaderCell("Naziv").SetBold();
                table.AddHeaderCell("Prodano komada").SetBold();
                foreach (var productTuple in topSellingProducts)
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