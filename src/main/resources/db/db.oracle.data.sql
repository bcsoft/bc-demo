-- ##bc平台的 oracle 数据初始化脚本##

-- 系统安全相关模块的初始化数据

-- 插入分类资源数据
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, null, '010000','工作事务', null, 'i0403');
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, null, '020000','系统公告', null, 'i0403');
		
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, null, '700000','我的配置', null, 'i0403');
	
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, null, '800000','系统配置', null, 'i0403');
  insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, m.id, '800100','组织架构', null, 'i0403' from BC_IDENTITY_RESOURCE m where m.order_='800000';
  insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 1, m.id, '800200','权限管理', null, 'i0403' from BC_IDENTITY_RESOURCE m where m.order_='800000';

-- 插入链接资源数据
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '010100','待办事务', '/bc/todoWork/list', 'i0001' from BC_IDENTITY_RESOURCE m where m.order_='010000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '010200','已办事务', '/bc/doneWork/paging', 'i0002' from BC_IDENTITY_RESOURCE m where m.order_='010000';

insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '020100','电子公告', '/bc/bulletin/paging', 'i0406' from BC_IDENTITY_RESOURCE m where m.order_='020000';

insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '700100','个性化设置', '/bc/personal/edit', 'i0302' from BC_IDENTITY_RESOURCE m where m.order_='700000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '700200','我的桌面', '/bc/shortcut/list', 'i0407' from BC_IDENTITY_RESOURCE m where m.order_='700000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '700300','我的日志', '/bc/mysyslog/paging', 'i0208' from BC_IDENTITY_RESOURCE m where m.order_='700000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '700400','我的反馈', '/bc/feedback/paging', 'i0303' from BC_IDENTITY_RESOURCE m where m.order_='700000';
	
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800101','职务配置', '/bc/duty/paging', 'i0009' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800102','单位配置', '/bc/unit/paging', 'i0007' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800103','部门配置', '/bc/department/paging', 'i0008' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800104','岗位配置', '/bc/group/paging', 'i0003' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800105','用户配置', '/bc/user/paging', 'i0003' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800106','资源配置', '/bc/resource/paging', 'i0005' from BC_IDENTITY_RESOURCE m where m.order_='800200';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800107','角色配置', '/bc/role/paging', 'i0006' from BC_IDENTITY_RESOURCE m where m.order_='800200';

insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800300','反馈管理', '/bc/feedback/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800400','附件管理', '/bc/attach/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800500','系统日志', '/bc/syslog/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (ID,STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 2, m.id, '800600','消息记录', '/bc/message/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
   

-- 插入超级管理员角色数据（可访问所有资源）
insert into BC_IDENTITY_ROLE (ID,STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 0,'0001', 'R_ADMIN','超级管理员');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_ADMIN' order by m.ORDER_;

-- 插入通用角色数据
insert into BC_IDENTITY_ROLE (ID,STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 0,'0000', 'R_COMMON','通用角色');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_COMMON' 
	and m.order_ in ('010100','010200','020100','700100','700200','700300','700400')
	order by m.order_;

-- 插入公告管理员角色数据
insert into BC_IDENTITY_ROLE (ID,STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 0,'0002', 'R_MANAGER_BULLETIN','电子公告管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_MANAGER_BULLETIN' 
	and m.order_ in ('020000','020100')
	order by m.order_;

-- 插入用户反馈管理角色数据
insert into BC_IDENTITY_ROLE (ID,STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 0,'0003', 'R_MANAGER_FEEDBACK','用户反馈管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_MANAGER_FEEDBACK' 
	and m.order_ in ('700400','800300')
	order by m.order_;

-- 插入附件管理角色数据
insert into BC_IDENTITY_ROLE (ID,STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, 0,'0004', 'R_MANAGER_ATTACH','附件管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_MANAGER_ATTACH' 
	and m.order_ in ('800400')
	order by m.order_;


-- 插入职务数据
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0101','董事长');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0201','总经理');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0202','副总经理');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0203','主管');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0204','主任');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0205','副主任');
insert into BC_IDENTITY_DUTY (ID,CODE, NAME) values(HIBERNATE_SEQUENCE.NEXTVAL,'0901','职员');


-- 插入单位数据
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 2, 'D00','总公司', '00000000','zonggongsi');
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 2, 'D01','分公司1', '01000000','fengongsi1');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='D01';
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 2, 'D02','分公司2', '02000000','fengongsi2');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='D02';

