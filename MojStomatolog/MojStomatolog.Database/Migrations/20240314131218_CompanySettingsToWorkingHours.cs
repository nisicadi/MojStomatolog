using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MojStomatolog.Database.Migrations
{
    public partial class CompanySettingsToWorkingHours : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CompanySettings");

            migrationBuilder.CreateTable(
                name: "WorkingHours",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DayOfWeek = table.Column<int>(type: "int", nullable: false),
                    StartTime = table.Column<TimeSpan>(type: "time", nullable: false),
                    EndTime = table.Column<TimeSpan>(type: "time", nullable: false),
                    BreakStartTime = table.Column<TimeSpan>(type: "time", nullable: false),
                    BreakEndTime = table.Column<TimeSpan>(type: "time", nullable: false),
                    UserModifiedId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_WorkingHours", x => x.Id);
                    table.ForeignKey(
                        name: "FK_WorkingHours_Users_UserModifiedId",
                        column: x => x.UserModifiedId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                });

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

            migrationBuilder.InsertData(
                table: "WorkingHours",
                columns: new[] { "Id", "BreakEndTime", "BreakStartTime", "DayOfWeek", "EndTime", "StartTime", "UserModifiedId" },
                values: new object[,]
                {
                    { 1, new TimeSpan(0, 14, 0, 0, 0), new TimeSpan(0, 13, 0, 0, 0), 1, new TimeSpan(0, 18, 0, 0, 0), new TimeSpan(0, 9, 0, 0, 0), null },
                    { 2, new TimeSpan(0, 14, 0, 0, 0), new TimeSpan(0, 13, 0, 0, 0), 2, new TimeSpan(0, 18, 0, 0, 0), new TimeSpan(0, 9, 0, 0, 0), null },
                    { 3, new TimeSpan(0, 14, 0, 0, 0), new TimeSpan(0, 13, 0, 0, 0), 3, new TimeSpan(0, 18, 0, 0, 0), new TimeSpan(0, 9, 0, 0, 0), null },
                    { 4, new TimeSpan(0, 14, 0, 0, 0), new TimeSpan(0, 13, 0, 0, 0), 4, new TimeSpan(0, 18, 0, 0, 0), new TimeSpan(0, 9, 0, 0, 0), null },
                    { 5, new TimeSpan(0, 14, 0, 0, 0), new TimeSpan(0, 13, 0, 0, 0), 5, new TimeSpan(0, 18, 0, 0, 0), new TimeSpan(0, 9, 0, 0, 0), null },
                    { 6, new TimeSpan(0, 13, 0, 0, 0), new TimeSpan(0, 12, 0, 0, 0), 6, new TimeSpan(0, 15, 0, 0, 0), new TimeSpan(0, 9, 0, 0, 0), null },
                    { 7, new TimeSpan(0, 13, 0, 0, 0), new TimeSpan(0, 12, 0, 0, 0), 0, new TimeSpan(0, 15, 0, 0, 0), new TimeSpan(0, 9, 0, 0, 0), null }
                });

            migrationBuilder.CreateIndex(
                name: "IX_WorkingHours_UserModifiedId",
                table: "WorkingHours",
                column: "UserModifiedId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "WorkingHours");

            migrationBuilder.CreateTable(
                name: "CompanySettings",
                columns: table => new
                {
                    SettingId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SettingName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    SettingValue = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CompanySettings", x => x.SettingId);
                });

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

            migrationBuilder.InsertData(
                table: "CompanySettings",
                columns: new[] { "SettingId", "SettingName", "SettingValue" },
                values: new object[] { 1, "WorkingHours", "08:30-18:00" });
        }
    }
}
