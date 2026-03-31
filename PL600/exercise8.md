# Exercise 08: Security Model

## **Task 1: Define Role-Based Access Control (RBAC) for System Components**
**Approach**:
- **Roles and Permissions**:
  - **Sales Staff**: Access to sales processes, visitor tracking related to sales, and historical sales data.
  - **Reception Staff**: Access to visitor check-ins, photo captures, and waiver management but restricted from sales data.
  - **Security Managers**: Access to visitor schedules, inspection reports, and incident tracking. No access to sales processes.
  - **Marketing**: Access to aggregate visitor statistics and campaign data. Limited access to personal visitor data.
- **Implementation**:
  - Utilize **Dataverse Security Roles** to create granular permissions for each role.
  - Use **Azure Active Directory (AAD)** for authentication and assign security roles to groups based on organizational hierarchy.

---

## **Task 2: Design Data Security for Visitor Waivers and Photos**
**Approach**:
- **Visitor Photos**:
  - Stored securely in **Azure Blob Storage** with unique references linked to Dataverse visitor records.
  - Use AAD to ensure authorized access based on role permissions.
- **Waiver Data**:
  - Store digital signatures and timestamps in **Dataverse** under a Waivers table.
  - Encrypt sensitive data fields such as signatures and employ role-based encryption keys.

---

## **Task 3: Multi-Level Security for API Integration**
**Approach**:
- **Integration with External Services**:
  - Use **Azure API Management** to control and monitor access to APIs, such as those fetching data from tracking devices.
  - Secure API calls using OAuth 2.0 tokens issued via AAD.
- **Data Access Layer**:
  - Implement row-level security in Dataverse to filter API data based on user roles.

---

## **Task 4: Data Retention and Auditing**
**Approach**:
- **Retention Policies**:
  - Set automatic deletion for visitor records older than 90 days via Power Automate workflows.
- **Audit Logs**:
  - Enable Dataverse auditing for changes to visitor and waiver data.
  - Export logs to **Azure Monitor** for long-term storage and compliance tracking.

---

## **Task 5: Protect Sensitive Information in Reports**
**Approach**:
- **Data Aggregation**:
  - Use **Power BI** with row-level security to provide marketing access to aggregated visitor statistics.
  - Mask or anonymize personal visitor details in reports.
- **Access Restrictions**:
  - Apply role-based restrictions in Power BI datasets to prevent unauthorized access to sensitive details.

---
