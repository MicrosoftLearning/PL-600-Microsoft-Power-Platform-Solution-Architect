---
exercise:
    module: 'Module 7: Explore Power Apps architecture'
    title: 'Exercise - Power Apps architecture'
---

# Exercise - Power Apps architecture

In this exercise you will work in small groups. Review the information presented about Fabrikam Robotics and complete the tasks.

## Learning Objectives

After completing the exercise, you will:

- Identify and group app users
- Discuss and propose app types to solve a requirement
- Identify and recommend use of components

## Exercise 1

You are building a solution for Fabrikam to track visitors to a showroom and manufacturing site. Some of the visitors are potential purchasers and some are just there to see the magic of the robots working.

Review the requirements here and address the concerns listed later in this document.

- Fabrikam has been rapidly moving to the cloud and already leverages Microsoft 365 for their email. They are adopting the use of Microsoft Teams at a rapid pace.
- The sales staff handles their own leads and opportunities. They are compensated by commission on close of sales and are very competitive. The staff that works on small deals all work together and receive commission on all closed deals in their department. The large deals sales staff mostly work by themselves; except on very large deals where there is a team of them assigned.
- The sales staff that works on large deals regularly visits prospects offices and are having meetings at conferences with prospects. While they each have mobile hot spots for WiFi, in practice many buildings have little or no signal.
- To handle the sales staff viewing tour data a custom connector will be created to connect to the device service cloud API to make the data available to the app the sales staff is using.
- Reception staff must be able to check in visitors prior to their showroom and manufacturing floor tour. During the check in, they must be able to capture a picture of each visitor. Reception staff must not have access to the sales data.
- Discounts can only be approved and applied by one of the sales managers. The app should ensure the sales staff can’t approve their own discounts. In the data model, there is a discount column of type currency and a required lookup column to the approver.
- Customers should be able to request a showroom visit from Fabrikam’s  website. The proposed solution should remind them via SMS message if they provide a phone number 24 hours before their visit.

Discuss as a group how you would address each of the following

1. Identify the following:
   1. Different app user groupings?
   1. What Power App(s) would you propose creating for these groups?
   1. What type would they be?
      1. model-driven
      1. canvas
      1. portal/power pages
      1. non-Power App custom development
1. How are you accommodating in your app architecture for the sales staff that visit prospects’ offices?
1. How will you propose to use the custom connector so the sales staff can view the tour data from their app?
1. Identify places a Power Apps Component Framework component might be helpful or required by your application architecture?
1. If any of your apps are canvas apps, what is your plan to support multiple app makers being able to work on building the app?
1. What would you offload and rely on Power Automate to handle?
