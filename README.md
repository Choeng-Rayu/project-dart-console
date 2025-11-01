# Hospital Management System

A comprehensive hospital management system built with Dart, following Clean Architecture principles.

## 📁 Project Structure

```
hospital_management/
├── lib/
│   ├── domain/              # Business logic layer
│   │   ├── entities/        # Core business entities
│   │   │   ├── enums/       # Enumeration types
│   │   │   ├── person.dart
│   │   │   ├── staff.dart
│   │   │   ├── patient.dart
│   │   │   ├── doctor.dart
│   │   │   ├── nurse.dart
│   │   │   ├── administrative.dart
│   │   │   ├── room.dart
│   │   │   ├── bed.dart
│   │   │   ├── equipment.dart
│   │   │   ├── medication.dart
│   │   │   ├── prescription.dart
│   │   │   └── appointment.dart
│   │   ├── repositories/    # Repository interfaces
│   │   │   ├── patient_repository.dart
│   │   │   ├── doctor_repository.dart
│   │   │   ├── nurse_repository.dart
│   │   │   ├── room_repository.dart
│   │   │   ├── prescription_repository.dart
│   │   │   └── appointment_repository.dart
│   │   └── usecases/        # Business use cases
│   │       ├── patient/
│   │       ├── doctor/
│   │       ├── nurse/
│   │       ├── room/
│   │       └── appointment/
│   │
│   ├── data/                # Data handling layer
│   │   ├── datasources/     # Data sources (local/remote)
│   │   │   ├── local/       # Local storage (JSON, SQLite, etc.)
│   │   │   └── remote/      # API calls (if needed)
│   │   ├── models/          # Data models (DTOs)
│   │   │   ├── patient_model.dart
│   │   │   ├── doctor_model.dart
│   │   │   ├── nurse_model.dart
│   │   │   ├── room_model.dart
│   │   │   └── ...
│   │   └── repositories/    # Repository implementations
│   │       ├── patient_repository_impl.dart
│   │       ├── doctor_repository_impl.dart
│   │       └── ...
│   │
│   └── presentation/        # User interface layer
│       ├── console/         # Console-based UI
│       │   ├── menus/       # Menu screens
│       │   │   ├── main_menu.dart
│       │   │   ├── patient_menu.dart
│       │   │   ├── doctor_menu.dart
│       │   │   ├── nurse_menu.dart
│       │   │   ├── room_menu.dart
│       │   │   └── appointment_menu.dart
│       │   └── utils/       # UI utilities
│       │       ├── input_validator.dart
│       │       └── display_formatter.dart
│       └── controllers/     # Business logic controllers
│           ├── patient_controller.dart
│           ├── doctor_controller.dart
│           └── ...
│
├── test/                    # Unit and integration tests
│   ├── domain/
│   ├── data/
│   └── presentation/
│
└── bin/
    └── main.dart           # Application entry point
```

## 📚 Layer Descriptions

### 🎯 Domain Layer (`lib/domain/`)
**Purpose**: Contains the core business logic and rules. This layer is independent of any external frameworks or libraries.

#### `entities/`
- **What**: Pure business objects representing real-world concepts
- **Why**: These are the heart of your application, defining what your system is about
- **Examples**: Patient, Doctor, Room, Prescription
- **Rules**: 
  - No dependencies on other layers
  - Contains only business logic
  - Immutable where possible with private fields

#### `repositories/`
- **What**: Abstract interfaces defining data operations
- **Why**: Allows the domain layer to define what data operations it needs without knowing how they're implemented
- **Examples**: `PatientRepository`, `DoctorRepository`
- **Rules**:
  - Only interfaces/abstract classes
  - No implementation details
  - Uses domain entities, not data models

#### `usecases/`
- **What**: Specific business use cases or actions
- **Why**: Encapsulates single pieces of business logic that orchestrate entities
- **Examples**: `AdmitPatient`, `ScheduleAppointment`, `PrescribeMedication`
- **Rules**:
  - One class per use case
  - Uses repositories to get/save data
  - Contains business validation logic

### 💾 Data Layer (`lib/data/`)
**Purpose**: Handles all data operations - storage, retrieval, and API calls. Implements the repository interfaces defined in the domain layer.

