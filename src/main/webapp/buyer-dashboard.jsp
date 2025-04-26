<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buyer Dashboard | Lotus Events</title>
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
            --info: #17a2b8;
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .current-info {
            display: flex;
            gap: 20px;
            align-items: center;
            font-size: 0.9em;
        }

        .header {
            background: var(--white);
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            padding: 15px 0;
            margin-bottom: 40px;
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
            margin: 0 auto;
            padding: 0 20px;
        }

        .welcome-section {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: var(--white);
            padding: 40px;
            border-radius: 15px;
            margin-bottom: 40px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .welcome-section h1 {
            font-size: 2em;
            margin-bottom: 10px;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .action-card {
            background: var(--white);
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .action-card:hover {
            transform: translateY(-5px);
        }

        .action-icon {
            font-size: 2.5em;
            color: var(--primary);
            margin-bottom: 15px;
        }

        .upcoming-events {
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

        .event-list {
            list-style: none;
        }

        .event-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid var(--light);
        }

        .event-info {
            flex: 1;
        }

        .event-title {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .event-meta {
            font-size: 0.9em;
            color: #666;
        }

        .event-status {
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 500;
        }

        .status-upcoming {
            background: var(--info);
            color: var(--white);
        }

        .saved-vendors {
            background: var(--white);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .vendor-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .vendor-card {
            background: var(--light);
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }

        .vendor-logo {
            width: 80px;
            height: 80px;
            background: var(--white);
            border-radius: 50%;
            margin: 0 auto 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
            color: var(--primary);
        }

        .logout-btn {
            background: transparent;
            color: var(--white);
            border: 1px solid var(--white);
            padding: 5px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: var(--white);
            color: var(--dark);
        }

        @media (max-width: 768px) {
            .quick-actions {
                grid-template-columns: 1fr;
            }

            .vendor-grid {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            }
        }
    </style>
</head>
<body>
    <div class="top-bar">
        <div class="top-bar-content">
            <div class="current-info">
                <div>
                    <i class="far fa-clock"></i>
                    <span>2025-04-26 20:34:11</span>
                </div>
                <div>
                    <i class="fas fa-user"></i>
                    <span>Krishmal2004</span>
                </div>
            </div>
            <button class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>
    </div>

    <header class="header">
        <div class="header-content">
            <a href="index.jsp" class="logo">Lotus Events</a>
        </div>
    </header>

    <div class="dashboard-container">
        <section class="welcome-section">
            <h1>Welcome Back, Krishmal2004!</h1>
            <p>Start planning your perfect event today.</p>
        </section>

        <section class="quick-actions">
            <div class="action-card">
                <div class="action-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h3>Find Vendors</h3>
                <p>Explore our network of professional vendors</p>
            </div>
            <div class="action-card">
                <div class="action-icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <h3>Plan Event</h3>
                <p>Create and manage your event timeline</p>
            </div>
            <div class="action-card">
                <div class="action-icon">
                    <i class="fas fa-tasks"></i>
                </div>
                <h3>Checklist</h3>
                <p>Track your planning progress</p>
            </div>
            <div class="action-card">
                <div class="action-icon">
                    <i class="fas fa-heart"></i>
                </div>
                <h3>Wishlist</h3>
                <p>Save your favorite vendors and ideas</p>
            </div>
        </section>

        <section class="upcoming-events">
            <h2 class="section-title">Your Upcoming Events</h2>
            <ul class="event-list">
                <li class="event-item">
                    <div class="event-info">
                        <div class="event-title">Wedding Ceremony</div>
                        <div class="event-meta">
                            <i class="far fa-calendar"></i> June 15, 2025
                            <i class="fas fa-map-marker-alt"></i> Crystal Gardens
                        </div>
                    </div>
                    <span class="event-status status-upcoming">Upcoming</span>
                </li>
                <!-- Add more events as needed -->
            </ul>
        </section>

        <section class="saved-vendors">
            <h2 class="section-title">Saved Vendors</h2>
            <div class="vendor-grid">
                <div class="vendor-card">
                    <div class="vendor-logo">
                        <i class="fas fa-camera"></i>
                    </div>
                    <h3>Capture Moments</h3>
                    <p>Photography</p>
                </div>
                <div class="vendor-card">
                    <div class="vendor-logo">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <h3>Gourmet Catering</h3>
                    <p>Catering</p>
                </div>
                <!-- Add more vendor cards as needed -->
            </div>
        </section>
    </div>

    <script>
        // Update time display
        setInterval(() => {
            document.querySelector('.current-info .far.fa-clock').nextElementSibling.textContent = 
                "2025-04-26 20:34:11";
        }, 1000);

        // Add logout functionality
        document.querySelector('.logout-btn').addEventListener('click', () => {
            window.location.href = 'logout';
        });
    </script>
</body>
</html>