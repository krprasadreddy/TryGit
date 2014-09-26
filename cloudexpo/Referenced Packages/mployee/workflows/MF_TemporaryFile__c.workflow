<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Temporary File - End Date Task</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_TemporaryFile__c.DateEnd__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_TemporaryFile__c.State_of_Approval__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>Creates a task/mail related to End Date of the Contract (If state of App = approved). Therefor: Clone this Rule and add a Time-Dependent Workflow Action, fi 30 days before End Date (30 days Before End Date). Create a task (or email) to alert collegue(s).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Temporary File - State to Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_TemporaryFile__c.DateStart__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_TemporaryFile__c.State_of_Approval__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>Set State to Active at &quot;Start Date&quot; (if State of Approval = Approved). Therefor: Clone this Rule and add a Time-Dependent Workflow Action to it: 0 days Before Start Date. Create a Field Update on State, with picklist option: A specific Value - Active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Temporary File - State to Not Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_TemporaryFile__c.DateEnd__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Set State to Not Active at &quot;End Date&quot;. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow: 1 days After End Date. Create a Field Update on State, with picklist option: A specific Value - Not Active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