-- 插入部门数据
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 3, 'B01','办公室', '00010000','bangongshi');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='B01';
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 3, 'B02','财务部', '00020000','caiwubu');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='B02';
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 3, 'B03','信息中心', '00030000','xinxizhongxin');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='B03';

insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 3, 'B0301','子部门1', '00030100','zibumen1');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='B0301';
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 3, 'B0302','子部门2', '00030200','zibumen2');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
     select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='B0302';
    
-- 插入人员数据
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'dongshizhang','董事长', '00000001','董事长');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='dongshizhang'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'zongjingli','总经理', '00000002','zongjingli');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID)  
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='zongjingli'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'fuzongjingli','副总经理', '00000003','fuzongjingli');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID)  
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='fuzongjingli'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'xiaoming','小明', '00010001','xiaoming');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B01' and af.code='xiaoming'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'xiaohong','小红', '00010002','xiaohong');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B01' and af.code='xiaohong'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'xiaojun','小军', '00020001','xiaojun');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B02' and af.code='xiaojun'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'admin','超级管理员', '00030001','chaojiguanliyuan');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='admin'; 
    
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 1, 'dragon','黄荣基', '00030002', 'huangrongji');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='dragon';
    
-- 插入人员的Detail信息
insert into BC_IDENTITY_ACTOR_DETAIL (ID,CREATE_DATE,WORK_DATE,SEX,CARD,DUTY_ID,COMMENT_) 
    select a.id,sysdate ,null,0,null,null,null from BC_IDENTITY_ACTOR a where a.type_=1; 
update BC_IDENTITY_ACTOR a set a.detail_id = (select ad.id from BC_IDENTITY_ACTOR_DETAIL ad where ad.id = a.id)
    where a.type_=1 and exists (select 1 from BC_IDENTITY_ACTOR_DETAIL ad where ad.id = a.id);
    
-- 插入人员的认证数据(密码默认为888888的md5值)
insert into BC_IDENTITY_AUTH (ID,PASSWORD) 
    select a.id,'21218cca77804d2ba1922c33e0151105' from BC_IDENTITY_ACTOR a where a.type_=1; 

