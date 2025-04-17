-- List of Patients and their billing reports
SELECT distinct
    CONCAT(p.first_name,' ',p.last_name)AS Full_name,
    SUM(b.total_amount)AS Total_amount,
    STRING_AGG(bi.Description,',  ')AS Bill_items,
  CASE WHEN b.paid = 1 THEN 'Yes'
      WHEN b.paid = 0 THEN 'No' 
	  ELSE NULL
  END AS Paid
FROM dbo.Patients p
JOIN dbo.Bills b ON p.Patient_ID = b.Patient_ID
JOIN dbo.Bill_Items bi ON b.Bill_ID = bi.Bill_ID
GROUP BY p.First_Name,p.Last_Name,b.paid
ORDER BY Full_name ASC;


SELECT* FROM dbo.Bill_Items;


--  Task 2 solution: List of top 3 Doctors with the highest number of appointments
SELECT
    TOP 3
    CONCAT(d.first_name,' ',d.last_name) AS Full_name,
	d.Specialty,
	COUNT(a.appointment_id) AS Appointment_count
FROM dbo.Doctors d
JOIN dbo.Appointments a ON d.Doctor_ID = a.Doctor_ID
GROUP BY d.First_Name,d.Last_Name,d.Specialty
ORDER BY Appointment_count DESC;


-- Task 3 solution: Patients with active prescriptions and their medications
SELECT 
    CONCAT(p.first_name,' ',p.last_name) AS Patients_Full_name,
	m.med_name AS Medication_name,
	pr.Dosage,
	pr.Date_issued,
	CONCAT(d.first_name,' ',d.last_name) AS Prescribed_by
FROM dbo.Patients p
JOIN dbo.Prescriptions pr ON p.Patient_ID = pr.Patient_ID
JOIN dbo.Doctors d ON pr.Doctor_ID = d.Doctor_ID
JOIN dbo.Medications m ON pr.Med_ID = m.Med_ID;





-- Task 4 solution: medications that are either low in stock or expired
SELECT
    Med_Name,
    Stock,
    ExpiryDate,
    Supplier_Name,
    CASE 
        WHEN Stock < 10 AND ExpiryDate < GETDATE() THEN 'Low Stock & Expired'
        WHEN Stock < 10 THEN 'Low Stock'
        WHEN ExpiryDate < GETDATE() THEN 'Expired'
        ELSE 'OK'
    END AS Status
FROM dbo.Medications
WHERE Stock < 10 OR ExpiryDate < GETDATE();



-- Simulating a low stock and expired medication
INSERT INTO Medications (Med_Name, Stock, ExpiryDate, Supplier_Name)
VALUES 
('Ibuprofen', 5, '2024-12-01', 'Fidson Healthcare'),           -- Low stock & expired
('Metformin', 3, '2025-12-01', 'Emzor Pharma'),                -- Low stock only
('Aspirin', 25, '2024-10-15', 'May & Baker Nigeria');           -- Expired only



-- Final Task solution: detailed report showing each patient’s appointment history
SELECT 
   CONCAT(p.first_name,' ',p.last_name) AS Patient_Full_name,
   CONCAT(d.first_name,' ',d.last_name) AS Doctor_seen,
   mr.Diagnosis,
   mr.Treatment,
   m.med_name AS Prescriptions,
   a.Appointment_date
FROM dbo.Patients p
JOIN dbo.Medical_Records mr ON p.Patient_ID = mr.Patient_ID
JOIN dbo.Doctors d ON mr.Doctor_ID = d.Doctor_ID
JOIN dbo.Appointments a ON D.Doctor_ID = a.Doctor_ID
LEFT JOIN dbo.Prescriptions pr ON p.Patient_ID = pr.Patient_ID
LEFT JOIN dbo.Medications m ON pr.Med_ID = m.Med_ID
ORDER BY p.First_Name, a.Appointment_Date;

