import { createClient } from '@supabase/supabase-js'

// Environment variables עם fallback לערכים הקיימים (למטרות פיתוח)
const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://noqfwkxzmvpkorcaymcb.supabase.co'
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5vcWZ3a3h6bXZwa29yY2F5bWNiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU0MTgzMTgsImV4cCI6MjA2MDk5NDMxOH0.LNozVpUNhbNR09WGCb79vKgUnrtflG2bEwPKQO7Q1oM'

// שימוש ב-Anon Key לבדיקה ראשונית (נצטרך להחליף ל-Service Role Key מאוחר יותר)
export const supabase = createClient(supabaseUrl, supabaseAnonKey) 