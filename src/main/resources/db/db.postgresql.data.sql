-- ##bc平台的mysql数据初始化脚本##

-- 系统安全相关模块的初始化数据

-- 资源:我的事务
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(0, 0,  1, null, '010000','我的事务', null, 'i0403');
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '010100','待办工作', '/bc/todoWork/list', 'i0001' from BC_IDENTITY_RESOURCE m where m.order_='010000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '010200','已办工作', '/bc/doneWork/paging', 'i0002' from BC_IDENTITY_RESOURCE m where m.order_='010000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 0, 0, 2, m.id, '011000','系统反馈', '/bc/feedback/paging', 'i0303' from BC_IDENTITY_RESOURCE m where m.order_='010000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '011100','个性化设置', '/bc/personal/edit', 'i0302' from BC_IDENTITY_RESOURCE m where m.order_='010000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '011200','桌面设置', '/bc/shortcut/list', 'i0407' from BC_IDENTITY_RESOURCE m where m.order_='010000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 0, 0, 2, m.id, '011300','登录日志', '/bc/mysyslog/paging', 'i0208' from BC_IDENTITY_RESOURCE m where m.order_='010000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 0, 0, 2, m.id, '011400','下载浏览器', '/bc/attach/browser', 'i0404' from BC_IDENTITY_RESOURCE m where m.order_='010000';

	
-- 资源:常用链接
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(0, 0,  1, null, '070000','友情链接', null, 'i0100');
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '070100','我在这里', 'http://code.google.com/p/dragon-bc', 'i0608' from BC_IDENTITY_RESOURCE m where m.order_='070000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '070100','GitHub', 'https://github.com/rongjihuang/bc-demo', 'i0607' from BC_IDENTITY_RESOURCE m where m.order_='070000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '070200','开源中国社区', 'http://www.oschina.net', 'i0606' from BC_IDENTITY_RESOURCE m where m.order_='070000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '070300','ITeye', 'http://www.iteye.com', 'i0605' from BC_IDENTITY_RESOURCE m where m.order_='070000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '070400','cnBeta', 'http://www.cnbeta.com', 'i0604' from BC_IDENTITY_RESOURCE m where m.order_='070000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '070500','图片资源', 'http://www.iconarchive.com', 'i0509' from BC_IDENTITY_RESOURCE m where m.order_='070000';
-- 资源:常用链接/微博
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select 0, 0, 1, m.id, '073900','微博', null, 'i0508' from BC_IDENTITY_RESOURCE m where m.order_='070000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '073901','新浪微博', 'http://weibo.com', 'i0508' from BC_IDENTITY_RESOURCE m where m.order_='073900';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '073902','腾讯微博', 'http://t.qq.com', 'i0507' from BC_IDENTITY_RESOURCE m where m.order_='073900';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '073903','网易微博', 'http://t.163.com', 'i0506' from BC_IDENTITY_RESOURCE m where m.order_='073900';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '073904','搜狐微博', 'http://t.sohu.com', 'i0508' from BC_IDENTITY_RESOURCE m where m.order_='073900';
-- 资源:常用链接/搜索引擎
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select 0, 0, 1, m.id, '074000','搜索引擎', null, 'i0100' from BC_IDENTITY_RESOURCE m where m.order_='070000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074001','谷歌', 'http://www.google.com.hk', 'i0204' from BC_IDENTITY_RESOURCE m where m.order_='074000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074002','必应', 'http://cn.bing.com', 'i0204' from BC_IDENTITY_RESOURCE m where m.order_='074000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074003','百度', 'http://www.baidu.com', 'i0205' from BC_IDENTITY_RESOURCE m where m.order_='074000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074004','中国雅虎', 'http://search.cn.yahoo.com', 'i0204' from BC_IDENTITY_RESOURCE m where m.order_='074000';
-- 资源:常用链接/功能演示
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select 0, 0, 1, m.id, '074100','功能演示', null, 'i0100' from BC_IDENTITY_RESOURCE m where m.order_='070000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '074101','选择4Actor', '/bc-test/selectIdentity', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '074102','选择日期', '/bc-test/datepicker', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '074103','附件设计', '/bc/attach/design', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '074104','选择4BS', '/bs-test/select', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074100';
-- 资源:常用链接/功能演示/报表演示
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select 0, 0, 1, m.id, '074200','报表演示', null, 'i0100' from BC_IDENTITY_RESOURCE m where m.order_='074100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '074201','饼图', '/bc/chart/pie', 'i0201' from BC_IDENTITY_RESOURCE m where m.order_='074200';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '074202','柱图', '/bc/chart/bar', 'i0200' from BC_IDENTITY_RESOURCE m where m.order_='074200';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '074203','动态曲线图', '/bc/chart/spline', 'i0202' from BC_IDENTITY_RESOURCE m where m.order_='074200';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '074204','综合图表', '/bc/chart/mix', 'i0203' from BC_IDENTITY_RESOURCE m where m.order_='074200';
-- 资源:常用链接/功能演示/UI组件
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select 0, 0, 1, m.id, '074300','UI组件', null, 'i0100' from BC_IDENTITY_RESOURCE m where m.order_='074100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074301','jqueryUI', '/ui-libs-demo/jquery-ui/1.8.16/index.html', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074300';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074302','jqGrid', '/ui-libs-demo/jqGrid/3.8.2/jqgrid.html', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074300';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074303','jqLayout', '/ui-libs-demo/jquery-layout/1.2.0/index.html', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074300';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074304','highcharts', '/ui-libs-demo/highcharts/2.1.4/index.htm', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074300';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074305','xheditor', '/ui-libs-demo/xheditor/1.1.7/index.html', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074300';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074306','zTree', '/ui-libs-demo/zTree/2.6/index.html', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074300';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 3, m.id, '074307','jcrop', '/ui-libs-demo/jcrop/0.9.9/index.html', 'i0300' from BC_IDENTITY_RESOURCE m where m.order_='074300';

	
-- 资源:系统维护
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(0, 0,  1, null, '800000','系统维护', null, 'i0403');
    
