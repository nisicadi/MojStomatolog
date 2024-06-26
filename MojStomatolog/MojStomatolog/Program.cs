using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using MojStomatolog;
using MojStomatolog.Database;
using MojStomatolog.Services.Common.RecommenderModel;
using MojStomatolog.Services.Interfaces;
using MojStomatolog.Services.Services;
#pragma warning disable CA1825
#pragma warning disable CA1861

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddSingleton<ModelTrainingService>();

builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IEmployeeService, EmployeeService>();
builder.Services.AddTransient<IProductService, ProductService>();
builder.Services.AddTransient<IAppointmentService, AppointmentService>();
builder.Services.AddTransient<IArticleService, ArticleService>();
builder.Services.AddTransient<IWorkingHoursService, WorkingHoursService>();
builder.Services.AddTransient<IOrderService, OrderService>();
builder.Services.AddTransient<IRatingService, RatingService>();
builder.Services.AddTransient<IProductCategoryService, ProductCategoryService>();
builder.Services.AddTransient<IServiceService, ServiceService>();
builder.Services.AddTransient<IPaymentService, PaymentService>();
builder.Services.AddTransient<ISentEmailService, SentEmailService>();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new OpenApiSecurityScheme
    {
        Type = SecuritySchemeType.Http,
        Scheme = "basic"
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "basicAuth"
                }
            },
            new string[]{}
        }
    });
});

builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<CustomAuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<MojStomatologContext>(options =>
    options.UseSqlServer(connectionString));

// AutoMapper
builder.Services.AddAutoMapper(typeof(IUserService));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors(x => x
    .AllowAnyMethod()
    .AllowAnyHeader()
    .SetIsOriginAllowed(_ => true) // allow any origin  
    .AllowCredentials());

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateAsyncScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<MojStomatologContext>();
    dataContext.Database.Migrate();
}

// Load or train Recommender model
var modelTrainingService = app.Services.GetRequiredService<ModelTrainingService>();
modelTrainingService.GetTrainedModel();

app.Run();
