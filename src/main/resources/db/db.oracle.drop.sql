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