-- 资源:系统维护/组织架构
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select 0, 0, 1, m.id, '800100','组织架构', null, 'i0403' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '800101','职务配置', '/bc/duty/paging', 'i0009' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '800102','单位配置', '/bc/units/paging', 'i0007' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '800103','部门配置', '/bc/departments/paging', 'i0008' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '800104','岗位配置', '/bc/groups/paging', 'i0003' from BC_IDENTITY_RESOURCE m where m.order_='800100';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '800105','用户配置', '/bc/users/paging', 'i0003' from BC_IDENTITY_RESOURCE m where m.order_='800100';
    
-- 资源:系统维护/权限管理
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
    select 0, 0, 1, m.id, '800200','权限管理', null, 'i0403' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 0, 0, 2, m.id, '800201','资源配置', '/bc/resource/paging', 'i0005' from BC_IDENTITY_RESOURCE m where m.order_='800200';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '800202','角色配置', '/bc/role/paging', 'i0006' from BC_IDENTITY_RESOURCE m where m.order_='800200';

-- 资源:系统维护/其他
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 0, 0, 2, m.id, '800301','选项分组', '/bc/optionGroup/list', 'i0000' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 0, 0, 2, m.id, '800302','选项管理', '/bc/optionItem/paging', 'i0000' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 0, 0, 2, m.id, '800303','反馈管理', '/bc/feedback/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 0, 0, 2, m.id, '800304','附件管理', '/bc/attach/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '800307','消息管理', '/bc/message/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS)
	select 0, 0, 2, m.id, '800305','定时任务', '/bc/schedule/job/list', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '800306','日志管理', '/bc/syslog/paging', 'i0309' from BC_IDENTITY_RESOURCE m where m.order_='800000';

