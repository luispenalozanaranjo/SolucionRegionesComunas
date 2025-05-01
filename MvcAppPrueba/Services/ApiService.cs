
using MvcAppPrueba.Models;
using System.Text;
using System.Text.Json;

namespace MvcAppPrueba.Services
{
    public class ApiService
    {
        private readonly HttpClient _httpClient;
        private readonly string _apiBaseUrl = Environment.GetEnvironmentVariable("API_BASE_URL") ?? throw new Exception("API_BASE_URL no esta definida");

        public ApiService()
        {
            _httpClient = new HttpClient();
        }

        public async Task<List<RegionModel>> GetRegionesAsync()
        {
            var response = await _httpClient.GetAsync($"{_apiBaseUrl}/region");
            if (response.IsSuccessStatusCode)
            {
                var json = await response.Content.ReadAsStringAsync();
                return JsonSerializer.Deserialize<List<RegionModel>>(json, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
            }
            return new List<RegionModel>();
        }

        public async Task<List<ComunaModel>> GetComunasByRegionAsync(int idRegion)
        {
            var response = await _httpClient.GetAsync($"{_apiBaseUrl}/region/{idRegion}/comuna");
            if (response.IsSuccessStatusCode)
            {
                var json = await response.Content.ReadAsStringAsync();
                return JsonSerializer.Deserialize<List<ComunaModel>>(json, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
            }
            return new List<ComunaModel>();
        }

        public async Task<ComunaModel?> GetComunaByIdAsync(int idRegion, int idComuna)
        {
            var response = await _httpClient.GetAsync($"{_apiBaseUrl}/region/{idRegion}/comuna/{idComuna}");

            if (response.IsSuccessStatusCode)
            {
                var json = await response.Content.ReadAsStringAsync();
                return JsonSerializer.Deserialize<ComunaModel>(json, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
            }

            return null;
        }

        public async Task<bool> MergeComunaAsync(int idRegion, ComunaModel comuna)
        {
            var json = JsonSerializer.Serialize(comuna, new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            });

            var content = new StringContent(json, Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync($"{_apiBaseUrl}/region/{idRegion}/comuna", content);
            return response.IsSuccessStatusCode;
        }
    }
}
