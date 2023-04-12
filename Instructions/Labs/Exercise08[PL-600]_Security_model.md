---
exercise:
    module: 'Module 10: Model security for Power Platform solutions'
    title: 'Exercise - Security model'
---

# Exercise - Security model

In this exercise you will work in small groups. Review the information presented about Fabrikam Robotics and complete the tasks.

## Learning objectives

After completing the exercise, you will:

- Evaluate requirements and propose a security design
- Discuss and propose security features to solve a requirement

## Exercise 1

You are building a solution for Fabrikam to track visitors to a showroom and manufacturing site. Some of the visitors are potential purchasers and some are just there to see the magic of the robots working.

Review the requirements here and address the concerns listed later in this document.

- Fabrikam has been rapidly moving to the cloud and already leverages Microsoft 365 for their email. They are adopting the use of Microsoft Teams at a rapid pace.
- You have already architected the solution to include the following Power Apps:
  - a model-driven app named Sales Central to be used by the sales staff and sales managers.
  - a canvas app to check in guests visiting the showroom to be used by the reception staff.
  - a Power Pages portal that visitors can use to request to visit.
- Fabrikam is going to use Power Apps per app licenses for reception staff and  Dynamics 365 Sales app licenses for the sales staff.
- Fabrikam’s IT security team wants to make sure the new solution doesn’t open up any security exposure from potential data leaks. You must ensure that your security setup prevents users from building their own flows in Power Automate that send data to outside services that aren’t approved. You could almost see the panic on their faces when your sales team did the demo of how easy it was to build a flow using random 3rd party connectors.
- The sales staff handles their own leads and opportunities. They are compensated by commission on close of sales and are very competitive. The staff that works on small deals all work together and receive commission on all closed deals in their department. The large deals sales staff mostly work by themselves; except on very large deals where there is a team of them assigned.
- Reception staff must not have access to the sales data.
- Sales managers need to have access to the deals of their team members.
- Discounts can only be approved and applied by one of the sales managers. The app should ensure the sales staff can’t approve their own discounts. In the data model, there is a discount column of type currency and a required lookup column to the approver.
- Fabrikam’s organization has the following divisions and departments:
  - Sales
  - Small Deals
  - Large Deals
  - Wholesale
  - Marketing
  - Operations
  - Manufacturing
  - Showroom (has all the reception staff)
  - Shipping
  - Customer Service

Discuss as a group how you would address each of the following:

1. How do you calm the concerns of the security staff and the rogue connector use?
1. How do you handle ensuring only sales managers approve and apply discounts?
1. How would you control access to each of the Power Apps?
1. What do you need to do to accommodate that Power Apps per app licenses are used for the reception staff?
1. What Dataverse security roles would you have the team create?
1. What business units can you begin to define to support your solution?
1. How will you handle so portal users can only see their own visit request records to check the status and potentially cancel the visit?
1. How would you ensure the small sales department can see all the data for all small sales staff, but the large deals sales staff can only see their own except when a team is put together to handle very large deals?
