public with sharing class WeatherAPI {

    public static String WEATHER_API_KEY = '219dfccb6014896b06a4adae75e093af';

    public static void fetchWeatherData(String CityName){
        
        String endPoint = 'https://api.openweathermap.org/data/2.5/weather?q='+EncodingUtil.urlEncode(cityName, 'UTF-8')+'&appid='+WEATHER_API_KEY;
        System.debug('endPoint: '+endPoint);
        
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint(endPoint);
        httpRequest.setMethod('GET');
        httpRequest.setTimeout(2000);
        
        Http http = new Http();
        httpResponse httpResponse = http.send(httpRequest);
        System.debug('status code: '+httpResponse.getStatusCode());
        if(httpResponse.getStatusCode()==200){
            System.debug('body: ' + httpResponse.getBody());
            WeatherAPI weatherRes = (WeatherAPI) JSON.deserialize(httpResponse.getBody(), WeatherAPI.class);
            System.debug('weatherRes : ' + weatherRes);
            // Convert temperature from Kelvin to Celsius
            //Decimal tempCelsius = weatherRes.main.temp - 273.15;
            
            //Create weather record
            //Weather__c weatherRecord = new Weather__c();
            //weatherRecord.Temperature__c = tempCelsius.setScale(2);
            //weatherRecord.Description__c = weatherRes.weather[0].description;
            
            //insert weatherRecord;
            //System.debug('Weather record created for city: ' + cityName);
        } else {
                System.debug('Error from API: ' + httpResponse.getStatusCode() + ' - ' + httpResponse.getBody());
        }
        
    }

}