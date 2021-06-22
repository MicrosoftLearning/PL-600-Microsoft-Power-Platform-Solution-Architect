---
lab:
    title: 'Lab 02: App composition and solution segmentation'
---

# **Module 8: App composition and solution segmentation**

## **Lab Scenario**

In this hands-on lab, you are a solution architect for Contoso.

A solution is required to manage building security:

- Tracking visitors
- Access control
- Parking passes
- Inspections
- Security staff shifts
- Incidents

A Minimal Viable Product (PVP) has been developed for Phase 1, visitor tracking, in the Microsoft Power Platform.

The entity relationship diagram for the MVP is as follows:

![MVP entity relationship diagram](../media/erd.png)

The contact table has been used for the Visitor entity.

All components are in a single solution.

## **High Level Steps**

In this lab you will need to:

- Define the apps that need to be built
- Determine the number of solutions and how solutions will be layered

## **Lab Test Environment**

You will be assigned one or more users to use to complete the tasks. As this is a shared environment, some tasks that require a tenant Global Administrator or a Service Administrator role will have already been performed.

## **Exercise 1: App composition**

In this exercise you will define which apps are required and which app type should be used.

### Requirements

- A security officer must be able to see the visitors due to arrive in each building for the current day
- For each visitor, the system must track the date, building, and employee responsible for the visitor
- Each visitor must be able to check in and check out using a tablet app at the public entrances of each building
- A security officer must be able to see who the visitor is meeting and their expected entry and exit times
- A security officer must be able to quickly and easily record when a visit arrives and leaves the building
- A security officer must be able to see if a visitor has not left by the scheduled exit time
- All visitor records should be deleted automatically after 90 days
- A security manager needs to see the volume of planned visitors by building so they can plan the security staff appropriately
- A security manager needs to be able to find which employees are booking visits
- Employees must be able to book visits easily for buildings they are entitled to use
- A code should be generated for each visit, that code should be available as a QR code for easy entry and exit
- Visitors must be able to access their visit details and enter their car registration to book a parking place
- Visitor parking is very limited at each building. Parking is booked on first come first served basis.
- The system should not allow visitors to book if there are no available places.
- Access to buildings for employees is controlled by a swipe card entry system. This system is hard to extract information from and can only be accessed by one dedicated computer in each building.
- The new Security System should track the buildings each employee has access to and manage adding new employees and new entitlements
- The Security System must automatically update the information in the swipe card entry system.
- A security manager needs to schedule regular inspections of the buildings and assign inspections to security officers.
- A security office must be able to see their list of inspections and to record the results of those inspections.
- The system needs to record security related incidents. All employees should be able to raise an incident. The security staff must be able to review and respond to these incidents.
- Some security staff are not employees of the company; they are sub-contracted workers.

### **Task 1: Apps**

1. Review the apps in the MVP solution
2. Determine what apps will be required for the full business solution
3. Decide which app type will be used for each app and who will use each app

## **Exercise 2: Solution segmentation**

In this exercise you will determine how many solutions are required and and how the solutions are to be segmented.

### **Task 1: Plan solution segmentation**

1. Review the components in the MVP solution
2. Estimate the number and type of other components that will be required for the c
3. Determine if you need to segment the solution and if you should use horizontal splitting or vertical layering
4. Map the components onto each solution

### **Task 2: Solutions**

1. Create the solutions in your environment
2. Add the components from the MVP solution to your solutions
