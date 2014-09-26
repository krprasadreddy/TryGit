<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Company Car - State to Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeCompanyCar__c.DateStart__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeCompanyCar__c.State_of_Approval__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>Set State to Active at &quot;Issue Date&quot; (if State of Approval = Approved). Therefor: Clone this Rule and add a Time-Dependent Workflow Action to it: 0 days Before Issue Date. Create a Field Update on State, with picklist option: A specific Value - Active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Company Car - State to Not Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeCompanyCar__c.DateEndEstimated__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Set State to Not Active at &quot;End Date&quot;. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow: 1 days After End Date. Create a Field Update on State, with picklist option: A specific Value - Not Active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
