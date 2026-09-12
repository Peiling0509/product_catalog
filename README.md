# 📱 Product Catalog

A Flutter product catalog app built for the **Neurogine Junior Mobile Developer Technical Assessment**.

The app uses the **DummyJSON API** to display products with pagination, search, and product details.

## ✨ Features

* 📦 Product listing with title, thumbnail, and price
* 🔄 Infinite scroll pagination
* 🔍 Debounced server-side search
* 📄 Product detail screen
* ⭐ Product rating and image gallery
* 🔄 Pull-to-refresh
* ⚠️ Loading, success, empty, and error states
* 🔁 Retry failed requests
* 🖼️ Image loading and error handling
* 🧪 Unit tests for JSON model parsing

## 📸 Screenshots

| Product List                                                                                                                 | Search                                                                                                                 | Product Details                                                                                                                 |
| ---------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| <img width="240" alt="Product List" src="https://github.com/user-attachments/assets/296b9289-ce3d-47ea-9844-ba6ae968313d" /> | <img width="240" alt="Search" src="https://github.com/user-attachments/assets/5ce8b160-33b3-42c8-84d6-bc907122453f" /> | <img width="240" alt="Product Details" src="https://github.com/user-attachments/assets/0fff044d-22bd-4e5d-a608-6ee156ac42fd" /> |

## 🛠️ Tech Stack

| Technology         | Purpose            |
| ------------------ | ------------------ |
| **Flutter / Dart** | Mobile application |
| **GetX**           | State management   |
| **HTTP**           | REST API requests  |
| **DummyJSON**      | Product data       |

## 🏗️ Architecture

The project uses a simple layered architecture suitable for a small application:

```text
Views / Widgets
       ↓
   Controllers
       ↓
   API Service
       ↓
   DummyJSON API
```

### Project Structure

```text
lib/
├── core/
│   └── app_theme.dart                 # App-wide theme and styling
│
├── data/
│   ├── models/
│   │   ├── product.dart               # Product list model
│   │   └── product_details.dart       # Product detail model
│   │
│   └── services/
│       └── product_api_service.dart   # DummyJSON API requests
│
├── controllers/
│   └── product_controller.dart        # State management and business logic
│
├── views/
│   ├── product_list_view.dart         # Product list screen
│   └── product_detail_view.dart       # Product detail screen
│
├── widgets/
│   ├── product_card.dart              # Reusable product card
│   └── product_image.dart             # Image loading/error handling
│
└── main.dart                          # App entry point
```

I kept the architecture intentionally simple to avoid unnecessary abstraction for a small assessment project.

## 🔍 Key Implementation Decisions

### Pagination

Products are loaded using DummyJSON's `limit` and `skip` parameters.

```text
limit=20
skip=0
```

When the user scrolls near the bottom, the next page is loaded.

The existing products remain visible while loading more items.

### Search

Search uses DummyJSON's server-side search endpoint:

```text
/products/search?q={query}
```

A **400ms debounce** prevents a request from being sent for every keystroke.

When the search field is cleared, the app returns to the normal paginated product list.

### UI States

The app handles four main states:

* **Loading** — request is in progress
* **Success** — data is displayed
* **Empty** — no products found
* **Error** — request failed, with a Retry action

## 🧪 Testing

Unit tests are included for:

* `Product.fromJson`
* `ProductDetails.fromJson`

Run tests with:

```bash
flutter test
```

## 🚀 Getting Started

### Requirements

* Flutter SDK
* Dart SDK
* Android Studio / VS Code
* Android emulator, iOS simulator, or physical device

### Installation

```bash
git clone https://github.com/Peiling0509/product_catalog.git

cd product_catalog

flutter pub get

flutter run
```

### Run Tests

```bash
flutter test
```

### Static Analysis

```bash
flutter analyze
```

## 🔮 Future Improvements

If this were developed beyond the assessment, possible improvements include:

* Local caching / offline support
* Fuzzy search
* Authentication
* Favourites / shopping cart
* Advanced animations
* Production backend integration

These were intentionally excluded to keep the implementation focused on the assessment requirements.

## 🤖 AI Assistance

**ChatGPT** was used minimally for technical guidance, Flutter/Dart API references, and exploring implementation approaches.

The application logic, project structure, implementation, and architectural decisions were developed and reviewed by me.

I have reviewed the submitted code and can explain the implementation and design decisions in this project.
