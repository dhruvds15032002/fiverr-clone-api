# 🎯 Fiverr Clone API

A backend API-only application inspired by [Fiverr](https://fiverr.com), built with Ruby on Rails.  
This project allows freelancers and clients to connect, create gigs, place orders, and manage workflows — mimicking the core functionalities of a freelancing marketplace.

---

## ⚙️ Tech Stack

- **Ruby**: 3.2.3  
- **Rails**: 7.1.3 (API-only mode)  
- **Database**: PostgreSQL  
- **Authentication**: JWT (JSON Web Token)  
- **Background Jobs**: Sidekiq  
- **Testing**: RSpec + FactoryBot

---
Setup

git clone https://github.com/your-username/fiverr_clone_api.git
cd fiverr_clone_api

rbenv local 3.2.3
bundle install

rails db:create db:migrate
rails s

Start with **master** Branch.

🔐 Authentication (JWT)
Users receive a JWT token on successful login.

All protected endpoints require Authorization: Bearer <token> header.

Devise + JWT setup (or custom token auth based on your configuration).



## 🚀 Features

- 👤 User Authentication & Role-based Access (Client / Freelancer)
- 🛒 Gig Management (Create, Update, Delete Services)
- 📦 Order Flow (Place, Accept, Reject, Mark as Complete)
- ✍️ Reviews and Ratings System
- 💬 Conversations and Messaging *(coming soon)*
- 📊 Admin-level APIs *(optional)*
- ✅ Email notifications (on order events)

---

🛠️ Getting Started
Prerequisites
Ruby 3.2.3

Rails 7.1.3

PostgreSQL

rbenv or rvm (recommended)


## 📁 Folder Structure (Overview)

```plaintext
app/
  controllers/         # API endpoints
  models/              # ActiveRecord models
  serializers/         # JSON serialization logic
  services/            # Business logic (optional)
  jobs/                # Background workers (if enabled)
spec/
  requests/            # RSpec API test cases
config/
  routes.rb            # API routing

✅ Future Enhancements
✅ Email notifications (on order events)

✅ Real-time messaging using ActionCable or external service

✅ Payment gateway integration (e.g., Razorpay / Stripe sandbox)

✅ Gig packages (Basic / Standard / Premium)

✅ Admin Dashboard APIs


