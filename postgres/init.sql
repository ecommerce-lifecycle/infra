SET TIMEZONE = 'Asia/Kolkata';

-- Enable pgcrypto for UUIDs
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Product table
CREATE TABLE products (
  product_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price NUMERIC(15,2) NOT NULL,
  category VARCHAR(100),
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT now(),
  updated_at TIMESTAMP NOT NULL DEFAULT now()
);

-- Optional seed data
INSERT INTO products (product_id, name, description, price, category, active, created_at, updated_at)
VALUES
  (gen_random_uuid(), 'iPhone 15', 'Latest Apple iPhone', 79999, 'Mobile', true, now(), now()),
  (gen_random_uuid(), 'Samsung Galaxy S23', 'Flagship Samsung phone', 74999, 'Mobile', true, now(), now());

