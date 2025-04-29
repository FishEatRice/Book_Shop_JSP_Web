# 🌌 Galaxy Bookshelf

**Galaxy Bookshelf** is a Java-based e-commerce web application built for selling books and stationery. Designed with modularity and maintainability in mind, this system includes complete administrative and customer-facing features to manage products, orders, reviews, payments, and more.

---

## 🧰 Tech Stack

- **Java** – JDK 11  
- **Web Server** – Glassfish 6.2.5  
- **Database** – Apache Derby (via Glassfish 4.1 integration)  
- **IDE** – NetBeans IDE 16  
- **Payment Gateway** – Stripe API  

---

## 📦 Features

### 👨‍💼 Staff Management
- Admin (Manager) can **create**, **edit**, **delete**, and **view** staff details.
- Built-in **search** functionality to locate staff records quickly.

### 👥 Customer Management
- Manage customer profiles with **create**, **edit**, **delete**, and **view** operations.
- Includes **search** capability for efficient lookup.

### 📚 Product Management
- Full **CRUD operations** for products.
- **Search** and **filter** tools to help manage and browse products by criteria.

### 🎭 Genre Management
- **Add**, **edit**, **delete**, and **retrieve** genre classifications.
- Supports **search** to find specific genres.

### 💳 Payment Gateway
- Seamless integration with **Stripe** for secure online payments.

### ⭐ Ratings & Reviews
- Customers can leave **comments and reviews** after purchases.
- Staff/Admin can **respond** to customer feedback to handle concerns.

### 📊 Report Management (Admin Only)
- View **sales reports** by day, month, or year.
- Generate summaries including **Top 10 sold products**.

### 🎁 Discount Management
- Admins can **create**, **update**, and **remove** discounts.
- Products display discount status, simplifying promotional management.

---

## 🗄️ Database Configuration

Ensure the following settings are applied in your Derby database setup:

- **Database Name**: `db_galaxy_bookshelf`  
- **Username**: `GALAXY`  
- **Password**: `GALAXY`

---

## 🚀 Getting Started

### Prerequisites

Before running the project, make sure you have the following installed:

- JDK 11  
- Glassfish 6.2.5 (ensure Derby Server from Glassfish 4.1 is configured)  
- NetBeans IDE 16  
- Stripe developer account for API integration  

### Steps to Run

1. Clone the repository or import it into NetBeans.
2. Configure your database connection in `glassfish-resources.xml` or equivalent setup.
3. Deploy the project to Glassfish Server via NetBeans.
4. Access the application through the browser at the Glassfish deployment address (e.g., `http://localhost:8080/GalaxyBookshelf`).

---

## 📌 Notes

- All sensitive credentials (e.g., Stripe API keys) should be stored securely and not hardcoded in the application.
- Derby database must be running before deployment.
- Stripe integration requires a valid internet connection.

---

## 📄 License

This project is for educational and demonstration purposes. You may modify and extend it for personal or institutional use.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Please open a pull request or file an issue to collaborate.

---

## 📧 Contact

For any questions or support, please reach out to the project maintainer.

