--  Retrive information about all Airlines.

select * from Airlines;



-- Retrive information about all Aircrafts.

select * from Aircrafts;


-- Retrive a list of passengers for a specific flight.

select Passengers.*
from Passengers
join Reservations on Passengers.PassengerID = Reservations.PassengerID
where Reservations.FlightID = 1;


-- Retrive a list of flights for a specific Airline.

SELECT * from Flights 
where airlineid = 1;


-- Retrive available seats for a specific flight.

SELECT * from Flights
join Aircrafts on Flights.AircraftID = Aircrafts.AircraftID
LEFT join Reservations on Flights.FlightID = Reservations.FlightID
where Flights.FlightID = Reservations.FlightID and (Reservations.ReservationID is NULL or Reservations.ReservationTime < getdate());


-- Retrive the total number of reservations for a specific flight.

SELECT COUNT(*) as Reservationscount
from Reservations
WHERE flightid = 1;


-- Retrive a list of passengers with their flight details for a specific airline

SELECT Passengers.FirstName, Passengers.LastName, Flights.FlightNumber, Flights.DepartureAirport, Flights.ArrivalAirport
from Passengers
join Reservations on Passengers.PassengerID = Reservations.PassengerID
join Flights on Reservations.FlightID = Flights.FlightID
WHERE Flights.AirlineID = 1;
