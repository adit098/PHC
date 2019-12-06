Create table doctor_detail(
    d_ssn varchar(25) not null primary key,
    d_name varchar(40) not null,
    gender varchar(6),
    position  varchar(25),
    phone varchar(14),
    office varchar(75),
    address varchar(100),
    city varchar(25),
    zip int(6)
    );  
    
    create table patient_entry(
    patient_no int(10) not null primary key auto_increment, 
    p_ssn  varchar(25),
    d_ssn varchar(25),
    age int(3),
    visit_date date,  
    foreign key(p_ssn) references beneficiary(ssn),
    foreign key(d_ssn) references doctor_detail(d_ssn)
    );
    
    create table beneficiary(
    ssn varchar(25) not null primary key,
    name varchar(25),
    position varchar(25),
    gender varchar(10),
    DOB date,
    address varchar(25),
    city varchar(25),
    pincode int(6)
    );
    create table prescription(
    p_no int(10) not null,
    drug_name varchar(25) not null,
    quantity int(3) default 2,
    primary key(p_no, drug_name),
    foreign key(p_no) references patient_entry(patient_no),
    FOREIGN KEY(drug_name)
   REFERENCES medicines(m_name)
     );
     create table medicines(
     m_name varchar(75) not null, 
     price decimal(8,2),
     in_stock int(6),
     primary key(m_name)
     );
     
     -- trigger
     create trigger update_medicine_quantity 
after insert on prescription
for each ROW
update medicines
SET in_stock = in_stock-new.quantity
where m_name=new.drug_name;



INSERT INTO doctor_detail(D_Ssn,D_Name,Gender,Position,Phone,Office,Address,city,Zip) VALUES("101","GS Sandhu","Male","Med Specialist",9424778355,"Sandhu Clinic","Ranjhi Azad Nagar","Jabalpur",482005);
INSERT INTO doctor_detail(D_Ssn,D_Name,Gender,Position,Phone,Office,Address,city,Zip) VALUES("102","Jyoti Garg","Female","Paediatrician",9893246670,"Sharda Diagnostics","Hotel Rishi Regency,north civil lines","Jabalpur",482005);
INSERT INTO doctor_detail(D_Ssn,D_Name,Gender,Position,Phone,Office,Address,city,Zip) VALUES("103","Arvind Nath Gupta","Male","Paediatrician",9425383515,"Seth Govind Das Hospital","North civil lines","Jabalpur",482005);
INSERT INTO beneficiary(ssn,name,Position,gender,DOB,address,city,pincode) VALUES("2018052","Aviral Tiwari","Student","Male","1999-10-29","Hall 4","Jabalpur",482005);
INSERT INTO beneficiary(ssn,name,Position,gender,DOB,address,city,pincode) VALUES("2018282","Vinay Patel","Student","Male","1999-02-05","Hall 4","Jabalpur",482005);
INSERT INTO beneficiary(ssn,name,Position,gender,DOB,address,city,pincode) VALUES
("2018013","Aditya kr Gupta","Student","Male","2000-04-08","Hall 4","Jabalpur",482005),
("2018163","Nihit Anand","Student","Male","1999-11-10","Hall 4","Jabalpur",482005),
("2018356","Raj Singh","Student","Male","1999-05-15","Hall 4","Jabalpur",482005),
("2018005","Abhishek Vijvergiya","Student","Male","1999-10-11","Hall 4","Jabalpur",482005),
("101","Shyam Kumar","Caretaker","Male","1984-01-14","Hall 4","Jabalpur",482005),
("102","Ramu","Worker","Male","1999-08-12","Hall 4","Jabalpur",482005),
("201","Pritee Khanna","Faculty","Female","1999-03-29","Hall 4","Jabalpur",482005),
("202","PK Jain","Faculty","Male","1999-02-26","Hall 4","Jabalpur",482005);




create trigger get_serial_no
    after insert on Prescription
    for each ROW
    update Prescription
        set new.p_no = (select max(patient_no) from patient_entry group by patient_no)
        where drug_name = new.drug_name;