<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Company Property Inv - State to Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_Organisation_PropertyInventory__c.DateStart__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Set State to Active at &quot;Start Date&quot;. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow: 0 days Before Start Date. Create a Field Update on Active, with checkbox option: True.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Company Property Inv - State to Not Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_Organisation_PropertyInventory__c.DateReturn__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Set State to Active at &quot;End Date&quot;. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow: 1 days After End Date. Create a Field Update on Active, with checkbox option: False.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
