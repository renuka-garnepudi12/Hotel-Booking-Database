CREATE DATABASE HotelBookingDB;

USE HotelBookingDB;

CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    star_rating INT
);

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT,
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    availability VARCHAR(20),
    FOREIGN KEY (hotel_id)
        REFERENCES Hotels(hotel_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    booking_status VARCHAR(20),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),
    FOREIGN KEY (room_id)
        REFERENCES Rooms(room_id)
);

SHOW TABLES;

USE HotelBookingDB;

INSERT INTO Hotels
(hotel_name, city, star_rating)
VALUES
('Grand Palace Hotel', 'Hyderabad', 5),
('Sunrise Residency', 'Vijayawada', 3),
('Ocean View Hotel', 'Visakhapatnam', 4);

SELECT * FROM Hotels;

INSERT INTO Rooms
(hotel_id, room_type, price_per_night, availability)
VALUES
(1, 'Deluxe', 3500.00, 'Available'),
(1, 'Suite', 6000.00, 'Available'),
(2, 'Standard', 1800.00, 'Available'),
(2, 'Deluxe', 2500.00, 'Booked'),
(3, 'Sea View', 4500.00, 'Available');

INSERT INTO Customers
(customer_name, email, phone)
VALUES
('Ananya', 'ananya@example.com', '9000000001'),
('Kiran', 'kiran@example.com', '9000000002'),
('Priya', 'priya@example.com', '9000000003'),
('Rahul', 'rahul@example.com', '9000000004');
SELECT * FROM  Customers;

INSERT INTO Bookings
(customer_id, room_id, check_in, check_out, booking_status)
VALUES
(1, 1, '2026-11-01', '2026-11-03', 'Confirmed'),
(2, 3, '2026-11-05', '2026-11-07', 'Confirmed'),
(3, 2, '2026-11-10', '2026-11-12', 'Pending'),
(4, 5, '2026-11-15', '2026-11-18', 'Confirmed');
USE HotelBookingDB;

SELECT * FROM  Bookings;

SELECT
    b.booking_id,
    c.customer_name,
    h.hotel_name,
    r.room_type,
    b.check_in,
    b.check_out,
    b.booking_status
FROM Bookings b
JOIN Customers c
    ON b.customer_id = c.customer_id
JOIN Rooms r
    ON b.room_id = r.room_id
JOIN Hotels h
    ON r.hotel_id = h.hotel_id;

SELECT
    h.hotel_name,
    SUM(
        DATEDIFF(b.check_out, b.check_in)
        * r.price_per_night
    ) AS total_booking_value
FROM Bookings b
JOIN Rooms r ON b.room_id = r.room_id
JOIN Hotels h ON r.hotel_id = h.hotel_id
WHERE b.booking_status = 'Confirmed'
GROUP BY h.hotel_id, h.hotel_name;
