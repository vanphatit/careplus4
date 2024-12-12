# CarePlus 4 - Functional Food E-Commerce System

## Overview
CarePlus 4 is a comprehensive e-commerce system designed for the sale and management of functional foods. Built with modern Java technologies and tools, this project leverages robust frameworks and libraries to ensure scalability, security, and user experience.

### Project Members
1. **Lê Văn Phát** - Team Leader
2. **Huỳnh Thanh Duy** - Contributor
3. **Nguyễn Chí Thanh** - Contributor
4. **Trần Như Quỳnh** - Contributor

## Features
- **User Management**: Registration, authentication, and role-based access using JWT.
- **Google OAuth2 Authentication**: Login with Google account using OAuth2.
- **OTP Authentication**: Reset password with One-Time Password (OTP) sent by email.
- **Product Management**: CRUD operations for product catalog with category filtering.
- **Order Management**: Cart functionalities and order history.
- **Shipping Management**: Integration with external shipping API for delivery calculation and tracking.
- **Responsive Design**: UI built with Bootstrap for cross-device compatibility.
- **Security**: Secure data access with Spring Security, JWT tokens, and multi-factor authentication.
- **Performance**: Optimized web pages with Sitemesh for dynamic content decoration.

## Tech Stack
- **Backend**: Spring Boot, JPA (Java Persistence API)
- **Frontend**: JSP (Java Server Pages), Bootstrap
- **Database**: MySQL
- **Security**: Spring Security, JWT (JSON Web Token), Google OAuth2, OTP
- **Shipping API**: Integration with [careplus4_shipping](https://github.com/Killig3110/careplus4_shipping)
- **UI Layout**: Decorator Sitemesh

## Requirements
- **Java**: Version 8 or higher
- **Maven**: For project dependency management
- **MySQL**: Database setup
- **Tomcat Server**: For deployment
- **Shipping API**: The shipping service must be running before starting this application.

## Setup Instructions
### 1. Clone and Setup the Shipping API
1. Clone the repository for the shipping API:
   ```bash
   git clone https://github.com/Killig3110/careplus4_shipping.git
   cd careplus4_shipping
   ```
2. Follow the setup instructions in the `careplus4_shipping` README to configure and start the API service.
3. Ensure the API is running and accessible on the configured port (e.g., `http://localhost:8080`).

### 2. Clone the Main Repository
1. Clone this repository:
   ```bash
   git clone https://github.com/vanphatit/careplus4.git
   cd careplus4
   git checkout dev
   ```

### 3. Database Configuration
- Create a MySQL database named `careplus4`.
- Update the `application.properties` file with your MySQL credentials:
  ```properties
  spring.datasource.url=jdbc:mysql://localhost:3306/careplus4
  spring.datasource.username=YOUR_USERNAME
  spring.datasource.password=YOUR_PASSWORD
  ```

### 4. Access the System
- Open your browser and navigate to `http://localhost:9090`.

## Security Features
- **JWT Authentication**: For secure and stateless user sessions.
- **Google OAuth2 Sign-In**: Simplifies authentication via Google accounts.
- **OTP Two-Factor Authentication**: Adds an additional layer of security by requiring a One-Time Password (OTP) at register or reset password.

## Shipping API Integration
- This application integrates with the external shipping API to handle:
  - Delivery cost calculations.
  - Order tracking.
- Ensure the shipping API is running on the configured base URL (`http://localhost:8080`).

## Development Branch
Ensure you're working on the latest `dev` branch for development purposes. All new features and fixes should be merged into this branch.

## Contact
For any queries or contributions, please contact [Phat Van](mailto:vanphat15it@gmail.com).
