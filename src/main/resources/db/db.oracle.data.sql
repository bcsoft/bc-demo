-- ##bcƽ̨�� oracle ���ݳ�ʼ���ű�##

-- ϵͳ��ȫ���ģ��ĳ�ʼ������

-- ���������Դ����
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, null, '010000','��������', null, 'i0403');
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, null, '020000','ϵͳ����', null, 'i0403');
		
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, null, '700000','�ҵ�����', null, 'i0403');
	
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, null, '800000','ϵͳ����', null, 'i0403');
  insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, m.id, '800100','��֯�ܹ�', null, 'i0403' from BC_IDENTITY_RESOURCE m where m.order_='800000';
  insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, m.id, '800200','Ȩ�޹���', null, 'i0403' from BC_IDENTITY_RESOURCE m where m.order_='800000';

-- ����������Դ����
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '010100','��������', '/bc/todoWork/list', 'i0001' from BC_IDENTITY_RESOURCE m where m.order_='010000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '010200','�Ѱ�����', '/bc/doneWork/paging', 'i0002' from BC_IDENTITY_RESOURCE m where m.order_='010000';

insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '020100','���ӹ���', '/bc/bulletin/paging', 'i0406' from BC_IDENTITY_RESOURCE m where m.order_='020000';

insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '700100','���Ի�����', '/bc/personal/edit', 'i0302' from BC_IDENTITY_RESOURCE m where m.order_='700000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '700200','�ҵ�����', '/bc/shortcut/list', 'i0407' from BC_IDENTITY_RESOURCE m where m.order_='700000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '700300','�ҵ���־', '/bc/mysyslog/paging', 'i0208' from BC_IDENTITY_RESOURCE m where m.order_='700000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '700400','�ҵķ���', '/bc/feedback/paging', 'i0303' from BC_IDENTITY_RESOURCE m where m.order_='700000';
	
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800101','ְ������', '/bc/duty/paging', 'i0009' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800102','��λ����', '/bc/unit/paging', 'i0007' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800103','��������', '/bc/department/paging', 'i0008' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800104','��λ����', '/bc/group/paging', 'i0003' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800105','�û�����', '/bc/user/paging', 'i0003' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800106','��Դ����', '/bc/resource/paging', 'i0005' from BC_IDENTITY_RESOURCE m where m.order_='800200';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800107','��ɫ����', '/bc/role/paging', 'i0006' from BC_IDENTITY_RESOURCE m where m.order_='800200';

insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800300','��������', '/bc/feedback/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800400','��������', '/bc/attach/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800500','ϵͳ��־', '/bc/syslog/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800600','��Ϣ��¼', '/bc/message/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
   

-- ���볬������Ա��ɫ���ݣ��ɷ���������Դ��
insert into BC_IDENTITY_ROLE (ID,STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 0,'0001', 'R_ADMIN','��������Ա');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_ADMIN' order by m.ORDER_;

-- ����ͨ�ý�ɫ����
insert into BC_IDENTITY_ROLE (ID,STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 0,'0000', 'R_COMMON','ͨ�ý�ɫ');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_COMMON' 
	and m.order_ in ('010100','010200','020100','700100','700200','700300','700400')
	order by m.order_;

-- ���빫�����Ա��ɫ����
insert into BC_IDENTITY_ROLE (ID,STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 0,'0002', 'R_MANAGER_BULLETIN','���ӹ������');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_MANAGER_BULLETIN' 
	and m.order_ in ('020000','020100')
	order by m.order_;

-- �����û����������ɫ����
insert into BC_IDENTITY_ROLE (ID,STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 0,'0003', 'R_MANAGER_FEEDBACK','�û���������');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_MANAGER_FEEDBACK' 
	and m.order_ in ('700400','800300')
	order by m.order_;

-- ���븽�������ɫ����
insert into BC_IDENTITY_ROLE (ID,STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 0,'0004', 'R_MANAGER_ATTACH','��������');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_MANAGER_ATTACH' 
	and m.order_ in ('800400')
	order by m.order_;


-- ����ְ������
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0101','���³�');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0201','�ܾ���');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0202','���ܾ���');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0203','����');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0204','����');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0205','������');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0901','ְԱ');


