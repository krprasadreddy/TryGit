<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Salary - State to Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeSalary__c.DateStart__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Set State to Active at &quot;Start Date&quot;. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow: 0 days Before Start Date. Create a Field Update on State, with picklist option: A specific Value - Active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Salary - State to Not Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeSalary__c.DateEnd__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Set State to Not Active at &quot;End Date&quot;. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow: 1 days After End Date. Create a Field Update on State, with picklist option: A specific Value - Not Active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
