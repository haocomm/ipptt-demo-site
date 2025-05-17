-- Check if the users table exists, if not create it
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  email VARCHAR(255),
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL DEFAULT 'user',
  status VARCHAR(50) NOT NULL DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create index on username for faster lookups
CREATE INDEX idx_users_username ON users(username);


-- Check if the managers table exists, if not create it
CREATE TABLE IF NOT EXISTS managers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  email VARCHAR(255),
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL DEFAULT 'admin',
  userId INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (userId) REFERENCES users(id) ON DELETE SET NULL
);

-- Create index on username for faster lookups
CREATE INDEX idx_managers_username ON managers(username);



-- Check if the members table exists, if not create it
CREATE TABLE IF NOT EXISTS members (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  server VARCHAR(50) NOT NULL DEFAULT '1',
  role VARCHAR(50) NOT NULL DEFAULT 'User',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



CREATE TABLE IF NOT EXISTS sessions (
  id VARCHAR(255) PRIMARY KEY,
  user_id INT NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES managers(id) ON DELETE CASCADE
);



-- Add user_id column to members table
ALTER TABLE members ADD COLUMN user_id VARCHAR(255) NULL;

-- Add index for faster lookups
CREATE INDEX idx_members_user_id ON members(user_id);


-- This script adds a test user with a bcrypt-hashed password
-- The password is 'admin123' hashed with bcrypt
INSERT INTO managers (username, email, password, role)
VALUES ('admin', 'admin@example.com', '$2a$12$e98e76NA.OAnaFwod2ChausaDDlFAS9W4zE3LeVq60sb1ZSeOUjFm', 'admin')
ON DUPLICATE KEY UPDATE
email = VALUES(email),
password = VALUES(password),
role = VALUES(role);
