# Project Memory: School Finance Administration System (SFAS)

> [!IMPORTANT]
> **STRICT INSTRUCTION FOR ALL SUBSEQUENT AGENTS:**
> This file is the absolute source of truth for the project. **Do not delete any content from this file under any circumstances.** You are only permitted to **append** new information, decisions, and statuses. Ensure you read this document thoroughly before commencing any work.

## 1. System Overview
The School Finance Administration System (SFAS) is designed to manage school financial operations, bridging the gap between school supervisors (Admins) and finance officers (Company Side). 
**Core Problems Solved:**
- Eliminating errors from manual handling of financial bills.
- Enabling real-time communication between the school and the company.
- Tracking financial collections regularly (Daily, Weekly, Monthly, Annual).
- Eliminating delays in generating and reviewing financial reports.

## 2. Technology Stack & Architecture
- **Frontend:** Angular 21
- **Backend:** Java 21 & Spring Boot 4.1.0
- **Database:** PostgreSQL
- **Architecture Type:** Layered REST API Architecture (Frontend -> Backend API -> Database)
- **Methodology:** Agile / Scrum

## 3. Actors
1. **Admin (School Supervisor):** Responsible for entering bills, managing collections, requesting funds, and generating reports.
2. **Finance Officer (Company Side):** Responsible for receiving notifications, reviewing submitted bills, reports, and fund requests.

## 4. Comprehensive User Stories
*(Extracted and inferred from the SDD, SRS, and existing component structure)*

### Authentication & Access
- **[US1]** As an Admin/Finance Officer, I want to log into the system securely, so that I can access my dashboard. (High | 1 week)
- **[US2]** As a User, I want to securely log out of the system.

### Bills Management
- **[US3]** As an Admin, I want to add a new bill with details (amount, tax, date, vendor), so that it can be processed. (High | 2 weeks)
- **[US4]** As an Admin, I want to upload bill images, so that there is digital proof of the transaction.
- **[US5]** As an Admin, I want to send bills to the finance officer, so that they can be reviewed and approved.

### Request Funds
- **[US6]** As an Admin, I want to generate a Request Funds Report detailing school needs and urgency level, so that I can request necessary funding. (High | 2 weeks)
- **[US7]** As an Admin, I want to send the Funds Request Report to the company.

### Collections Management
- **[US8]** As an Admin, I want to manage and view collections for bills (Daily, Weekly, Monthly, and Annual), so that I know the numbers and values of collections accurately. (Medium | 2 weeks)

### Reports
- **[US9]** As an Admin, I want to generate financial reports, so that I can track performance. (Medium | 2 weeks)
- **[US10]** As an Admin, I want to send reports to the company for transparency.

### Notifications & Review
- **[US11]** As an Admin, I want the system to send notifications when bills, reports, or fund requests are generated, so the finance officer is immediately informed. (High | 1 week)
- **[US12]** As a Finance Officer, I want to receive real-time notifications, so that I can review incoming bills, reports, or Request Funds. (High | 1 week)

## 5. Screen Inventory (Estimated 8 Screens)
1. **Login Screen:** Authentication for all users.
2. **Admin Dashboard:** Overview of all modules.
3. **Finance Officer Dashboard:** Central view for reviewing incoming documents.
4. **Bills Management Screen:** Component for adding bills, uploading images, and listing bills.
5. **Request Funds Screen:** Component to formulate and send fund requests.
6. **Collections Screen:** Component to track and view categorized collections.
7. **Reports Screen:** Component for generating and sending performance reports.
8. **Notifications Screen / Dropdown:** Interface to view system alerts.

## 6. Database Design (Entities)
- **Users:** `id`, `name`, `role`, `email`, `password`
- **Bills:** `id`, `title`, `vendor`, `amount`, `date`, `image`, `tax`, `description`, `status`
- **Request Funds:** `id`, `title`, `description`, `amount of fund`, `urgency level`, `date`, `image`
- **Collections:** `id`, `date`, `type` (Daily/Weekly/Monthly/Annual)
- **Reports:** `id`, `date`, `title`, `description`, `type of report` (email or in-App)

