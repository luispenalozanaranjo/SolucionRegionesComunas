using Serilog;

var builder = WebApplication.CreateBuilder(args);

// Configurar Serilog para guardar logs en archivo
Log.Logger = new LoggerConfiguration()
    .WriteTo.File("Logs/log.txt", rollingInterval: RollingInterval.Day)
    .CreateLogger();

// Reemplazar el proveedor de logs por Serilog
builder.Host.UseSerilog();

// Agrega servicios al contenedor
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer(); // elemental para Swagger
builder.Services.AddSwaggerGen();           // elemental para Swagger

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

var app = builder.Build();

// Middleware de desarrollo + Swagger
app.UseSwagger();       
app.UseSwaggerUI();      // se genera /swagger

app.UseCors("AllowAll");

app.UseAuthorization();

app.MapControllers();

app.Run();