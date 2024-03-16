using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MojStomatolog.Database.Migrations
{
    public partial class AddOrderStatus : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Status",
                table: "Orders",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 1,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 21, 14, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 2,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 22, 14, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 3,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 21, 11, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 4,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 21, 10, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 5,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 22, 11, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 2, 21, 10, 41, 20, 981, DateTimeKind.Local).AddTicks(592));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 2, 21, 10, 41, 20, 981, DateTimeKind.Local).AddTicks(600));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 2, 21, 10, 41, 20, 981, DateTimeKind.Local).AddTicks(608));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 2, 21, 10, 41, 20, 981, DateTimeKind.Local).AddTicks(615));

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 1,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 2,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 3,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 4,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 5,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 6,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 7,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 8,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 9,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 10,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 11,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 12,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 13,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 14,
                column: "Status",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 15,
                column: "Status",
                value: 2);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Status",
                table: "Orders");

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 1,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 20, 14, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 2,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 21, 14, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 3,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 20, 11, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 4,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 20, 10, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 5,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 21, 11, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 19, 13, 12, 229, DateTimeKind.Local).AddTicks(7362));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 19, 13, 12, 229, DateTimeKind.Local).AddTicks(7377));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 19, 13, 12, 229, DateTimeKind.Local).AddTicks(7389));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 19, 13, 12, 229, DateTimeKind.Local).AddTicks(7402));
        }
    }
}
