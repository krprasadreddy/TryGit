<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Employee File - Anniversary 25 Years</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeFile__c.EmployedSince__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeFile__c.Create_Anniversary_Task__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeFile__c.State__c</field>
            <operation>equals</operation>
            <value>employed</value>
        </criteriaItems>
        <description>Creates a task related to 25 years Anniversary. Therefor: Clone this rule and add a Time-Dependent Workflow Action to it, for instance 60 days before Anniversary (60 days Before Anniversary 25 Year ). Create a task (or email) to alert collegue(s).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Employee File - Birthday</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeFile__c.Birthdate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeFile__c.Create_Birthday_Task__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeFile__c.State__c</field>
            <operation>equals</operation>
            <value>employed</value>
        </criteriaItems>
        <description>Creates a task on the Employee Birthday. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow, for instance on the next birthday (0 days After Next Birthday). Create a task (or email) to alert the responsible collegue(s).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Employee File - End Date Driver%27s License</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeFile__c.DriversLicenseEndDate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeFile__c.Create_End_Date_Drivers_License_Task__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeFile__c.State__c</field>
            <operation>equals</operation>
            <value>employed</value>
        </criteriaItems>
        <description>Creates a task related to the Driver&apos;s License End Date. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to it, fi 14 days before End Date (14 days Before Exp Date Driver&apos;s License). Create a task (or email) to alert collegue(s).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Employee File - End Date Identification</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeFile__c.IdentificationExpirationDate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeFile__c.Create_End_Date_Identification_Task__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeFile__c.State__c</field>
            <operation>equals</operation>
            <value>employed</value>
        </criteriaItems>
        <description>Creates a task related to the End Date of an ID. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to it, for instance 14 days before End Date (14 days Before Expiration Date Id). Create a task (or email) to alert collegue(s).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Employee File - State to Employed</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeFile__c.EmployedSince__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeFile__c.State__c</field>
            <operation>notEqual</operation>
            <value>employed</value>
        </criteriaItems>
        <description>Set State to Employed at &quot;Employed Since&quot; Date. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow:  0 days Before Employed Since. Create a Field Update on State, with picklist option: A specific Value - Employed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Employee File - State to Not Employed</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeFile__c.EmployedSince__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeFile__c.State__c</field>
            <operation>notEqual</operation>
            <value>Not Employed</value>
        </criteriaItems>
        <description>Set State to Not Employed at &quot;Exit Date&quot;. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow:  1 days After Exit Date. Create a Field Update on State, with picklist option: A specific Value - Not Employed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
