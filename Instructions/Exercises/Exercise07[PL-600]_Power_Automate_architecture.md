---
exercise:
    module: 'Module 9: Explore Power Automate architecture'
    title: 'Exercise - Power Automate architecture'
---

# Exercise - Power Automate architecture

You will be working in small groups. Discuss each scenario and address the question. Each group takes a turn leading the larger group discussion on the proposed approaches.

During this exercise, you will be reviewing some scenarios and determining how to architect them using Power Automate.

## Learning Objectives

After completing the exercise, you will be able to:

- Evaluate requirements and propose a Power Automate flow design
- Evaluate a proposed design that includes Power Automate

## Scenario 1

When working on a help request for a smart bed customer, Contoso’s support staff can request a replacement bed from the manufacturer. Each manufacturer provides a contact that can authorize the replacement. Once authorized, the support staff can inform the customer.

What would your design look like to implement this process?

## Scenario 2

When a repair is required, the system needs to look up the customer’s support plan, check if they have available repair allowance / warranty, and if they do decrease the cost of the repair from their lifetime warranty allowance and prioritize the help request.

Your development team has proposed a plug-in – is that the best choice or how might you handle this in Power Automate?

## Scenario 3

When a manufacturer has a defect, they issue a recall to fix the problem. They will provide Contoso a file that contains the serial numbers of the affected beds. Each serial number must be looked up to see if there is an active customer and the customer record must be tagged with the recall.

For some large recalls this could exceed 200,000+ beds. The process must be designed so it can be restarted if the process fails without creating any duplication.

What would your design look like to implement this process?

## Scenario 4

On create of a help request Contoso needs to calculate the customer deductible which is based a percentage determined by how old their bed is. The support staff needs this value displayed as soon as they create the record.

What would your design look like to implement this?
