-- Create additional admin user
CREATE USER admin WITH PASSWORD 'admin_password';

-- Grant all privileges to the admin user
GRANT ALL PRIVILEGES ON DATABASE mlflow TO admin;

-- You can also create additional databases and users as needed
-- Example:
-- CREATE DATABASE another_db;
-- CREATE USER another_user WITH PASSWORD 'another_password';
-- GRANT ALL PRIVILEGES ON DATABASE another_db TO another_user;
