-- Create patients table
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE
);

-- Create medical_histories table
CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(255)
);

CREATE INDEX ON medical_histories(patient_id)

-- Create treatments table
CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    code VARCHAR(255),
    name VARCHAR(255)
);

-- Create many-to-many relationship table between medical_histories and treatments
CREATE TABLE medical_history_treatments (
    medical_history_id INT REFERENCES medical_histories(id),
    treatment_id INT REFERENCES treatments(id),
    PRIMARY KEY (medical_history_id, treatment_id)
);

CREATE INDEX ON medical_history_treatments(medical_history_id);
CREATE INDEX ON medical_history_treatments(treatment_id)

-- Create invoices table
CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id)
);

CREATE INDEX ON invoices(medical_history_id);

-- Create invoice_items table
CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
);

CREATE INDEX ON invoice_items(invoice_id);
CREATE INDEX ON invoice_items(treatment_id);
