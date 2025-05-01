using Microsoft.AspNetCore.Mvc;
using MvcAppPrueba.Models;
using MvcAppPrueba.Services;
using System.Diagnostics;

namespace MvcAppPrueba.Controllers
{
    public class HomeController : Controller
    {
        private readonly ApiService _apiService;

        public HomeController()
        {
            _apiService = new ApiService();
        }

        public async Task<IActionResult> Index()
        {
            var regiones = await _apiService.GetRegionesAsync();
            return View(regiones);
        }

        public async Task<IActionResult> Comuna(int idRegion, string nombreRegion)
        {
            var comuna = await _apiService.GetComunasByRegionAsync(idRegion);

            // Ordenar en forma descendente por IdComuna
            var comunaOrdenada = comuna.OrderByDescending(c => c.IdComuna).ToList();

            // Procesar cada comuna para extraer los valores desde el XML
            foreach (var c in comunaOrdenada)
            {
                c.ProcesarInformacionAdicional();
            }

            ViewBag.IdRegion = idRegion;
            ViewBag.NombreRegion = nombreRegion;
            return View(comunaOrdenada);
        }

        // GET: Formulario para agregar o editar comuna
        [HttpGet]
        public async Task<IActionResult> CrearComuna(int idRegion, int? idComuna = null, string NombreRegion = "")
        {
            ViewBag.IdRegion = idRegion;
            ViewBag.NombreRegion = NombreRegion;

            if (idComuna.HasValue && idComuna > 0)
            {
                var comuna = await _apiService.GetComunaByIdAsync(idRegion, idComuna.Value);
                if (comuna != null)
                    return View(comuna);
            }

            return View(new ComunaModel { IdRegion = idRegion });
        }

        // POST: Guardar comuna (merge)
        [HttpPost]
        public async Task<IActionResult> CrearComuna(ComunaModel comunamodel, string NombreRegion)
        {
            Console.WriteLine($"ID: {comunamodel.IdComuna}, Región: {comunamodel.IdRegion}, Nombre: {comunamodel.Comuna}, Info: {comunamodel.InformacionAdicional}");

            if (!ModelState.IsValid)
            {
                ViewBag.IdRegion = comunamodel.IdRegion;
                ViewBag.NombreRegion = NombreRegion;

                // Opcional: corrige la estructura XML si está vacía
                if (string.IsNullOrWhiteSpace(comunamodel.InformacionAdicional))
                {
                    comunamodel.InformacionAdicional = "<Info><Superficie>0</Superficie><Poblacion Densidad=\"0\">0</Poblacion></Info>";
                }

                return View(comunamodel);
            }

            ViewBag.IdRegion = comunamodel.IdRegion;

            bool exito = await _apiService.MergeComunaAsync(comunamodel.IdRegion, comunamodel);
            if (exito)
            {
                comunamodel.ProcesarInformacionAdicional(); // extrae los valores desde el XML

                TempData["Mensaje"] = $"Comuna {(comunamodel.IdComuna == 0 ? "agregada" : "actualizada")} correctamente: {comunamodel.Comuna} " +
                                      $"- Superficie: {comunamodel.Superficie} km², " +
                                      $"Población: {comunamodel.Poblacion}, " +
                                      $"Densidad: {comunamodel.Densidad} hab/km²";

                return RedirectToAction("Comuna", new { idRegion = comunamodel.IdRegion, nombreRegion = NombreRegion });
            }

            ViewBag.Error = "No se pudo guardar la comuna.";
            return View(comunamodel);
        }
    }
}
