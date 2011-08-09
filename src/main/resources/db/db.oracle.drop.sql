-- ##bcƽ̨�� oracle ɾ��ű�##

-- ���ý���Ϣ���������̨���������SQL Plus�������������sql�ļ���������ִ�����������ܿ��������Ϣ��
-- set serveroutput on;

-- ����ɾ��ָ���û���Ĵ洢����
CREATE OR REPLACE PROCEDURE DROP_USER_TABLE
(
   --����IN��ʾ���������
   --OUT��ʾ������������Ϳ���ʹ������Oracle�еĺϷ����͡�
   i_table_name IN varchar2
)
AS
--�������
num_ number;
str1 varchar2(1000);
BEGIN
  select count(1) into num_ from user_tables where table_name = upper(i_table_name) or table_name = lower(i_table_name); 
  if num_ > 0 then 
    str1 := 'DROP TABLE ' || i_table_name;
    execute immediate str1;
    dbms_output.put_line('�� ' || i_table_name || ' ��ɾ��');
  end if; 
  if num_ <= 0 then 
    dbms_output.put_line('�� ' || i_table_name || ' �����ڣ�����');
  end if; 
END;
/

-- ����ɾ��ָ�����еĴ洢����
CREATE OR REPLACE PROCEDURE DROP_USER_SEQUENCE
(
   i_sequence_name IN varchar2
)
AS
--�������
num_ number;
str1 varchar2(1000);
BEGIN
  select count(1) into num_ from user_sequences where sequence_name = upper(i_sequence_name) or sequence_name = lower(i_sequence_name); 
  if num_ > 0 then 
    str1 := 'DROP SEQUENCE ' || i_sequence_name;
    execute immediate str1;
    dbms_output.put_line('���� ' || i_sequence_name || ' ��ɾ��');
  end if; 
  if num_ <= 0 then 
    dbms_output.put_line('���� ' || i_sequence_name || ' �����ڣ�����');
  end if; 
END;
/

-- ��������hibernate id������
CALL DROP_USER_SEQUENCE('hibernate_sequence');

-- �����õı�
CALL DROP_USER_TABLE('BC_EXAMPLE');

-- �û�����
CALL DROP_USER_TABLE('BC_FEEDBACK');

-- ���ӹ���
CALL DROP_USER_TABLE('BC_BULLETIN');

-- �ĵ�����
CALL DROP_USER_TABLE('BC_DOCS_ATTACH_HISTORY');
CALL DROP_USER_TABLE('BC_DOCS_ATTACH');

-- ϵͳ��־
CALL DROP_USER_TABLE('BC_LOG_SYSTEM');

-- ��������
CALL DROP_USER_TABLE('BC_WORK_TODO');
CALL DROP_USER_TABLE('BC_WORK_DONE');
CALL DROP_USER_TABLE('BC_WORK');

-- ��Ϣ����
CALL DROP_USER_TABLE('BC_MESSAGE');

-- ���Ի�����
CALL DROP_USER_TABLE('BC_DESKTOP_SHORTCUT');
CALL DROP_USER_TABLE('BC_DESKTOP_PERSONAL');

-- ϵͳ��ʶ
CALL DROP_USER_TABLE('BC_IDENTITY_ROLE_ACTOR');
CALL DROP_USER_TABLE('BC_IDENTITY_AUTH');
CALL DROP_USER_TABLE('BC_IDENTITY_ACTOR_RELATION');
CALL DROP_USER_TABLE('BC_IDENTITY_ACTOR_HISTORY');
CALL DROP_USER_TABLE('BC_IDENTITY_ACTOR');
CALL DROP_USER_TABLE('BC_IDENTITY_ACTOR_DETAIL');
CALL DROP_USER_TABLE('BC_IDENTITY_DUTY');
CALL DROP_USER_TABLE('BC_IDENTITY_IDGENERATOR');
CALL DROP_USER_TABLE('BC_IDENTITY_ROLE_RESOURCE');
CALL DROP_USER_TABLE('BC_IDENTITY_ROLE');
CALL DROP_USER_TABLE('BC_IDENTITY_RESOURCE');

-- ѡ��ģ��
CALL DROP_USER_TABLE('BC_OPTION_ITEM');
CALL DROP_USER_TABLE('BC_OPTION_GROUP');

-- ɾ���Խ��Ĵ洢����
-- drop procedure DROP_USER_TABLE;
-- drop procedure DROP_USER_SEQUENCE;

-- activiti5.6 cycle
CALL DROP_USER_TABLE('ACT_CY_CONN_CONFIG');
CALL DROP_USER_TABLE('ACT_CY_CONFIG');
CALL DROP_USER_TABLE('ACT_CY_LINK');
CALL DROP_USER_TABLE('ACT_CY_PEOPLE_LINK');
CALL DROP_USER_TABLE('ACT_CY_TAG');
CALL DROP_USER_TABLE('ACT_CY_COMMENT');
CALL DROP_USER_TABLE('ACT_CY_V_FOLDER');
CALL DROP_USER_TABLE('ACT_CY_PROCESS_SOLUTION');

-- activiti5.6 identity
CALL DROP_USER_TABLE('ACT_ID_INFO');
CALL DROP_USER_TABLE('ACT_ID_MEMBERSHIP');
CALL DROP_USER_TABLE('ACT_ID_GROUP');
CALL DROP_USER_TABLE('ACT_ID_USER');

-- activiti5.6 history
CALL DROP_USER_TABLE('ACT_HI_PROCINST');
CALL DROP_USER_TABLE('ACT_HI_ACTINST');
CALL DROP_USER_TABLE('ACT_HI_TASKINST');
CALL DROP_USER_TABLE('ACT_HI_DETAIL');
CALL DROP_USER_TABLE('ACT_HI_COMMENT');
CALL DROP_USER_TABLE('ACT_HI_ATTACHMENT');

-- activiti5.6 engine
CALL DROP_USER_TABLE('ACT_GE_PROPERTY');
CALL DROP_USER_TABLE('ACT_RU_VARIABLE');
CALL DROP_USER_TABLE('ACT_RU_JOB');
CALL DROP_USER_TABLE('ACT_GE_BYTEARRAY');
CALL DROP_USER_TABLE('ACT_RE_DEPLOYMENT');
CALL DROP_USER_TABLE('ACT_RU_IDENTITYLINK');
CALL DROP_USER_TABLE('ACT_RU_TASK');
CALL DROP_USER_TABLE('ACT_RE_PROCDEF');
CALL DROP_USER_TABLE('ACT_RU_EXECUTION');

