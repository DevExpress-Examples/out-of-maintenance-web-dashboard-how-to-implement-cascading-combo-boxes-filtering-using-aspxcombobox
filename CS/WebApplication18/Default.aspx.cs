using DevExpress.DashboardWeb;
using System;
using System.Linq;

namespace WebApplication18 {
    public partial class Default : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            DashboardFileStorage newDashboardStorage = new DashboardFileStorage(@"~/App_Data/Dashboards");
            ASPxDashboard1.SetDashboardStorage(newDashboardStorage);
        }

        protected void CmbCountry_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e) {
            if (string.IsNullOrEmpty(e.Parameter)) return;

            SqlDataSource2.SelectParameters["Salesperson"].DefaultValue = e.Parameter;
            CmbCountry.DataBind();
        }

        protected void CmbCity_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e) {
            if (string.IsNullOrEmpty(e.Parameter)) return;

            var parameters = e.Parameter.Split('|');
            SqlDataSource3.SelectParameters["Country"].DefaultValue = parameters[0];
            SqlDataSource3.SelectParameters["Salesperson"].DefaultValue = parameters[1];
            CmbCity.DataBind();
        }
    }
}