---
exercise:
    module: 'Module 12: Explore Dynamics 365 applications architecture'
    title: 'Exercise - First party apps'
---

# Exercise - First party apps

## Evaluate requirements for first-party apps

Review the requirements for each app. Decide how best to address a requirement. Some items might be out of the box functionality, some might have nothing to do with our first-party applications, some might need third-party apps, and more.

## Dynamics 365 Sales

- While viewing a contact record, sales managers need to see detailed information about the parent account record of that contact.
- Preferred pricing is only valid for a period of time and reverts back upon agreement expiration.
- Sales reps need to have the ability to configure products (color, size, components, etc.) and track them to an opportunity. We currently use a
custom-built product configurator. It was built by a developer that is still on staff. It's a WPF application built using .NET.
- Some users expect the opportunity form to show and hide columns based on their column choices on the opportunity form.
- Display real-time information of an account's top current events on the account form.
- When a user creates a new opportunity valued at greater than $1 million, change the owner of the record to the user's team. Notify the original record owner of the change.
- You must display the current stage of the lead in the lead grid.

## Dynamics 365 Customer Service

- When a customer calls in for a new support request, if they do not have available pre-purchased support tickets available, support agents need to be able to sell them support tickets without leaving the case record they are currently viewing.
- When a preferred customer is out of available support incidences we need to reach out and offer to sell them more.
- Users must not access the application on mobile devices.
- Once a support request is opened for an on-site service, we need to dispatch to an available qualified field resource.
- The top support agent (the one with the highest number of closed case records) has created a personal chart to show their open cases from the beginning of the week. You need to make this available to all support agents to see their own support cases from the beginning of the week.
- You must display the current stage of the case in the case grid.
- Some users expect the case form to show and hide sections based on their column choices on the opportunity form.

## Dynamics 365 Field Service

- We have implemented a new training program and need resources' skills automatically updated when they pass a class.
- All screens must render for the user in less than 5.25 seconds.
- Resources must be certified prior to completing field tickets without a supervisor.
- Each work order requires a work order type.
- Dispatchers perform 70% of the booking, technicians can perform self-booking via mobile.
- Many customers do not accurately represent what is actually the problem that requires service. We need to make better use of our technicians' time and only send them on a call when it's needed.
