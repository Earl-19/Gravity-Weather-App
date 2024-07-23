String getWeatherIcon(String condition) {
  switch (condition) {
    case 'Clear':
      return 'lib/assets/sunny-day.svg';
    case 'Clouds':
      return 'lib/assets/cloud-view.svg';
    case 'Rain':
      return 'lib/assets/icon-rain.svg';
    case 'Drizzle':
      return 'lib/assets/rainbow.svg';
    case 'Thunderstorm':
      return 'lib/assets/reshot-icon-weather-YRQ52EZUTW.svg';
    case 'Snow':
      return 'lib/assets/rainbow.svg';
    case 'Mist':
    case 'Smoke':
    case 'Haze':
    case 'Dust':
    case 'Fog':
    case 'Sand':
    case 'Ash':
    case 'Squall':
    case 'Tornado':
      return 'lib/assets/rainbow.svg';
    default:
      return 'lib/assets/rainbow.svg';
  }
}
