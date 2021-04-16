Copyright ©

**Content**

[Introduction to the Labs 3](#introduction-to-the-labs)

[Objectives 3](#objectives)

[Purpose 3](#purpose)

[Preparation 3](#preparation)

[Resources 3](#resources)

[Implications of using a cloud service
3](#implications-of-using-a-cloud-service)

[Location of files 3](#location-of-files)

[Credentials 3](#credentials)

[Profiles or InPrivate/Incognito Mode 3](#profiles-or-inprivateincognito-mode)

[Trial Setup 5](#trial-setup)

[Trial tenant 5](#trial-tenant)

[Objectives 5](#objectives-1)

[Steps 5](#steps)

[Lab Setup 8](#lab-setup)

[Objectives 8](#objectives-2)

[Steps 8](#steps-1)

 Introduction to the Labs
=========================

Objectives
----------

### Purpose

The purpose of the hands-on labs is to reinforce learning.

### Preparation

To execute the labs, you need access to a Power Platform environment where you
have access to create apps.

### Resources

The labs utilise a Microsoft 365 tenant with:

**Power Apps**: A Software-as-a-Service (SaaS) application platform that enables
power users in line of business roles to easily build and deploy custom business
apps.

**Microsoft Dataverse**: Make it easier to bring your data together and quickly
create powerful apps using a compliant and scalable data service and app
platform that integrates into Power Apps.

### Implications of using a cloud service

The user interface and functionality in Microsoft 365 and Power Platform are
subject to change without notice so the steps listed may not be correct.

### Location of files

Files are in GitHub
<https://github.com/MicrosoftLearning/PL-600-Power-Platform-Solution-Architect/tree/master/Allfiles>

### Credentials

**IMPORTANT** Do not use your own company credentials or company name when
creating a trial. We recommend using a Gmail or Outlook address rather than your
work email address to prevent your trial being associated with your company.

### Profiles or InPrivate/Incognito Mode

One of the issues faced with trials is credential “leakage” where you suddenly
find yourself in your own company’s Microsoft 365 live tenant and environment.

You have two options:

1.  Use InPrivate (Edge) or Incognito (Chrome)

2.  Create a Profile (Edge) or add a Person (Chrome)

Note: InPrivate/Incognito does not store session cookies, and this can cause
authentication issues with constant login prompts.

How to create a person <https://support.google.com/chrome/answer/2364824>

How to create a profile
<https://www.onmsft.com/how-to/how-to-use-profiles-a-new-feature-in-microsoft-edge-insider>
or
<https://www.tenforums.com/tutorials/144642-how-add-profile-microsoft-edge-chromium.html#option1>

Trial Setup
===========

Trial tenant
------------

### Objectives

Create a Power Apps trial.

### Steps

#### Sign up for a trial

In a browser profile session, navigate to
[https://signup.microsoft.com/Signup?OfferId=83D3609A-14C1-4FC2-A18E-0F5CA7047E46](https://signup.microsoft.com/Signup?OfferId=83D3609A-14C1-4FC2-A18E-0F5CA7047E46,B07A1127-DE83-4a6d-9F85-2C104BDAE8B4)

![](media/fdfc45f38beb293323826d9f71469bb8.png)

For this screen, use a valid email address (**not your business email address**)
where you can receive credentials and password resets, and a valid mobile phone
number. If you are already using Microsoft 365 then use another email address
e.g., outlook.com or gmail.com.

Click **Next** and then **Setup account**.

![](media/55a61e2a445ed42dee9d649931ae7331.png)

Fill out the form above.

For Company Name, use **Power Platform Training**.

For Your organisation size, select **1 person.**

Note: We recommend using United States for country and English as language as
this makes following the labs easier.

Click **Next**.

Select the **Text me** radio button, enter your mobile number and click **Send
Verification Code**.

Enter the unique verification code you received and click **Next**.

![](media/27fcac8d54687c2a084b136561d9a9fa.png)

Fill out the form above.

For the organisation name, enter a unique name to reflect this training e.g.,
your initials + year/month.

Click **Check availability**.

Click **Next**.

![](media/5e02064556929e64d58475a64b94344c.png)

Fill out the form above.

Click **Sign up**.

After a short while the following page will appear.

![](media/473ee6e6dcb9746a31ac25d321c7a2e7.png)

Write the user ID down.

Click **Get Started**

#### Configure Microsoft 365

This will transfer control to the Microsoft 365 environment. You need to access
the Microsoft 365 Admin Centre <https://admin.microsoft.com/AdminPortal/Home>.

![](media/abf5b23e0c71c6df6845761b9312c189.png)

Click **Users** and then **Active Users** in the left hand navigation

Verify that your users has all licenses assigned

![](media/184c5570f0c0282696b6609f039f330e.png)

**Close** the pane.

Lab Setup
---------

### Objectives

Create users and environments for all students.

### Steps

#### PowerShell Script

In Windows, open Windows PowerShell. Make sure you open PowerShell as an
administrator. See
<https://docs.microsoft.com/powershell/scripting/learn/ps101/01-getting-started#how-do-i-launch-powershell>
for how to start PowerShell.

Note: You can use the PowerShell command line or the PowerShell ISE.

Change Directory to where the **Setup.ps1** and
**ContosoDeviceOrderManagement_1_0_0_1.zip** files are located.

![](media/70e0595271ac3554f3bc27858addab7f.png)

Run the following commands:

>   **Set-ExecutionPolicy RemoteSigned**

>   **Set-PSRepository -Name PSGallery -InstallationPolicy Trusted**

![](media/bce6e94b9d5cd055cdeb1f7e302dfe56.png)

If prompted answer with **A [Yes to All]**

Run **Setup.ps1**

![](media/32ab8fc998a851725edd72016eecb353.png)

If prompted answer with **A [Yes to All]**

![](media/77e4c772c6fc866527ad10371a5ff562.png)

Run the following command:

**Start-MB600-Setup -TenantName \<Tenant name\> -CDSLocation \<Region\>
-UserCount \<Number of Students\>**

Your Tenant name is the name you entered for Step 3 when creating the trial. You
should enter only the first part of the Tenant name i.e., without
onmicrosoft.com.

The region should be the region of your tenant and will be from the country you
selected in Step 2. You can find your region by running the commands:

>   **Connect-MsolService**

>   **Get-MsolCompanyInformation**

And checking the country code. Valid values for Region are:

-   unitedstates

-   southamerica

-   canada

-   europe

-   asia

-   australia

-   japan

-   india

-   unitedkingdom

-   France

The script creates environments and databases for each student and a development
environment with the solution imported.

#### Check Dataverse Environments

Navigate to the Power Platform Admin Center <https://aka.ms/ppac>

Verify that there are environments for each student.

![](media/cc5e11aa22ad8038ba3522845aeedbfb.png)

#### Check Development Environment

Navigate to the Maker Portal <https://make.powerapps.com/>

Select the **Device Ordering Development** environment.

![](media/7b7569dce81f2b7ab45c5b7d9c158766.png)

If you do not see the environment, press Ctrl-F5 to refresh your browser.

Click on **Solutions** and verify the **Contoso Device Order Management**
solution has been imported.

![](media/624ba9442314f4f11de35f82120109fc.png)

Click on **Apps** and verify the **Device Ordering App** and the **Device
Procurement** apps have been imported.

![](media/1c45791c423ef077bddd11a244b28f19.png)

#### Add users to the Development environment

Navigate to the Power Platform Admin Center <https://aka.ms/ppac>

Select the **Device Ordering Development** environment.

Click on **Settings**.

Expand **Users + permissions**.

Select **Users**.

![](media/eef7fa328ac9721f233f96249b271254.png)

If the Lab Admin users for each of the students are listed, skip to the next
step, Assign security roles.

Click on **+ Add user**.

![](media/ac232956313bc97046afd60d7496728d.png)

Enter **labadmin**

![](media/1f21a53415d63490790be37b13d5de3e.png)

Select a Lab Admin user and click **Add**.

Click **Not Now**.

Repeat for all the Lab Admin users.

![](media/581c16e0a0b20a369cc5b86ef51f23a5.png)

#### Assign security roles

Navigate to the Power Platform Admin Center <https://aka.ms/ppac>

Select the **Device Ordering Development** environment.

Click on **Settings**.

Expand **Users + permissions**.

Select **Security Roles**.

Select the **System Customizer** role.

![](media/063598178fbd5b1e3d1928b2f544a630.png)

Click **+ Add people**.

![](media/5ac93c0242eab8c2a00920127e0835c6.png)

Enter **labadmin**

Select a Lab Admin user.

Repeat and select all Lab Admin users.

![](media/b31ed96b430c65786ebc633d7c7e866b.png)

Click on **Add**.

You are now ready to run the ALM lab.
