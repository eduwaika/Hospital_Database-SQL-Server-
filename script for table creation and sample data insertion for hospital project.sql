CREATE DATABASE HospitalDB;
GO

USE HospitalDB;

-- Entities

CREATE TABLE Patients (
    Patient_ID INT IDENTITY(1,1) PRIMARY KEY,
    First_Name NVARCHAR(50),
    Last_Name NVARCHAR(50),
    Gender VARCHAR(10),
    Date_Of_Birth DATE,
    Phone_Number VARCHAR(20),
    Email VARCHAR(100),
    Address NVARCHAR(255),
    Registration_Date DATETIME DEFAULT GETDATE()
);



CREATE TABLE Doctors (
    Doctor_ID INT IDENTITY(1,1) PRIMARY KEY,
    First_Name NVARCHAR(50),
    Last_Name NVARCHAR(50),
    Specialty NVARCHAR(100),
    Phone_Number VARCHAR(20),
    Email VARCHAR(100),
    Department NVARCHAR(100)
);




-- Medications Table
CREATE TABLE Medications (
    Med_ID INT IDENTITY(1,1) PRIMARY KEY,
    Med_Name NVARCHAR(100),
    Stock INT,
    ExpiryDate DATE,
    Supplier_Name NVARCHAR(100)
);




-- Relationships
-- Appointments Table
CREATE TABLE Appointments (
    Appointment_ID INT IDENTITY(1,1) PRIMARY KEY,
    Patient_ID INT FOREIGN KEY REFERENCES Patients(Patient_ID),
    Doctor_ID INT FOREIGN KEY REFERENCES Doctors(Doctor_ID),
    Appointment_Date DATETIME,
    Status VARCHAR(20) DEFAULT 'Scheduled' -- e.g., Scheduled, Completed, Cancelled
);
SELECT NAME
FROM SYS.TABLES;

-- Medical Records Table
CREATE TABLE Medical_Records (
    Record_ID INT IDENTITY(1,1) PRIMARY KEY,
    Patient_ID INT FOREIGN KEY REFERENCES Patients(Patient_ID),
    Doctor_ID INT FOREIGN KEY REFERENCES Doctors(Doctor_ID),
    Appointment_ID INT FOREIGN KEY REFERENCES Appointments(Appointment_ID),
    Diagnosis TEXT,
    Treatment TEXT,
    Record_Date DATETIME DEFAULT GETDATE()
);


-- Prescriptions Table
CREATE TABLE Prescriptions (
    Prescription_ID INT IDENTITY(1,1) PRIMARY KEY,
    Patient_ID INT FOREIGN KEY REFERENCES Patients(Patient_ID),
    Doctor_ID INT FOREIGN KEY REFERENCES Doctors(Doctor_ID),
    Med_ID INT FOREIGN KEY REFERENCES Medications(Med_ID),
    Date_Issued DATETIME DEFAULT GETDATE(),
    Dosage NVARCHAR(100)
);


-- Bills Table
CREATE TABLE Bills (
    Bill_ID INT IDENTITY(1,1) PRIMARY KEY,
    Patient_ID INT FOREIGN KEY REFERENCES Patients(Patient_ID),
    Total_Amount DECIMAL(10,2),
    Paid BIT DEFAULT 0,
    Date_Issued DATETIME DEFAULT GETDATE()
);


-- Bill Item Table
CREATE TABLE Bill_Items (
    Bill_Item_ID INT IDENTITY(1,1) PRIMARY KEY,
    Bill_ID INT FOREIGN KEY REFERENCES Bills(Bill_ID),
    Description NVARCHAR(255),
    Cost DECIMAL(10,2)
);


-- DISCLAIMER:
-- The data used in this project is sample data for demonstration purposes only.
-- It does not represent any real persons, patients, or organizations.




-- Sample Data (Patients)

INSERT INTO Patients (First_Name, Last_Name, Gender, Date_Of_Birth, Phone_Number, Email, Address)
VALUES
('Chinedu', 'Okafor', 'Male', '1985-04-12', '+2348034567890', 'chinedu.okafor@example.com', 'No. 14 Zik Avenue, Enugu'),
('Amina', 'Bello', 'Female', '1992-08-23', '+2348091122334', 'amina.bello@example.com', '25 Sultan Road, Kaduna'),
('Tunde', 'Adebayo', 'Male', '1979-11-30', '+2348029988776', 'tunde.adebayo@example.com', '32 Allen Avenue, Ikeja, Lagos'),
('Ngozi', 'Eze', 'Female', '1995-01-10', '+2347012345678', 'ngozi.eze@example.com', '11 Presidential Road, Aba'),
('Sani', 'Mohammed', 'Male', '1988-06-15', '+2348123456789', 'sani.mohammed@example.com', 'Plot 9 Airport Road, Kano');



