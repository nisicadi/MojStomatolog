using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MojStomatolog.Database.Migrations
{
    public partial class AddMissingReferences : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "UserCreatedId",
                table: "Articles",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "EmployeeId",
                table: "Appointments",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 1,
                columns: new[] { "AppointmentDateTime", "EmployeeId" },
                values: new object[] { new DateTime(2024, 2, 20, 14, 30, 0, 0, DateTimeKind.Local), 3 });

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 2,
                columns: new[] { "AppointmentDateTime", "EmployeeId" },
                values: new object[] { new DateTime(2024, 2, 21, 14, 30, 0, 0, DateTimeKind.Local), 3 });

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 3,
                columns: new[] { "AppointmentDateTime", "EmployeeId" },
                values: new object[] { new DateTime(2024, 2, 20, 11, 30, 0, 0, DateTimeKind.Local), 4 });

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 4,
                columns: new[] { "AppointmentDateTime", "EmployeeId" },
                values: new object[] { new DateTime(2024, 2, 20, 10, 30, 0, 0, DateTimeKind.Local), 5 });

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 5,
                columns: new[] { "AppointmentDateTime", "EmployeeId" },
                values: new object[] { new DateTime(2024, 2, 21, 11, 30, 0, 0, DateTimeKind.Local), 1 });

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1,
                columns: new[] { "PublishDate", "UserCreatedId" },
                values: new object[] { new DateTime(2024, 2, 20, 15, 38, 6, 647, DateTimeKind.Local).AddTicks(4902), 4 });

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2,
                columns: new[] { "PublishDate", "UserCreatedId" },
                values: new object[] { new DateTime(2024, 2, 20, 15, 38, 6, 647, DateTimeKind.Local).AddTicks(4911), 3 });

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3,
                columns: new[] { "PublishDate", "UserCreatedId" },
                values: new object[] { new DateTime(2024, 2, 20, 15, 38, 6, 647, DateTimeKind.Local).AddTicks(4938), 5 });

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4,
                columns: new[] { "PublishDate", "UserCreatedId" },
                values: new object[] { new DateTime(2024, 2, 20, 15, 38, 6, 647, DateTimeKind.Local).AddTicks(4946), 6 });

            migrationBuilder.CreateIndex(
                name: "IX_Ratings_UserId",
                table: "Ratings",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_UserId",
                table: "Orders",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Articles_UserCreatedId",
                table: "Articles",
                column: "UserCreatedId");

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_EmployeeId",
                table: "Appointments",
                column: "EmployeeId");

            migrationBuilder.AddForeignKey(
                name: "FK_Appointments_Employees_EmployeeId",
                table: "Appointments",
                column: "EmployeeId",
                principalTable: "Employees",
                principalColumn: "EmployeeId");

            migrationBuilder.AddForeignKey(
                name: "FK_Articles_Users_UserCreatedId",
                table: "Articles",
                column: "UserCreatedId",
                principalTable: "Users",
                principalColumn: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Orders_Users_UserId",
                table: "Orders",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Ratings_Users_UserId",
                table: "Ratings",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "UserId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Appointments_Employees_EmployeeId",
                table: "Appointments");

            migrationBuilder.DropForeignKey(
                name: "FK_Articles_Users_UserCreatedId",
                table: "Articles");

            migrationBuilder.DropForeignKey(
                name: "FK_Orders_Users_UserId",
                table: "Orders");

            migrationBuilder.DropForeignKey(
                name: "FK_Ratings_Users_UserId",
                table: "Ratings");

            migrationBuilder.DropIndex(
                name: "IX_Ratings_UserId",
                table: "Ratings");

            migrationBuilder.DropIndex(
                name: "IX_Orders_UserId",
                table: "Orders");

            migrationBuilder.DropIndex(
                name: "IX_Articles_UserCreatedId",
                table: "Articles");

            migrationBuilder.DropIndex(
                name: "IX_Appointments_EmployeeId",
                table: "Appointments");

            migrationBuilder.DropColumn(
                name: "UserCreatedId",
                table: "Articles");

            migrationBuilder.DropColumn(
                name: "EmployeeId",
                table: "Appointments");

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 1,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 2, 14, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 2,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 3, 14, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 3,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 2, 11, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 4,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 2, 10, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 5,
                column: "AppointmentDateTime",
                value: new DateTime(2024, 2, 3, 11, 30, 0, 0, DateTimeKind.Local));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 2, 2, 18, 28, 56, 971, DateTimeKind.Local).AddTicks(2268));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 2, 2, 18, 28, 56, 971, DateTimeKind.Local).AddTicks(2277));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 2, 2, 18, 28, 56, 971, DateTimeKind.Local).AddTicks(2314));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 2, 2, 18, 28, 56, 971, DateTimeKind.Local).AddTicks(2328));
        }
    }
}
