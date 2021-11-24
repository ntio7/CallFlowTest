using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MyCallFlowApi.Models
{
    public class Client
    {
        public int? Id { get; set; }

        [Required(ErrorMessage = "חובה להזין תעודת זהות.")]
        public string idNumber { get; set; }

        [Required(ErrorMessage = "חובה להזין מספר טלפון.")]
        public string phone { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string DateOfBirth { get; set; }
        public string comments { get; set; }

    }
}