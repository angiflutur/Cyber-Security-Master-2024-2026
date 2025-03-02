using System.Diagnostics;
using CourseInvites.Models;
using Microsoft.AspNetCore.Mvc;

namespace CourseInvites.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }
        
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public IActionResult RsvpForm()
        {
            return View();
        }

        [HttpPost]
        public IActionResult RsvpForm(GuestResponse guestResponse)
        {
            if (ModelState.IsValid)
            {
                Repository.AddResponse(guestResponse);
                //nu se retrimite formularul daca facem refresh
                return RedirectToAction(nameof(Thanks),
                    new {WillAttend = guestResponse.WillAttend });
                //return View("Thanks", guestResponse);
            }
            else
            {
                // there is a validation error 
                return View();
            }
        }
        public IActionResult Thanks(bool willAttend)
        {
            var response = new GuestResponse { WillAttend = willAttend };
            return View(response);
        }
        public IActionResult ListResponses()
        {
            return View(Repository.Responses.Where(r => r.WillAttend == true));
        }
    }
}
