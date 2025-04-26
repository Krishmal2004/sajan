<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Dashboard | Lotus Events</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600;700&family=Raleway:wght@300;400;500;600&family=Great+Vibes&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #bc8f8f;
            --secondary: #deb887;
            --accent: #d2691e;
            --text: #2c3e50;
            --light: #faf0e6;
            --white: #ffffff;
            --dark: #343a40;
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
            --gray: #6c757d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Raleway', sans-serif;
        }

        body {
            background: #f8f9fa;
            color: var(--text);
            line-height: 1.6;
        }

        .top-bar {
            background: var(--dark);
            color: var(--white);
            padding: 10px 0;
        }

        .top-bar-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-info i {
            margin-right: 5px;
        }

        .header {
            background: var(--white);
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            padding: 15px 0;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-family: 'Great Vibes', cursive;
            font-size: 2.5em;
            color: var(--primary);
            text-decoration: none;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--white);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .stat-card h3 {
            color: var(--gray);
            font-size: 1em;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 2em;
            font-weight: 600;
            color: var(--primary);
        }

        .recent-bookings {
            background: var(--white);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 1.5em;
            color: var(--text);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--light);
        }

        .booking-list {
            list-style: none;
        }

        .booking-item {
            padding: 15px;
            border-bottom: 1px solid var(--light);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .booking-info {
            flex: 1;
        }

        .booking-title {
            font-weight: 600;
            color: var(--text);
            margin-bottom: 5px;
        }

        .booking-meta {
            font-size: 0.9em;
            color: var(--gray);
        }

        .booking-status {
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 500;
        }

        .status-pending {
            background: var(--warning);
            color: var(--dark);
        }

        .status-confirmed {
            background: var(--success);
            color: var(--white);
        }

        .actions-menu {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .action-btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            background: var(--primary);
            color: var(--white);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .action-btn:hover {
            background: var(--accent);
            transform: translateY(-2px);
        }

        .reviews-section {
            background: var(--white);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .review-item {
            padding: 15px;
            border-bottom: 1px solid var(--light);
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .reviewer-name {
            font-weight: 600;
        }

        .review-rating {
            color: var(--warning);
        }

        .review-content {
            color: var(--text);
            font-size: 0.95em;
        }

        @media (max-width: 768px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .actions-menu {
                flex-direction: column;
            }

            .action-btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="top-bar">
        <div class="top-bar-content">
            <div class="user-info">
                <div>
                    <i class="far fa-clock"></i>
                    <span>2025-04-26 20:26:48</span>
                </div>
                <div>
                    <i class="fas fa-user"></i>
                    <span>Krishmal2004</span>
                </div>
            </div>
            <div>
                <a href="logout" class="action-btn" style="padding: 5px 15px; font-size: 0.9em;">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </div>

    <header class="header">
        <div class="header-content">
            <a href="index.jsp" class="logo">Lotus Events</a>
            <nav class="nav-links">
                <!-- Add navigation if needed -->
            </nav>
        </div>
    </header>

    <div class="dashboard-container">
        <div class="actions-menu">
            <button class="action-btn">
                <i class="fas fa-plus"></i> Add New Service
            </button>
            <button class="action-btn">
                <i class="fas fa-calendar-alt"></i> Manage Bookings
            </button>
            <button class="action-btn">
                <i class="fas fa-cog"></i> Settings
            </button>
        </div>

        <div class="dashboard-grid">
            <div class="stat-card">
                <h3>Total Bookings</h3>
                <div class="stat-value">28</div>
            </div>
            <div class="stat-card">
                <h3>Pending Bookings</h3>
                <div class="stat-value">5</div>
            </div>
            <div class="stat-card">
                <h3>Average Rating</h3>
                <div class="stat-value">4.8</div>
            </div>
            <div class="stat-card">
                <h3>Total Revenue</h3>
                <div class="stat-value">$12,450</div>
            </div>
        </div>

        <div class="recent-bookings">
            <h2 class="section-title">Recent Bookings</h2>
            <ul class="booking-list">
                <li class="booking-item">
                    <div class="booking-info">
                        <div class="booking-title">Wedding Photography Package</div>
                        <div class="booking-meta">John & Sarah • May 15, 2025</div>
                    </div>
                    <span class="booking-status status-confirmed">Confirmed</span>
                </li>
                <li class="booking-item">
                    <div class="booking-info">
                        <div class="booking-title">Full Day Event Coverage</div>
                        <div class="booking-meta">Michael & Emma • June 2, 2025</div>
                    </div>
                    <span class="booking-status status-pending">Pending</span>
                </li>
                <!-- Add more booking items as needed -->
            </ul>
        </div>

        <div class="reviews-section">
            <h2 class="section-title">Recent Reviews</h2>
            <div class="review-item">
                <div class="review-header">
                    <span class="reviewer-name">Emily Johnson</span>
                    <span class="review-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </span>
                </div>
                <p class="review-content">
                    Amazing service! The photographs captured our special day perfectly.
                </p>
            </div>
            <!-- Add more review items as needed -->
        </div>
    </div>

    <script>
        // Add any JavaScript functionality here
        document.addEventListener('DOMContentLoaded', function() {
            // Update current time
            setInterval(() => {
                document.querySelector('.user-info .far.fa-clock').nextElementSibling.textContent = 
                    "2025-04-26 20:26:48";
            }, 1000);
        });
    </script>
</body>
</html>