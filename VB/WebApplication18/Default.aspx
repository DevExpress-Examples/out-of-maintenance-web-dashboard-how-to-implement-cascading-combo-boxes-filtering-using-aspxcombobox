<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="WebApplication18.Default" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Dashboard.v17.2.Web, Version=17.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.DashboardWeb" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript">
        function OnSalesPersonChanged(s, e) {
            cmbCountry.PerformCallback(cmbSalesPerson.GetValue());
        }
        function OnCountryChanged(s, e) {
            cmbCity.PerformCallback(cmbCountry.GetValue() + '|' + cmbSalesPerson.GetValue());
        }
        function OnCityChanged(s, e) {
            var parameters = WebDashboard.GetParameters();
            var countryParam = parameters.GetParameterByName("CountryParam");
            var cityParam = parameters.GetParameterByName("CityParam");
            var salesPersonParam = parameters.GetParameterByName("SalesPersonParam");

            countryParam.SetValue(cmbCountry.GetValue());
            cityParam.SetValue(cmbCity.GetValue());
            salesPersonParam.SetValue(cmbSalesPerson.GetValue());
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server">
                <Items>
                    <dx:LayoutItem Caption="Sales Person">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="CmbSalesPerson" DropDownStyle="DropDownList" ClientInstanceName="cmbSalesPerson" IncrementalFilteringMode="StartsWith"
                                    TextField="Salesperson" ValueField="Salesperson" DataSourceID="SqlDataSource1"
                                    EnableSynchronization="False">
                                    <ClientSideEvents SelectedIndexChanged="OnSalesPersonChanged" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem>
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="CmbCountry" DropDownStyle="DropDownList" ClientInstanceName="cmbCountry" IncrementalFilteringMode="StartsWith" OnCallback="CmbCountry_Callback"
                                    TextField="Country" ValueField="Country" DataSourceID="SqlDataSource2"
                                    EnableSynchronization="False">
                                    <ClientSideEvents SelectedIndexChanged="OnCountryChanged" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="City">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="CmbCity" DropDownStyle="DropDownList" ClientInstanceName="cmbCity" IncrementalFilteringMode="StartsWith" OnCallback="CmbCity_Callback"
                                    TextField="City" ValueField="City" DataSourceID="SqlDataSource3"
                                    EnableSynchronization="False">
                                    <ClientSideEvents SelectedIndexChanged="OnCityChanged" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:ASPxFormLayout>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:northwind %>" SelectCommand="SELECT DISTINCT Salesperson FROM Invoices ORDER BY Salesperson"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:northwind %>" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT [Country] FROM [Invoices] WHERE (Salesperson = @Salesperson) ORDER BY Country">
                <SelectParameters>
                    <asp:Parameter Name="Salesperson" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:northwind %>" SelectCommand="SELECT DISTINCT City FROM Invoices WHERE (Country = @Country And Salesperson = @Salesperson) ORDER BY City">
                <SelectParameters>
                    <asp:Parameter Name="Country" />
                    <asp:Parameter Name="Salesperson" />
                </SelectParameters>
            </asp:SqlDataSource>

            <dx:ASPxDashboard ID="ASPxDashboard1" runat="server" ClientInstanceName="WebDashboard"></dx:ASPxDashboard>
        </div>
    </form>
</body>
</html>