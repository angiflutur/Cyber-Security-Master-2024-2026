using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using MVCStore.Data;
using MVCStore.Models;

namespace MVCStore
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddDbContext<ApplicationDbContext>(opts => {
                opts.UseSqlServer(
                builder.Configuration["ConnectionStrings:DefaultConnection"]);
            });
            builder.Services.AddScoped<IStoreRepository, EFStoreRepository>();
            builder.Services.AddDatabaseDeveloperPageExceptionFilter();

            // !!!! new/updated code {
            builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = false)
                .AddEntityFrameworkStores<ApplicationDbContext>();
            //}
            builder.Services.AddControllersWithViews();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseMigrationsEndPoint();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            // !!!! new/updated code {
            app.UseAuthentication();
            app.UseAuthorization();
            //}

            app.MapControllerRoute("pagination",
                "Products/Page{productPage}",
                new { Controller = "Home", action = "Index" });
            //}
            app.MapDefaultControllerRoute();
            // !!!! new/updated code {
            app.MapRazorPages();
            //}
            Task.Run(async () =>
            {
                await SeedDataIdentity.EnsurePopulatedAsync(app);
            }).Wait();
            app.Run();
        }
    }
}
