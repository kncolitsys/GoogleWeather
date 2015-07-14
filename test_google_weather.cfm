<cfif isDefined("form.place")>
    <cfif len(form.language) is 0>
	  <cfset form.language = "en">
	</cfif>
    <cfif len(form.unit) is 0>
	  <cfset form.unit = "F">
	</cfif>
	<cfinvoke component="GoogleWeather" method="GoogleWeather" returnvariable="variables.google_weather_struct">	  
	  <cfinvokeargument name="place" value="#form.place#">
	  <cfinvokeargument name="language" value="#form.language#">
      <cfinvokeargument name="unit" value="#form.unit#">
	</cfinvoke>
    
    <cfif variables.google_weather_struct.status is "Good">
      <cfoutput>
    	Date: #variables.google_weather_struct.Forecast_Date#<br />
	    City: #variables.google_weather_struct.Forecast_City#<br />
        Postal Code: #variables.google_weather_struct.Forecast_Postal_Code#<br />
        Forecast Date Time: #variables.google_weather_struct.Forecast_Date_Time#<br />
        Current Temperature (Celsius): #variables.google_weather_struct.Current_Temp_C#<br />
        Current Temperature (Fahrenheit): #variables.google_weather_struct.Current_Temp_F#<br />
        Humidity: #variables.google_weather_struct.Humidity#<br />
        Wind Condition: #variables.google_weather_struct.Wind_Condition#<br />
        Icon: <img src="#variables.google_weather_struct.icon#" border="0" />
    	<table>
	      <tr>
    	    <td>Day of Week 1</td>
            <td>#variables.google_weather_struct.Forecast_Condition1_day_of_week#</td>
	      </tr>
          <tr>
            <td>Condition 1</td>
            <td>#variables.google_weather_struct.Forecast_Condition1_condition#</td>
          </tr>
          <tr>
            <td>Low 1</td>
            <td>#variables.google_weather_struct.Forecast_Condition1_low#</td>
          </tr>
          <tr>
            <td>High 1</td>
            <td>#variables.google_weather_struct.Forecast_Condition1_High#</td>
          </tr>
          <tr>
            <td>Icon 1</td>
            <td><img src="#variables.google_weather_struct.Forecast_Condition1_icon#" border="0" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
	      <tr>
    	    <td>Day of Week 2</td>
            <td>#variables.google_weather_struct.Forecast_Condition2_day_of_week#</td>
	      </tr>
          <tr>
            <td>Condition 2</td>
            <td>#variables.google_weather_struct.Forecast_Condition2_condition#</td>
          </tr>
          <tr>
            <td>Low 2</td>
            <td>#variables.google_weather_struct.Forecast_Condition2_low#</td>
          </tr>
          <tr>
            <td>High 2</td>
            <td>#variables.google_weather_struct.Forecast_Condition2_High#</td>
          </tr>
          <tr>
            <td>Icon 2</td>
            <td><img  src="#variables.google_weather_struct.Forecast_Condition2_icon#" border="0" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
	      <tr>
    	    <td>Day of Week 3</td>
            <td>#variables.google_weather_struct.Forecast_Condition3_day_of_week#</td>
	      </tr>
          <tr>
            <td>Condition 3</td>
            <td>#variables.google_weather_struct.Forecast_Condition3_condition#</td>
          </tr>
          <tr>
            <td>Low 3</td>
            <td>#variables.google_weather_struct.Forecast_Condition3_low#</td>
          </tr>
          <tr>
            <td>High 3</td>
            <td>#variables.google_weather_struct.Forecast_Condition3_High#</td>
          </tr>
          <tr>
            <td>Icon 3</td>
            <td><img src="#variables.google_weather_struct.Forecast_Condition3_icon#" border="0" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
	      <tr>
    	    <td>Day of Week 4</td>
            <td>#variables.google_weather_struct.Forecast_Condition4_day_of_week#</td>
	      </tr>
          <tr>
            <td>Condition 4</td>
            <td>#variables.google_weather_struct.Forecast_Condition4_condition#</td>
          </tr>
          <tr>
            <td>Low 4</td>
            <td>#variables.google_weather_struct.Forecast_Condition4_low#</td>
          </tr>
          <tr>
            <td>High 4</td>
            <td>#variables.google_weather_struct.Forecast_Condition4_High#</td>
          </tr>
          <tr>
            <td>Icon 4</td>
            <td><img src="#variables.google_weather_struct.Forecast_Condition4_icon#" border="0" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
    	</table>
      </cfoutput>
	<cfelse>
      No results.
	</cfif>
    <hr />
    <cfdump var="#variables.google_weather_struct#">
</cfif>

<form action="test_google_weather.cfm" method="post">
  <table>
    <tr>
      <td>Place</td>
      <td><input type="text" name="place" size="30" /></td>
    </tr>
    <tr>
      <td>Language (ISO 639-1 Language Code)</td>
      <td><input type="text" name="language" size="10" /></td>
    </tr>
    <tr>
      <td>Unit</td>
      <td>
      	<select name="unit">
          <option value="F">Fahrenheit</option>
          <option value="C">Celsius</option>
        </select>
      </td>
    </tr>
    <tr>
      <td><input type="submit" value="Submit" /></td>
    </tr>
  </table>
</form>