-- Sample Data (Doctors)
INSERT INTO Doctors (First_Name, Last_Name, Specialty, Phone_Number, Email, Department)
VALUES
('Ifeoma', 'Nwosu', 'Cardiology', '+2348095566771', 'ifeoma.nwosu@hospital.com', 'Cardiology'),
('Yakubu', 'Garba', 'Orthopedics', '+2348023344556', 'yakubu.garba@hospital.com', 'Orthopedics'),
('Olufemi', 'Adeyemi', 'Pediatrics', '+2347019876543', 'olufemi.adeyemi@hospital.com', 'Pediatrics'),
('Zainab', 'Usman', 'Dermatology', '+2348132244667', 'zainab.usman@hospital.com', 'Dermatology'),
('Emeka', 'Uzor', 'General Surgery', '+2348056677889', 'emeka.uzor@hospital.com', 'Surgery');



-- Sample Data (Appointments)
INSERT INTO Appointments (Patient_ID, Doctor_ID, Appointment_Date, Status)
VALUES
(1, 1, '2025-04-20 10:00:00', 'Scheduled'),
(2, 3, '2025-04-20 11:30:00', 'Scheduled'),
(3, 5, '2025-04-21 09:00:00', 'Scheduled'),
(4, 2, '2025-04-21 14:00:00', 'Scheduled'),
(5, 4, '2025-04-22 13:00:00', 'Scheduled');

SELECT* FROM Medical_Records;


-- Sample Data (Medical Records)
INSERT INTO Medical_Records (Patient_ID, Doctor_ID, Appointment_ID, Diagnosis, Treatment)
VALUES
(1, 1, 1, 'Hypertension', 'Advised lifestyle change, prescribed Amlodipine'),
(2, 3, 2, 'Malaria', 'Prescribed Artemether-Lumefantrine for 3 days'),
(3, 5, 3, 'Appendicitis', 'Scheduled for laparoscopic surgery'),
(4, 2, 4, 'Knee injury from fall', 'Recommended physiotherapy and rest'),
(5, 4, 5, 'Acne breakout', 'Prescribed topical retinoid cream');

select* from Medications;


-- Sample Data (Medications)
-- Sample medication data for the 'Medications' table
INSERT INTO Medications (Med_Name, Stock, ExpiryDate, Supplier_Name)
VALUES
('Amlodipine', 200, '2026-07-12', 'Pharma Solutions Ltd.'),
('Artemether-Lumefantrine', 150, '2025-12-25', 'Med Supplies Nigeria'),
('Paracetamol', 500, '2026-03-10', 'HealthPro Pharmaceuticals'),
('Ciprofloxacin', 100, '2025-10-30', 'CureMed Inc.'),
('Topical Retinoid Cream', 80, '2025-11-15', 'Dermal Care Supplies');



-- Sample Data (Prescriptions)
INSERT INTO Prescriptions (Patient_ID, Doctor_ID, Med_ID, Date_Issued, Dosage)
VALUES
(1, 1, 1, '2025-04-20 10:00:00', '5mg once daily to control blood pressure'),
(2, 3, 2, '2025-04-20 11:30:00', '80/480mg twice daily with meals for 3 days for malaria'),
(3, 5, 4, '2025-04-21 09:00:00', '500mg twice daily for bacterial infection (pre-surgery)'),
(4, 2, 3, '2025-04-21 14:00:00', '500mg every 6 hours for joint pain relief'),
(5, 4, 5, '2025-04-22 13:00:00', 'Apply once at night for acne treatment');



-- Sample Data (Bills)
INSERT INTO Bills (Patient_ID, Total_Amount, Paid, Date_Issued)
VALUES
(1, 15000.00, 0, '2025-04-20 10:00:00'), -- Bill for Chinedu
(2, 8000.00, 1, '2025-04-20 11:30:00'), -- Bill for Amina
(3, 20000.00, 0, '2025-04-21 09:00:00'), -- Bill for Tunde
(4, 5000.00, 1, '2025-04-21 14:00:00'), -- Bill for Ngozi
(5, 12000.00, 0, '2025-04-22 13:00:00'); -- Bill for Sani




-- Sample Data (Bill_Items)
INSERT INTO Bill_Items (Bill_ID, Description, Cost)
VALUES
(1, 'Consultation Fee', 5000.00),
(1, 'Laboratory Test', 3000.00),
(1, 'Medication', 4000.00),
(2, 'Consultation Fee', 4000.00),
(2, 'Medication', 4000.00),
(3, 'Consultation Fee', 6000.00),
(3, 'Surgery Fee', 14000.00),
(4, 'Consultation Fee', 3000.00),
(4, 'Physiotherapy', 2000.00),
(5, 'Consultation Fee', 5000.00),
(5, 'Medication', 7000.00);