#### `datasources/`
- **What**: Raw data access implementations
- **Why**: Separates the actual data access mechanism from business logic
- **local/**: File storage, JSON, SQLite, shared preferences
- **remote/**: HTTP API calls, web services
- **Examples**: `PatientLocalDataSource`, `DoctorRemoteDataSource`
- **Rules**:
  - Direct access to storage/API
  - Returns data models, not entities
  - Handles serialization/deserialization

#### `models/`
- **What**: Data Transfer Objects (DTOs) that match your storage/API structure
- **Why**: Separates data representation from business entities
- **Examples**: `PatientModel` extends or converts to `Patient` entity
- **Rules**:
  - Contains `fromJson()` and `toJson()` methods
  - Can convert to/from domain entities
  - Matches external data structure

#### `repositories/`
- **What**: Concrete implementations of repository interfaces
- **Why**: Bridges the gap between data sources and domain layer
- **Examples**: `PatientRepositoryImpl implements PatientRepository`
- **Rules**:
  - Implements domain repository interfaces
  - Uses data sources to get data
  - Converts between models and entities
  - Handles error cases

### 🖥️ Presentation Layer (`lib/presentation/`)
**Purpose**: Handles all user interaction - displaying information and capturing input.

#### `console/menus/`
- **What**: Console-based menu screens for user interaction
- **Why**: Provides the user interface for the console application
- **Examples**: Main menu, Patient management menu, Room booking menu
- **Rules**:
  - Handles user input/output
  - Calls controllers for business operations
  - No business logic here

#### `console/utils/`
- **What**: Helper utilities for the console UI
- **Why**: Reusable formatting and validation logic
- **Examples**: Input validators, table formatters, color utilities
- **Rules**:
  - Pure utility functions
  - No business logic
  - Reusable across menus

#### `controllers/`
- **What**: Coordinates between UI and use cases
- **Why**: Keeps UI code clean and testable
- **Examples**: `PatientController`, `AppointmentController`
- **Rules**:
  - Receives requests from UI
  - Calls appropriate use cases
  - Formats responses for UI

## 🔄 How Layers Interact

```
[Presentation Layer]
        ↓
    Controllers
        ↓
[Domain Layer]
    Use Cases → Repository Interfaces
        ↓
[Data Layer]
    Repository Implementations → Data Sources → Storage/API
```

### Data Flow Example: Admitting a Patient
1. **Presentation**: User inputs patient details in `PatientMenu`
2. **Presentation**: `PatientController` receives the input
3. **Domain**: Controller calls `AdmitPatient` use case
4. **Domain**: Use case validates business rules and calls `PatientRepository.save()`
5. **Data**: `PatientRepositoryImpl` converts entity to model
6. **Data**: `PatientLocalDataSource` saves to JSON/database
7. **Response flows back up** through the layers

## 🎯 Key Principles

### Dependency Rule
- **Inner layers don't know about outer layers**
- Domain doesn't know about Data or Presentation
- Data knows about Domain but not Presentation
- Presentation knows about Domain and Data

### Separation of Concerns
- Each layer has a single responsibility
- Business logic stays in Domain
- Data access stays in Data
- UI logic stays in Presentation

### Testability
- Each layer can be tested independently
- Mock repositories for testing use cases
- Mock data sources for testing repositories
- Test business logic without UI or database

## 🚀 Getting Started

### Prerequisites
- Dart SDK 3.0.0 or higher

### Installation
```bash
# Install dependencies
dart pub get

# Run the application
dart run bin/main.dart

# Run tests
dart test
```

## 📝 Development Workflow

1. **Start with Domain**: Define entities and their relationships
2. **Define Repositories**: Create interfaces for data operations needed
3. **Create Use Cases**: Implement business logic using entities and repositories
4. **Implement Data Layer**: Create models and repository implementations
5. **Build Presentation**: Create menus and controllers
6. **Test**: Write tests for each layer

## 🧪 Testing Strategy

- **Unit Tests**: Test individual classes and methods
- **Integration Tests**: Test interaction between layers
- **Domain Tests**: Focus on business logic validation
- **Data Tests**: Mock data sources, test repositories
- **Presentation Tests**: Test controllers and input validation

## 📄 License

This project is for educational purposes.

## 👥 Contributors

- Development Team

---

**Note**: This is a console-based application following Clean Architecture principles. The structure supports easy migration to GUI (Flutter) or web interfaces in the future.