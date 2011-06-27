-- ##bc平台的mysql数据初始化脚本##

-- 系统安全相关模块的初始化数据

-- 插入分类资源数据
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(1, 0, 1, null, '010000','工作事务', null, 'ixxxx');
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(1, 0, 1, null, '020000','系统公告', null, 'ixxxx');
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(1, 0, 1, null, '030000','营运管理', null, 'ixxxx');
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(1, 0, 1, null, '700000','我的配置', null, 'ixxxx');
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(1, 0, 1, null, '800000','系统配置', null, 'ixxxx');
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 1, m.id, '800100','组织架构', null, 'ixxxx' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 1, m.id, '800200','权限管理', null, 'ixxxx' from BC_IDENTITY_RESOURCE m where m.order_='800000';

-- 插入链接资源数据
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '010100','待办事务', '/bc/todoWork/list', 'i0605' from BC_IDENTITY_RESOURCE m where m.order_='010000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '010200','已办事务', '/bc/doneWork/paging', 'i0606' from BC_IDENTITY_RESOURCE m where m.order_='010000';

insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '020100','电子公告', '/bc/bulletin/paging', 'ixxxx' from BC_IDENTITY_RESOURCE m where m.order_='020000';


insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '700100','个性化设置', '/bc/personal/edit', 'i0504' from BC_IDENTITY_RESOURCE m where m.order_='700000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '700200','我的桌面', '/bc/shortcut/list', 'ixxxx' from BC_IDENTITY_RESOURCE m where m.order_='700000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 1, 0, 2, m.id, '700300','我的日志', '/bc/mysyslog/paging', 'ixxxx' from BC_IDENTITY_RESOURCE m where m.order_='700000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 1, 0, 2, m.id, '700400','我的反馈', '/bc/feedback/paging', 'ixxxx' from BC_IDENTITY_RESOURCE m where m.order_='700000';
	
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '800101','职务配置', '/bc/duty/paging', 'i0603' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '800102','单位配置', '/bc/unit/paging', 'i0601' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '800103','部门配置', '/bc/department/paging', 'i0602' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '800104','岗位配置', '/bc/group/paging', 'i0508' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '800105','用户配置', '/bc/user/paging', 'i0507' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 1, 0, 2, m.id, '800106','资源配置', '/bc/resource/paging', 'i0600' from BC_IDENTITY_RESOURCE m where m.order_='800200';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '800107','角色配置', '/bc/role/paging', 'i0509' from BC_IDENTITY_RESOURCE m where m.order_='800200';

insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 1, 0, 2, m.id, '800300','反馈管理', '/bc/feedback/paging', 'ixxxx' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 1, 0, 2, m.id, '800400','附件管理', '/bc/attach/paging', 'ixxxx' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '800500','系统日志', '/bc/syslog/paging', 'ixxxx' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 1, 0, 2, m.id, '800600','消息记录', '/bc/message/paging', 'ixxxx' from BC_IDENTITY_RESOURCE m where m.order_='800000';
    

-- 插入超级管理员角色数据（可访问所有资源）
insert into BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(1, 0, 0,'0001', 'R_ADMIN','超级管理员');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_ADMIN' order by m.ORDER_;

-- 插入通用角色数据
insert into BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(1, 0, 0,'0000', 'R_COMMON','通用角色');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_COMMON' 
	and m.order_ in ('010100','010200','020100','700100','700200','700300','700400','030100','030200')
	order by m.order_;

-- 插入公告管理员角色数据
insert into BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(1, 0, 0,'0002', 'R_MANAGER_BULLETIN','电子公告管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_MANAGER_BULLETIN' 
	and m.order_ in ('020000','020100')
	order by m.order_;

-- 插入用户反馈管理角色数据
insert into BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(1, 0, 0,'0003', 'R_MANAGER_FEEDBACK','用户反馈管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_MANAGER_FEEDBACK' 
	and m.order_ in ('700400','800300')
	order by m.order_;

-- 插入附件管理角色数据
insert into BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(1, 0, 0,'0004', 'R_MANAGER_ATTACH','附件管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='R_MANAGER_ATTACH' 
	and m.order_ in ('800400')
	order by m.order_;


-- 插入职务数据
insert into BC_IDENTITY_DUTY (STATUS_,INNER_,CODE, NAME) values(1, 0, '0101','董事长');
insert into BC_IDENTITY_DUTY (STATUS_,INNER_,CODE, NAME) values(1, 0, '0201','总经理');
insert into BC_IDENTITY_DUTY (STATUS_,INNER_,CODE, NAME) values(1, 0, '0202','副总经理');
insert into BC_IDENTITY_DUTY (STATUS_,INNER_,CODE, NAME) values(1, 0, '0203','主管');
insert into BC_IDENTITY_DUTY (STATUS_,INNER_,CODE, NAME) values(1, 0, '0204','主任');
insert into BC_IDENTITY_DUTY (STATUS_,INNER_,CODE, NAME) values(1, 0, '0205','副主任');
insert into BC_IDENTITY_DUTY (STATUS_,INNER_,CODE, NAME) values(1, 0, '0901','职员');

-- 插入职务编码自动增长数据
-- insert into BC_IDENTITY_IDGENERATOR (TYPE_,VALUE, FORMAT) values('duty.code', 0, '${T}.${V}');
-- 插入用户uid自动增长数据
-- insert into BC_IDENTITY_IDGENERATOR (TYPE_,VALUE, FORMAT) values('user.uid', 0, '${T}.${V}');
-- 插入公告uid自动增长数据
-- insert into BC_IDENTITY_IDGENERATOR (TYPE_,VALUE, FORMAT) values('bulletin.uid', 0, '${T}.${V}');

-- 插入单位数据
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 2, 'D000000','总公司', '000000');
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 2, 'D000100','分公司1', '000100');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D000000' and af.code='D000100';
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 2, 'D000200','分公司2', '000200');

