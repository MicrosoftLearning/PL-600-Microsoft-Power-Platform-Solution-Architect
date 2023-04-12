---
exercise:
    module: 'Module 2: Conceptualizing the design from requirements'
    title: 'Exercise - Design from requirements'
---

# Exercise - Design from requirements

During this exercise, you will be reviewing project details for Contoso. This includes a set of requirements gathered from customer workshop sessions. You will use this information to design a high-level architecture and complete a fit gap analysis.

## Learning Objectives

After completing the exercise, you will be able to:

- Perform evaluation of requirements to decide which approach to take
- Develop a high-level architecture for a set of requirements
- Perform a gap analysis from the Dynamics 365 apps used and the requirements

## Exercise 1: Evaluate Project Details

Review the project details below.

These details are also available in the [Project Details](https://github.com/MicrosoftLearning/PL-600-Microsoft-Power-Platform-Solution-Architect/blob/master/Allfiles/Project%20Details.docx)
 Word document.

The details contain the following information:

- Project Scenario
- Key Facts
- Requirements

As you review the document your team should take notes as you go and start to develop a proposed design to meet the requirements.

### Project Scenario

Contoso Services provides after-market support for various manufacturer’s smart beds. They use a proprietary solution today to manage their customers and their support ticket requests. They would like to move to a solution built on Microsoft Power Platform.

Some of their support requests can be handled quickly with a phone call or with a quick email response of a knowledge base article. Some may go on for days (or weeks) as the technicians dig in and research, then solve, the customers’ problems. For complex challenges they dispatch technicians onsite to resolve the problem.

Today most of their support is reactive to a customer calling in. They would like to be able to become more proactive.

There are three type of cases that can come into Contoso’s service center.

1. Items from customers without support agreements.
1. Items from preferred level support customers.
1. Items from premier level support customers.

Request for support can come from several sources: email, phone, online chat, social media, and so on. Requests for support coming in need to be evaluated and routed accordingly based on the requirements and policies. Some of the manufacturers have apps for customers that communicate with the beds and can then communicate the need for support to Contoso.

Contoso receives a data feed nightly from the manufacturers they support with customer information including bed serial number, bed configuration and ongoing telemetry of bed hardware wear indicators.

### Key Facts

|Fact| Details|
|---------------------------------|----------------------------------------------------------------------|
|Number of solution users|2,500|
|Number of service center agents|500|
|Number of field technicians|100 employees, 500 contractors|
|Locations| United States, United Kingdom and India|
|Number of customers|1.5 million|
|Contoso founded|2002|
|Contoso board of directors|9 members|
|Devices|Some users work with a single monitor and 1024x768 screen resolution|
|||

### Requirements

|ID|Description|
|---|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|1|As the system, a help request shall be routed to the named team accordingly based on several factors including their service level, and type of incident so that the correct group can address the issue.|
|2|As a support staff, I should be able to see a list of open help requests so I can pick one to work on for which I am qualified.|
|3|As a customer, I don’t want to wait on hold so should I be able to open a new request from Contoso’s website using an interactive chat.|
|4|As a support staff, I need to be able to search knowledge base articles so that I can send them to customers.|
|5|As the system, I should process the nightly data feed from the manufacturers and keep track of the customer and bed configuration so requests can properly be associated.|
|6|As a support staff, I should be able to schedule a technician for onsite service.|
|7|As a support staff, I should see a list of customers to contact to schedule proactive maintenance based on insights from the bed wear indicators sent to us by the manufacturer so I can provide proactive service to ensure happy customers.|
|8|As a field technician, I should be able to view my next scheduled customer visit and receive details of the problem and directions if needed so that I can resolve their bed problem.|
|9|As a support staff, I need to be able to sell a support agreement to customers that didn’t buy one with their original bed purchase so I can get their support request assigned to be resolved.|
|10|As a customer, I should receive an email when a support staff has closed my request so I can provide feedback on the experience.|
|11|As a support manager, I need to be able to see any support requests that are outside of the SLA for the customer so I can help prioritize the requests.|
|12|As a customer, I should be able to see the status of my support requests on Contoso’s website so that I know what is happening to resolve my problem.|
|13|As a support manager, I want to receive a copy of any customer communication that the customer seems upset so that I can get involved to help resolve the problem.|
|14|As a support staff, I need to be able to see the remaining time I have to meet the SLA so that I’m not in trouble with my manager.|
|15|As the system, I need to track when a support request was opened, number of days open and resolved.|
|16|As a customer, I need to be able to take ownership of a bed, and support agreement when I acquire a used bed from a private buyer so that I can get the benefits of ownership.|
|17|As a support staff, regardless of my location, I should have acceptable response time for page loads.|
|18|As a C-level executive, I need to see real time metrics on the performance of the support team so I know what’s going on.|
|||

## Exercise 2: Complete the Project Workbook

Open and complete the worksheets in the [Project Workbook](https://github.com/MicrosoftLearning/PL-600-Microsoft-Power-Platform-Solution-Architect/blob/master/Allfiles/M02-Project%20Workbook.xlsx) Excel file.

Complete each of the following tabs:

- **High-level architecture diagram** – Create a simple high-level architecture diagram. This can be a picture of a whiteboard, a photo of a paper drawing. Simply paste it into the worksheet tab.
- **Dynamics 365 apps used** – Document which apps you used and a brief description how it will be used.
- **Fit Gap** – For each requirement complete the priority, level of effort, category and implementation details.

Your work will be reviewed by another team in a future exercise, so provide the level of detail you would want from the team you review.
