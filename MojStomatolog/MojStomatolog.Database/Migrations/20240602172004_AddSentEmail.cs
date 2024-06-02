using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MojStomatolog.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddSentEmail : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "SentEmails",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Subject = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Body = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SentEmails", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SentEmails_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId");
                });

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 6, 2, 19, 20, 3, 887, DateTimeKind.Local).AddTicks(3463));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 6, 2, 19, 20, 3, 887, DateTimeKind.Local).AddTicks(3486));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 6, 2, 19, 20, 3, 887, DateTimeKind.Local).AddTicks(3503));

            migrationBuilder.UpdateData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 6, 2, 19, 20, 3, 887, DateTimeKind.Local).AddTicks(3541));

            migrationBuilder.InsertData(
                table: "SentEmails",
                columns: new[] { "Id", "Body", "Subject", "UserId" },
                values: new object[,]
                {
                    { 1, "Vaša narudžba sa brojem 1 je uspješno kreirana.", "Narudžba kreirana", 1 },
                    { 2, "Vaša narudžba sa brojem 2 je uspješno kreirana.", "Narudžba kreirana", 2 },
                    { 3, "Vaša narudžba sa brojem 3 je uspješno kreirana.", "Narudžba kreirana", 3 },
                    { 4, "Vaša narudžba sa brojem 4 je uspješno kreirana.", "Narudžba kreirana", 1 },
                    { 5, "Vaša narudžba sa brojem 5 je uspješno kreirana.", "Narudžba kreirana", 2 },
                    { 6, "Vaša narudžba sa brojem 6 je uspješno kreirana.", "Narudžba kreirana", 3 },
                    { 7, "Vaša narudžba sa brojem 7 je uspješno kreirana.", "Narudžba kreirana", 1 },
                    { 8, "Vaša narudžba sa brojem 8 je uspješno kreirana.", "Narudžba kreirana", 2 },
                    { 9, "Vaša narudžba sa brojem 9 je uspješno kreirana.", "Narudžba kreirana", 3 },
                    { 10, "Vaša narudžba sa brojem 10 je uspješno kreirana.", "Narudžba kreirana", 1 },
                    { 11, "Vaša narudžba sa brojem 11 je uspješno kreirana.", "Narudžba kreirana", 2 },
                    { 12, "Vaša narudžba sa brojem 12 je uspješno kreirana.", "Narudžba kreirana", 1 },
                    { 13, "Vaša narudžba sa brojem 13 je uspješno kreirana.", "Narudžba kreirana", 3 },
                    { 14, "Vaša narudžba sa brojem 14 je uspješno kreirana.", "Narudžba kreirana", 2 },
                    { 15, "Vaša narudžba sa brojem 15 je uspješno kreirana.", "Narudžba kreirana", 1 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_SentEmails_UserId",
                table: "SentEmails",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "SentEmails");

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
    }
}
