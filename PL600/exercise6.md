# App Composition and Solution Segmentation

## **Exercise 1: Define the Apps and Their Types**

### **Apps Required and Recommended Types**
1. **Visitor Schedule App**  
   - **Type**: Model-Driven App  
   - **Purpose**: Allows security officers to view visitors scheduled to arrive at each building for the current day.  

2. **Visitor Check-In/Out App**  
   - **Type**: Canvas App  
   - **Purpose**: Enables visitors to check in and out using tablets at public entrances.  

3. **Visitor Management Dashboard**  
   - **Type**: Model-Driven App  
   - **Purpose**: Allows security officers to track visitors' expected entry/exit times and log their arrival/departure.

4. **Visitor Parking App**  
   - **Type**: Canvas App  
   - **Purpose**: Enables visitors to view parking availability, enter car registration details, and book parking spots on a first-come, first-served basis.  

5. **Employee Visit Booking App**  
   - **Type**: Canvas App  
   - **Purpose**: Allows employees to book visits for specific buildings they are authorized to access.  

6. **Security Manager Reporting App**  
   - **Type**: Model-Driven App  
   - **Purpose**: Enables managers to view visitor volume by building and analyze which employees are booking visits.  

7. **Inspection Scheduling App**  
   - **Type**: Model-Driven App  
   - **Purpose**: Assists security managers in scheduling inspections and assigning them to security officers.  

---

## **Exercise 2: Solution Design and Layering**

### **Solution Segmentation**
1. **Core Solution**  
   - **Components**: Shared tables and configurations (e.g., Visitors, Employees, Buildings, Parking).
   - **Purpose**: Provides a foundation for other solutions with standardized data models.

2. **Visitor Management Solution**  
   - **Components**: Visitor schedule, check-in/out processes, QR code generation, and parking functionality.
   - **Layer**: Managed solution to ensure reusability and maintainability.

3. **Security Staff Operations Solution**  
   - **Components**: Staff scheduling, inspections, and swipe card integration.
   - **Layer**: Built atop the core solution to extend functionality.

4. **Reporting and Analytics Solution**  
   - **Components**: Dashboards for visitor statistics, parking usage, and security operations analytics.
   - **Layer**: Integrated with the core and other solutions to provide actionable insights.

### **Integration and Lifecycle Management**
- **Version Control**: Use Azure DevOps pipelines for deployment and environment management.  
- **Environment Setup**: Segregate environments for development, testing, and production.  
- **Managed Layers**: Deploy managed solutions for critical features to prevent accidental changes.  

This approach ensures modularity, scalability, and efficient collaboration across development teams. 