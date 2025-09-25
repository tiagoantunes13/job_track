# Job Track

A simple job application tracking system built with Rails. Helps you keep track of job applications, generate cover letters, and manage your job search.

## What it does

- Track job applications with status updates
- Store your profile with education, experience, and skills
- Generate cover letters automatically using AI
- Upload and manage your CV
- Keep notes on each application
- Search for jobs using SerpAPI (Google Jobs API)
- Parse uploaded CVs to auto-populate your profile

## Setup

```bash
bundle install
rails db:create db:migrate
bin/dev
```

## Usage

Create an account, fill out your profile, then start adding and tracking your job applications. You can also generate cover letters and search for new jobs, but the main focus is keeping track of where you've applied and what stage each application is at.

## AI Features

The app uses AI for a few things:
- **Cover letter generation**: Uses the Ruby LLM gem to create personalized cover letters by matching your profile with job descriptions
- **Remote location checking**: AI analyzes job postings to determine if positions are remote-friendly
- **CV parsing**: Upload your CV and AI will parse it to automatically create your profile with all your experience, skills, and education

## Job Search

Uses SerpAPI to pull job listings directly from Google's job search API. Not AI-powered, just good old API integration to get fresh job postings.

## Tech Stack

- Rails 8
- PostgreSQL
- Tailwind CSS
- Hotwire (Turbo + Stimulus)
- Devise for authentication
- Ruby LLM gem for all AI functionality
- SerpAPI for Google Jobs API integration

That's about it. Pretty straightforward job tracking app.