-- 插入部门数据
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 3, 'B000100','办公室', '010100');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D000000' and af.code='B0001';
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 3, 'B000200','财务部', '010200');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D000000' and af.code='B000200';
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 3, 'B009900','信息中心', '019900');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D000000' and af.code='B000300';

insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 3, 'B009901','子部门1', '019901');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='B009901';
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 3, 'B009902','子部门2', '019902');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
     select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='B009902';
    
-- 插入人员数据
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 1, 'dongshizhang','董事长', '000001');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D000000' and af.code='dongshizhang'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 1, 'zongjingli','总经理', '000002');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID)  
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D000000' and af.code='zongjingli'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 1, 'fuzongjingli','副总经理', '000003');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID)  
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D000000' and af.code='fuzongjingli'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 1, 'xiaoming','小明', '000101');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B000100' and af.code='xiaoming'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 1, 'xiaohong','小红', '000102');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B000100' and af.code='xiaohong'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 1, 'xiaojun','小军', '000201');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B000200' and af.code='xiaojun'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 1, 'admin','超级管理员', '009901');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='admin'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 1, 'designer','设计师', '009902');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='designer';
    
-- 插入人员的Detail信息
insert into BC_IDENTITY_ACTOR_DETAIL (ID,CREATE_DATE,WORK_DATE,SEX,CARD,DUTY_ID,COMMENT) 
    select a.id,now(),null,0,null,null,null from BC_IDENTITY_ACTOR a where a.type_=1; 
update BC_IDENTITY_ACTOR a,BC_IDENTITY_ACTOR_DETAIL ad set a.detail_id = ad.id 
    where ad.id = a.id and a.type_=1;
    
-- 插入人员的认证数据(密码默认为888888的md5值)
insert into BC_IDENTITY_AUTH (ID,PASSWORD) 
    select a.id,'21218cca77804d2ba1922c33e0151105' from BC_IDENTITY_ACTOR a where a.type_=1; 

-- 插入岗位数据
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 4, 'G_ADMIN','超级管理岗', '0001');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='G_ADMIN'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 4, 'G9901','测试岗位1', '9901');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='G9901'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 4, 'G9902','测试岗位2', '9902');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='G9902'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 4, 'G9903','测试岗位3', '9903');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='G9903'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 4, 'G9904','测试岗位4', '9904');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='G9904'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 4, 'G9905','测试岗位5', '9905');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='G9905'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 4, 'G9906','测试岗位6', '9906');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='G9906'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_) values('uid', 1, 0, 4, 'G9907','测试岗位7', '9907');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B009900' and af.code='G9907'; 
-- 让超级管理员拥有超级管理岗
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where af.code = 'admin' and am.code = 'G_ADMIN'; 

insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where af.code = 'designer' and am.code in ('G_ADMIN','G9901','G9902','G9903','G9904','G9905','G9906','G9907'); 

-- 更新Actor的uid为'ACTOR-'+id
UPDATE BC_IDENTITY_ACTOR SET UID_=CONCAT('ACTOR-',id);

-- 让顶层单位拥有通用角色
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code='D0000' and r.code='R_COMMON';

-- 让超级管理员拥有超级管理员角色
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code='admin' and r.code='R_ADMIN';

-- 让超级管理岗拥有所有角色
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code='G_ADMIN';

-- 系统桌面相关模块的初始化数据

-- 插入桌面快捷方式数据
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '0001', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='待办事务';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '0002', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='已办事务';
	
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '0101', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='电子公告';
	
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '5001', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='个性化设置';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '5002', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='我的桌面';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '5003', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='我的反馈';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '5004', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='我的日志';
	
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '7001', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='单位配置';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '7002', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='部门配置';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '7003', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='岗位配置';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '7004', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='用户配置';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '7005', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='资源配置';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '7006', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='角色配置';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '7007', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='职务配置';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '7008', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='反馈管理';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,SID,AID) 
	select 1, 0, '7009', 0, null, null, id, null from BC_IDENTITY_RESOURCE where name='系统日志';

