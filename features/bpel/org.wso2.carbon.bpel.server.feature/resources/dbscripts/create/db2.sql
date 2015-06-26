--Copyright (c) 2015, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
--
--  WSO2 Inc. licenses this file to you under the Apache License,
--  Version 2.0 (the "License"); you may not use this file except
--  in compliance with the License.
--  You may obtain a copy of the License at
--
--  http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing,
--  software distributed under the License is distributed on an
--  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
--  KIND, either express or implied.  See the License for the
--  specific language governing permissions and limitations
--  under the License.
--

create table ODE_SCHEMA_VERSION (VERSION integer) 
insert into ODE_SCHEMA_VERSION values (6) 


CREATE TABLE ODE_JOB (jobid char(64) NOT NULL, ts bigint  NOT NULL DEFAULT 0, nodeid char(64)  NULL, scheduled INTEGER  NOT NULL DEFAULT 0, transacted INTEGER  NOT NULL DEFAULT 0, instanceId BIGINT, mexId varchar(254), processId varchar(254), type varchar(254), channel varchar(254), correlatorId varchar(254), correlationKeySet varchar(254), retryCount INTEGER, inMem INTEGER, detailsExt BLOB,  PRIMARY KEY (jobid))

CREATE INDEX IDX_ODE_JOB_TS on ODE_JOB(ts)
CREATE INDEX IDX_ODE_JOB_NODEID on ODE_JOB(nodeid)


