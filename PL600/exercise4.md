# Modeling Data

## **1. Create a Data Model for the Requirements**
**Approach:**
A relational data model is designed to meet the requirements, incorporating the following core entities:
- **Visitors**: Stores visitor details (name, contact, and type: purchaser or tourist).
- **Visits**: Tracks individual visits with date, time, and visitor type.
- **Guests**: Associates guests with primary visitors for specific visits.
- **Photos**: Links visitor photos to their records and visits.
- **Waivers**: Tracks waiver acceptance, including signatures, date, and time.
- **Engagement Tracking Devices**: Links visitors to tracking data stored in the cloud.
- **Sales**: Tracks invited visitors linked to the sales process.
- **Marketing Statistics**: Aggregates visit data by day, month, quarter, and conversion rates.

---

## **2. How Did You Handle Storing of Visitor Photos?**
**Approach:**
- Visitor photos are stored as binary large objects (BLOBs) in **Dataverse** or **Azure Blob Storage**.
- A **foreign key** links each photo to the respective visitor and visit records.
- Metadata such as visit ID, timestamp, and visitor name is included for efficient access.

---

## **3. How Did You Handle Storing of Visitor Waiver Acceptance and Signature?**
**Approach:**
- A **Waivers** entity is created in Dataverse:
  - **Fields**: Visitor ID (foreign key), visit ID, signature (as an image or digital text), date, and time of acceptance.
  - Integration with **Adobe Sign** or **DocuSign** can be used for capturing and storing digital signatures.
  - Signed documents are stored in **Azure Blob Storage**, with references in Dataverse.

---

## **4. How Did You Accommodate for Viewing of Tracking Data in the Sales Process?**
**Approach:**
- The tracking device’s API is integrated using a **Custom Connector** in Power Platform.
- Relevant tracking data (Visitor ID, location timestamps, areas visited) is stored in a **TrackingData** table in Dataverse.
- The sales process UI (using Dynamics 365 or Power Apps) includes:
  - Embedded views to display visitor movements.
  - Real-time API integration or scheduled imports for consistent updates.

---

## **5. Did You Use Anything from the Common Data Model (CDM) Schema?**
**Approach:**
- Leveraged existing entities from the **Common Data Model**:
  - **Contact**: To store visitor information.
  - **Activity**: To log visits and interactions.
  - **Opportunity**: To track sales-related activities for invited visitors.
- Custom entities were created for Waivers and Tracking Data as needed.

---

## **6. How Did You Handle Marketing’s Statistics Needs?**
**Approach:**
- Used **Power BI** for marketing analysis and reporting:
  - Dashboards display visits by day, month, and quarter, as well as conversion rates.
  - Relationships between Visits, Sales, and Marketing entities in Dataverse enable dynamic statistics generation.
- Near real-time updates ensure accurate reporting from the Visits and Sales entities.

---
