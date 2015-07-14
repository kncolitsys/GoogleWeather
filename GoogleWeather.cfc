<cfcomponent>
  <cffunction name="GoogleWeather" access="public" returntype="struct">
    <cfargument name="place" required="yes" type="string">
    <cfargument name="language" required="no" type="string" default="en">
    <cfargument name="unit" required="no" type="string" default="F">

	<cfset variables.place_string = urlEncodedFormat(arguments.place)>

	<cfset variables.base_url = "http://www.google.com/ig/api?weather=" & variables.place_string & "&hl=" & arguments.language>

	<cfhttp url="#variables.base_url#" result="variables.google_weather">
	<cfset variables.google_weather_string = xmlParse(variables.google_weather.FileContent)>

	<cfset variables.weather_struct = StructNew()>
	<cfset variables.google_base_url = "http://www.google.com">
	<cfif NOT structKeyExists(variables.google_weather_string.xmlroot.weather, "problem_cause")>
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Current_Condition", variables.google_weather_string.xmlroot.weather.current_conditions.condition.xmlattributes.data)>
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Current_Temp_F", variables.google_weather_string.xmlroot.weather.current_conditions.temp_f.xmlattributes.data)>
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Current_Temp_C", variables.google_weather_string.xmlroot.weather.current_conditions.temp_c.xmlattributes.data)>
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Humidity", variables.google_weather_string.xmlroot.weather.current_conditions.humidity.xmlattributes.data)>
	  <cfset variables.temp = StructInsert(variables.weather_struct, "icon", variables.google_base_url & variables.google_weather_string.xmlroot.weather.current_conditions.icon.xmlattributes.data)>
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Wind_Condition", variables.google_weather_string.xmlroot.weather.current_conditions.wind_condition.xmlattributes.data)>
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Forecast_City", variables.google_weather_string.xmlroot.weather.forecast_information.city.xmlattributes.data)>
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Forecast_Postal_Code", variables.google_weather_string.xmlroot.weather.forecast_information.postal_code.xmlattributes.data)>  
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Forecast_Date", variables.google_weather_string.xmlroot.weather.forecast_information.forecast_date.xmlattributes.data)>  
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Forecast_date_time", variables.google_weather_string.xmlroot.weather.forecast_information.current_date_time.xmlattributes.data)>
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Forecast_Unit", variables.google_weather_string.xmlroot.weather.forecast_information.unit_system.xmlattributes.data)>
	  <cfloop from="1" to="4" index="counter">
    	<cfset variables.temp = StructInsert(variables.weather_struct, "Forecast_Condition#Counter#_day_of_week", variables.google_weather_string.xmlroot.weather.forecast_conditions[counter].day_of_week.xmlattributes.data)>
        <cfif arguments.unit is "C">
          <cfset variables.low_temp = ConvertFtoC(variables.google_weather_string.xmlroot.weather.forecast_conditions[counter].low.xmlattributes.data)>
          <cfset variables.high_temp = ConvertFtoC(variables.google_weather_string.xmlroot.weather.forecast_conditions[counter].high.xmlattributes.data)>
		<cfelse>
          <cfset variables.low_temp = variables.google_weather_string.xmlroot.weather.forecast_conditions[counter].low.xmlattributes.data>
          <cfset variables.high_temp = variables.google_weather_string.xmlroot.weather.forecast_conditions[counter].high.xmlattributes.data>
		</cfif>
	    <cfset variables.temp = StructInsert(variables.weather_struct, "Forecast_Condition#Counter#_low", variables.low_temp)>
    	<cfset variables.temp = StructInsert(variables.weather_struct, "Forecast_Condition#Counter#_high", variables.high_temp)>
	    <cfset variables.temp = StructInsert(variables.weather_struct, "Forecast_Condition#Counter#_icon", variables.google_base_url & variables.google_weather_string.xmlroot.weather.forecast_conditions[counter].icon.xmlattributes.data)>
    	<cfset variables.temp = StructInsert(variables.weather_struct, "Forecast_Condition#Counter#_condition", variables.google_weather_string.xmlroot.weather.forecast_conditions[counter].condition.xmlattributes.data)>
	  </cfloop>
      <cfset variables.temp = StructInsert(variables.weather_struct, "Status", "Good")>
	<cfelse>
	  <cfset variables.temp = StructInsert(variables.weather_struct, "Status", "Error")>
	</cfif>

	<cfreturn variables.weather_struct>
  </cffunction>
  <cffunction name="ConvertFtoC" access="private" returntype="numeric">
    <cfargument name="TempF" required="yes" type="numeric">
    
    <cfset variables.TempC = (arguments.TempF - 32) * 5 / 9>
    
    <cfreturn Round(variables.TempC)>
  </cffunction>
</cfcomponent>