-- 平台模块
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	values(0, 0,  1, null, '020000','平台模块', null, 'i0403');
insert into BC_IDENTITY_RESOURCE (STATUS_,INNER_,TYPE_,BELONG,ORDER_,NAME,URL,ICONCLASS) 
	select 0, 0, 2, m.id, '020100','公告信息', '/bc/bulletins/paging', 'i0406' from BC_IDENTITY_RESOURCE m where m.order_='020000';

-- 全局更新Resource的pname值
select update_resource_pname(0);

-- 插入通用角色数据
insert into BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(0, 0,  0,'0000', 'BC_COMMON','通用角色');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='BC_COMMON' 
	and m.type_ > 1 and (m.order_ like '01%' or m.order_ like '02%' or m.order_ like '03%' or m.order_ like '04%' or m.order_ like '07%')
	order by m.order_;

-- 插入超级管理员角色数据（可访问所有资源）
insert into BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(0, 0,  0,'0001', 'BC_ADMIN','超级管理员');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where m.type_ > 1 and r.code='BC_ADMIN' order by r.ORDER_,m.ORDER_;

-- 插入组织架构管理角色数据
insert into BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(0, 0,  0,'0002', 'BC_ORGANIZE','组织架构管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='BC_ORGANIZE' 
	and m.type_ > 1 and (m.order_ like '8001%' or m.order_ like '8002%')
	order by m.order_;

-- 插入选项管理员角色数据
insert into BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(0, 0,  0,'0003', 'BC_OPTION','选项管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='BC_OPTION' 
	and m.type_ > 1 and m.order_ in ('800301','800302')
	order by m.order_;

-- 插入公告管理员角色数据
insert into  BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(0, 0,  0,'0004', 'BC_BULLETIN','公告管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='BC_BULLETIN' 
	and m.type_ > 1 and m.order_ = '020100'
	order by m.order_;

-- 插入用户反馈管理角色数据
insert into  BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(0, 0,  0,'0005', 'BC_FEEDBACK','反馈管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='BC_FEEDBACK' 
	and m.type_ > 1 and m.order_ in ('011000','800303')
	order by m.order_;

-- 插入附件管理角色数据
insert into  BC_IDENTITY_ROLE (STATUS_,INNER_,TYPE_,ORDER_,CODE,NAME) 
	values(0, 0,  0,'0006', 'BC_ATTACH','附件管理');
insert into BC_IDENTITY_ROLE_RESOURCE (RID,SID) 
	select r.id,m.id from BC_IDENTITY_ROLE r,BC_IDENTITY_RESOURCE m where r.code='BC_ATTACH' 
	and m.type_ > 1 and m.order_ in ('800304')
	order by m.order_;


-- 插入职务数据
insert into BC_IDENTITY_DUTY (CODE, NAME) values('0100','职员');
insert into BC_IDENTITY_DUTY (CODE, NAME) values('0101','董事长');
insert into BC_IDENTITY_DUTY (CODE, NAME) values('0201','总经理');
insert into BC_IDENTITY_DUTY (CODE, NAME) values('0202','副总经理');
insert into BC_IDENTITY_DUTY (CODE, NAME) values('0203','主管');
insert into BC_IDENTITY_DUTY (CODE, NAME) values('0204','主任');
insert into BC_IDENTITY_DUTY (CODE, NAME) values('0205','副主任');

-- 插入职务编码自动增长数据
-- insert into BC_IDENTITY_IDGENERATOR (TYPE_,VALUE, FORMAT) values('duty.code', 0, '${T}.${V}');
-- 插入用户uid自动增长数据
-- insert into BC_IDENTITY_IDGENERATOR (TYPE_,VALUE, FORMAT) values('user.uid', 0, '${T}.${V}');
-- 插入公告uid自动增长数据
-- insert into BC_IDENTITY_IDGENERATOR (TYPE_,VALUE, FORMAT) values('bulletin.uid', 0, '${T}.${V}');

-- 插入单位数据
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 1, 'D00','总公司', '00000000','zonggongsi',NULL,NULL);
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 1, 'D01','分公司1', '01000000','fengongsi1','[1]D00','总公司');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='D01';
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 1, 'D02','分公司2', '02000000','fengongsi2','[1]D00','总公司');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='D02';

-- 插入部门数据
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 2, 'B01','办公室', '00010000','bangongshi','[1]D00','总公司');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='B01';
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 2, 'B02','财务部', '00020000','caiwubu','[1]D00','总公司');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='B02';
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 2, 'B03','信息中心', '00030000','xinxizhongxin','[1]D00','总公司');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='B03';

insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 2, 'B0301','子部门1', '00030100','zibumen1','[1]D00','总公司');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='B0301';
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 2, 'B0302','子部门2', '00030200','zibumen2','[1]D00','总公司');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
     select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='B0302';
    
-- 插入人员数据
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 4, 'dongshizhang','董事长', '00000001','董事长','[1]D00','总公司');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='dongshizhang'; 
insert into BC_IDENTITY_ACTOR_HISTORY (CREATE_DATE,ACTOR_TYPE,ACTOR_ID,ACTOR_NAME,UPPER_ID,UPPER_NAME,UNIT_ID,UNIT_NAME,PCODE,PNAME) 
    select now(),a.type_,a.id,a.name,b.id,b.name,c.id,c.name,a.pcode,a.pname 
    from BC_IDENTITY_ACTOR a, BC_IDENTITY_ACTOR b, BC_IDENTITY_ACTOR c where a.code='dongshizhang' and b.code='D00' and c.code='D00'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 4, 'zongjingli','总经理', '00000002','zongjingli','[1]D00','总公司');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID)  
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='zongjingli'; 
insert into BC_IDENTITY_ACTOR_HISTORY (CREATE_DATE,ACTOR_TYPE,ACTOR_ID,ACTOR_NAME,UPPER_ID,UPPER_NAME,UNIT_ID,UNIT_NAME,PCODE,PNAME) 
    select now(),a.type_,a.id,a.name,b.id,b.name,c.id,c.name,a.pcode,a.pname 
    from BC_IDENTITY_ACTOR a, BC_IDENTITY_ACTOR b, BC_IDENTITY_ACTOR c where a.code='zongjingli' and b.code='D00' and c.code='D00'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 4, 'fuzongjingli','副总经理', '00000003','fuzongjingli','[1]D00','总公司');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID)  
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='D00' and af.code='fuzongjingli'; 
insert into BC_IDENTITY_ACTOR_HISTORY (CREATE_DATE,ACTOR_TYPE,ACTOR_ID,ACTOR_NAME,UPPER_ID,UPPER_NAME,UNIT_ID,UNIT_NAME,PCODE,PNAME) 
    select now(),a.type_,a.id,a.name,b.id,b.name,c.id,c.name,a.pcode,a.pname 
    from BC_IDENTITY_ACTOR a, BC_IDENTITY_ACTOR b, BC_IDENTITY_ACTOR c where a.code='fuzongjingli' and b.code='D00' and c.code='D00'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 4, 'xiaoming','小明', '00010001','xiaoming','[1]D00/[2]B01','总公司/办公室');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B01' and af.code='xiaoming'; 
insert into BC_IDENTITY_ACTOR_HISTORY (CREATE_DATE,ACTOR_TYPE,ACTOR_ID,ACTOR_NAME,UPPER_ID,UPPER_NAME,UNIT_ID,UNIT_NAME,PCODE,PNAME) 
    select now(),a.type_,a.id,a.name,b.id,b.name,c.id,c.name,a.pcode,a.pname 
    from BC_IDENTITY_ACTOR a, BC_IDENTITY_ACTOR b, BC_IDENTITY_ACTOR c where a.code='xiaoming' and b.code='B01' and c.code='D00'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 4, 'xiaohong','小红', '00010002','xiaohong','[1]D00/[2]B01','总公司/办公室');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B01' and af.code='xiaohong'; 