-- ���뵥λ����
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 2, 'D00','�ܹ�˾', '00000000','zonggongsi');
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 2, 'D01','�ֹ�˾1', '01000000','fengongsi1');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='D01';
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 2, 'D02','�ֹ�˾2', '02000000','fengongsi2');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='D02';

-- ���벿������
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 3, 'B01','�칫��', '00010000','bangongshi');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='B01';
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 3, 'B02','����', '00020000','caiwubu');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='B02';
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 3, 'B03','��Ϣ����', '00030000','xinxizhongxin');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='B03';

insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 3, 'B0301','�Ӳ���1', '00030100','zibumen1');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='B0301';
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 3, 'B0302','�Ӳ���2', '00030200','zibumen2');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
     select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='B0302';
    
-- ������Ա����
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'dongshizhang','���³�', '00000001','���³�');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='dongshizhang'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'zongjingli','�ܾ���', '00000002','zongjingli');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID)  
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='zongjingli'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'fuzongjingli','���ܾ���', '00000003','fuzongjingli');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID)  
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='fuzongjingli'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'xiaoming','С��', '00010001','xiaoming');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B01' and af.code='xiaoming'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'xiaohong','С��', '00010002','xiaohong');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B01' and af.code='xiaohong'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'xiaojun','С��', '00020001','xiaojun');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B02' and af.code='xiaojun'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'admin','��������Ա', '00030001','chaojiguanliyuan');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='admin'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'dragon','���ٻ�', '00030002', 'huangrongji');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='dragon';
    
-- ������Ա��Detail��Ϣ
insert into BC_IDENTITY_ACTOR_DETAIL (ID,CREATE_DATE,WORK_DATE,SEX,CARD,DUTY_ID,COMMENT_) 
    select a.id,sysdate ,null,0,null,null,null from BC_IDENTITY_ACTOR a where a.type_=1; 
update BC_IDENTITY_ACTOR a set a.detail_id = (select ad.id from BC_IDENTITY_ACTOR_DETAIL ad where ad.id = a.id)
    where a.type_=1 and exists (select 1 from BC_IDENTITY_ACTOR_DETAIL ad where ad.id = a.id);
    
-- ������Ա����֤����(����Ĭ��Ϊ888888��md5ֵ)
insert into BC_IDENTITY_AUTH (ID,PASSWORD) 
    select a.id,'21218cca77804d2ba1922c33e0151105' from BC_IDENTITY_ACTOR a where a.type_=1; 

-- �����λ����
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G_ADMIN','���������', '0000');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G_ADMIN'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9901','���Ը�λ1', '9901');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9901'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9902','���Ը�λ2', '9902');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9902'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9903','���Ը�λ3', '9903');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9903'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9904','���Ը�λ4', '9904');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9904'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9905','���Ը�λ5', '9905');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9905'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9906','���Ը�λ6', '9906');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9906'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9907','���Ը�λ7', '9907');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9907'; 
-- �ó�������Աӵ�г��������
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where af.code in ('admin','dragon') and am.code in ('G_ADMIN','G9901','G9902','G9903','G9904','G9905','G9906','G9907'); 

-- ����Actor��uidΪ'ACTOR-'+id
UPDATE BC_IDENTITY_ACTOR SET UID_=CONCAT('ACTOR-',id);

-- �ö��㵥λӵ��ͨ�ý�ɫ
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code='D00' and r.code='R_COMMON';

-- �ó�������Աӵ�г�������Ա��ɫ
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code in ('admin','dragon') and r.code='R_ADMIN';

-- �ó��������ӵ�����н�ɫ
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code='G_ADMIN';

-- ϵͳ�������ģ��ĳ�ʼ������

-- ���������ݷ�ʽ����
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '0001', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='��������';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '0002', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='�Ѱ�����';
	
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '0101', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='���ӹ���';
	
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1001', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='���Ի�����';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1002', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='�ҵ�����';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1003', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='�ҵķ���';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1004', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='�ҵ���־';
	
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1101', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='��λ����';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1102', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='��������';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1103', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='��λ����';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1104', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='�û�����';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1105', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='��Դ����';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1106', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='��ɫ����';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1107', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='ְ������';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1108', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='��������';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1109', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='ϵͳ��־';
    
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8001', 1, '�ȸ�����', 'http://www.google.com.hk/', 'i0204');
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8002', 1, '�ٶ�����', 'http://www.baidu.com/', 'i0205');
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8003', 0, '���������', '/bc/attach/browser', 'i0404');

