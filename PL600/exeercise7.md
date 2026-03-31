# Exercise 07: Power Automate Architecture

## **Scenario 1: Smart Bed Replacement Process**
### **Task: Design a Flow for Replacement Authorization**
**Approach**:
- **Trigger**: When support staff submits a replacement request via a Model-Driven App.
- **Steps**:
  1. **Automate Email Request**: Use Power Automate to send an email to the manufacturer’s contact for authorization.
  2. **Approval Workflow**: Incorporate an approval action in Power Automate where the manufacturer’s contact can approve or reject the replacement request.
  3. **Notification to Staff**: Notify the support staff of the manufacturer’s decision using Outlook or Microsoft Teams.
- **Data Storage**: Log the replacement request and its approval status in Dataverse for tracking and reporting.

---

## **Scenario 2: Repair Allowance and Warranty Validation**
### **Task: Build a Flow to Validate Repairs**
**Approach**:
- **Trigger**: When a repair request is submitted via a Canvas App.
- **Steps**:
  1. **Fetch Customer Data**: Use a Dataverse connector to retrieve the customer’s support plan and available repair allowance.
  2. **Decision Point**: Implement a condition to check if the customer is eligible for the requested repair (within warranty or allowance limits).
  3. **Automated Response**:
     - If eligible: Notify the technician to proceed with the repair.
     - If not eligible: Notify the customer of the denial and next steps (e.g., payment options).
- **Reporting**: Store repair validation outcomes in Dataverse to generate insights for support managers.

---

## **Best Practices Implemented**
1. **Secure Approvals**: Used Power Automate’s approval features to ensure authorized actions.
2. **Efficiency**: Automated repetitive tasks like data retrieval and notifications.
3. **Integration**: Connected Dataverse, email systems, and Teams for seamless workflows.
4. **Traceability**: Ensured all requests and approvals are logged in Dataverse for transparency.
