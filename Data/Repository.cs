using MyCallFlowApi.Models;

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace MyCallFlowApi.Data
{
    public class Repository
    {
        public string cs
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["CS"].ConnectionString;
            }
        }

        public async Task<string> GetTitle()
        {

            DataSet ds = await DAL.FilldataAsync(cs, "SP_GetTitle");
            return ds.Tables[0].Rows[0]["Title"].ToString();
        }



        public async Task<int> PostClient(Client client)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("idNumber", client.idNumber));
            param.Add(new SqlParameter("phone", client.phone));
            param.Add(new SqlParameter("firstName", client.firstName == null ? "" : client.firstName));
            param.Add(new SqlParameter("lastName", client.lastName == null ? "" : client.lastName));
            param.Add(new SqlParameter("DateOfBirth", client.DateOfBirth == null ? "" : client.DateOfBirth));
            param.Add(new SqlParameter("comments", client.comments == null ? "" : client.comments));

            DataSet ds = await DAL.FilldataAsync(cs, "SP_CreateUser", param);
            return Convert.ToInt32(ds.Tables[0].Rows[0]["status"]);
        }

        public async Task<List<Client>> GetFilteredClients(SearchRequest req)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("searchParam", req.searchParam));
            param.Add(new SqlParameter("searchValue", req.searchValue));

            DataSet ds = await DAL.FilldataAsync(cs, "SP_getFilteredClients", param);
            List<Client> clients = new List<Client>();
            try
            {

                clients = ds.Tables[0].AsEnumerable()
                     .Select(row => new Client
                     {
                         Id = Convert.ToInt32(row["Id"]),
                         idNumber = row["idNumber"].ToString(),
                         phone = row["phone"].ToString(),
                         firstName = row["firstName"].ToString(),
                         lastName = row["lastName"].ToString(),
                         DateOfBirth = (Convert.ToDateTime(row["DateOfBirth"])).ToString("MM/dd/yyyy"),
                         comments = row["comments"].ToString(),
                     }).ToList();

            }
            catch (Exception ex)
            {

                throw;
            }

            // JsonConvert.SerializeObject(clients)
            return clients;
        }

    }
}