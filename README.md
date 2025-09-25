# Job Track

A simple job application tracking system built with Rails. Helps you keep track of job applications, generate cover letters, and manage your job search.

## What it does

- Track job applications with status updates (applied, interviewing, rejected, etc.)
- Store your profile with education, experience, and skills
- Generate cover letters automatically using AI
- Upload and manage your CV
- Keep notes on each application

## Setup

You'll need Ruby 3.x and PostgreSQL installed.

```bash
bundle install
rails db:create db:migrate
rails server
```

## Usage

Create an account, fill out your profile, then start tracking your job applications. The app will help you generate cover letters based on your profile and the job description.

## Tech Stack

- Rails 8
- PostgreSQL
- Tailwind CSS
- Hotwire (Turbo + Stimulus)
- Devise for authentication

That's about it. Pretty straightforward job tracking app.