---
exercise:
    module: 'Module 11: Implement integrations with Power Platform'
    title: 'Exercise - Evaluate integration options'
---

# Exercise - Evaluate integration options

You will be working in small groups. Discuss each scenario and address the question. Each group takes a turn leading the larger group discussion on the proposed approaches.

During this exercise, you will be reviewing some scenarios and determining how to architect them inbound and outbound integration methods.

## Learning Objectives

After completing the exercise, you will be able to:

- Evaluate requirements and propose inbound and outbound integration methods
- Evaluate a proposed design that includes pull and push integrations

## Scenario 1 - Property Environmental Hazard data

Your client has licensed property environment hazard data and would like an indicator on each property if a hazard exists and what the hazard is, and the date last reported.

### Details on the property hazard data

- There are currently 555,000 properties on the data.
- Approximately 1K records are changed or new each week.
- They provide an updated file once a week.
- The file is in JSON format and can be downloaded from a supplied URL.
- Each property is identified by a County and Parcel ID in that county. This is a unique key.
- There are 20 columns in the data.

What would your integration design look like to meet this requirement?

## Scenario 2 - Access to Property Tax Authority

You need to be able to show the current property tax amount and the amount of the last payment in the app when the user views a property.

Any problems with the transmission must be reported to Contoso’s manager.

### Information about the property tax API

- The data can only be stored locally for 24 hours.
- The tax authority provides a REST API using OAuth to access the data.
- They have downtime each weekend for 2 hours.
- The app is a model-driven app.
- Data is updated all the time.

What would your integration design look like to meet this requirement?

## Scenario 3 - Outsourced customer support

Contoso has outsourced support to a 3rd party firm. New and changed customers needs to be transmitted to the third-party.

Any problems with the transmission must be reported to Contoso’s manager

### Information about the third party

- The third party has provided a JSON schema for the data they need.
- The third party has provided a webhook url to post the data to.

What would your integration design look like to meet this requirement?

## Scenario 4 - Customer Referral

Another division at Woodgrove wants to send customer referrals to you.

They have asked for API access to send the referral automatically from their system.

The referral creation process:

- Create Account, if name doesn’t exist.
- Create an Opportunity.
- Assign the opportunity to the sales team based on region.
- Create a task for the account research team to research the company.

### Relevant information

- All users are on the same internal network.
- The division sends approximately 25 leads a week.

What would your integration design look like to meet this requirement?
