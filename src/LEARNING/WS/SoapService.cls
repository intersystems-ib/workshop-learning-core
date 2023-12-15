Class LEARNING.WS.SoapService Extends %SOAP.WebService
{

Parameter SERVICENAME = "SoapService";

Parameter NAMESPACE = "http://localhost:52774/csp/learning";

Parameter USECLASSNAMESPACES = 1;

Method SaveVivienda(vivienda As LEARNING.Object.Vivienda) As %Integer [ WebMethod ]
{
        set sc = vivienda.%Save()
        Quit vivienda.%Id()
}

}
