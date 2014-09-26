<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Benefit_Send_Approved_Email_to_Requestor</fullName>
        <description>Benefit: Send Approved Email to Requestor</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approvals/Benefits_Approved</template>
    </alerts>
    <alerts>
        <fullName>Benefit_Send_Rejection_Email_to_Requestor</fullName>
        <description>Benefit: Send Rejection Email to Requestor</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approvals/Benefits_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Benefit_Set_Date_Approved</fullName>
        <field>DateApproved__c</field>
        <formula>NOW()</formula>
        <name>Benefit: Set Date Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Benefit_Set_Date_Submitted</fullName>
        <field>DateSubmitted__c</field>
        <formula>NOW()</formula>
        <name>Benefit: Set Date Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Benefit_Set_State_to_Approved</fullName>
        <field>State__c</field>
        <literalValue>Approved</literalValue>
        <name>Benefit: Set State to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Benefit_Set_State_to_Pending</fullName>
        <field>State__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Benefit Set State to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Benefit_Set_State_to_Rejected</fullName>
        <field>State__c</field>
        <literalValue>Rejected</literalValue>
        <name>Benefit: Set State to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Employee Benefit - State to Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeBenefit__c.DateStart__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MF_EmployeeBenefit__c.State__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>Set State to Active at &quot;Start Date&quot; (if State of Approval = Approved). Therefor: Clone this Rule and add a Time-Dependent Workflow Action to it: 0 days Before Start Date. Create a Field Update on State, with picklist option: A specific Value - Active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Employee Benefit - State to Not Active</fullName>
        <active>false</active>
        <criteriaItems>
            <field>MF_EmployeeBenefit__c.DateEnd__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Set State to Not Active at &quot;End Date&quot;. Therefor: Clone this Rule and add a Time-Dependent Workflow Action to this workflow: 1 days After End Date. Create a Field Update on State, with picklist option: A specific Value - Not Active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