## 7. Security Design
- JWT Authentication
- Role-Based Access Control (Admin vs. Finance Officer)
- Password Hashing via BCrypt
- Strict data protection policies

## 8. Development Rules
- **No Legacy Code Usage:** Do not build upon or modify the code inside the legacy `basis` folder. All development must be done from scratch outside of it, ensuring adherence to modern standards.
- **Think Before Creating:** It is mandatory to think deeply and more than once before creating or implementing any new component, feature, or logic.
- **Continuous Documentation:** Any new decision, feature, or structural change made MUST be immediately documented and appended to this `memory.md` file.

## 9. Backend Implementation Summary

**Initial Prompt:**
> You are a Principal Enterprise Software Architect and Senior Java Developer operating in 2026. Your expertise lies in Java 21+ and the cutting-edge Spring Boot 4.1.0 ecosystem (Spring Framework 7.0+, Jakarta EE 11, Jackson 3).
> 
> I am building the backend for the "School Finance Administration System (SFAS)". The database connection to PostgreSQL is configured in `application.properties` using `spring.jpa.hibernate.ddl-auto=update`. 
> 
> Your task is to generate the production-ready backend code. You must adhere strictly to Clean Architecture, SOLID principles, and the modern features of Spring Boot 4.1.0. **Do not write legacy Spring Boot 2.x/3.x code.**
> 
> ### 1. Technology Stack & Modern 2026 Practices
> - **Core:** Java 21 (Use `Records` for all DTOs, Pattern Matching, and Switch Expressions).
> - **Framework:** Spring Boot 4.1.0.
> - **Concurrency:** Fully leverage Java 21 Virtual Threads (`spring.threads.virtual.enabled=true` assumed).
> - **Null-Safety:** Utilize **JSpecify** annotations (`@Nullable`, `@NonNull`) which are standard in Spring Boot 4.
> - **Performance:** Assume `spring.datasource.connection-fetch=lazy` is used; optimize JPA queries to prevent N+1 problems (Use `@EntityGraph` or JOIN FETCH).
> - **Serialization:** Jackson 3 (default in Spring Boot 4).
> - **Database:** PostgreSQL with Spring Data JPA.
> - **Security:** Spring Security 7+ with JWT stateless authentication.
> 
> ### 2. Strict Architectural Rules
> - **Strict Layering:** Controllers -> Service Interfaces -> Service Implementations -> Repositories -> Database.
> - **Domain Isolation:** Database Entities MUST NEVER leak into Controllers. Use Java `Record` classes exclusively for Request/Response DTOs. MapStruct or modern manual mapping must be used.
> - **Error Handling:** Use `@ControllerAdvice` extending `ResponseEntityExceptionHandler` and implement **RFC 7807 ProblemDetail** for all standardized JSON error responses (e.g., Validation Errors, 404, 401, 403).
> - **Validation:** Use Jakarta EE 11 Validation on DTOs.
> - **Immutability:** Favor `final` fields and constructor injection exclusively (no `@Autowired` on fields).
> 
> ### 3. Database Entities & Relationships
> Create the entities based on the following business rules (ensure proper `@Table` indexing and relationships):
> 1. **User:** `id` (UUID), `name`, `role` (Enum: ADMIN, FINANCE_OFFICER), `email` (Unique), `password` (Hashed).
> 2. **Bill:** `id` (UUID), `title`, `vendor`, `amount` (BigDecimal), `tax` (BigDecimal), `date` (LocalDateTime), `imagePath` (String), `description`, `status` (Enum: PENDING, APPROVED, REJECTED). Link to `User` (CreatedBy).
> 3. **RequestFund:** `id` (UUID), `title`, `description`, `amountOfFund` (BigDecimal), `urgencyLevel` (Enum: LOW, MEDIUM, HIGH, CRITICAL), `date` (LocalDateTime), `imagePath` (String). Link to `User`.
> 4. **Collection:** `id` (UUID), `date` (LocalDate), `type` (Enum: DAILY, WEEKLY, MONTHLY, ANNUAL), `amount` (BigDecimal).
> 5. **Report:** `id` (UUID), `date` (LocalDateTime), `title`, `description`, `typeOfReport` (Enum: EMAIL, IN_APP). Link to `User`.
> 
> ### 4. Advanced Security & Authorization (US1, US2)
> - Configure a modern Spring Security 7 `SecurityFilterChain` (lambda DSL only, stateless session management).
> - Provide a `JwtUtil` component and a generic JWT Filter.
> - **Role-Based Access Control via Method Security (`@PreAuthorize`):**
>   - `ADMIN`: Full access to Bills, Funds, Collections, and Reports.
>   - `FINANCE_OFFICER`: Read-only/Review access to Bills, Reports, and Funds. Can update Bill status to Approved/Rejected.
> 
> ### 5. API Endpoints (RESTful Best Practices)
> Ensure endpoints follow strictly RESTful noun-based paths and return proper HTTP status codes (201 Created, 200 OK, 204 No Content).
> - **Auth:** `POST /api/v1/auth/login`
> - **Bills:** `POST /api/v1/bills`, `GET /api/v1/bills`, `GET /api/v1/bills/{id}`, `PATCH /api/v1/bills/{id}/status`
> - **Funds:** `POST /api/v1/funds`, `GET /api/v1/funds`
> - **Collections:** `POST /api/v1/collections`, `GET /api/v1/collections`
> - **Reports:** `POST /api/v1/reports`, `GET /api/v1/reports`
> - **Notifications (Simulated for US11, US12):** Create a generic `NotificationService` triggered asynchronously via Spring Events (`@EventListener` or `@TransactionalEventListener`). Provide `GET /api/v1/notifications`.
> 
> ### 6. Execution & Deliverables
> I expect highly robust, cleanly formatted code. Break down your output into these sequential steps so I can copy-paste them easily:
> 
> 1. **JPA Entities & Enums** (With Auditing and JSpecify annotations).
> 2. **Spring Data Repositories** (Include custom queries with `@EntityGraph` if needed).
> 3. **DTOs** (Using Java `Record` and Jakarta Validation).
> 4. **Service Layer** (Interfaces and Implementations utilizing Spring Events for Notifications).
> 5. **Controllers** (Clean, minimal logic, documented with OpenAPI/Swagger annotations if possible).
> 6. **Security Configuration** (JWT Filter, SecurityFilterChain, UserDetailsService).
> 7. **Global Exception Handler** (Using `ProblemDetail`).
> 
> Do not skip any crucial implementation details. Start with Step 1 and 2.