-- 插入岗位数据
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G_ADMIN','超级管理岗', '0000');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G_ADMIN'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9901','测试岗位1', '9901');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9901'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9902','测试岗位2', '9902');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9902'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9903','测试岗位3', '9903');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9903'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9904','测试岗位4', '9904');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9904'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9905','测试岗位5', '9905');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9905'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9906','测试岗位6', '9906');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9906'; 
insert into BC_IDENTITY_ACTOR (ID,UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values(HIBERNATE_SEQUENCE.NEXTVAL,'uid', 1, 0, 4, 'G9907','测试岗位7', '9907');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9907'; 
-- 让超级管理员拥有超级管理岗
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where af.code in ('admin','dragon') and am.code in ('G_ADMIN','G9901','G9902','G9903','G9904','G9905','G9906','G9907'); 

-- 更新Actor的uid为'ACTOR-'+id
UPDATE BC_IDENTITY_ACTOR SET UID_=CONCAT('ACTOR-',id);

-- 让顶层单位拥有通用角色
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code='D00' and r.code='R_COMMON';

-- 让超级管理员拥有超级管理员角色
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code in ('admin','dragon') and r.code='R_ADMIN';

-- 让超级管理岗拥有所有角色
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code='G_ADMIN';

-- 系统桌面相关模块的初始化数据

-- 插入桌面快捷方式数据
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '0001', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='待办事务';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '0002', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='已办事务';
	
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '0101', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='电子公告';
	
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1001', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='个性化设置';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1002', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='我的桌面';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1003', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='我的反馈';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1004', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='我的日志';
	
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1101', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='单位配置';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1102', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='部门配置';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1103', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='岗位配置';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1104', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='用户配置';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1105', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='资源配置';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1106', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='角色配置';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1107', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='职务配置';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1108', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='反馈管理';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '1109', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='系统日志';
    
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8001', 1, '谷歌搜索', 'http://www.google.com.hk/', 'i0204');
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8002', 1, '百度搜索', 'http://www.baidu.com/', 'i0205');
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8003', 0, '下载浏览器', '/bc/attach/browser', 'i0404');

-- 报表
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8101', 0, '饼图', '/bc/chart/pie', 'i0201');
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8102', 0, '柱图', '/bc/chart/bar', 'i0200');
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8103', 0, '动态曲线图', '/bc/chart/spline', 'i0202');
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8104', 0, '综合图表', '/bc/chart/mix', 'i0203');
	
-- 设计用的快捷方式
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8201', 0, '分页设计', '/bc/duty/paging', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8202', 0, '无分页设计', '/bc/duty/list', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';
insert into BC_DESKTOP_SHORTCUT (ID,STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '8203', 0, '附件设计', '/bc/attach/design', 'i0300', a.id from BC_IDENTITY_ACTOR a where a.code = 'admin';

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

-- 插入全局配置信息
insert into BC_DESKTOP_PERSONAL (ID,STATUS_,INNER_,FONT,THEME,AID) 
	values(HIBERNATE_SEQUENCE.NEXTVAL,1, 0, '12', 'redmond', null);

-- 插入浏览器附件下载信息
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'chrome12.0.742.112', 23152416,'exe',0
	,'谷歌浏览器Chrome12.0.exe','browser/chrome/chrome12.0.742.112.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'firefox5.0', 13530208,'exe',0
	,'火狐浏览器Firefox5.0.exe','browser/firefox/firefox5.0.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'safari5.0.5', 35624744,'exe',0
	,'苹果浏览器Safari5.0.5.exe','browser/safari/safari5.0.5.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'opera11.50', 10309696,'exe',0
	,'挪威浏览器Opera11.50.exe','browser/opera/opera11.50.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'ie9.0', 18658608,'exe',0
	,'微软浏览器IE9.0.exe','browser/ie/IE9.0-Windows7-x86-chs.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;
insert into BC_DOCS_ATTACH (ID,FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH
	,AUTHOR_ID,AUTHOR_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , 1, 'browser', 'ie8.0', 16901472,'exe',0
	,'微软浏览器IE8.0.exe','browser/ie/IE8.0-WindowsXP-x86-chs.exe',
	(select a.id from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='admin'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='B03'),
	(select a.id from BC_IDENTITY_ACTOR a where a.code='D00'),
	(select a.name from BC_IDENTITY_ACTOR a where a.code='D00') from dual;

-- 插入测试消息
insert into BC_MESSAGE (ID,SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , '测试标题1', '测试内容1', 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin') from dual;
insert into BC_MESSAGE (ID,SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , '测试标题2', '测试内容2', 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin') from dual;
insert into BC_MESSAGE (ID,SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , '测试标题3', '测试内容3', 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin') from dual;
insert into BC_MESSAGE (ID,SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select HIBERNATE_SEQUENCE.NEXTVAL,sysdate , '测试标题4', null, 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin') from dual;


-- 插入1000条登录数据
-- 创建存储过程：loop_time为循环的次数
-- 创建删除指定用户表的存储过程
CREATE OR REPLACE PROCEDURE test_create_syslog
(
   --参数IN表示输入参数，
   --OUT表示输入参数，类型可以使用任意Oracle中的合法类型。
   loop_time IN number,
   userCode IN varchar2
)
AS
--定义变量
i number;
BEGIN
  i := 0;
  WHILE i <  loop_time LOOP
    insert into BC_LOG_SYSTEM (ID,TYPE_,CREATE_DATE,SUBJECT,CREATER_ID,CREATER_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME,C_IP,S_IP,C_INFO)
      select HIBERNATE_SEQUENCE.NEXTVAL, 0,sysdate,concat(u.name,'登录系统'),u.id,u.name,1,'D',1,'U','127.0.0.1','localhost','Chrome12'
      from BC_IDENTITY_ACTOR u where u.CODE=userCode;
    i := i + 1;
  END LOOP;
END;
/

-- 调用存储过程
CALL test_create_syslog(500,'admin'); 
CALL test_create_syslog(500,'dragon'); 