CREATE TABLE ODE_ACTIVITY_RECOVERY (ID BIGINT NOT NULL, ACTIONS VARCHAR(254), ACTIVITY_ID BIGINT, CHANNEL VARCHAR(254), DATE_TIME TIMESTAMP, DETAILS CLOB(1M), INSTANCE_ID BIGINT, REASON VARCHAR(254), RETRIES INTEGER, PRIMARY KEY (ID)) 
CREATE TABLE ODE_CORRELATION_SET (CORRELATION_SET_ID BIGINT NOT NULL, CORRELATION_KEY VARCHAR(254), NAME VARCHAR(254), SCOPE_ID BIGINT, PRIMARY KEY (CORRELATION_SET_ID)) 
CREATE TABLE ODE_CORRELATOR (CORRELATOR_ID BIGINT NOT NULL, CORRELATOR_KEY VARCHAR(254), PROC_ID BIGINT, PRIMARY KEY (CORRELATOR_ID)) 
CREATE TABLE ODE_CORSET_PROP (ID BIGINT NOT NULL, CORRSET_ID BIGINT, PROP_KEY VARCHAR(254), PROP_VALUE VARCHAR(254), PRIMARY KEY (ID)) 
CREATE TABLE ODE_EVENT (EVENT_ID BIGINT NOT NULL, DETAIL VARCHAR(254), DATA BLOB, SCOPE_ID BIGINT, TSTAMP TIMESTAMP, TYPE VARCHAR(254), INSTANCE_ID BIGINT, PROCESS_ID BIGINT, PRIMARY KEY (EVENT_ID)) 
CREATE TABLE ODE_FAULT (FAULT_ID BIGINT NOT NULL, ACTIVITY_ID INTEGER, DATA CLOB(1M), MESSAGE VARCHAR(4000), LINE_NUMBER INTEGER, NAME VARCHAR(254), PRIMARY KEY (FAULT_ID)) 
CREATE TABLE ODE_MESSAGE (MESSAGE_ID BIGINT NOT NULL, DATA CLOB(1M), HEADER CLOB(1M), TYPE VARCHAR(254), MESSAGE_EXCHANGE_ID VARCHAR(254), PRIMARY KEY (MESSAGE_ID)) 
CREATE TABLE ODE_MESSAGE_EXCHANGE (MESSAGE_EXCHANGE_ID VARCHAR(254) NOT NULL, CALLEE VARCHAR(254), CHANNEL VARCHAR(254), CORRELATION_ID VARCHAR(254), CORRELATION_KEYS VARCHAR(254), CORRELATION_STATUS VARCHAR(254), CREATE_TIME TIMESTAMP, DIRECTION CHAR(254), EPR CLOB(1M), FAULT VARCHAR(254), FAULT_EXPLANATION VARCHAR(254), OPERATION VARCHAR(254), PARTNER_LINK_MODEL_ID INTEGER, PATTERN VARCHAR(254), PIPED_ID VARCHAR(254), PORT_TYPE VARCHAR(254), PROPAGATE_TRANS SMALLINT, STATUS VARCHAR(254), SUBSCRIBER_COUNT INTEGER, CORR_ID BIGINT, PARTNER_LINK_ID BIGINT, PROCESS_ID BIGINT, PROCESS_INSTANCE_ID BIGINT, REQUEST_MESSAGE_ID BIGINT, RESPONSE_MESSAGE_ID BIGINT, PRIMARY KEY (MESSAGE_EXCHANGE_ID)) 
CREATE TABLE ODE_MESSAGE_ROUTE (MESSAGE_ROUTE_ID BIGINT NOT NULL, CORRELATION_KEY VARCHAR(254), GROUP_ID VARCHAR(254), ROUTE_INDEX INTEGER, PROCESS_INSTANCE_ID INTEGER, ROUTE_POLICY VARCHAR(16), CORR_ID BIGINT, PRIMARY KEY (MESSAGE_ROUTE_ID)) 
CREATE TABLE ODE_MEX_PROP (ID BIGINT NOT NULL, MEX_ID VARCHAR(254), PROP_KEY VARCHAR(254), PROP_VALUE VARCHAR(2000), PRIMARY KEY (ID)) 
CREATE TABLE ODE_PARTNER_LINK (PARTNER_LINK_ID BIGINT NOT NULL, MY_EPR CLOB(1M), MY_ROLE_NAME VARCHAR(254), MY_ROLE_SERVICE_NAME VARCHAR(254), MY_SESSION_ID VARCHAR(254), PARTNER_EPR CLOB(1M), PARTNER_LINK_MODEL_ID INTEGER, PARTNER_LINK_NAME VARCHAR(254), PARTNER_ROLE_NAME VARCHAR(254), PARTNER_SESSION_ID VARCHAR(254), SCOPE_ID BIGINT, PRIMARY KEY (PARTNER_LINK_ID)) 
CREATE TABLE ODE_PROCESS (ID BIGINT NOT NULL, GUID VARCHAR(254), PROCESS_ID VARCHAR(254), PROCESS_TYPE VARCHAR(254), VERSION BIGINT, PRIMARY KEY (ID)) 
CREATE TABLE ODE_PROCESS_INSTANCE (ID BIGINT NOT NULL, DATE_CREATED TIMESTAMP, EXECUTION_STATE BLOB, FAULT_ID BIGINT, LAST_ACTIVE_TIME TIMESTAMP, LAST_RECOVERY_DATE TIMESTAMP, PREVIOUS_STATE SMALLINT, SEQUENCE BIGINT, INSTANCE_STATE SMALLINT, INSTANTIATING_CORRELATOR_ID BIGINT, PROCESS_ID BIGINT, ROOT_SCOPE_ID BIGINT, PRIMARY KEY (ID)) 
CREATE TABLE ODE_SCOPE (SCOPE_ID BIGINT NOT NULL, MODEL_ID INTEGER, SCOPE_NAME VARCHAR(254), SCOPE_STATE VARCHAR(254), PROCESS_INSTANCE_ID BIGINT, PARENT_SCOPE_ID BIGINT, PRIMARY KEY (SCOPE_ID)) 
CREATE TABLE ODE_XML_DATA (XML_DATA_ID BIGINT NOT NULL, DATA CLOB(1M), IS_SIMPLE_TYPE SMALLINT, NAME VARCHAR(254), SCOPE_ID BIGINT, PRIMARY KEY (XML_DATA_ID)) 
CREATE TABLE ODE_XML_DATA_PROP (ID BIGINT NOT NULL, XML_DATA_ID BIGINT, PROP_KEY VARCHAR(254), PROP_VALUE VARCHAR(254), PRIMARY KEY (ID)) 