**What was accomplished:**
The entire backend for SFAS has been fully implemented based on the above instruction.
1. **Entities & Enums:** Created robust Java 21 JPA entities (`User`, `Bill`, `RequestFund`, `Collection`, `Report`) with strict null-safety (JSpecify) and UUIDs.
2. **Repositories:** Implemented Spring Data Repositories using `@EntityGraph` to prevent N+1 queries.
3. **DTOs & Mappers:** Configured fully decoupled Java 21 Records for DTOs alongside **MapStruct** for highly optimized object mapping.
4. **Service Layer & Events:** Added business logic wrapped in `Service` classes, plus an entirely asynchronous `NotificationService` triggered by Spring Events (`@EventListener` + `@Async`).
5. **Controllers:** Configured minimalist REST APIs for all domains under `/api/v1/`.
6. **Security:** Built stateless JWT authentication utilizing the modern Spring Security 7 Lambda DSL structure, Role-Based Access Control (`ADMIN`, `FINANCE_OFFICER`), and a custom filter `JwtAuthFilter`.
7. **Exception Handling:** Implemented a `GlobalExceptionHandler` using the modern RFC 7807 `ProblemDetail` approach to return uniform JSON errors.

The code compiles fully with zero errors on Java 21 (`BUILD SUCCESS`). An endpoints JSON file (`endpoints.json`) has been generated in the root directory formatted as a Postman Collection for future references.

## 10. Database Redesign & Vendor Table Implementation

