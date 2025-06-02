<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sresta Organic Farms</title>
    <style>
        :root {
            --primary: #388e3c;
            --secondary: #a5d6a7;
            --accent: #fffde7;
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: var(--accent);
            margin: 0;
            padding: 0;
        }
        .navbar {
            background: var(--primary);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar h1 {
            margin: 0;
            font-size: 2rem;
            letter-spacing: 2px;
        }
        .cart-icon {
            position: relative;
            font-size: 1.5rem;
            cursor: pointer;
        }
        .cart-count {
            background: var(--secondary);
            color: var(--primary);
            padding: 2px 8px;
            border-radius: 50%;
            position: absolute;
            top: -10px;
            right: -15px;
            font-size: 1rem;
        }
        .hero {
            background: linear-gradient(90deg, #a5d6a7 60%, #fffde7 100%);
            padding: 2rem;
            text-align: center;
        }
        .hero h2 {
            color: var(--primary);
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        .hero p {
            color: #555;
            font-size: 1.2rem;
        }
        .products {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 2rem;
            padding: 2rem;
            max-width: 1100px;
            margin: 0 auto;
        }
        .product-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(56, 142, 60, 0.08);
            padding: 1.5rem;
            text-align: center;
            transition: box-shadow 0.2s;
        }
        .product-card:hover {
            box-shadow: 0 4px 16px rgba(56, 142, 60, 0.16);
        }
        .product-card img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            margin-bottom: 1rem;
        }
        .product-card h3 {
            margin: 0.5rem 0 0.2rem 0;
            color: var(--primary);
        }
        .product-card p {
            color: #444;
            margin-bottom: 0.7rem;
        }
        .product-card button {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.2s;
        }
        .product-card button:hover {
            background: #256029;
        }
        .footer {
            background: var(--primary);
            color: white;
            text-align: center;
            padding: 1rem;
            margin-top: 2rem;
        }
        @media (max-width: 600px) {
            .navbar, .hero, .footer {
                padding: 1rem;
            }
            .hero h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>Sresta Organic Farms</h1>
        <div class="cart-icon" onclick="alert('Cart coming soon!')">
            🛒 <span class="cart-count">0</span>
        </div>
    </nav>

    <section class="hero">
        <h2>Welcome to Sresta Organic Farms</h2>
        <p>Fresh, organic produce delivered from our farm to your doorstep. Eat healthy, live healthy!</p>
    </section>

    <section class="products">
        <div class="product-card">
            <img src="https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=400&q=80" alt="Organic Tomatoes">
            <h3>Organic Tomatoes</h3>
            <p>₹60 per kg</p>
            <button onclick="addToCart(1, 'Organic Tomatoes', 60)">Add to Cart</button>
        </div>
        <div class="product-card">
            <img src="https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80" alt="Fresh Carrots">
            <h3>Fresh Carrots</h3>
            <p>₹50 per kg</p>
            <button onclick="addToCart(2, 'Fresh Carrots', 50)">Add to Cart</button>
        </div>
        <div class="product-card">
            <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80" alt="Organic Spinach">
            <h3>Organic Spinach</h3>
            <p>₹40 per bunch</p>
            <button onclick="addToCart(3, 'Organic Spinach', 40)">Add to Cart</button>
        </div>
        <div class="product-card">
            <img src="https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=400&q=80" alt="Farm Eggs">
            <h3>Farm Eggs (12 pcs)</h3>
            <p>₹90 per dozen</p>
            <button onclick="addToCart(4, 'Farm Eggs', 90)">Add to Cart</button>
        </div>
    </section>

    <footer class="footer">
        &copy; 2025 Sresta Organic Farms. All rights reserved.
    </footer>

    <script>
        // Simple cart using localStorage
        let cart = JSON.parse(localStorage.getItem('sresta_cart')) || [];

        function updateCartCount() {
            document.querySelector('.cart-count').textContent = cart.reduce((sum, item) => sum + item.qty, 0);
        }

        function addToCart(id, name, price) {
            const existing = cart.find(item => item.id === id);
            if (existing) {
                existing.qty += 1;
            } else {
                cart.push({ id, name, price, qty: 1 });
            }
            localStorage.setItem('sresta_cart', JSON.stringify(cart));
            updateCartCount();
            alert(name + " added to cart!");
        }

        // Initialize cart count on page load
        updateCartCount();
    </script>
</body>
</html>
