CREATE DATABASE data_enginnering;

-- DROP DATABASE data_enginnering;

USE data_enginnering;

CREATE TABLE cities (
    city_id INT, 
    city_name VARCHAR(50), 
    country_code VARCHAR(50),
    country VARCHAR(50),
    population INT,
    latitude FLOAT(6),
    longitude FLOAT(6),
    PRIMARY KEY (city_id)
);

select * from cities;

CREATE TABLE population (
    city_id INT, 
    city_name VARCHAR(50), 
    country_code VARCHAR(50),
    population float(6),
    timestamp_population YEAR,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

select * from population;

CREATE TABLE weather (
    city_id INT, 
    city VARCHAR(50), 
    country VARCHAR(50),
    forecast_time datetime,
    outlook	VARCHAR(50),
    detailed_outlook VARCHAR(50),
    temperature	float(6),
    temperature_feels_like float(6),	
    clouds float(6),
    rain float(6),
    snow float(6),
    wind_speed float(6),
    wind_deg float(6),
    humidity float(6),
    pressure float(6),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

select * from weather;

CREATE TABLE cities_airport (
    city_id INT, 
    airport_icao VARCHAR(50),
    primary key(airport_icao),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

 -- drop table cities_airport;

select * from cities_airport;

CREATE TABLE airports (
    airport_icao VARCHAR(50), 
    airport_name VARCHAR(50),
    primary KEY (airport_icao),
    FOREIGN KEY (airport_icao) REFERENCES cities_airport(airport_icao)
    );
    
/*INSERT INTO airports (airport_icao,airport_name)
VALUES ("EGLC", "London City");*/

select * from airports;
    
-- delete from airports where airport_name = "City";

CREATE TABLE flights (
    flight_id INT, 
    flight_num VARCHAR(50), 
    departure_icao VARCHAR(50),
    arrival_icao VARCHAR(50),
    arrival_time datetime,
    PRIMARY KEY (flight_id),
    foreign key (arrival_icao) references airports (airport_icao)
);

select * from flights;