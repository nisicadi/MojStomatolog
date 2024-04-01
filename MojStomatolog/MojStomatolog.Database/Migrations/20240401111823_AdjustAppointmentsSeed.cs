using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MojStomatolog.Database.Migrations
{
    public partial class AdjustAppointmentsSeed : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 1,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 15, 14, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 2,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 16, 9, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 3,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 17, 11, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 4,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 18, 10, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 5,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 3, 19, 14, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 4, 1, 13, 18, 22, 32, DateTimeKind.Local).AddTicks(1327));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 4, 1, 13, 18, 22, 32, DateTimeKind.Local).AddTicks(1341));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 4, 1, 13, 18, 22, 32, DateTimeKind.Local).AddTicks(1350));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 4, 1, 13, 18, 22, 32, DateTimeKind.Local).AddTicks(1359));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
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
        }
    }
}
