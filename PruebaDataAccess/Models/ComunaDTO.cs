using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PruebaDataAccess.Models
{
    public class ComunaDTO
    {
        public int IdComuna { get; set; }
        public int IdRegion { get; set; }
        public string Comuna { get; set; }
        public string InformacionAdicional { get; set; }
    }
}
