using MyCallFlowApi.Data;
using MyCallFlowApi.Models;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace MyCallFlowApi.Controllers
{
    public class ClientController : ApiController
    {
        // GET: api/Home
        [HttpGet]
        public async Task<string> GetTitle()
        {
            return await new Repository().GetTitle();
        }

        [HttpPost]
        public async Task<List<Client>> PostFilteredClients(SearchRequest req)
        {  
            return await new Repository().GetFilteredClients(req);
        }


        [HttpPost]
        public async Task<int> PostClient([FromBody] Client client)
        {
            if (IsClientValid(client))
                return await new Repository().PostClient(client);
            else return 0;
        }

        private bool IsClientValid(Client client)
        {
            if (client.idNumber != null &&
                client.phone != null) 
                return true;
            else return false;
        }
    }
}
