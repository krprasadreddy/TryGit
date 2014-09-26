<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>When_Approval_done</fullName>
        <description>When Approval done</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Timesheet_Folder/Timesheet_Approval_Template</template>
    </alerts>
    <alerts>
        <fullName>When_Rejection_done</fullName>
        <description>When Rejection done</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Timesheet_Folder/Timesheet_Reject_Template</template>
    </alerts>
    <fieldUpdates>
        <fullName>When_Approve</fullName>
        <field>Status__c</field>
        <literalValue>APPROVING</literalValue>
        <name>When Approve</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>When_Reject</fullName>
        <field>Status__c</field>
        <literalValue>REJECT</literalValue>
        <name>When Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
