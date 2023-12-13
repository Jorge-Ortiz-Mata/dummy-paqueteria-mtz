# Paquetería Martínez.

<img src="./app/assets/images/logo-paqueteria.png" width="100" height="100">

This is the official GitHub repository for the Paqueteria Martniez web application

## Description.

At Paquetería Martinez, we're more than just a delivery service – we're your reliable partner in getting your packages from point A to point B, quickly and securely. We understand the importance of efficient and dependable delivery, whether it's for personal or business needs.

## Our Mission:
Our mission is to simplify and streamline the delivery process, making it as convenient as possible for our customers. We aim to provide a seamless experience that allows you to focus on what matters most, while we take care of the rest.

## What Sets Us Apart:

- Speed and Efficiency: We pride ourselves on our swift delivery services. Whether it's a same-day delivery, next-day delivery, or scheduled deliveries, we ensure your packages reach their destination on time.

- Reliability: You can count on us. We've built a reputation for trustworthiness, and we handle your packages with the utmost care to ensure they arrive in perfect condition.

- Customized Solutions: We offer tailored delivery solutions to meet the unique needs of individuals, small businesses, e-commerce retailers, and larger corporations. No delivery task is too small or too big for us.

- Advanced Tracking: With our state-of-the-art tracking systems, you can monitor your deliveries in real-time, giving you peace of mind and transparency throughout the entire process.

- Eco-Friendly Initiatives: We care about the environment, and our commitment to sustainability is evident in our eco-friendly delivery practices and innovative solutions.

- Exceptional Customer Service: Our dedicated customer service team is always ready to assist you with any inquiries or special requests, ensuring your experience with us is pleasant and hassle-free.

## Industries We Serve:

E-commerce
Retail
Healthcare
Manufacturing
Restaurants
Individuals and Families
Service Offerings:

## Advantages

- Same-day delivery
- Next-day delivery
- Scheduled deliveries
- International shipping
- Specialized services for fragile or sensitive items
- Last-mile delivery solutions

## Join Us on Our Journey:

Paquetería Martinez is committed to pushing the boundaries of what's possible in the delivery industry. We're continuously innovating and adapting to meet the changing needs of our customers. Join us on our journey to create a better, faster, and more efficient delivery experience for everyone.

Choose Paquetería Martinez for all your delivery needs, and experience the difference in our service. We're more than just a delivery company – we're your delivery partner.

## Local Development.

In order to launch this web application in local development, we need to install Docker and launch de PSQL server:

```
docker run -p 5432:5432 --rm --name postgresql-container -e POSTGRES_PASSWORD=postgres -v dummy-paqueteria-martinez:/var/lib/postgresql/data postgres
```
