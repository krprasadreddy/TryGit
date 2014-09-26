<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>HR Contract - End Date Probation Task</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_Contract__c.DateEndProbation__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_Contract__c.State_Contract__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>MF_Contract__c.Create_End_Date_Probation_Task__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Creates a task/mail related to End Date Probation HR Contract. Therefor: Clone this Rule and add a Time-Dependent Workflow Action, fi 30 days before End Date Prob. (30 days Before End Date Probation ). Create a task (or email) to alert collegue(s).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>HR Contract - End Date Task</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_Contract__c.DateEnd__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_Contract__c.State__c</field>
            <operation>equals</operation>
            <value>Final</value>
        </criteriaItems>
        <criteriaItems>
            <field>MF_Contract__c.Create_End_Date_Task__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Creates a task/mail related to End Date HR Contract. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to it, for instance 30 days before End Date (30 days Before End Date). Create a task (or email) to alert the responsible collegue(s).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>HR Contract - State to Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_Contract__c.DateStart__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_Contract__c.State__c</field>
            <operation>equals</operation>
            <value>Final</value>
        </criteriaItems>
        <description>Set State to Active at &quot;Start Date&quot; (if State of Approval = Final). Therefor: Clone this Rule and add a Time-Dependent Workflow Action to it: 0 days Before Start Date. Create a Field Update on State, with picklist option: A specific Value - Active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>HR Contract - State to Not Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_Contract__c.DateEnd__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Set State to Not Active at &quot;End Date&quot;. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow: 1 days After End Date. Create a Field Update on State, with picklist option: A specific Value - Not Active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
