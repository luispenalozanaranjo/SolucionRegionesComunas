using Microsoft.AspNetCore.Mvc;
using PruebaDataAccess.Repositories;
using PruebaDataAccess.Models;

namespace WebApiService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegionController : ControllerBase
    {
        private readonly RegionRepository _regionRepository;

        public RegionController(IConfiguration configuration)
        {
            var connectionString = configuration.GetConnectionString("DefaultConnection");
            _regionRepository = new RegionRepository(connectionString);
        }

        [HttpGet]
        public ActionResult<List<RegionDTO>> GetAllRegions()
        {
            var regions = _regionRepository.GetAllRegions();
            return Ok(regions);
        }

        [HttpGet("{id}")]
        public ActionResult<RegionDTO> GetRegionById(string id)
        {
            if (!int.TryParse(id, out int regionId) || regionId <= 0)
            {
                return Ok(new RegionDTO
                {
                    IdRegion = 0,
                    Region = "Región no válida o no encontrada"
                });
            }

            var region = _regionRepository.GetRegionById(regionId);
            if (region == null)
            {
                return Ok(new RegionDTO
                {
                    IdRegion = 0,
                    Region = "Región no encontrada"
                });
            }

            return Ok(region);
        }
    }
}
