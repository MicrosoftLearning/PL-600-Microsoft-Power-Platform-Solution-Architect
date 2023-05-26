---
exercise:
    module: 'Module 8: Plan application lifecycle management for Power Platform'
    title: 'Exercise - App composition and solution segmentation'
---

# Exercise - App composition and solution segmentation

In this exercise you will work in small groups. Review the information presented about Contoso  Robotics and complete the tasks.

A solution is required to manage building security:

- Tracking visitors
- Access control
- Parking passes
- Inspections
- Security staff shifts
- Incidents

A Minimal Viable Product (MVP) has been developed for Phase 1, visitor tracking, in the Microsoft Power Platform.

The entity relationship diagram for the MVP is as follows:

![mvp_erd](/PL-600-Microsoft-Power-Platform-Solution-Architect/Instructions/media/mvp_erd.png)

The contact table has been used for the Visitor entity. The user table has been used for security staff and employees.

All components are in a single solution.

> **Note:** The MVP solution file can be found on [GitHub](https://github.com/MicrosoftLearning/PL-600-Microsoft-Power-Platform-Solution-Architect/blob/master/Allfiles/SecuritySystem_1_0_0_0.zip)

## Learning Objectives

After completing the exercise, you will:

- Define the apps that need to be built
- Determine the number of solutions and how solutions will be layered

## Exercise 1

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

### MVP Dataverse

The following tables are in the MVP solution:

- Access Key
- Building
- Contact
- Country
- Inspection
- Parking Pass
- Room
- User
- Visit

There are the following global choices:

- Parking Status: Available, Full
- Visit Purpose: Meeting, Maintenance, Interview
- Visit Status: Planned, Arrived, Overdue, Completed, Cancelled

Connection roles have been created between the Contact, Visit, and User tables.

There are two security roles:

- Security Manager
- Security Officer

A classic workflow updates the number of parking spaces booked for a building when a parking pass is created for the current date. A scheduled cloud flow updates the number of parking passes spaces booked for the current date each morning.

A separate scheduled cloud flow creates an inspection for each building.

### MVP Apps

There are two apps in the existing MVP solution:

- Security canvas app. This app has three screens
  - Visits: Gallery containing today's visits
  - Visit: Individual visitor check in and out
  - Inspections: Gallery of Inspections
- Visit management model-driven app. This app is allows data entry and update for the following tables:
  - Contacts
  - Visits
  - Inspections
  - Buildings
  - Countries
  - Access Keys
  - Parking Passes

A business process has been created for the Visit table with the following stages:

- New Visit
- Purpose
- Parking
- Arrived
- Left

### Tasks

1. Determine what apps will be required for the full business solution.
1. Decide which app type will be used for each app and who will use each app.

## Exercise 2: Solution segmentation

In this exercise you will determine how many solutions are required and and how the solutions are to be segmented.

### Task 1: Plan solution segmentation

1. Review the components in the MVP solution.
1. Estimate the number and type of other components that will be required for the full business solution.
1. Determine if you need to segment the solution and if you should use horizontal splitting or vertical layering.
1. Map the components onto each solution.