CREATE TABLE STORE_DU (NAME VARCHAR(254) NOT NULL, DEPLOYDT TIMESTAMP, DEPLOYER VARCHAR(254), DIR VARCHAR(254), PRIMARY KEY (NAME)) 
CREATE TABLE STORE_PROCESS (PID VARCHAR(254) NOT NULL, STATE VARCHAR(254), TYPE VARCHAR(254), VERSION BIGINT, DU VARCHAR(254), PRIMARY KEY (PID)) 
CREATE TABLE STORE_PROCESS_PROP (id BIGINT NOT NULL, PROP_KEY VARCHAR(254), PROP_VAL VARCHAR(254), PRIMARY KEY (id)) 
CREATE TABLE STORE_PROC_TO_PROP (PROCESSCONFDAOIMPL_PID VARCHAR(254), ELEMENT_ID BIGINT) 
CREATE TABLE STORE_VERSIONS (id BIGINT NOT NULL, VERSION BIGINT, PRIMARY KEY (id)) 
CREATE TABLE TASK_ATTACHMENT (ATTACHMENT_ID BIGINT NOT NULL, MESSAGE_EXCHANGE_ID VARCHAR(254), PRIMARY KEY (ATTACHMENT_ID)) 
CREATE INDEX I_D_CTVRY__INSTANCE ON ODE_ACTIVITY_RECOVERY (INSTANCE_ID) 
CREATE INDEX I_D_CR_ST__SCOPE ON ODE_CORRELATION_SET (SCOPE_ID) 
CREATE INDEX I_D_CRLTR__PROCESS ON ODE_CORRELATOR (PROC_ID) 
CREATE INDEX I_D_CRPRP__CORRSET ON ODE_CORSET_PROP (CORRSET_ID) 
CREATE INDEX I_OD_VENT__INSTANCE ON ODE_EVENT (INSTANCE_ID) 
CREATE INDEX I_OD_VENT__PROCESS ON ODE_EVENT (PROCESS_ID) 
CREATE INDEX I_OD_MSSG__MESSAGEEXCHANGE ON ODE_MESSAGE (MESSAGE_EXCHANGE_ID) 
CREATE INDEX I_D_MSHNG__CORRELATOR ON ODE_MESSAGE_EXCHANGE (CORR_ID) 
CREATE INDEX I_D_MSHNG__PARTNERLINK ON ODE_MESSAGE_EXCHANGE (PARTNER_LINK_ID) 
CREATE INDEX I_D_MSHNG__PROCESS ON ODE_MESSAGE_EXCHANGE (PROCESS_ID) 
CREATE INDEX I_D_MSHNG__PROCESSINST ON ODE_MESSAGE_EXCHANGE (PROCESS_INSTANCE_ID) 
CREATE INDEX I_D_MSHNG__REQUEST ON ODE_MESSAGE_EXCHANGE (REQUEST_MESSAGE_ID) 
CREATE INDEX I_D_MSHNG__RESPONSE ON ODE_MESSAGE_EXCHANGE (RESPONSE_MESSAGE_ID) 
CREATE INDEX I_D_MS_RT__CORRELATOR ON ODE_MESSAGE_ROUTE (CORR_ID) 
CREATE INDEX I_D_MS_RT__PROCESSINST ON ODE_MESSAGE_ROUTE (PROCESS_INSTANCE_ID) 
CREATE INDEX I_D_MXPRP__MEX ON ODE_MEX_PROP (MEX_ID) 
CREATE INDEX I_D_PRLNK__SCOPE ON ODE_PARTNER_LINK (SCOPE_ID) 
CREATE INDEX I_D_PRTNC__FAULT ON ODE_PROCESS_INSTANCE (FAULT_ID) 
CREATE INDEX I_D_PRTNC__INSTANTIATINGCORRELATOR ON ODE_PROCESS_INSTANCE (INSTANTIATING_CORRELATOR_ID) 
CREATE INDEX I_D_PRTNC__PROCESS ON ODE_PROCESS_INSTANCE (PROCESS_ID) 
CREATE INDEX I_D_PRTNC__ROOTSCOPE ON ODE_PROCESS_INSTANCE (ROOT_SCOPE_ID) 
CREATE INDEX I_OD_SCOP__PARENTSCOPE ON ODE_SCOPE (PARENT_SCOPE_ID) 
CREATE INDEX I_OD_SCOP__PROCESSINSTANCE ON ODE_SCOPE (PROCESS_INSTANCE_ID) 
CREATE INDEX I_D_XM_DT__SCOPE ON ODE_XML_DATA (SCOPE_ID) 
CREATE INDEX I_D_XMPRP__XMLDATA ON ODE_XML_DATA_PROP (XML_DATA_ID) 
CREATE INDEX I_STR_CSS__DU ON STORE_PROCESS (DU) 
CREATE INDEX I_STR_PRP_ELEMENT ON STORE_PROC_TO_PROP (ELEMENT_ID) 
CREATE INDEX I_STR_PRP_PROCESSCONFDAOIMPL_PID ON STORE_PROC_TO_PROP (PROCESSCONFDAOIMPL_PID) 
CREATE INDEX I_TSK_MNT_MEXDAO ON TASK_ATTACHMENT (MESSAGE_EXCHANGE_ID) 

