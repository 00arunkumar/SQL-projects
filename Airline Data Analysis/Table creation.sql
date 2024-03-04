--Create Database Airlines

-- Create Airlines table
CREATE TABLE Airlines (
    AirlineID INT PRIMARY KEY,
    AirlineName VARCHAR(255) NOT NULL,
    Headquarters VARCHAR(255),
    ContactNumber VARCHAR(20)
);

-- Aircrafts table
CREATE TABLE Aircrafts (
    AircraftID INT PRIMARY KEY,
    AircraftType VARCHAR(255) NOT NULL,
    RegistrationNumber VARCHAR(20) NOT NULL,
    Capacity INT NOT NULL,
    CurrentStatus VARCHAR(20) DEFAULT 'Active',
    AirlineID INT,
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
);


-- Create Flights table
CREATE TABLE Flights (
    FlightID INT PRIMARY KEY,
    FlightNumber VARCHAR(10) NOT NULL,
    DepartureAirport VARCHAR(255) NOT NULL,
    ArrivalAirport VARCHAR(255) NOT NULL,
    DepartureTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    AirlineID INT,
    AircraftID INT,
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID),
    FOREIGN KEY (AircraftID) REFERENCES Aircrafts(AircraftID)
);

-- Create Passengers table
CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(20),
    UNIQUE (Email, Phone)
);

-- Create Reservations table
CREATE TABLE Reservations (
    ReservationID INT,
    PassengerID INT,
    FlightID INT,
    SeatNumber VARCHAR(10),
    ReservationTime DATETIME NOT NULL,
    PRIMARY KEY (PassengerID, FlightID),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Insert sample data for Airlines
-- Insert sample data for Airlines
INSERT INTO Airlines (AirlineID, AirlineName, Headquarters, ContactNumber) VALUES
(1, 'Airline A', 'City A', '123-456-7890'),
(2, 'Airline B', 'City B', '987-654-3210');

-- Insert sample data for Aircrafts
INSERT INTO Aircrafts (AircraftID, AircraftType, RegistrationNumber, Capacity, CurrentStatus, AirlineID) VALUES
(1, 'Boeing 737', 'ABC123', 150, 'Active', 1),
(2, 'Airbus A320', 'XYZ789', 180, 'Active', 2);


-- Insert sample data for Flights
INSERT INTO Flights (FlightID, FlightNumber, DepartureAirport, ArrivalAirport, DepartureTime, ArrivalTime, AirlineID, AircraftID) VALUES
(1, 'AA101', 'JFK', 'LAX', '2023-01-01 08:00:00', '2023-01-01 12:00:00', 1, 1),
(2, 'BA202', 'LHR', 'CDG', '2023-01-02 10:00:00', '2023-01-02 12:30:00', 2, 2);

-- Insert sample data for Passengers
INSERT INTO Passengers (PassengerID, FirstName, LastName, Email, Phone) VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '555-1234'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '555-5678');

-- Insert sample data for Reservations
INSERT INTO Reservations (ReservationID, PassengerID, FlightID, SeatNumber, ReservationTime) VALUES
(1, 1, 1, 'A1', '2023-01-01 07:30:00'),
(2, 2, 2, 'B3', '2023-01-02 09:45:00');