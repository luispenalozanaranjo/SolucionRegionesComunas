using PruebaDataAccess.Models;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace PruebaDataAccess.Repositories
{
    public class RegionRepository
    {
        private readonly string _connectionString;

        public RegionRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public List<RegionDTO> GetAllRegions()
        {
            var regions = new List<RegionDTO>();

            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("sp_ListarRegiones", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        regions.Add(new RegionDTO
                        {
                            IdRegion = (int)reader["IdRegion"],
                            Region = reader["Region"].ToString()
                        });
                    }
                }
            }

            return regions;
        }

        public RegionDTO GetRegionById(int id)
        {
            RegionDTO region = null;

            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("sp_ObtenerRegion", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdRegion", id);
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        region = new RegionDTO
                        {
                            IdRegion = (int)reader["IdRegion"],
                            Region = reader["Region"].ToString()
                        };
                    }
                }
            }

            return region;
        }
    }
}