using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace MyCallFlowApi.Data
{

    public class DAL
    {
        public static Task<DataSet> FilldataAsync(string ConnectionString, string StoredProcedureName)
        {

            try
            {

                SqlCommand cmd = new SqlCommand();
                SqlConnection Cnn = new SqlConnection(ConnectionString);
                cmd.Connection = Cnn;
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 180;

                return Task.Run(() =>
                {

                    using (var da = new SqlDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        da.SelectCommand.CommandTimeout = 15000;
                        da.Fill(ds);
                        return ds;
                    }
                });
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public static async Task<DataSet> FilldataAsync(string ConnectionString, string StoredProcedureName, IList<SqlParameter> sqlParameters)
        {

            try
            {

                SqlCommand cmd = new SqlCommand();
                SqlConnection Cnn = new SqlConnection(ConnectionString);
                cmd.Connection = Cnn;
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 180;

                if (sqlParameters != null)
                {
                    foreach (var sqlParam in sqlParameters)
                    {
                        cmd.Parameters.Add(sqlParam);
                    }
                }


                return await Task.Run(() =>
                {

                    using (var da = new SqlDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        da.SelectCommand.CommandTimeout = 15000;
                        da.Fill(ds);
                        return ds;
                    }
                });
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public static async Task<int> ExecuteNonQueryAsync(string ConnectionString, string StoredProcedureName, List<SqlParameter> sqlParameter)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection Cnn = new SqlConnection(ConnectionString);
            cmd.Connection = Cnn;
            cmd.CommandText = StoredProcedureName;
            cmd.CommandType = CommandType.StoredProcedure;
            int RowsAffected;

            foreach (var p in sqlParameter)
            {
                cmd.Parameters.Add(p);
            }

            try
            {
                cmd.Connection.Open();
                RowsAffected = await cmd.ExecuteNonQueryAsync();
                cmd.Parameters.Clear();
                cmd.Connection.Close();
                cmd = null;
                Cnn = null;
            }
            catch (Exception)
            {
                cmd.Parameters.Clear();
                cmd.Connection.Close();
                cmd = null;
                Cnn = null;
                throw;
            }

            return RowsAffected;
        }
     
    }
}