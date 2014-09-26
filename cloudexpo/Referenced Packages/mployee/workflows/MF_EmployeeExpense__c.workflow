<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Expense_Send_Approved_Email_to_Requestor</fullName>
        <description>Expense: Send Approved Email to Requestor</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approvals/Expense_Approved</template>
    </alerts>
    <alerts>
        <fullName>Expense_Send_Rejection_Email_to_Requestor</fullName>
        <description>Expense: Send Rejection Email to Requestor</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approvals/Expense_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Expense_Set_Date_Approved</fullName>
        <field>DateApproved__c</field>
        <formula>NOW()</formula>
        <name>Expense: Set Date Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expense_Set_Date_Submitted</fullName>
        <field>DateSubmitted__c</field>
        <formula>NOW()</formula>
        <name>Expense: Set Date Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expense_Set_State_to_Approved</fullName>
        <field>State__c</field>
        <literalValue>Approved</literalValue>
        <name>Expense: Set State to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expense_Set_State_to_Pending</fullName>
        <description>Sets the state of the expense request to Pending.</description>
        <field>State__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Expense: Set State to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expense_Set_State_to_Rejected</fullName>
        <field>State__c</field>
        <literalValue>Rejected</literalValue>
        <name>Expense: Set State to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