-- Human Task Tables and Indexes

CREATE TABLE HT_DEADLINE (id BIGINT NOT NULL, DEADLINE_DATE TIMESTAMP NOT NULL, DEADLINE_NAME VARCHAR(254) NOT NULL, STATUS_TOBE_ACHIEVED VARCHAR(254) NOT NULL, TASK_ID BIGINT, PRIMARY KEY (id)) 
CREATE TABLE HT_DEPLOYMENT_UNIT (id BIGINT NOT NULL, CHECKSUM VARCHAR(254) NOT NULL, DEPLOYED_ON TIMESTAMP, DEPLOY_DIR VARCHAR(254) NOT NULL, NAME VARCHAR(254) NOT NULL, PACKAGE_NAME VARCHAR(254) NOT NULL, STATUS VARCHAR(254) NOT NULL, TENANT_ID BIGINT NOT NULL, VERSION BIGINT NOT NULL, PRIMARY KEY (id)) 
CREATE TABLE HT_EVENT (id BIGINT NOT NULL, EVENT_DETAILS VARCHAR(254), NEW_STATE VARCHAR(254), OLD_STATE VARCHAR(254), EVENT_TIMESTAMP TIMESTAMP NOT NULL, EVENT_TYPE VARCHAR(254) NOT NULL, EVENT_USER VARCHAR(254) NOT NULL, TASK_ID BIGINT, PRIMARY KEY (id)) 
CREATE TABLE HT_GENERIC_HUMAN_ROLE (GHR_ID BIGINT NOT NULL, GHR_TYPE VARCHAR(254), TASK_ID BIGINT, PRIMARY KEY (GHR_ID)) 
CREATE TABLE HT_HUMANROLE_ORGENTITY (HUMANROLE_ID BIGINT, ORGENTITY_ID BIGINT) 
CREATE TABLE HT_JOB (id BIGINT NOT NULL, JOB_DETAILS VARCHAR(4000), JOB_NAME VARCHAR(254), NODEID VARCHAR(254), SCHEDULED VARCHAR(1) NOT NULL, TASKID BIGINT NOT NULL, JOB_TIME BIGINT NOT NULL, TRANSACTED VARCHAR(1) NOT NULL, JOB_TYPE VARCHAR(254) NOT NULL, PRIMARY KEY (id)) 
CREATE TABLE HT_MESSAGE (MESSAGE_ID BIGINT NOT NULL, MESSAGE_DATA CLOB, MESSAGE_HEADER CLOB, MESSAGE_TYPE VARCHAR(254), MESSAGE_NAME VARCHAR(512), TASK_ID BIGINT, PRIMARY KEY (MESSAGE_ID)) 
CREATE TABLE HT_ORG_ENTITY (ORG_ENTITY_ID BIGINT NOT NULL, ORG_ENTITY_NAME VARCHAR(254), ORG_ENTITY_TYPE VARCHAR(254), PRIMARY KEY (ORG_ENTITY_ID)) 
CREATE TABLE HT_PRESENTATION_ELEMENT (id BIGINT NOT NULL, PE_CONTENT VARCHAR(2000), XML_LANG VARCHAR(254), PE_TYPE VARCHAR(31), CONTENT_TYPE VARCHAR(254), TASK_ID BIGINT, PRIMARY KEY (id)) 
CREATE TABLE HT_PRESENTATION_PARAM (id BIGINT NOT NULL, PARAM_NAME VARCHAR(254), PARAM_TYPE VARCHAR(254), PARAM_VALUE VARCHAR(2000), TASK_ID BIGINT, PRIMARY KEY (id)) 
CREATE TABLE HT_TASK (id BIGINT NOT NULL, ACTIVATION_TIME TIMESTAMP, COMPLETE_BY_TIME TIMESTAMP, CREATED_ON TIMESTAMP, ESCALATED VARCHAR(1), EXPIRATION_TIME TIMESTAMP, TASK_NAME VARCHAR(254) NOT NULL, PACKAGE_NAME VARCHAR(254) NOT NULL, PRIORITY INTEGER NOT NULL, SKIPABLE VARCHAR(1), START_BY_TIME TIMESTAMP, STATUS VARCHAR(254) NOT NULL, STATUS_BEFORE_SUSPENSION VARCHAR(254), TASK_DEF_NAME VARCHAR(254) NOT NULL, TASK_VERSION BIGINT NOT NULL, TENANT_ID INTEGER NOT NULL, TASK_TYPE VARCHAR(254) NOT NULL, UPDATED_ON TIMESTAMP, FAILURE_MESSAGE BIGINT, INPUT_MESSAGE BIGINT, OUTPUT_MESSAGE BIGINT, PARENTTASK_ID BIGINT, PRIMARY KEY (id)) 
CREATE TABLE HT_TASK_ATTACHMENT (id BIGINT NOT NULL, ACCESS_TYPE VARCHAR(254), ATTACHED_AT TIMESTAMP, CONTENT_TYPE VARCHAR(254), ATTACHMENT_NAME VARCHAR(254), ATTACHMENT_VALUE VARCHAR(254), TASK_ID BIGINT, ATTACHED_BY BIGINT, PRIMARY KEY (id)) 
CREATE TABLE HT_TASK_COMMENT (id BIGINT NOT NULL, COMMENT_TEXT VARCHAR(4000), COMMENTED_BY VARCHAR(100), COMMENTED_ON TIMESTAMP, MODIFIED_BY VARCHAR(100), MODIFIED_ON TIMESTAMP, TASK_ID BIGINT, PRIMARY KEY (id)) 
CREATE TABLE HT_VERSIONS (id BIGINT NOT NULL, TASK_VERSION BIGINT NOT NULL, PRIMARY KEY (id)) 

