using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MojStomatolog.Database.Migrations
{
    public partial class AddService : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ServiceId",
                table: "Appointments",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "Service",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Service", x => x.Id);
                });

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 18, 8, 38, 483, DateTimeKind.Local).AddTicks(2534));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 18, 8, 38, 483, DateTimeKind.Local).AddTicks(2547));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 18, 8, 38, 483, DateTimeKind.Local).AddTicks(2559));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 18, 8, 38, 483, DateTimeKind.Local).AddTicks(2570));

            migrationBuilder.UpdateData(
                table: "ProductCategories",
                keyColumn: "ProductCategoryId",
                keyValue: 1,
                column: "Name",
                value: "Četkica za zube");

            migrationBuilder.InsertData(
                table: "Service",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Liječenje karijesa" },
                    { 2, "Parodontologija" },
                    { 3, "Protetika" },
                    { 4, "Pregled" },
                    { 5, "Preventivna stomatologija" }
                });

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 1,
                column: "ServiceId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 2,
                column: "ServiceId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 3,
                column: "ServiceId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 4,
                column: "ServiceId",
                value: 4);

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 5,
                column: "ServiceId",
                value: 5);

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_ServiceId",
                table: "Appointments",
                column: "ServiceId");

            migrationBuilder.AddForeignKey(
                name: "FK_Appointments_Service_ServiceId",
                table: "Appointments",
                column: "ServiceId",
                principalTable: "Service",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Appointments_Service_ServiceId",
                table: "Appointments");

            migrationBuilder.DropTable(
                name: "Service");

            migrationBuilder.DropIndex(
                name: "IX_Appointments_ServiceId",
                table: "Appointments");

            migrationBuilder.DropColumn(
                name: "ServiceId",
                table: "Appointments");

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 15, 38, 6, 647, DateTimeKind.Local).AddTicks(4902));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 15, 38, 6, 647, DateTimeKind.Local).AddTicks(4911));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 15, 38, 6, 647, DateTimeKind.Local).AddTicks(4938));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 2, 20, 15, 38, 6, 647, DateTimeKind.Local).AddTicks(4946));

            migrationBuilder.UpdateData(
                table: "ProductCategories",
                keyColumn: "ProductCategoryId",
                keyValue: 1,
                column: "Name",
                value: "četkica za zube");
        }
    }
}
