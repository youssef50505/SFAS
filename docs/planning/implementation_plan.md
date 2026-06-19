# Flutter Mobile App Implementation Plan -- SFAS (Finalized 2026 Enterprise Standards)

## Goal

Develop an uncompromisingly professional, international-grade Flutter mobile application for the School Finance Administration System (SFAS). The app will integrate with the existing Spring Boot REST API and strictly replicate the premium UI/UX standards established in the Angular frontend. Crucially, the architecture will be built upon **2026 Flutter enterprise best practices**, utilizing MVVM, scalability, offline resilience, and financial-grade security.

## Architectural Decisions (Locked In)

> [!NOTE]
> Based on the requirement for an international-grade enterprise financial application, the following architectural choices have been finalized:
> 
> 1.  **State Management: BLoC (9.x)**. BLoC is the absolute gold standard for financial/enterprise applications because it forces strict, event-driven state transitions. This provides a clear audit trail for every action (e.g., approving a bill), which is crucial for a finance administration system.
> 2.  **Routing: GoRouter**. The 2026 standard for declarative, URL-based navigation, enabling robust role-based route guards and deep linking.
> 3.  **UI Pattern: MVVM (Model-View-ViewModel)**. The presentation layer will decouple UI logic from the Views. The ViewModels will be powered by BLoC, feeding reactive states to the UI.

## 1. Core Enterprise Architecture (Clean Architecture + DDD + MVVM)

We will adopt a **Modular Clean Architecture** combined with **Domain-Driven Design (DDD)** and **MVVM** for the presentation layer. This is the 2026 standard for ensuring code isolation, testability, and scalability across multiple teams.

### Directory Structure (Feature-First Modular Approach)
```text
/lib
  /core                 # Enterprise foundations (DI, Security, Networking, Theming)
    /network            # dio client, interceptors
    /security           # flutter_secure_storage (Encrypted JWT)
    /theme              # Premium Design System tokens
  /domain               # Pure business logic & interfaces (No Flutter dependencies)
    /models             # freezed data classes (The 'Model' in MVVM)
    /repositories       # Abstract repository interfaces
  /data                 # Data implementation layer
    /datasources        # Remote (REST) & Local (Offline-first caching via Isar/Hive)
    /repositories       # Concrete repository implementations
  /presentation         # UI Layer (MVVM Implementation)
    /features           # Auth, Dashboards, Bills, Funds, Collections
      /viewmodels       # BLoC/Cubits acting as ViewModels
      /views            # Screens and UI widgets (The 'View' in MVVM)
```

## 2. International-Grade UI & Theming

The UI must feel like a premium, high-end financial tool (comparable to international banking apps), perfectly aligned with the `memory.md` aesthetics.

*   **Color System:** Strict use of **NTG Red** (`#c8102e`) as the primary accent.
*   **Typography:** Google Fonts: **Inter** (body readability) and **Outfit** (executive headers).
*   **Iconography:** **Remix Icons** package (clean, emoji-free).
*   **Performance Engineering:** Leveraging the **Impeller rendering engine** (standard in 2026) for buttery smooth 120fps animations.
*   **Micro-Animations:** Heavy use of `flutter_animate` for staggered list entries, sleek modal transitions, and interactive feedback, mimicking the web's `GsapFadeDirective`.
*   **Skeletons & Shimmer:** Intelligent loading states (no blank screens) using `shimmer` during network requests.

## 3. Financial-Grade Security & Networking

*   **HTTP Client:** `dio` configured with automatic retry mechanisms and interceptors.
*   **Interceptors:**
    *   `AuthInterceptor`: Injects Bearer JWT.
    *   `SecurityInterceptor`: Certificate pinning and payload validation.
    *   `ErrorInterceptor`: Catches `401 Unauthorized` (triggers instant local wipe and redirect to login) and maps the backend's RFC 7807 `ProblemDetail` errors to elegant UI toasts.
*   **Storage:** `flutter_secure_storage` for Encrypted Shared Preferences/Keychain to store the JWT.
*   **Offline-First Capability:** Implementing a local caching layer (e.g., Isar Database) to allow users to view previously loaded Bills/Reports even on spotty connections (syncing actions when reconnected).

## 4. Feature Modules Implementation

### [Auth]
*   **UI (View):** Executive split-screen on tablets, elegant stacked card on mobile with the NTG logo. Integrated password visibility toggle.
*   **ViewModel (BLoC):** Authenticate, parse JWT for roles (`ADMIN` vs `FINANCE_OFFICER`), and hydrate the user session.

### [Dashboards & Navigation]
*   **Navigation:** Custom animated Bottom Navigation Bar using `GoRouter`. Features are dynamically hidden based on the user's role (e.g., Vendors hidden for Finance Officer).
*   **Dashboards:** Role-specific overviews. Use `fl_chart` for dynamic, animated financial metric grids.

### [Bills Management & Review Workflow]
*   **Listings:** Slivers for smooth scrolling, filter chips, and elegant empty states.
*   **Creation:** Multi-step wizard form for Admins.
*   **Finance Review (Crucial):** A premium bottom sheet modal mimicking the web's `ReviewModalComponent` for Finance Officers to Approve/Reject bills with mandatory comment fields.

### [Request Funds]
*   **Workflow:** Similar to Bills. Admins create requests with urgency levels (LOW, MEDIUM, HIGH, CRITICAL) using native-feeling dropdowns/selectors. Finance Officers review via bottom sheet.

### [Collections & Reports]
*   **Forms:** Native form validations for logging Daily, Weekly, Monthly, and Annual revenues.

### [Notifications Hub]
*   **Integration:** Polling or WebSockets to fetch alerts.
*   **UI:** Accessed via an AppBar bell icon. Unread items styled with an NTG Red border indicator. Swipe-to-dismiss functionality.

## Verification Plan

### Automated Tests
*   **Unit Tests:** 100% coverage on ViewModels (BLoC) and API parsing.
*   **Widget Tests:** Golden tests for critical UI components (e.g., `ReviewModal` and `MetricCard`) to prevent visual regressions across screen sizes.

### Manual Verification
1.  **Security:** Ensure the JWT is inaccessible to standard file managers and wiped on logout.
2.  **Role Guarding:**
    *   Admin: Full CRUD access.
    *   Finance Officer: Strictly limited to reviewing Bills/Funds and Dashboards.
3.  **Performance:** Run Flutter DevTools in `profile` mode to ensure no dropped frames during staggered list animations on physical devices.
4.  **UX Flow:** Complete a full Bill Creation -> Finance Review -> Notification pipeline natively.
