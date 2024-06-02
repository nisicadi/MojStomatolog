using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MojStomatolog.Database.Migrations
{
    public partial class AddPayment : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PaymentId",
                table: "Orders",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "Payments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Amount = table.Column<double>(type: "float", nullable: false),
                    PaymentDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    PaymentNumber = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Payments", x => x.Id);
                });

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 1,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 29, 14, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 2,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 30, 14, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 3,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 29, 11, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 4,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 29, 10, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 5,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 30, 11, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 3, 29, 13, 29, 32, 997, DateTimeKind.Local).AddTicks(7383));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 3, 29, 13, 29, 32, 997, DateTimeKind.Local).AddTicks(7396));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 3, 29, 13, 29, 32, 997, DateTimeKind.Local).AddTicks(7405));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 3, 29, 13, 29, 32, 997, DateTimeKind.Local).AddTicks(7412));

            migrationBuilder.InsertData(
                table: "Payments",
                columns: new[] { "Id", "Amount", "PaymentDate", "PaymentNumber" },
                values: new object[,]
                {
                    { 1, 29.300000000000001, new DateTime(2023, 6, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-001" },
                    { 2, 24.100000000000001, new DateTime(2023, 7, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-002" },
                    { 3, 19.800000000000001, new DateTime(2023, 8, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-003" },
                    { 4, 32.100000000000001, new DateTime(2023, 9, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-004" },
                    { 5, 32.210000000000001, new DateTime(2023, 10, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-005" },
                    { 6, 24.800000000000001, new DateTime(2023, 11, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-006" },
                    { 7, 15.949999999999999, new DateTime(2023, 12, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-007" },
                    { 8, 27.100000000000001, new DateTime(2024, 1, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-008" },
                    { 9, 40.259999999999998, new DateTime(2024, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-009" },
                    { 10, 15.0, new DateTime(2023, 6, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-010" },
                    { 11, 19.800000000000001, new DateTime(2023, 7, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-011" },
                    { 12, 33.25, new DateTime(2023, 8, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-012" },
                    { 13, 20.41, new DateTime(2023, 9, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-013" },
                    { 14, 23.100000000000001, new DateTime(2023, 10, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-014" },
                    { 15, 28.449999999999999, new DateTime(2023, 11, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "PAY-015" }
                });

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 1,
                column: "PaymentId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 2,
                column: "PaymentId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 3,
                column: "PaymentId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 4,
                column: "PaymentId",
                value: 4);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 5,
                column: "PaymentId",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 6,
                column: "PaymentId",
                value: 6);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 7,
                column: "PaymentId",
                value: 7);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 8,
                column: "PaymentId",
                value: 8);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 9,
                column: "PaymentId",
                value: 9);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 10,
                column: "PaymentId",
                value: 10);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 11,
                column: "PaymentId",
                value: 11);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 12,
                column: "PaymentId",
                value: 12);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 13,
                column: "PaymentId",
                value: 13);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 14,
                column: "PaymentId",
                value: 14);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 15,
                column: "PaymentId",
                value: 15);

            migrationBuilder.CreateIndex(
                name: "IX_Orders_PaymentId",
                table: "Orders",
                column: "PaymentId");

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_Payments_PaymentId",
                table: "Orders",
                column: "PaymentId",
                principalTable: "Payments",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Orders_Payments_PaymentId",
                table: "Orders");

            migrationBuilder.DropTable(
                name: "Payments");

            migrationBuilder.DropIndex(
                name: "IX_Orders_PaymentId",
                table: "Orders");

            migrationBuilder.DropColumn(
                name: "PaymentId",
                table: "Orders");

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 1,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 14, 14, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 2,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 15, 14, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 3,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 14, 11, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 4,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 14, 10, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 5,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 15, 11, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 3, 14, 14, 12, 18, 112, DateTimeKind.Local).AddTicks(6545));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 3, 14, 14, 12, 18, 112, DateTimeKind.Local).AddTicks(6554));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 3, 14, 14, 12, 18, 112, DateTimeKind.Local).AddTicks(6607));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 3, 14, 14, 12, 18, 112, DateTimeKind.Local).AddTicks(6615));
        }
    }
}