CREATE INDEX I_HT_DDLN_TASK ON HT_DEADLINE (TASK_ID) 
CREATE INDEX I_HT_VENT_TASK ON HT_EVENT (TASK_ID) 
CREATE INDEX I_HT_G_RL_TASK ON HT_GENERIC_HUMAN_ROLE (TASK_ID) 
CREATE INDEX I_HT_HTTY_ELEMENT ON HT_HUMANROLE_ORGENTITY (ORGENTITY_ID) 
CREATE INDEX I_HT_HTTY_HUMANROLE_ID ON HT_HUMANROLE_ORGENTITY (HUMANROLE_ID) 
CREATE INDEX I_HT_MSSG_TASK ON HT_MESSAGE (TASK_ID) 
CREATE INDEX I_HT_PMNT_DTYPE ON HT_PRESENTATION_ELEMENT (PE_TYPE) 
CREATE INDEX I_HT_PMNT_TASK ON HT_PRESENTATION_ELEMENT (TASK_ID) 
CREATE INDEX I_HT_PPRM_TASK ON HT_PRESENTATION_PARAM (TASK_ID) 
CREATE INDEX I_HT_TASK_FAILUREMESSAGE ON HT_TASK (FAILURE_MESSAGE) 
CREATE INDEX I_HT_TASK_INPUTMESSAGE ON HT_TASK (INPUT_MESSAGE) 
CREATE INDEX I_HT_TASK_OUTPUTMESSAGE ON HT_TASK (OUTPUT_MESSAGE) 
CREATE INDEX I_HT_TASK_PARENTTASK ON HT_TASK (PARENTTASK_ID) 
CREATE INDEX I_HT_TMNT_ATTACHEDBY ON HT_TASK_ATTACHMENT (ATTACHED_BY) 
CREATE INDEX I_HT_TMNT_TASK ON HT_TASK_ATTACHMENT (TASK_ID) 
CREATE INDEX I_HT_TMNT_TASK1 ON HT_TASK_COMMENT (TASK_ID) 

-- Attachment Management Tables and Indexes

CREATE TABLE ATTACHMENT (id BIGINT NOT NULL, ATTACHMENT_CONTENT BLOB, CONTENT_TYPE VARCHAR(254) NOT NULL, CREATED_BY VARCHAR(254) NOT NULL, CREATED_TIME Timestamp NOT NULL, ATTACHMENT_NAME VARCHAR(254) NOT NULL, ATTACHMENT_URL VARCHAR(254) NOT NULL, PRIMARY KEY (id)) 

-- HT Coordination data table

CREATE TABLE HT_COORDINATION_DATA (MESSAGE_ID VARCHAR(254) NOT NULL, PROCESS_INSTANCE_ID VARCHAR(254), PROTOCOL_HANDlER_URL VARCHAR(254) NOT NULL, TASK_ID VARCHAR(254), PRIMARY KEY (MESSAGE_ID)) 

CREATE TABLE OPENJPA_SEQUENCE_TABLE (ID SMALLINT NOT NULL, SEQUENCE_VALUE BIGINT, PRIMARY KEY (ID)) 