-- 报表
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(1, 0, '8001', 0, '饼图', '/bc/chart/pie', 'i0501');
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(1, 0, '8002', 0, '柱图', '/bc/chart/bar', 'i0500');
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(1, 0, '8003', 0, '动态曲线图', '/bc/chart/spline', 'i0502');
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(1, 0, '8004', 0, '综合图表', '/bc/chart/mix', 'i0503');
    
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(1, 0, '8005', 1, '谷歌搜索', 'http://www.google.com.hk/', 'i0505');
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS) 
	values(1, 0, '8006', 1, '百度搜索', 'http://www.baidu.com/', 'i0506');
	
-- 设计用的快捷方式
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select 1, 0, '9001', 0, '分页设计', '/bc/duty/paging', 'i0604', a.id from BC_IDENTITY_ACTOR a where a.code = 'designer';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select 1, 0, '9002', 0, '无分页设计', '/bc/duty/list', 'i0604', a.id from BC_IDENTITY_ACTOR a where a.code = 'designer';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select 1, 0, '9003', 1, 'highcharts', '/ui-libs-demo/highcharts/2.1.4/index.htm', 'i0604', a.id from BC_IDENTITY_ACTOR a where a.code = 'designer';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select 1, 0, '9004', 1, 'jqueryUI', '/ui-libs-demo/jquery-ui/1.8.13/index.html', 'i0604', a.id from BC_IDENTITY_ACTOR a where a.code = 'designer';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select 1, 0, '9005', 1, 'jqGrid', '/ui-libs-demo/jqGrid/3.8.2/jqgrid.html', 'i0604', a.id from BC_IDENTITY_ACTOR a where a.code = 'designer';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select 1, 0, '9006', 1, 'jqLayout', '/ui-libs-demo/jquery-layout/1.2.0/index.html', 'i0604', a.id from BC_IDENTITY_ACTOR a where a.code = 'designer';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select 1, 0, '9007', 1, 'xheditor', '/ui-libs-demo/xheditor/1.1.7/index.html', 'i0604', a.id from BC_IDENTITY_ACTOR a where a.code = 'designer';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select 1, 0, '9008', 1, 'zTree', '/ui-libs-demo/zTree/2.6/index.html', 'i0604', a.id from BC_IDENTITY_ACTOR a where a.code = 'designer';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,AID) 
    select 1, 0, '9009', 0, '附件设计', '/bc/attach/design', 'i0604', a.id from BC_IDENTITY_ACTOR a where a.code = 'designer';

-- 插入全局配置信息
insert into BC_DESKTOP_PERSONAL (STATUS_,INNER_,FONT,THEME,AID) 
	values(1, 0, '12', 'humanity', null);
-- insert into BC_DESKTOP_PERSONAL (STATUS_,INNER_,FONT,THEME,AID) 
-- 	select 1, 0, '14', 'flick', id from BC_IDENTITY_ACTOR where code='admin';

-- 插入测试消息
insert into BC_MESSAGE (SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select now(), '测试标题1', '测试内容1', 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin');
insert into BC_MESSAGE (SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select now(), '测试标题2', '测试内容2', 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin');
insert into BC_MESSAGE (SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select now(), '测试标题3', '测试内容3', 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin');
insert into BC_MESSAGE (SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select now(), '测试标题4', null, 
	(select s.id from BC_IDENTITY_ACTOR s where s.code='admin'),
	(select r.id from BC_IDENTITY_ACTOR r where r.code='admin');

-- 插入1000条登录数据
-- 创建存储过程：loop_time为循环的次数
DELIMITER $$ 
    DROP PROCEDURE IF EXISTS test_create_syslog $$ 
    CREATE PROCEDURE test_create_syslog (loop_time int,userCode varchar(255)) 
    BEGIN 
        DECLARE i int default 0; 
        WHILE i <  loop_time DO 
        insert into BC_LOG_SYSTEM (TYPE_,CREATE_DATE,SUBJECT,CREATER_ID,CREATER_NAME,DEPART_ID,DEPART_NAME,UNIT_ID,UNIT_NAME,C_IP,S_IP,C_INFO) 
        	select 0,now(),concat(u.name,'登录系统',i),u.id,u.name,1,'D',1,'U','127.0.0.1','localhost','Chrome12'
        	from bc_identity_actor u where u.code=userCode;
        SET i = i + 1; 
        END WHILE; 
    END $$ 
DELIMITER ; 
-- 调用存储过程
CALL test_create_syslog(500,'admin'); 
CALL test_create_syslog(500,'designer'); 
