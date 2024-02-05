# MojStomatolog

MojStomatolog is an integrated dental practice management solution featuring a mobile app for patients and a desktop app for employees. The desktop application facilitates the management of content, scheduling, and analytics, while the mobile app enhances patient engagement by allowing them to view content, schedule appointments, and purchase products.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Flutter SDK
- Dart
- Docker
- Docker Compose

Optionally, for mobile app testing:

- Android Studio

### Installation

1. Clone the repository: `git clone https://github.com/nisicadi/MojStomatolog.git`
2. Navigate to the project directory: `cd MojStomatolog`
3. To run the Flutter application, specify your device or platform: `flutter run -d [device/platform]`

### Running the Application

To run the Dockerized API, MailingService, database, and RabbitMQ:

1. Ensure Docker and Docker Compose are installed.
2. Build and start all services: `docker-compose up --build`
3. To stop the services: `docker-compose down`


## Technologies, Libraries, and Plugins

- **Flutter** for mobile and desktop application development.
- **ML.NET** for collaborative filtering.
- **Stripe** for payment integration.
- **RabbitMQ** for message queuing.

## Credentials

### Desktop App

- **Username:** desktop
- **Password:** test

### Mobile App

- **Username:** mobile
- **Password:** test

### Credit Card (For Testing Purposes)

- **Card Number:** 4242 4242 4242 4242
- **Expiration:** 12/34
- **CCV:** 567
- **ZIP Code:** 12345

## Testing the MailingService

Create an order in the application to test the MailingService functionalities.