-- ����
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8101', 0, '��ͼ', '/bc/chart/pie', 'i0201');
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8102', 0, '��ͼ', '/bc/chart/bar', 'i0200');
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8103', 0, '��̬����ͼ', '/bc/chart/spline', 'i0202');
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8104', 0, '�ۺ�ͼ��', '/bc/chart/mix', 'i0203');
	
-- ����õĿ�ݷ�ʽ
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8201', 0, '��ҳ���', '/bc/duty/paging', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8202', 0, '�޷�ҳ���', '/bc/duty/list', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8203', 0, '�������', '/bc/attach/design', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';

insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8301', 1, 'jqueryUI', '/ui-libs-demo/jquery-ui/1.8.13/index.html', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8302', 1, 'highcharts', '/ui-libs-demo/highcharts/2.1.4/index.htm', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8303', 1, 'xheditor', '/ui-libs-demo/xheditor/1.1.7/index.html', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8304', 1, 'zTree', '/ui-libs-demo/zTree/2.6/index.html', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8305', 1, 'jcrop', '/ui-libs-demo/jcrop/0.9.9/index.html', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8306', 1, 'jqGrid', '/ui-libs-demo/jqGrid/3.8.2/jqgrid.html', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8307', 1, 'jqLayout', '/ui-libs-demo/jquery-layout/1.2.0/index.html', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';

-- ����ȫ��������Ϣ
insert into BC_DESKTOP_PERSONAL (ID,STATUS_,INNER_,FONT,THEME,AID) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '12', 'redmond', null);

-- �������������������Ϣ
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'chrome12.0.742.112', 23152416,'exe',0
	,'�ȸ������Chrome12.0.exe','browser/chrome/chrome12.0.742.112.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'firefox5.0', 13530208,'exe',0
	,'��������Firefox5.0.exe','browser/firefox/firefox5.0.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'safari5.0.5', 35624744,'exe',0
	,'ƻ�������Safari5.0.5.exe','browser/safari/safari5.0.5.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'opera11.50', 10309696,'exe',0
	,'Ų�������Opera11.50.exe','browser/opera/opera11.50.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'ie9.0', 18658608,'exe',0
	,'΢�������IE9.0.exe','browser/ie/IE9.0-Windows7-x86-chs.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'ie8.0', 16901472,'exe',0
	,'΢�������IE8.0.exe','browser/ie/IE8.0-WindowsXP-x86-chs.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;

-- ���������Ϣ
insert into BC_MESSAGE (ID,SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , '���Ա���1', '��������1', 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin') from dual;
insert into BC_MESSAGE (ID,SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , '���Ա���2', '��������2', 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin') from dual;
insert into BC_MESSAGE (ID,SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , '���Ա���3', '��������3', 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin') from dual;
insert into BC_MESSAGE (ID,SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , '���Ա���4', null, 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin') from dual;


-- ����1000����¼����
-- �����洢���̣�loop_timeΪѭ���Ĵ���
-- ����ɾ��ָ���û���Ĵ洢����
CREATE OR REPLACE PROCEDURE test_create_syslog
(
   --����IN��ʾ���������
   --OUT��ʾ������������Ϳ���ʹ������Oracle�еĺϷ����͡�
   loop_time IN number,
   userCode IN varchar2
)
AS
--�������
i number;
BEGIN
  i := 0;
  WHILE i <  loop_time LOOP
    insert into BC_LOG_SYSTEM (ID,TYPE_,CREATE_DATE,SUBJECT,CREATER_ID,CREATER_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME,C_IP,S_IP,C_INFO)
      select HIBERNATE_SEQUENCE.NEXTVAL, 0,sysdate,concat(u.name,'��¼ϵͳ'),u.id,u.name,1,'D',1,'U','127.0.0.1','localhost','Chrome12'
      from BC_IDENTITY_ACTOR u where u.CODE=userCode;
    i := i + 1;
  END LOOP;
END;
/

-- ���ô洢����
CALL test_create_syslog(500,'admin'); 
CALL test_create_syslog(500,'dragon'); 