insert into BC_IDENTITY_ACTOR_HISTORY (CREATE_DATE,ACTOR_TYPE,ACTOR_ID,ACTOR_NAME,UPPER_ID,UPPER_NAME,UNIT_ID,UNIT_NAME,PCODE,PNAME) 
    select now(),a.type_,a.id,a.name,b.id,b.name,c.id,c.name,a.pcode,a.pname 
    from BC_IDENTITY_ACTOR a, BC_IDENTITY_ACTOR b, BC_IDENTITY_ACTOR c where a.code='xiaohong' and b.code='B01' and c.code='D00'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 4, 'xiaojun','小军', '00020001','xiaojun','[1]D00/[2]B02','总公司/财务部');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B02' and af.code='xiaojun'; 
insert into BC_IDENTITY_ACTOR_HISTORY (CREATE_DATE,ACTOR_TYPE,ACTOR_ID,ACTOR_NAME,UPPER_ID,UPPER_NAME,UNIT_ID,UNIT_NAME,PCODE,PNAME) 
    select now(),a.type_,a.id,a.name,b.id,b.name,c.id,c.name,a.pcode,a.pname 
    from BC_IDENTITY_ACTOR a, BC_IDENTITY_ACTOR b, BC_IDENTITY_ACTOR c where a.code='xiaojun' and b.code='B02' and c.code='D00'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 4, 'admin','超级管理员', '00030001','chaojiguanliyuan','[1]D00/[2]B03','总公司/信息中心');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='admin'; 
insert into BC_IDENTITY_ACTOR_HISTORY (CREATE_DATE,ACTOR_TYPE,ACTOR_ID,ACTOR_NAME,UPPER_ID,UPPER_NAME,UNIT_ID,UNIT_NAME,PCODE,PNAME) 
    select now(),a.type_,a.id,a.name,b.id,b.name,c.id,c.name,a.pcode,a.pname 
    from BC_IDENTITY_ACTOR a, BC_IDENTITY_ACTOR b, BC_IDENTITY_ACTOR c where a.code='admin' and b.code='B03' and c.code='D00'; 
    
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_, PY,PCODE,PNAME) values('uid', 0, 0, 4, 'dragon','黄荣基', '00030002', 'huangrongji','[1]D00/[2]B03','总公司/信息中心');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='dragon';
insert into BC_IDENTITY_ACTOR_HISTORY (CREATE_DATE,ACTOR_TYPE,ACTOR_ID,ACTOR_NAME,UPPER_ID,UPPER_NAME,UNIT_ID,UNIT_NAME,PCODE,PNAME) 
    select now(),a.type_,a.id,a.name,b.id,b.name,c.id,c.name,a.pcode,a.pname 
    from BC_IDENTITY_ACTOR a, BC_IDENTITY_ACTOR b, BC_IDENTITY_ACTOR c where a.code='dragon' and b.code='B03' and c.code='D00'; 
    
-- 插入人员的Detail信息
insert into BC_IDENTITY_ACTOR_DETAIL (ID,CREATE_DATE,WORK_DATE,SEX,CARD,DUTY_ID,COMMENT_) 
    select a.id,now(),null,0,null,null,null from BC_IDENTITY_ACTOR a where a.type_=4; 
update BC_IDENTITY_ACTOR a set a.detail_id = (select ad.id from BC_IDENTITY_ACTOR_DETAIL ad where ad.id = a.id)
    where a.type_=4 and exists (select 1 from BC_IDENTITY_ACTOR_DETAIL ad where ad.id = a.id);
    
-- 插入人员的认证数据(密码默认为888888的md5值)
insert into BC_IDENTITY_AUTH (ID,PASSWORD) 
    select a.id,'21218cca77804d2ba1922c33e0151105' from BC_IDENTITY_ACTOR a where a.type_=4; 

