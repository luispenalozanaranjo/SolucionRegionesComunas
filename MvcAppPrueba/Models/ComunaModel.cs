using System.ComponentModel.DataAnnotations;
using System.Xml.Linq;

namespace MvcAppPrueba.Models
{
    public class ComunaModel
    {
        public int IdComuna { get; set; }
        public int IdRegion { get; set; }

        [Required(ErrorMessage = "El nombre de la comuna es obligatorio.")]
        [StringLength(128, ErrorMessage = "El nombre de la comuna no debe superar los 128 caracteres.")]
        [RegularExpression(@"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$", ErrorMessage = "El nombre de la comuna solo puede contener letras y espacios.")]
        public string Comuna { get; set; } = string.Empty;

        [Required(ErrorMessage = "Debe ingresar la información adicional en formato XML.")]
        public string InformacionAdicional { get; set; } = string.Empty;

        // Propiedades adicionales para mostrar los valores extraídos del XML
        public string Superficie { get; set; } = "0";
        public string Densidad { get; set; } = "0";
        public string Poblacion { get; set; } = "0";

        public void ProcesarInformacionAdicional()
        {
            try
            {
                var xml = XElement.Parse(InformacionAdicional);

                var superficie = xml.Element("Superficie")?.Value ?? "0";
                var poblacionEl = xml.Element("Poblacion");
                var densidad = poblacionEl?.Attribute("Densidad")?.Value ?? "0";
                var poblacion = poblacionEl?.Value ?? "0";

                Superficie = superficie;
                Densidad = densidad;
                Poblacion = poblacion;
            }
            catch
            {
                Superficie = Densidad = Poblacion = "0";
            }
        }
    }
}
