-- Initialization script for PostgreSQL database
-- This script runs when the database container starts for the first time

-- Create the messages table if it doesn't exist
CREATE TABLE IF NOT EXISTS messages (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create an index on created_at for better query performance
CREATE INDEX IF NOT EXISTS idx_messages_created_at ON messages(created_at DESC);

-- Insert some sample messages for testing
INSERT INTO messages (content) VALUES 
    ('Bun venit la aplicația CICD6! 🎉'),
    ('Acesta este un mesaj de test din PostgreSQL.')
ON CONFLICT DO NOTHING;

-- Create a user for the application (if needed for additional security)
-- CREATE USER IF NOT EXISTS app_user WITH PASSWORD 'app_password';
-- GRANT CONNECT ON DATABASE messages_db TO app_user;
-- GRANT USAGE ON SCHEMA public TO app_user;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;
-- GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_user;

-- Display initialization message
DO $$
BEGIN
    RAISE NOTICE 'Database initialized successfully for CICD6 application';
    RAISE NOTICE 'Messages table created with sample data';
END $$;