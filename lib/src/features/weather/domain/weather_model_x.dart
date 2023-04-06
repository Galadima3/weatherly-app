// To parse this JSON data, do
//
//     final weatherModelX = weatherModelXFromJson(jsonString);


// ignore_for_file: constant_identifier_names

import 'dart:convert';

WeatherModelX weatherModelXFromJson(String str) => WeatherModelX.fromJson(json.decode(str));

String weatherModelXToJson(WeatherModelX data) => json.encode(data.toJson());

class WeatherModelX {
    WeatherModelX({
        required this.location,
        required this.current,
        required this.forecast,
    });

    final Location location;
    final Current current;
    final Forecast forecast;

    factory WeatherModelX.fromJson(Map<String, dynamic> json) => WeatherModelX(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
        forecast: Forecast.fromJson(json["forecast"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "current": current.toJson(),
        "forecast": forecast.toJson(),
    };
}

class Current {
    Current({
        required this.lastUpdated,
        required this.tempC,
        required this.isDay,
        required this.condition,
        required this.windKph,
        required this.windDegree,
        required this.windDir,
        required this.pressureMb,
        required this.pressureIn,
        required this.precipMm,
        required this.humidity,
        required this.cloud,
        required this.feelslikeC,
        required this.visKm,
        required this.uv,
        required this.gustKph,
    });

    final String lastUpdated;
    final double tempC;
    final int isDay;
    final Condition condition;
    final double windKph;
    final int windDegree;
    final WindDir windDir;
    final num pressureMb;
    final double pressureIn;
    final num precipMm;
    final num humidity;
    final num cloud;
    final double feelslikeC;
    final num visKm;
    final num uv;
    final double gustKph;

    factory Current.fromJson(Map<String, dynamic> json) => Current(
        lastUpdated: json["last_updated"],
        tempC: json["temp_c"]?.toDouble(),
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windKph: json["wind_kph"]?.toDouble(),
        windDegree: json["wind_degree"],
        windDir: windDirValues.map[json["wind_dir"]]!,
        pressureMb: json["pressure_mb"],
        pressureIn: json["pressure_in"]?.toDouble(),
        precipMm: json["precip_mm"],
        humidity: json["humidity"],
        cloud: json["cloud"],
        feelslikeC: json["feelslike_c"]?.toDouble(),
        visKm: json["vis_km"],
        uv: json["uv"],
        gustKph: json["gust_kph"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "last_updated": lastUpdated,
        "temp_c": tempC,
        "is_day": isDay,
        "condition": condition.toJson(),
        "wind_kph": windKph,
        "wind_degree": windDegree,
        "wind_dir": windDirValues.reverse[windDir],
        "pressure_mb": pressureMb,
        "pressure_in": pressureIn,
        "precip_mm": precipMm,
        "humidity": humidity,
        "cloud": cloud,
        "feelslike_c": feelslikeC,
        "vis_km": visKm,
        "uv": uv,
        "gust_kph": gustKph,
    };
}

class Condition {
    Condition({
        required this.text,
        required this.icon,
        required this.code,
    });

    final Text text;
    final String icon;
    final int code;

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: textValues.map[json["text"]]!,
        icon: json["icon"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "text": textValues.reverse[text],
        "icon": icon,
        "code": code,
    };
}

enum Text { CLEAR, SUNNY, MODERATE_RAIN, PATCHY_RAIN_POSSIBLE, OVERCAST, CLOUDY, PARTLY_CLOUDY, MODERATE_OR_HEAVY_RAIN_SHOWER, MODERATE_RAIN_AT_TIMES, THUNDERY_OUTBREAKS_POSSIBLE, LIGHT_RAIN_SHOWER, PATCHY_LIGHT_RAIN_WITH_THUNDER }

final textValues = EnumValues({
    "Clear": Text.CLEAR,
    "Cloudy": Text.CLOUDY,
    "Light rain shower": Text.LIGHT_RAIN_SHOWER,
    "Moderate or heavy rain shower": Text.MODERATE_OR_HEAVY_RAIN_SHOWER,
    "Moderate rain": Text.MODERATE_RAIN,
    "Moderate rain at times": Text.MODERATE_RAIN_AT_TIMES,
    "Overcast": Text.OVERCAST,
    "Partly cloudy": Text.PARTLY_CLOUDY,
    "Patchy light rain with thunder": Text.PATCHY_LIGHT_RAIN_WITH_THUNDER,
    "Patchy rain possible": Text.PATCHY_RAIN_POSSIBLE,
    "Sunny": Text.SUNNY,
    "Thundery outbreaks possible": Text.THUNDERY_OUTBREAKS_POSSIBLE
});

enum WindDir { W, WSW, SW, S, SSE, SE, SSW, NNW, NW, WNW, N, NNE }

final windDirValues = EnumValues({
    "N": WindDir.N,
    "NNE": WindDir.NNE,
    "NNW": WindDir.NNW,
    "NW": WindDir.NW,
    "S": WindDir.S,
    "SE": WindDir.SE,
    "SSE": WindDir.SSE,
    "SSW": WindDir.SSW,
    "SW": WindDir.SW,
    "W": WindDir.W,
    "WNW": WindDir.WNW,
    "WSW": WindDir.WSW
});

class Forecast {
    Forecast({
        required this.forecastday,
    });

    final List<Forecastday> forecastday;

    factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        forecastday: List<Forecastday>.from(json["forecastday"].map((x) => Forecastday.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "forecastday": List<dynamic>.from(forecastday.map((x) => x.toJson())),
    };
}

class Forecastday {
    Forecastday({
        required this.date,
        required this.day,
        required this.astro,
        required this.hour,
    });

    final DateTime date;
    final Day day;
    final Astro astro;
    final List<Hour> hour;

    factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
        date: DateTime.parse(json["date"]),
        day: Day.fromJson(json["day"]),
        astro: Astro.fromJson(json["astro"]),
        hour: List<Hour>.from(json["hour"].map((x) => Hour.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "day": day.toJson(),
        "astro": astro.toJson(),
        "hour": List<dynamic>.from(hour.map((x) => x.toJson())),
    };
}

class Astro {
    Astro({
        required this.sunrise,
        required this.sunset,
        required this.moonrise,
        required this.moonset,
        required this.moonPhase,
        required this.moonIllumination,
        required this.isMoonUp,
        required this.isSunUp,
    });

    final String sunrise;
    final String sunset;
    final String moonrise;
    final String moonset;
    final String moonPhase;
    final String moonIllumination;
    final int isMoonUp;
    final int isSunUp;

    factory Astro.fromJson(Map<String, dynamic> json) => Astro(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"],
        moonIllumination: json["moon_illumination"],
        isMoonUp: json["is_moon_up"],
        isSunUp: json["is_sun_up"],
    );

    Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "moon_illumination": moonIllumination,
        "is_moon_up": isMoonUp,
        "is_sun_up": isSunUp,
    };
}

class Day {
    Day({
        required this.maxtempC,
        required this.mintempC,
        required this.avgtempC,
        required this.maxwindKph,
        required this.totalprecipMm,
        required this.totalsnowCm,
        required this.avgvisKm,
        required this.avghumidity,
        required this.dailyWillItRain,
        required this.dailyChanceOfRain,
        required this.dailyWillItSnow,
        required this.dailyChanceOfSnow,
        required this.condition,
        required this.uv,
    });

    final double maxtempC;
    final double mintempC;
    final double avgtempC;
    final double maxwindKph;
    final double totalprecipMm;
    final num totalsnowCm;
    final double avgvisKm;
    final num avghumidity;
    final num dailyWillItRain;
    final num dailyChanceOfRain;
    final num dailyWillItSnow;
    final num dailyChanceOfSnow;
    final Condition condition;
    final num uv;

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        maxtempC: json["maxtemp_c"]?.toDouble(),
        mintempC: json["mintemp_c"]?.toDouble(),
        avgtempC: json["avgtemp_c"]?.toDouble(),
        maxwindKph: json["maxwind_kph"]?.toDouble(),
        totalprecipMm: json["totalprecip_mm"]?.toDouble(),
        totalsnowCm: json["totalsnow_cm"],
        avgvisKm: json["avgvis_km"]?.toDouble(),
        avghumidity: json["avghumidity"],
        dailyWillItRain: json["daily_will_it_rain"],
        dailyChanceOfRain: json["daily_chance_of_rain"],
        dailyWillItSnow: json["daily_will_it_snow"],
        dailyChanceOfSnow: json["daily_chance_of_snow"],
        condition: Condition.fromJson(json["condition"]),
        uv: json["uv"],
    );

    Map<String, dynamic> toJson() => {
        "maxtemp_c": maxtempC,
        "mintemp_c": mintempC,
        "avgtemp_c": avgtempC,
        "maxwind_kph": maxwindKph,
        "totalprecip_mm": totalprecipMm,
        "totalsnow_cm": totalsnowCm,
        "avgvis_km": avgvisKm,
        "avghumidity": avghumidity,
        "daily_will_it_rain": dailyWillItRain,
        "daily_chance_of_rain": dailyChanceOfRain,
        "daily_will_it_snow": dailyWillItSnow,
        "daily_chance_of_snow": dailyChanceOfSnow,
        "condition": condition.toJson(),
        "uv": uv,
    };
}

class Hour {
    Hour({
        required this.time,
        required this.tempC,
        required this.isDay,
        required this.condition,
        required this.windKph,
        required this.windDegree,
        //required this.windDir,
        required this.pressureMb,
        required this.pressureIn,
        required this.precipMm,
        required this.humidity,
        required this.cloud,
        required this.feelslikeC,
        required this.windchillC,
        required this.heatindexC,
        required this.dewpointC,
        required this.willItRain,
        required this.chanceOfRain,
        required this.willItSnow,
        required this.chanceOfSnow,
        required this.visKm,
        required this.gustKph,
        required this.uv,
    });

    final String time;
    final double tempC;
    final int isDay;
    final Condition condition;
    final double windKph;
    final int windDegree;
    
    final num pressureMb;
    final double pressureIn;
    final double precipMm;
    final int humidity;
    final int cloud;
    final double feelslikeC;
    final double windchillC;
    final double heatindexC;
    final double dewpointC;
    final int willItRain;
    final int chanceOfRain;
    final int willItSnow;
    final int chanceOfSnow;
    final double visKm;
    final double gustKph;
    final num uv;

    factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        time: json["time"],
        tempC: json["temp_c"]?.toDouble(),
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windKph: json["wind_kph"]?.toDouble(),
        windDegree: json["wind_degree"],
        
        pressureMb: json["pressure_mb"],
        pressureIn: json["pressure_in"]?.toDouble(),
        precipMm: json["precip_mm"]?.toDouble(),
        humidity: json["humidity"],
        cloud: json["cloud"],
        feelslikeC: json["feelslike_c"]?.toDouble(),
        windchillC: json["windchill_c"]?.toDouble(),
        heatindexC: json["heatindex_c"]?.toDouble(),
        dewpointC: json["dewpoint_c"]?.toDouble(),
        willItRain: json["will_it_rain"],
        chanceOfRain: json["chance_of_rain"],
        willItSnow: json["will_it_snow"],
        chanceOfSnow: json["chance_of_snow"],
        visKm: json["vis_km"]?.toDouble(),
        gustKph: json["gust_kph"]?.toDouble(),
        uv: json["uv"],
    );

    Map<String, dynamic> toJson() => {
        "time": time,
        "temp_c": tempC,
        "is_day": isDay,
        "condition": condition.toJson(),
        "wind_kph": windKph,
        "wind_degree": windDegree,
        //"wind_dir": windDirValues.reverse[windDir],
        "pressure_mb": pressureMb,
        "pressure_in": pressureIn,
        "precip_mm": precipMm,
        "humidity": humidity,
        "cloud": cloud,
        "feelslike_c": feelslikeC,
        "windchill_c": windchillC,
        "heatindex_c": heatindexC,
        "dewpoint_c": dewpointC,
        "will_it_rain": willItRain,
        "chance_of_rain": chanceOfRain,
        "will_it_snow": willItSnow,
        "chance_of_snow": chanceOfSnow,
        "vis_km": visKm,
        "gust_kph": gustKph,
        "uv": uv,
    };
}

class Location {
    Location({
        required this.name,
        required this.region,
        required this.country,
        required this.lat,
        required this.lon,
        required this.tzId,
        required this.localtimeEpoch,
        required this.localtime,
    });

    final String name;
    final String region;
    final String country;
    final double lat;
    final double lon;
    final String tzId;
    final int localtimeEpoch;
    final String localtime;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        tzId: json["tz_id"],
        localtimeEpoch: json["localtime_epoch"],
        localtime: json["localtime"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
        "tz_id": tzId,
        "localtime_epoch": localtimeEpoch,
        "localtime": localtime,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
