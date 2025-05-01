using PruebaDataAccess.Models;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace PruebaDataAccess.Repositories
{
    public class ComunaRepository
    {
        private readonly string _connectionString;

        public ComunaRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public List<ComunaDTO> GetComunasByRegion(int idRegion)
        {
            var comunas = new List<ComunaDTO>();

            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("sp_ListarComunasPorRegion", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdRegion", idRegion);
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        comunas.Add(new ComunaDTO
                        {
                            IdComuna = (int)reader["IdComuna"],
                            IdRegion = idRegion,
                            Comuna = reader["Comuna"].ToString(),
                            InformacionAdicional = reader["InformacionAdicional"].ToString()
                        });
                    }
                }
            }

            return comunas;
        }

        public ComunaDTO GetComuna(int idRegion, int idComuna)
        {
            ComunaDTO comuna = null;

            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("sp_ObtenerComuna", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdRegion", idRegion);
                cmd.Parameters.AddWithValue("@IdComuna", idComuna);
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        comuna = new ComunaDTO
                        {
                            IdComuna = (int)reader["IdComuna"],
                            IdRegion = idRegion,
                            Comuna = reader["Comuna"].ToString(),
                            InformacionAdicional = reader["InformacionAdicional"].ToString()
                        };
                    }
                }
            }

            return comuna;
        }

        public void MergeActualizarComuna(ComunaDTO comuna)
        {
            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("sp_MergeActualizarComuna", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdRegion", comuna.IdRegion);
                cmd.Parameters.AddWithValue("@IdComuna", comuna.IdComuna);
                cmd.Parameters.AddWithValue("@Comuna", comuna.Comuna);
                cmd.Parameters.AddWithValue("@InformacionAdicional", comuna.InformacionAdicional);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}