-- 插入岗位数据
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_,PCODE,PNAME) values('uid', 0, 0, 3, 'G_ADMIN','超级管理岗', '0000','[1]D00/[2]B03','总公司/信息中心');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G_ADMIN'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_,PCODE,PNAME) values('uid', 0, 0, 3, 'G9901','测试岗位1', '9901','[1]D00/[2]B03','总公司/信息中心');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9901'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_,PCODE,PNAME) values('uid', 0, 0, 3, 'G9902','测试岗位2', '9902','[1]D00/[2]B03','总公司/信息中心');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9902'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_,PCODE,PNAME) values('uid', 0, 0, 3, 'G9903','测试岗位3', '9903','[1]D00/[2]B03','总公司/信息中心');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9903'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_,PCODE,PNAME) values('uid', 0, 0, 3, 'G9904','测试岗位4', '9904','[1]D00/[2]B03','总公司/信息中心');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9904'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_,PCODE,PNAME) values('uid', 0, 0, 3, 'G9905','测试岗位5', '9905','[1]D00/[2]B03','总公司/信息中心');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9905'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_,PCODE,PNAME) values('uid', 0, 0, 3, 'G9906','测试岗位6', '9906','[1]D00/[2]B03','总公司/信息中心');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9906'; 
insert into BC_IDENTITY_ACTOR (UID_,STATUS_,INNER_,TYPE_,CODE, NAME, ORDER_,PCODE,PNAME) values('uid', 0, 0, 3, 'G9907','测试岗位7', '9907','[1]D00/[2]B03','总公司/信息中心');
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where am.code='B03' and af.code='G9907'; 

-- 全局更新Actor的pcode、pname值
select update_actor_pcodepname(0);

-- 让超级管理员拥有超级管理岗
insert into BC_IDENTITY_ACTOR_RELATION (TYPE_,MASTER_ID,FOLLOWER_ID) 
    select 0,am.id,af.id from BC_IDENTITY_ACTOR am,BC_IDENTITY_ACTOR af where af.code in ('admin') and am.code in ('G_ADMIN','G9901','G9902','G9903','G9904','G9905','G9906','G9907'); 

-- 更新Actor的uid为'ACTOR-'+id
UPDATE BC_IDENTITY_ACTOR SET UID_=CONCAT('ACTOR-',id);

-- 让顶层单位拥有通用角色
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code='D00' and r.code='BC_COMMON';

-- 让超级管理员拥有超级管理员角色
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code = 'admin' and r.code='BC_ADMIN';

-- 让dragon拥有组织架构管理角色
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code = 'dragon' and r.code='BC_ORGANIZE';

-- 让超级管理岗拥有所有角色
insert into BC_IDENTITY_ROLE_ACTOR (AID,RID) 
	select a.id, r.id from BC_IDENTITY_ACTOR a,BC_IDENTITY_ROLE r where a.code='G_ADMIN';

-- 系统桌面相关模块的初始化数据

-- 插入桌面快捷方式数据
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,SID,AID) 
	select 0, 0, '1001', 0, name, url, iconclass, id, 0 from BC_IDENTITY_RESOURCE where name='个性化设置';
insert into BC_DESKTOP_SHORTCUT (STATUS_,INNER_,ORDER_,STANDALONE,NAME,URL,ICONCLASS,SID,AID) 
	select 0, 0, '1002', 0, name, url, iconclass, id, 0 from BC_IDENTITY_RESOURCE where name='系统反馈';


-- 插入全局配置信息
insert into BC_DESKTOP_PERSONAL (STATUS_,INNER_,FONT,THEME) 
	values(0, 0, '12', 'smoothness');

