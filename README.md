# School Finance Administration System (SFAS)

The School Finance Administration System is a comprehensive, full-stack application designed to manage school finances, including vendors, bills, requested funds, reports, and collections metrics.

## Tech Stack
- **Backend:** Java, Spring Boot, PostgreSQL
- **Frontend:** Angular, Tailwind CSS, RxJS, ApexCharts
- **Documentation:** Mermaid (ERD), JSON (API endpoints), Markdown

## Key Features
- **Authentication & Roles:** Built-in JWT security with roles for `ADMIN` and `FINANCE_OFFICER`.
- **Vendor & Bill Management:** Track vendors and their provided bills efficiently.
- **Fund Requests:** System for school staff to request and review funding.
- **Collection Metrics:** Real-time dashboards visualizing calculated collections metrics (Today, Weekly, Monthly, Annually).
- **Automated Notifications & Reports:** Email and in-app reporting features.

## Project Structure
- `sfas-backend/`: The Spring Boot backend.
- `sfas-ui/`: The Angular frontend application.
- `docs/`: Database schema, ERD, API definitions, and project memories.
