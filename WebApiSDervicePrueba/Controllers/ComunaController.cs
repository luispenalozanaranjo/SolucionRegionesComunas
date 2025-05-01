using Microsoft.AspNetCore.Mvc;
using PruebaDataAccess.Repositories;
using PruebaDataAccess.Models;
using Microsoft.Extensions.Logging;
using System.Xml;
using System.Xml.Linq;

namespace WebApiSDervicePrueba.Controllers
{
    [Route("api/region/{idRegion}/comuna")]
    [ApiController]
    public class ComunaController : ControllerBase
    {
        private readonly ILogger<ComunaController> _logger;
        private readonly ComunaRepository _comunaRepository;

        public ComunaController(IConfiguration config, ILogger<ComunaController> logger)
        {
            var connectionString = config.GetConnectionString("DefaultConnection");
            _comunaRepository = new ComunaRepository(connectionString);
            _logger = logger;
        }

        // GET: api/region/1/comuna
        [HttpGet]
        public ActionResult<List<ComunaDTO>> GetComunasByRegion(int idRegion)
        {
            _logger.LogInformation("Solicitando comunas de la región {IdRegion}", idRegion);
            var comunas = _comunaRepository.GetComunasByRegion(idRegion);
            _logger.LogInformation("Se encontraron {Cantidad} comunas", comunas.Count);
            return Ok(comunas);
        }

        // GET: api/region/1/comuna/3
        [HttpGet("{idComuna}")]
        public ActionResult<ComunaDTO> GetComuna(string idRegion, string idComuna)
        {
            _logger.LogInformation("Consultando comuna con IdRegion={IdRegion} e IdComuna={IdComuna}", idRegion, idComuna);

            // Validación de que sean números enteros y positivos
            if (!int.TryParse(idRegion, out int regionId) || regionId <= 0 ||
                !int.TryParse(idComuna, out int comunaId) || comunaId <= 0)
            {
                _logger.LogWarning("Parámetros no válidos: IdRegion={IdRegion}, IdComuna={IdComuna}", idRegion, idComuna);
                return Ok(new ComunaDTO
                {
                    IdComuna = 0,
                    IdRegion = 0,
                    Comuna = "Parámetros inválidos en la solicitud, idregion o idcomuna no existe o valor no era un numero",
                    InformacionAdicional = "<info><Superficie>0</Superficie><Poblacion Densidad=\"0\">0</Poblacion></info>"
                });
            }

            // Consulta la comuna
            var comuna = _comunaRepository.GetComuna(regionId, comunaId);

            // Si no se encuentra, se retorna mensaje informativo
            if (comuna == null)
            {
                _logger.LogWarning("No se encontró la comuna {IdComuna} en región {IdRegion}", comunaId, regionId);
                return Ok(new ComunaDTO
                {
                    IdComuna = 0,
                    IdRegion = 0,
                    Comuna = "Región asociada a comuna no encontrada",
                    InformacionAdicional = "<info><Superficie>0</Superficie><Poblacion Densidad=\"0\">0</Poblacion></info>"
                });
            }

            // Retorno exitoso
            _logger.LogInformation("Comuna encontrada: {@Comuna}", comuna);
            return Ok(comuna);
        }


        // POST: api/region/1/comuna
        [HttpPost]
        public IActionResult MergeComuna(int idRegion, [FromBody] ComunaDTO comuna)
        {
            if (comuna == null || string.IsNullOrWhiteSpace(comuna.Comuna) || string.IsNullOrWhiteSpace(comuna.InformacionAdicional))
            {
                _logger.LogWarning("Datos inválidos al guardar comuna: {@Comuna}", comuna);
                return BadRequest("Datos inválidos. Error guardar Comuna.");
            }

            // Validación de caracteres válidos en el nombre de la comuna
            if (!System.Text.RegularExpressions.Regex.IsMatch(comuna.Comuna, @"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$"))
            {
                _logger.LogWarning("El nombre de la comuna contiene caracteres inválidos: {Comuna}", comuna.Comuna);
                return BadRequest("El nombre de la comuna solo puede contener letras y espacios. No se permiten números ni caracteres especiales.");
            }

            try
            {
                comuna.IdRegion = idRegion;
                bool esNueva = comuna.IdComuna == 0;

                _comunaRepository.MergeActualizarComuna(comuna);

                if (esNueva)
                {
                    _logger.LogInformation("Comuna insertada correctamente en región {IdRegion}: {@Comuna}", comuna.IdRegion, comuna);
                    return Ok(new { mensaje = "Comuna insertada correctamente." });
                }
                else
                {
                    _logger.LogInformation("Comuna {IdComuna} actualizada exitosamente en región {IdRegion}", comuna.IdComuna, comuna.IdRegion);
                    return Ok(new { mensaje = "Comuna actualizada correctamente." });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al guardar comuna {IdComuna} en región {IdRegion}", comuna.IdComuna, comuna.IdRegion);
                return StatusCode(500, "Error interno del servidor.");
            }
        }

    }
}
