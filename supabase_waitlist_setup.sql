-- Run this in Supabase SQL Editor
-- Go to: supabase.com → your project → SQL Editor → New Query → paste this → Run

CREATE TABLE waitlist (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    source TEXT DEFAULT 'website'
);

-- Allow anyone to insert (for the website form)
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public insert" ON waitlist
    FOR INSERT TO anon
    WITH CHECK (true);

-- Only you (authenticated) can read all emails
CREATE POLICY "Allow auth read" ON waitlist
    FOR SELECT TO authenticated
    USING (true);