**Database Redesign Prompt:**
> You are a Principal Database Architect and Senior Java Spring Boot Developer. I have attached the official ERD image from our system's base documentation (School Finance Administration System).
> 
> Your objective is to upgrade our database design to be highly professional, normalized, and scalable, and then update our existing backend code accordingly. 
> 
> Please execute the following steps precisely:
> 
> 1. **Analyze the ERD Thoroughly:** 
>    Carefully examine the attached ERD image to understand the base structure of our entities (Users, Roles, Bills, Request Funds, Collections, Reports) and their relationships.
> 
> 2. **Professional Database Redesign & Add Vendor Table:**
>    - Elevate the current database schema to a highly professional enterprise standard.
>    - **Crucial Requirement:** Extract the "Vendor" concept into its own dedicated and comprehensive table (`vendors`). The table should include professional fields (e.g., `id`, `name`, `contact_email`, `phone_number`, `tax_id`, `address`, `created_at`).
>    - Establish the correct relationships (e.g., A `Vendor` has a One-to-Many relationship with `Bills`).
> 
> 3. **Contextual Awareness (Read-Only):**
>    - Read the `docs/memory.md` file to fully understand the project's established rules, architecture, and current state. 
>    - **DO NOT modify the `docs/memory.md` file.** Use it purely as read-only context to ensure your work adheres perfectly to our existing guidelines.
> 
> 4. **Update the Spring Boot Codebase:**
>    - Based on your professional database redesign, update the Spring Boot backend code.
>    - Create the new `Vendor` entity, along with its Repository, Service, Controller, and DTOs.
>    - Refactor the `Bill` entity to reference the new `Vendor` entity instead of a plain string.
>    - Ensure all code strictly follows Clean Architecture, SOLID principles, and Java 21 / Spring Boot 4.x best practices as outlined in the memory file.

**What was accomplished:**
The database design was successfully upgraded, and the codebase was refactored to adopt the new structure:
1. **Vendor Entity & Layering:** Created a dedicated `Vendor` entity (`vendors` table) with fields for `id`, `name`, `contactEmail`, `phoneNumber`, `taxId`, `address`, `createdAt`, and `updatedAt`. Added full Clean Architecture support with `VendorRepository`, `VendorService`, `VendorServiceImpl`, `VendorController`, `VendorMapper`, and appropriate request/response DTOs.
2. **Bill Normalization:** Removed the string-based `vendor` field from the `Bill` entity and replaced it with a strictly typed Many-To-One relationship to the new `Vendor` entity using `@JoinColumn(name = "vendor_id")`.
3. **Database Documentation:** Updated `erd.mmd` and `schema_erd.html` to reflect the new `vendors` table and its 1-to-N relationship with the `bills` table.
4. **Exception Handling & Safety:** Ensured robust exception handling (e.g., `ResourceNotFoundException`) in the Service layer to safely handle vendor existence checks. Recompiled flawlessly in a Java 21 environment.

## 11. Strict Database Relationships & Auditing Upgrade

**Context:** A review of the DB relationships identified several logical gaps where audit trails and workflow tracking were missing for a highly exemplary enterprise finance application.

**Decisions Made:**
1. **Vendor Audit Trail:** Added a `createdBy` relationship (`@ManyToOne` User) to the `Vendor` entity to track which Admin onboarded the vendor.
2. **Collection Audit Trail:** Added a `createdBy` relationship (`@ManyToOne` User) to the `Collection` entity to track who entered the collection data.
3. **Bill Approval Tracking:** Added a `reviewedBy` relationship (`@ManyToOne` User, nullable) to the `Bill` entity to record which Finance Officer approved or rejected the bill.
4. **RequestFund Workflow:** Added a `status` field (using a newly created `FundStatus` enum: `PENDING`, `APPROVED`, `REJECTED`) and a `reviewedBy` relationship to the `RequestFund` entity, allowing Finance Officers to review and approve/reject fund requests properly.
5. All associated DTOs and Mappers were updated to handle these new fields, ensuring full data fidelity from the database to the REST API responses. ERD diagrams were updated accordingly.

## 12. Database Connection Configuration

**Context:** The application has been connected to the PostgreSQL database, and the connection settings have been verified.
**Configuration (`application.properties`):**
```properties
spring.application.name=sfas-backend

spring.datasource.url=jdbc:postgresql://localhost:5432/sfas
spring.datasource.username=postgres
spring.datasource.password=password
spring.datasource.driver-class-name=org.postgresql.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.show-sql=true
```
