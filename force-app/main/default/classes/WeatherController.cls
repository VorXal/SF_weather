public with sharing class WeatherController {

    public WeatherController(){}

    @AuraEnabled
    public static string getWeatherByCoordinates(String latitude, String longitude){

        try {

            String API_key = 'dce9c9edc46284d1d061142cc4b8df2e';
            String URL = 'https://api.openweathermap.org/data/2.5/weather?lat=' + latitude  +
                            '&lon=' + longitude + '&appid=' + API_key;
        
            Http http = new Http();
		    HttpRequest request = new HttpRequest();
		    request.setEndpoint(URL);
		    request.setMethod('GET');
		    HttpResponse response = http.send(request);

		    if (response.getStatusCode() == 200) {
    	    	Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                Map<String, Object> main = (Map<String, Object>)results.get('main');

                return String.ValueOf(Integer.valueOf(main.get('temp')) - 273.15); //because temperature in kelvins
            } else {
                return '0,0';
            }
        
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}