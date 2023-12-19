Class LEARNING.WS.Service Extends %CSP.REST
{

Parameter CHARSET = "utf-8";

Parameter CONVERTINPUTSTREAM = 1;

Parameter CONTENTTYPE = "application/json";

Parameter HandleCorsRequest = 0;

XData UrlMap [ XMLNamespace = "https://www.intersystems.com/urlmap" ]
{
<Routes>
	<Route Url="/getVivienda/:id" Method="GET" Call="GetVivienda" />
	<Route Url="/saveVivienda" Method="POST" Call="SaveVivienda" />
    <Route Url="/savePlano" Method="POST" Call="SavePlano" />
    <Route Url="/saveComercial" Method="POST" Call="SaveComercial" />
    <Route Url="/saveCiudad" Method="POST" Call="SaveCiudad" />
</Routes>
}

ClassMethod OnHandleCorsRequest(url As %String) As %Status
{
	set url = %request.GetCgiEnv("HTTP_REFERER")
    set origin = $p(url,"/",1,3) // origin = "http(s)://origin.com:port"

    // here you can check specific origins
    // otherway, it will allow all origins (useful while developing only)

	do %response.SetHeader("Access-Control-Allow-Credentials","true")
	do %response.SetHeader("Access-Control-Allow-Methods","GET,POST,PUT,DELETE,OPTIONS")
	do %response.SetHeader("Access-Control-Allow-Origin",origin)
	do %response.SetHeader("Access-Control-Allow-Headers","Access-Control-Allow-Origin, Origin, X-Requested-With, Content-Type, Accept, Authorization, Cache-Control")
	quit $$$OK
}

// Class method to retrieve the data of a person filtered by PersonId

ClassMethod GetVivienda(id As %Integer) As %Status
{
    Try {
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
    
        //CODE
    
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        Do ##class(%REST.Impl).%WriteResponse(ex.DisplayString())
        return {"errormessage": "Client error"}
    }
    Quit $$$OK
}

// Class method to receive real estate data to persist in our database

ClassMethod SaveVivienda() As %Status
{
    Try {
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
    
        //CODE
    
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        Do ##class(%REST.Impl).%WriteResponse(ex.DisplayString())
        return {"errormessage": "Client error"}
    }
}

ClassMethod SavePlano() As %Status
{
    Try {
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
    
        //CODE
    
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        Do ##class(%REST.Impl).%WriteResponse(ex.DisplayString())
        return {"errormessage": "Client error"}
    }
}

ClassMethod SaveComercial() As %Status
{
    Try {
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
    
        //CODE
    
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        Do ##class(%REST.Impl).%WriteResponse(ex.DisplayString())
        return {"errormessage": "Client error"}
    }
}

ClassMethod SaveCiudad() As %Status
{
    Try {
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
    
        //CODE
    
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        Do ##class(%REST.Impl).%WriteResponse(ex.DisplayString())
        return {"errormessage": "Client error"}
    }
}

}