-- 插入浏览器附件下载信息
insert into BC_DOCS_ATTACH (FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH,AUTHOR_ID)
	select now(), 1, 'browser', 'chrome14.0.835.186', 24610040,'exe',0
	,'谷歌浏览器Chrome14.0.exe','browser/chrome/chrome14.0.835.186.exe',
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin');
insert into BC_DOCS_ATTACH (FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH,AUTHOR_ID)
	select now(), 1, 'browser', 'firefox7.0', 13891928,'exe',0
	,'火狐浏览器Firefox7.0.exe','browser/firefox/firefox7.0.exe',
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin');
insert into BC_DOCS_ATTACH (FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH,AUTHOR_ID)
	select now(), 1, 'browser', 'safari5.1', 37806960,'exe',0
	,'苹果浏览器Safari5.1.exe','browser/safari/safari5.1.exe',
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin');
insert into BC_DOCS_ATTACH (FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH,AUTHOR_ID)
	select now(), 0, 'browser', 'opera11.50', 10309696,'exe',0
	,'挪威浏览器Opera11.50.exe','browser/opera/opera11.50.exe',
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin');
insert into BC_DOCS_ATTACH (FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH,AUTHOR_ID)
	select now(), 0, 'browser', 'ie9.0', 18658608,'exe',0
	,'微软浏览器IE9.0.exe','browser/ie/IE9.0-Windows7-x86-chs.exe',
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin');
insert into BC_DOCS_ATTACH (FILE_DATE,STATUS_,PTYPE,PUID,SIZE_,EXT,APPPATH,SUBJECT,PATH,AUTHOR_ID)
	select now(), 0, 'browser', 'ie8.0', 16901472,'exe',0
	,'微软浏览器IE8.0.exe','browser/ie/IE8.0-WindowsXP-x86-chs.exe',
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin');
  
-- 插入任务调度测试信息
insert into BC_SD_JOB (ID,STATUS_,NAME,GROUPN,BEAN,METHOD,CRON,ORDER_,IGNORE_ERROR,MEMO_) 
	values(1,1,'无异常任务测试','bc', 'schedulerTestMock', 'success','0/10 * * * * ? *','9901', 0, '测试信息');
insert into BC_SD_JOB (ID,STATUS_,NAME,GROUPN,BEAN,METHOD,CRON,ORDER_,IGNORE_ERROR,MEMO_) 
	values(2,1,'有异常任务测试','bc', 'schedulerTestMock', 'error','5/10 * * * * ? *','9902', 0, '测试信息');
    
-- 插入测试消息
insert into BC_MESSAGE (SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select now(), '测试标题1', '测试内容1', 
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin'),
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin');
insert into BC_MESSAGE (SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select now(), '测试标题2', '测试内容2', 
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin'),
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin');
insert into BC_MESSAGE (SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select now(), '测试标题3', '测试内容3', 
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin'),
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin');
insert into BC_MESSAGE (SEND_DATE,SUBJECT,CONTENT,SENDER_ID,RECEIVER_ID) 
	select now(), '测试标题4', null, 
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin'),
	(select b.id from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.code='admin');

-- 插入1000条登录数据
-- 创建存储过程：loop_time为循环的次数
CREATE OR REPLACE FUNCTION test_create_syslog(loop_time integer,userCode varchar(255)) RETURNS VOID AS $$
DECLARE
	i integer :=0; 
BEGIN 
	LOOP
		if i >=  loop_time then 
			RETURN;
		END IF;
		insert into BC_LOG_SYSTEM (TYPE_,FILE_DATE,SUBJECT,AUTHOR_ID,C_IP,S_IP,C_INFO) 
			select 0,now(),concat(a.name,'登录系统',i),b.id,'127.0.0.1','localhost','Chrome12'
			from BC_IDENTITY_ACTOR a inner join BC_IDENTITY_ACTOR_HISTORY b on b.actor_id=a.id where a.CODE=userCode;
		i := i + 1; 
	END LOOP; 
END;
$$ LANGUAGE plpgsql;
-- 调用存储过程
select test_create_syslog(500,'admin'); 
select test_create_syslog(500,'designer'); 
