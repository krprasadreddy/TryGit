<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Name_and_Note</fullName>
        <field>Unique_Name__c</field>
        <formula>Name &amp;&quot; &quot;&amp; Note__c</formula>
        <name>Update Name and Note</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Function - Unique</fullName>
        <actions>
            <name>Update_Name_and_Note</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>MF_Organisation_Position__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_Organisation_Position__c.Note__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Prevent duplicates</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
