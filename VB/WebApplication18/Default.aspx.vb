Imports DevExpress.DashboardWeb
Imports System
Imports System.Linq

Namespace WebApplication18
    Partial Public Class [Default]
        Inherits System.Web.UI.Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
            Dim newDashboardStorage As New DashboardFileStorage("~/App_Data/Dashboards")
            ASPxDashboard1.SetDashboardStorage(newDashboardStorage)
        End Sub

        Protected Sub CmbCountry_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.CallbackEventArgsBase)
            If String.IsNullOrEmpty(e.Parameter) Then
                Return
            End If

            SqlDataSource2.SelectParameters("Salesperson").DefaultValue = e.Parameter
            CmbCountry.DataBind()
        End Sub

        Protected Sub CmbCity_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.CallbackEventArgsBase)
            If String.IsNullOrEmpty(e.Parameter) Then
                Return
            End If

            Dim parameters = e.Parameter.Split("|"c)
            SqlDataSource3.SelectParameters("Country").DefaultValue = parameters(0)
            SqlDataSource3.SelectParameters("Salesperson").DefaultValue = parameters(1)
            CmbCity.DataBind()
        End Sub
    End Class
End Namespace