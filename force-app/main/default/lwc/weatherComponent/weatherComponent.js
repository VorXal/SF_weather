import { LightningElement, track, wire } from 'lwc';
import getWeatherByCoordinates from '@salesforce/apex/WeatherController.getWeatherByCoordinates';

export default class WeatherComponent extends LightningElement {

    weatherResult;

    async connectedCallback(){
        const response = await fetch("https://ipinfo.io/json", {
            method: 'GET'
        });

        let location = await response.json();
        location = location.loc.split(',');
        let latitude = location[0];
        let longitude = location[1];

        this.weatherResult = await getWeatherByCoordinates({latitude: latitude, longitude: longitude});
    }


}