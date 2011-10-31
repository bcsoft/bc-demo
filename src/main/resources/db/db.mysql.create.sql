-- ##BC平台的MYSQL建表脚本##

-- 测试用的表
CREATE TABLE BC_EXAMPLE (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    NAME VARCHAR(255) NOT NULL COMMENT '名称',
    CODE VARCHAR(255),
    PRIMARY KEY (ID)
) COMMENT='测试用的表';

-- 系统标识相关模块
-- 系统资源
CREATE TABLE BC_IDENTITY_RESOURCE (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    UID_ VARCHAR(36) COMMENT '全局标识',
    TYPE_ INT(1) NOT NULL COMMENT '类型：1-文件夹,2-内部链接,3-外部链接,4-HTML',
    STATUS_ INT(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    INNER_ INT(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    BELONG BIGINT COMMENT '所隶属的资源',
    ORDER_ VARCHAR(100) COMMENT '排序号',
    NAME VARCHAR(255) NOT NULL COMMENT '名称',
    URL VARCHAR(255) COMMENT '地址',
    ICONCLASS VARCHAR(255) COMMENT '图标样式',
    OPTION_ TEXT COMMENT '扩展参数',
    PNAME TEXT COMMENT '所隶属模块的全名:如系统维护/组织架构/单位配置',
    PRIMARY KEY (ID)
) COMMENT='系统资源';
ALTER TABLE BC_IDENTITY_RESOURCE ADD INDEX BCIDX_RESOURCE_BELONG (BELONG);

-- 角色
CREATE TABLE BC_IDENTITY_ROLE (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    CODE VARCHAR(100) NOT NULL COMMENT '编码',
    ORDER_ VARCHAR(100) COMMENT '排序号',
    NAME VARCHAR(255) NOT NULL COMMENT '名称',
    
    UID_ VARCHAR(36) COMMENT '全局标识',
   	TYPE_ INT(1) NOT NULL COMMENT '类型',
    STATUS_ INT(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    INNER_ INT(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    PRIMARY KEY (ID)
) COMMENT='角色';

-- 角色与资源的关联
CREATE TABLE BC_IDENTITY_ROLE_RESOURCE (
    RID BIGINT NOT NULL COMMENT '角色ID',
    SID BIGINT NOT NULL COMMENT '资源ID',
    PRIMARY KEY (RID,SID)
) COMMENT='角色与资源的关联：角色可以访问哪些资源';
ALTER TABLE BC_IDENTITY_ROLE_RESOURCE ADD CONSTRAINT BCFK_RS_ROLE FOREIGN KEY (RID) 
	REFERENCES BC_IDENTITY_ROLE (ID);
ALTER TABLE BC_IDENTITY_ROLE_RESOURCE ADD CONSTRAINT BCFK_RS_RESOURCE FOREIGN KEY (SID) 
	REFERENCES BC_IDENTITY_RESOURCE (ID);

-- 职务
CREATE TABLE BC_IDENTITY_DUTY (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    CODE VARCHAR(100) NOT NULL COMMENT '编码',
    NAME VARCHAR(255) NOT NULL COMMENT '名称',
    PRIMARY KEY (ID)
) COMMENT='职务';

-- 参与者的扩展属性
CREATE TABLE BC_IDENTITY_ACTOR_DETAIL (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    CREATE_DATE DATETIME COMMENT '创建时间',
    WORK_DATE DATE COMMENT 'USER-入职时间',
    SEX INT(1) DEFAULT 0 COMMENT 'USER-性别：0-未设置,1-男,2-女',
    ISO INT(1) DEFAULT 0 COMMENT 'USER-iso',
   	CARD VARCHAR(20) COMMENT 'USER-身份证',
    DUTY_ID BIGINT COMMENT 'USER-职务ID',
   	COMMENT_ VARCHAR(1000) COMMENT '备注',
    PRIMARY KEY (ID)
) COMMENT='参与者的扩展属性';
ALTER TABLE BC_IDENTITY_ACTOR_DETAIL ADD CONSTRAINT BCFK_ACTORDETAIL_DUTY FOREIGN KEY (DUTY_ID) 
	REFERENCES BC_IDENTITY_DUTY (ID);

-- 参与者
CREATE TABLE BC_IDENTITY_ACTOR (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    UID_ VARCHAR(36) NOT NULL COMMENT '全局标识',
    TYPE_ INT(1) NOT NULL COMMENT '类型：1-用户,2-单位,3-部门,4-岗位',
    STATUS_ INT(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    CODE VARCHAR(100) NOT NULL COMMENT '编码',
    NAME VARCHAR(255) NOT NULL COMMENT '名称',
    PY VARCHAR(255) COMMENT '名称的拼音',
    ORDER_ VARCHAR(100) COMMENT '同类参与者之间的排序号',
    EMAIL VARCHAR(255) COMMENT '邮箱',
    PHONE VARCHAR(255) COMMENT '联系电话',
    DETAIL_ID BIGINT COMMENT '扩展表的ID',
    INNER_ INT(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    PCODE VARCHAR(4000) COMMENT '隶属机构的全编码',
    PNAME VARCHAR(4000) COMMENT '隶属机构的全名',
    PRIMARY KEY (ID)
) COMMENT='参与者(代表一个人或组织，组织也可以是单位、部门、岗位、团队等)';
ALTER TABLE BC_IDENTITY_ACTOR ADD CONSTRAINT BCFK_ACTOR_ACTORDETAIL FOREIGN KEY (DETAIL_ID) 
	REFERENCES BC_IDENTITY_ACTOR_DETAIL (ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE BC_IDENTITY_ACTOR ADD INDEX BCIDX_ACTOR_TYPE (TYPE_);
ALTER TABLE BC_IDENTITY_ACTOR ADD INDEX BCIDX_ACTOR_CODE (CODE);
ALTER TABLE BC_IDENTITY_ACTOR ADD INDEX BCIDX_ACTOR_DETAIL (DETAIL_ID);
ALTER TABLE BC_IDENTITY_ACTOR ADD INDEX BCIDX_ACTOR_STATUSTYPE (STATUS_,TYPE_);

-- 参与者之间的关联关系
CREATE TABLE BC_IDENTITY_ACTOR_RELATION (
    TYPE_ INT(2) NOT NULL COMMENT '关联类型',
    MASTER_ID BIGINT NOT NULL COMMENT '主控方ID',
   	FOLLOWER_ID BIGINT NOT NULL COMMENT '从属方ID',
    ORDER_ VARCHAR(100) COMMENT '从属方之间的排序号',
    PRIMARY KEY (MASTER_ID,FOLLOWER_ID,TYPE_)
) COMMENT='参与者之间的关联关系';
ALTER TABLE BC_IDENTITY_ACTOR_RELATION ADD CONSTRAINT BCFK_AR_MASTER FOREIGN KEY (MASTER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_IDENTITY_ACTOR_RELATION ADD CONSTRAINT BCFK_AR_FOLLOWER FOREIGN KEY (FOLLOWER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_IDENTITY_ACTOR_RELATION ADD INDEX BCIDX_AR_TM (TYPE_, MASTER_ID),ADD INDEX BCIDX_AR_TF (TYPE_, FOLLOWER_ID);

-- ACTOR隶属信息的变动历史
CREATE TABLE BC_IDENTITY_ACTOR_HISTORY(
   ID                   BIGINT NOT NULL AUTO_INCREMENT,
   CREATE_DATE          DATETIME NOT NULL COMMENT '创建时间',
   START_DATE           DATETIME COMMENT '起始时段',
   END_DATE             DATETIME COMMENT '结束时段',
   ACTOR_TYPE           INT(1) NOT NULL COMMENT 'ACTOR类型',
   ACTOR_ID             BIGINT NOT NULL COMMENT 'ACTORID',
   ACTOR_NAME           VARCHAR(100) NOT NULL COMMENT 'ACTOR名称',
   UPPER_ID             BIGINT COMMENT '所属上级ID',
   UPPER_NAME           VARCHAR(255) COMMENT '所属上级名称',
   UNIT_ID              BIGINT COMMENT '所在单位ID',
   UNIT_NAME            VARCHAR(255) COMMENT '所在单位名称',
   PCODE VARCHAR(4000) COMMENT '隶属机构的全编码',
   PNAME VARCHAR(4000) COMMENT '隶属机构的全名',
   PRIMARY KEY (ID)
) COMMENT 'ACTOR隶属信息的变动历史';
ALTER TABLE BC_IDENTITY_ACTOR_HISTORY ADD CONSTRAINT BCFK_ACTORHISTORY_ACTOR FOREIGN KEY (ACTOR_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_IDENTITY_ACTOR_HISTORY ADD INDEX BCIDX_ACTORHISTORY_UPPER (UPPER_ID)
    ,ADD INDEX BCIDX_ACTORHISTORY_UNIT (UNIT_ID)
    ,ADD INDEX BCIDX_ACTORHISTORY_ACTOR (ACTOR_ID);

-- 认证信息
CREATE TABLE BC_IDENTITY_AUTH (
    ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '与ACTOR表的ID对应',
    PASSWORD VARCHAR(32) NOT NULL COMMENT '密码',
    PRIMARY KEY (ID)
) COMMENT='认证信息';
ALTER TABLE BC_IDENTITY_AUTH ADD CONSTRAINT BCFK_AUTH_ACTOR FOREIGN KEY (ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);

-- 标识生成器
CREATE TABLE BC_IDENTITY_IDGENERATOR (
  TYPE_ VARCHAR(45) NOT NULL COMMENT '分类',
  VALUE_ BIGINT NOT NULL COMMENT '当前值',
  FORMAT VARCHAR(45) COMMENT '格式模板,如“CASE-${V}”、“${T}-${V}”,V代表VALUE的值，T代表TYPE_的值' ,
  PRIMARY KEY (TYPE_)
) COMMENT = '标识生成器,用于生成主键或唯一编码用';

-- 参与者与角色的关联
CREATE TABLE BC_IDENTITY_ROLE_ACTOR (
    AID BIGINT NOT NULL COMMENT '参与者ID',
    RID BIGINT NOT NULL COMMENT '角色ID',
    PRIMARY KEY (AID,RID)
) COMMENT='参与者与角色的关联：参与者拥有哪些角色';
ALTER TABLE BC_IDENTITY_ROLE_ACTOR ADD CONSTRAINT BCFK_RA_ACTOR FOREIGN KEY (AID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_IDENTITY_ROLE_ACTOR ADD CONSTRAINT BCFK_RA_ROLE FOREIGN KEY (RID) 
	REFERENCES BC_IDENTITY_ROLE (ID);
	
-- ##系统桌面相关模块##
-- 桌面快捷方式
CREATE TABLE BC_DESKTOP_SHORTCUT (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    UID_ VARCHAR(36) COMMENT '全局标识',
    STATUS_ INT(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    ORDER_ VARCHAR(100) NOT NULL COMMENT '排序号',
    STANDALONE INT(1) NOT NULL COMMENT '是否在独立的浏览器窗口中打开',
    NAME VARCHAR(255) COMMENT '名称,为空则使用资源的名称',
    URL VARCHAR(255) COMMENT '地址,为空则使用资源的地址',
    ICONCLASS VARCHAR(255) COMMENT '图标样式',
    SID BIGINT NOT NULL DEFAULT 0 COMMENT '对应的资源ID',
    AID BIGINT NOT NULL DEFAULT 0 COMMENT '所属的参与者(如果为上级参与者,如单位部门,则其下的所有参与者都拥有该快捷方式)',
    INNER_ INT(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    PRIMARY KEY (ID)
) COMMENT='桌面快捷方式';
ALTER TABLE BC_DESKTOP_SHORTCUT ADD INDEX BCIDX_SHORTCUT (AID,SID) ;

-- 个人设置
CREATE TABLE BC_DESKTOP_PERSONAL (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    UID_ VARCHAR(36) COMMENT '全局标识',
    STATUS_ INT(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    FONT VARCHAR(2) NOT NULL COMMENT '字体大小，如12、14、16',
    THEME VARCHAR(255) NOT NULL COMMENT '主题名称,如BASE',
    AID BIGINT NOT NULL DEFAULT 0 COMMENT '所属的参与者',
    INNER_ INT(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    PRIMARY KEY (ID)
) COMMENT='个人设置';
ALTER TABLE BC_DESKTOP_PERSONAL ADD UNIQUE INDEX BCUK_PERSONAL_AID (AID) ;

-- 消息模块
CREATE TABLE BC_MESSAGE (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    UID_ VARCHAR(36) COMMENT '全局标识',
    STATUS_ INT(1) NOT NULL DEFAULT 0 COMMENT '状态：0-发送中,1-已发送,2-已删除,3-发送失败',
    TYPE_ INT(1) NOT NULL DEFAULT 0 COMMENT '消息类型',
    SENDER_ID BIGINT NOT NULL COMMENT '发送者',
    SEND_DATE DATETIME NOT NULL COMMENT '发送时间',
    RECEIVER_ID BIGINT NOT NULL COMMENT '接收者',
    READ_ INT(1) NOT NULL DEFAULT 0 COMMENT '已阅标记',
    FROM_ID BIGINT COMMENT '来源标识',
    FROM_TYPE BIGINT COMMENT '来源类型',
    SUBJECT VARCHAR(255) NOT NULL COMMENT '标题',
    CONTENT TEXT COMMENT '内容',
    PRIMARY KEY (ID)
) COMMENT='消息';
ALTER TABLE BC_MESSAGE ADD CONSTRAINT BCFK_MESSAGE_SENDER FOREIGN KEY (SENDER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_MESSAGE ADD CONSTRAINT BCFK_MESSAGE_REVEIVER FOREIGN KEY (RECEIVER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_MESSAGE ADD INDEX BCIDX_MESSAGE_FROMID (FROM_TYPE,FROM_ID);
ALTER TABLE BC_MESSAGE ADD INDEX BCIDX_MESSAGE_TYPE (TYPE_);

-- 工作事项
CREATE TABLE BC_WORK (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    CLASSIFIER VARCHAR(500) NOT NULL COMMENT '分类词,可多级分类,级间使用/连接,如“发文类/正式发文”',
    SUBJECT VARCHAR(255) NOT NULL COMMENT '标题',
    FROM_ID BIGINT COMMENT '来源标识',
    FROM_TYPE BIGINT COMMENT '来源类型',
    FROM_INFO VARCHAR(255) COMMENT '来源描述',
    OPEN_URL VARCHAR(255) COMMENT '打开的URL模板',
    CONTENT TEXT COMMENT '内容',
    PRIMARY KEY (ID)
) COMMENT='工作事项';
ALTER TABLE BC_WORK ADD INDEX BCIDX_WORK_FROMID (FROM_TYPE,FROM_ID);

-- 待办事项
CREATE TABLE BC_WORK_TODO (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    WORK_ID BIGINT NOT NULL COMMENT '工作事项ID',
    SENDER_ID BIGINT NOT NULL COMMENT '发送者',
    SEND_DATE DATETIME NOT NULL COMMENT '发送时间',
    WORKER_ID BIGINT NOT NULL COMMENT '发送者',
    INFO VARCHAR(255) COMMENT '附加说明',
    PRIMARY KEY (ID)
) COMMENT='待办事项';
ALTER TABLE BC_WORK_TODO ADD CONSTRAINT BCFK_TODOWORK_WORK FOREIGN KEY (WORK_ID) 
	REFERENCES BC_WORK (ID);
ALTER TABLE BC_WORK_TODO ADD CONSTRAINT BCFK_TODOWORK_SENDER FOREIGN KEY (SENDER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_WORK_TODO ADD CONSTRAINT BCFK_TODOWORK_WORKER FOREIGN KEY (WORKER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);

-- 已办事项
CREATE TABLE BC_WORK_DONE (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    FINISH_DATE DATETIME NOT NULL COMMENT '完成时间',
    FINISH_YEAR INT(4) NOT NULL COMMENT '完成时间的年度',
    FINISH_MONTH INT(2) NOT NULL COMMENT '完成时间的月份(1-12)',
    FINISH_DAY INT(2) NOT NULL COMMENT '完成时间的日(1-31)',

    WORK_ID BIGINT NOT NULL COMMENT '工作事项ID',
    SENDER_ID BIGINT NOT NULL COMMENT '发送者',
    SEND_DATE DATETIME NOT NULL COMMENT '发送时间',
    WORKER_ID BIGINT NOT NULL COMMENT '发送者',
    INFO VARCHAR(255) COMMENT '附加说明',
    PRIMARY KEY (ID)
) COMMENT='已办事项';
ALTER TABLE BC_WORK_DONE ADD CONSTRAINT BCFK_DONEWORK_WORK FOREIGN KEY (WORK_ID) 
	REFERENCES BC_WORK (ID);
ALTER TABLE BC_WORK_DONE ADD CONSTRAINT BCFK_DONEWORK_SENDER FOREIGN KEY (SENDER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_WORK_DONE ADD CONSTRAINT BCFK_DONEWORK_WORKER FOREIGN KEY (WORKER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_WORK_DONE ADD INDEX BCIDX_DONEWORK_FINISHDATE (FINISH_YEAR,FINISH_MONTH,FINISH_DAY);

-- 系统日志
CREATE TABLE BC_LOG_SYSTEM (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    TYPE_ INT(1) NOT NULL COMMENT '类别：0-登录,1-主动注销,2-超时注销',
    
    FILE_DATE DATETIME NOT NULL COMMENT '创建时间',
    SUBJECT VARCHAR(500) NOT NULL COMMENT '标题',
    AUTHOR_ID BIGINT NOT NULL COMMENT '创建人ID',
    C_IP VARCHAR(100) COMMENT '用户机器IP',
    C_NAME VARCHAR(100) COMMENT '用户机器名称',
    C_INFO VARCHAR(1000) COMMENT '用户浏览器信息：USER-AGENT',
    S_IP VARCHAR(100) COMMENT '服务器IP',
    S_NAME VARCHAR(100) COMMENT '服务器名称',
    S_INFO VARCHAR(1000) COMMENT '服务器信息',

    CONTENT TEXT COMMENT '详细内容',
    PRIMARY KEY (ID)
) COMMENT='系统日志';
ALTER TABLE BC_LOG_SYSTEM ADD CONSTRAINT BCFK_SYSLOG_USER FOREIGN KEY (AUTHOR_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_LOG_SYSTEM ADD INDEX BCIDX_SYSLOG_CLIENT (C_IP);
ALTER TABLE BC_LOG_SYSTEM ADD INDEX BCIDX_SYSLOG_SERVER (S_IP);

-- 公告模块
CREATE TABLE BC_BULLETIN (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    UID_ VARCHAR(36) NOT NULL COMMENT '关联附件的标识号',
    UNIT_ID BIGINT COMMENT '公告所属单位ID',
    SCOPE INT(1) NOT NULL COMMENT '公告发布范围：0-本单位,1-全系统',
    STATUS_ INT(1) NOT NULL COMMENT '状态:0-草稿,1-已发布,2-已过期',
   
    OVERDUE_DATE DATETIME COMMENT '过期日期：为空代表永不过期',
   	ISSUE_DATE DATETIME COMMENT '发布时间',
    ISSUER_ID BIGINT COMMENT '发布人ID',
    ISSUER_NAME VARCHAR(100) COMMENT '发布人姓名',
    
    SUBJECT VARCHAR(500) NOT NULL COMMENT '标题',
    
    FILE_DATE DATETIME NOT NULL COMMENT '创建时间',
    AUTHOR_ID BIGINT NOT NULL COMMENT '创建人ID',
    MODIFIER_ID BIGINT COMMENT '最后修改人ID',
    MODIFIED_DATE DATETIME COMMENT '最后修改时间',

    CONTENT TEXT NOT NULL COMMENT '详细内容',
    PRIMARY KEY (ID)
) COMMENT='公告模块';
ALTER TABLE BC_BULLETIN ADD CONSTRAINT BCFK_BULLETIN_AUTHOR FOREIGN KEY (AUTHOR_ID)
      REFERENCES BC_IDENTITY_ACTOR_HISTORY (ID);
ALTER TABLE BC_BULLETIN ADD CONSTRAINT BCFK_BULLETIN_ISSUER FOREIGN KEY (ISSUER_ID)
      REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_BULLETIN ADD CONSTRAINT BCFK_BULLETIN_MODIFIER FOREIGN KEY (MODIFIER_ID)
      REFERENCES BC_IDENTITY_ACTOR_HISTORY (ID);
ALTER TABLE BC_BULLETIN ADD CONSTRAINT BCFK_BULLETIN_UNIT FOREIGN KEY (UNIT_ID)
      REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_BULLETIN ADD INDEX BCIDX_BULLETIN_SEARCH (SCOPE,UNIT_ID,STATUS_);

-- 文档附件
CREATE TABLE BC_DOCS_ATTACH (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    STATUS_ INT(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    PTYPE VARCHAR(36) NOT NULL COMMENT '所关联文档的类型',
    PUID VARCHAR(36) NOT NULL COMMENT '所关联文档的UID',
   
    SIZE_ BIGINT NOT NULL COMMENT '文件的大小(单位为字节)',
    COUNT_ BIGINT NOT NULL DEFAULT 0 COMMENT '文件的下载次数',
    EXT VARCHAR(10) COMMENT '文件扩展名：如PNG、DOC、MP3等',
    APPPATH INT(1) NOT NULL COMMENT '指定PATH的值是相对于应用部署目录下路径还是相对于全局配置的APP.DATA目录下的路径',
    SUBJECT VARCHAR(500) NOT NULL COMMENT '文件名称(不带路径的部分)',
    PATH VARCHAR(500) NOT NULL COMMENT '物理文件保存的相对路径(相对于全局配置的附件根目录下的子路径，如"2011/BULLETIN/XXXX.DOC")',
    
    FILE_DATE DATETIME NOT NULL COMMENT '创建时间',
    AUTHOR_ID BIGINT NOT NULL COMMENT '创建人ID',
    MODIFIER_ID BIGINT COMMENT '最后修改人ID',
    MODIFIED_DATE DATETIME COMMENT '最后修改时间',
    PRIMARY KEY (ID)
) COMMENT='文档附件,记录文档与其相关附件之间的关系';
ALTER TABLE BC_DOCS_ATTACH ADD CONSTRAINT BCFK_ATTACH_AUTHOR FOREIGN KEY (AUTHOR_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_DOCS_ATTACH ADD INDEX BCIDX_ATTACH_PUID (PUID);
ALTER TABLE BC_DOCS_ATTACH ADD INDEX BCIDX_ATTACH_PTYPE (PTYPE);

-- 附件处理痕迹
CREATE TABLE BC_DOCS_ATTACH_HISTORY (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    AID BIGINT NOT NULL COMMENT '附件ID',
    TYPE_ BIGINT NOT NULL COMMENT '处理类型：0-下载,1-在线查看,2-格式转换',
    SUBJECT VARCHAR(500) NOT NULL COMMENT '简单说明',
    FORMAT VARCHAR(10) COMMENT '下载的文件格式或转换后的文件格式：如PDF、DOC、MP3等',
    
    FILE_DATE DATETIME NOT NULL COMMENT '处理时间',
    AUTHOR_ID BIGINT NOT NULL COMMENT '处理人ID',
    MODIFIER_ID BIGINT COMMENT '最后修改人ID',
    MODIFIED_DATE DATETIME COMMENT '最后修改时间',

    C_IP VARCHAR(100) COMMENT '客户端IP',
    C_INFO VARCHAR(1000) COMMENT '浏览器信息：USER-AGENT',
    
    MEMO VARCHAR(2000) COMMENT '备注',
    PRIMARY KEY (ID)
) COMMENT='附件处理痕迹';
ALTER TABLE BC_DOCS_ATTACH_HISTORY ADD CONSTRAINT BCFK_ATTACHHISTORY_AUTHOR FOREIGN KEY (AUTHOR_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_DOCS_ATTACH_HISTORY ADD CONSTRAINT BCFK_ATTACHHISTORY_MODIFIER FOREIGN KEY (MODIFIER_ID) 
	REFERENCES BC_IDENTITY_ACTOR_HISTORY (ID);
ALTER TABLE BC_DOCS_ATTACH_HISTORY ADD CONSTRAINT BCFK_ATTACHHISTORY_ATTACH FOREIGN KEY (AID) 
	REFERENCES BC_DOCS_ATTACH (ID);

-- 用户反馈
CREATE TABLE BC_FEEDBACK (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    UID_ VARCHAR(36) NOT NULL COMMENT '关联附件的标识号',
    STATUS_ INT(1) NOT NULL COMMENT '状态:0-草稿,1-已提交,2-已受理',
    SUBJECT VARCHAR(500) NOT NULL COMMENT '标题',
    FILE_DATE DATETIME NOT NULL COMMENT '创建时间',
    AUTHOR_ID BIGINT NOT NULL COMMENT '创建人ID',
    MODIFIER_ID BIGINT COMMENT '最后修改人ID',
    MODIFIED_DATE DATETIME COMMENT '最后修改时间',

    CONTENT TEXT NOT NULL COMMENT '详细内容',
    PRIMARY KEY (ID)
) COMMENT='用户反馈';
ALTER TABLE BC_FEEDBACK ADD CONSTRAINT BCFK_FEEDBACK_AUTHOR FOREIGN KEY (AUTHOR_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_FEEDBACK ADD CONSTRAINT BCFK_FEEDBACK_MODIFIER FOREIGN KEY (MODIFIER_ID) 
	REFERENCES BC_IDENTITY_ACTOR_HISTORY (ID);


-- 选项模块
-- 选项分组
CREATE TABLE BC_OPTION_GROUP (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    KEY_ VARCHAR(255) NOT NULL COMMENT '键',
    VALUE_ VARCHAR(255) NOT NULL COMMENT '值',
    ORDER_ VARCHAR(100) COMMENT '排序号',
    ICON VARCHAR(100) COMMENT '图标样式',
    PRIMARY KEY (ID)
) COMMENT='选项分组';
ALTER TABLE BC_OPTION_GROUP ADD INDEX BCIDX_OPTIONGROUP_KEY (KEY_);
ALTER TABLE BC_OPTION_GROUP ADD INDEX BCIDX_OPTIONGROUP_VALUE (VALUE_);

-- 选项条目
CREATE TABLE BC_OPTION_ITEM (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    PID BIGINT NOT NULL COMMENT '所属分组的ID',
    KEY_ VARCHAR(255) NOT NULL COMMENT '键',
    VALUE_ VARCHAR(255) NOT NULL COMMENT '值',
    ORDER_ VARCHAR(100) COMMENT '排序号',
    ICON VARCHAR(100) COMMENT '图标样式',
    STATUS_ INT(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    PRIMARY KEY (ID)
) COMMENT='选项条目';
ALTER TABLE BC_OPTION_ITEM ADD CONSTRAINT BCFK_OPTIONITEM_OPTIONGROUP FOREIGN KEY (PID) 
	REFERENCES BC_OPTION_GROUP (ID);
ALTER TABLE BC_OPTION_ITEM ADD INDEX BCIDX_OPTIONITEM_KEY (KEY_);
ALTER TABLE BC_OPTION_ITEM ADD INDEX BCIDX_OPTIONITEM_VALUE (VALUE_);
ALTER TABLE BC_OPTION_ITEM ADD INDEX BCIDX_OPTIONITEM_PID (PID);

-- 调度任务配置
CREATE TABLE BC_SD_JOB (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    STATUS_ INT(1)  NOT NULL COMMENT '状态：0-启用中,1-已禁用,2-已删除,3-正在运行,4-暂停',
    NAME VARCHAR(255) NOT NULL COMMENT '名称',
    GROUPN VARCHAR(255) NOT NULL COMMENT '分组名',
    CRON VARCHAR(255) NOT NULL COMMENT '表达式',
    BEAN VARCHAR(255) NOT NULL COMMENT '要调用的SpringBean名',
    METHOD VARCHAR(255) NOT NULL COMMENT '要调用的SpringBean方法名',
    IGNORE_ERROR INT(1) NOT NULL COMMENT '发现异常是否忽略后继续调度:0-否,1-是',
    ORDER_ VARCHAR(100) COMMENT '排序号',
    NEXT_DATE datetime COMMENT '任务的下一运行时间',
    MEMO_ VARCHAR(1000) COMMENT '备注',
    PRIMARY KEY (ID)
) COMMENT='调度任务配置';

-- 任务调度日志
CREATE TABLE BC_SD_LOG (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    SUCCESS INT(1) NOT NULL COMMENT '任务是否处理成功:0-失败,1-成功',
    START_DATE datetime NOT NULL COMMENT '任务的启动时间',
    END_DATE datetime NOT NULL COMMENT '任务的结束时间',
    CFG_CRON VARCHAR(255) NOT NULL COMMENT '对应ScheduleJob的cron',
    CFG_NAME VARCHAR(255) COMMENT '对应ScheduleJob的name',
    CFG_GROUP VARCHAR(255) COMMENT '对应ScheduleJob的groupn',
    CFG_BEAN VARCHAR(255) COMMENT '对应ScheduleJob的bean',
    CFG_METHOD VARCHAR(255) COMMENT '对应ScheduleJob的method',
    ERROR_TYPE VARCHAR(255) COMMENT '异常分类',
    MSG TEXT COMMENT '异常信息',
    PRIMARY KEY (ID)
) COMMENT='任务调度日志';
-- ##bc平台的 mysql 自定义函数和存储过程##

DELIMITER $$ 
DROP PROCEDURE IF EXISTS update_actor_pcodepname $$ 
-- 创建更新actor的pcode和pname的存储过程：会递归处理下级单位和部门
-- pid: actor所隶属上级的id，为0代表顶层单位
CREATE PROCEDURE update_actor_pcodepname(pid bigint)
BEGIN
	-- 定义变量
	DECLARE done INT DEFAULT 0;
	DECLARE pfcode varchar(4000);
	DECLARE pfname varchar(4000);
	DECLARE cid bigint;
	DECLARE ct bigint;
	DECLARE pid1 bigint;

	-- 定义游标
	DECLARE curChilden CURSOR FOR select a.id,a.type_ from bc_identity_actor a inner join bc_identity_actor_relation r on r.follower_id = a.id 
		where r.type_=0 and r.master_id=pid order by a.order_;
	DECLARE curTops CURSOR FOR select a.id from bc_identity_actor a where a.type_=1 and not exists 
		(select r.follower_id from bc_identity_actor_relation r where r.type_=0 and a.id=r.follower_id)
		order by a.order_;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

	-- 启用存储过程的递归调用
	SET @@max_sp_recursion_depth = 10; 

	if pid > 0 then
		select concat((case when pcode is null then '' else concat(pcode,'/') end),'[',type_,']',code)
			,concat((case when pname is null then '' else concat(pname,'/') end),name)
			into pfcode,pfname from bc_identity_actor where id=pid;
		open curChilden;
		REPEAT
			fetch curChilden into cid,ct;
			IF NOT done THEN
				update bc_identity_actor a set a.pcode=pfcode,a.pname=pfname where a.id=cid;
				if ct < 3 then 
					-- 单位或部门执行递归处理
					call update_actor_pcodepname(cid);
				end if;
			END IF;
		UNTIL done END REPEAT;
		close curChilden;
	else
		open curTops;
		REPEAT
			fetch curTops into pid1;
			IF NOT done THEN
				call update_actor_pcodepname(pid1);
			END IF;
		UNTIL done END REPEAT;
		close curTops;
	end if; 
END $$ 
DELIMITER ; 

DELIMITER $$ 
DROP PROCEDURE IF EXISTS update_resource_pname $$ 
-- 创建更新resource的pname的存储过程：会递归处理下级资源
-- pid: resource所隶属的id，为0代表顶层资源
CREATE PROCEDURE update_resource_pname(pid bigint)
BEGIN
	-- 定义变量
	DECLARE done INT DEFAULT 0;
	DECLARE pfname varchar(4000);
	DECLARE cid bigint;
	DECLARE ct bigint;
	DECLARE pid1 bigint;

	-- 定义游标
	DECLARE curChilden CURSOR FOR select r.id,r.type_ from bc_identity_resource r where r.belong = pid order by r.order_;
	DECLARE curTops CURSOR FOR select r.id from bc_identity_resource r where r.belong is null order by r.order_;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

	-- 启用存储过程的递归调用
	SET @@max_sp_recursion_depth = 10; 

	if pid > 0 then
		select concat((case when pname is null then '' else concat(pname,'/') end),name)
        	into pfname from bc_identity_resource where id=pid;
		open curChilden;
		REPEAT
			fetch curChilden into cid,ct;
			IF NOT done THEN
				update bc_identity_resource r set r.pname=pfname where r.id=cid;
				if ct = 1 then 
					-- 分类型资源执行递归处理
					call update_resource_pname(cid);
				end if;
			END IF;
		UNTIL done END REPEAT;
		close curChilden;
	else
		open curTops;
		REPEAT
			fetch curTops into pid1;
			IF NOT done THEN
				call update_resource_pname(pid1);
			END IF;
		UNTIL done END REPEAT;
		close curTops;
	end if; 
END $$ 
DELIMITER ; 
create table ACT_GE_PROPERTY (
    NAME_ varchar(64),
    VALUE_ varchar(300),
    REV_ integer,
    primary key (NAME_)
);

insert into ACT_GE_PROPERTY
values ('schema.version', '5.6', 1);

insert into ACT_GE_PROPERTY
values ('schema.history', 'create(5.6)', 1);

insert into ACT_GE_PROPERTY
values ('next.dbid', '1', 1);

create table ACT_GE_BYTEARRAY (
    ID_ varchar(64),
    REV_ integer,
    NAME_ varchar(255),
    DEPLOYMENT_ID_ varchar(64),
    BYTES_ LONGBLOB,
    primary key (ID_)
);

create table ACT_RE_DEPLOYMENT (
    ID_ varchar(64),
    NAME_ varchar(255),
    DEPLOY_TIME_ timestamp,
    primary key (ID_)
);

create table ACT_RU_EXECUTION (
    ID_ varchar(64),
    REV_ integer,
    PROC_INST_ID_ varchar(64),
    BUSINESS_KEY_ varchar(255),
    PARENT_ID_ varchar(64),
    PROC_DEF_ID_ varchar(64),
    SUPER_EXEC_ varchar(64),
    ACT_ID_ varchar(255),
    IS_ACTIVE_ TINYINT,
    IS_CONCURRENT_ TINYINT,
    IS_SCOPE_ TINYINT,
    primary key (ID_),
    unique ACT_UNIQ_RU_BUS_KEY (PROC_DEF_ID_, BUSINESS_KEY_)
);

create table ACT_RU_JOB (
    ID_ varchar(64) NOT NULL,
	  REV_ integer,
    TYPE_ varchar(255) NOT NULL,
    LOCK_EXP_TIME_ timestamp,
    LOCK_OWNER_ varchar(255),
    EXCLUSIVE_ boolean,
    EXECUTION_ID_ varchar(64),
    PROCESS_INSTANCE_ID_ varchar(64),
    RETRIES_ integer,
    EXCEPTION_STACK_ID_ varchar(64),
    EXCEPTION_MSG_ varchar(4000),
    DUEDATE_ timestamp NULL,
    REPEAT_ varchar(255),
    HANDLER_TYPE_ varchar(255),
    HANDLER_CFG_ varchar(4000),
    primary key (ID_)
);

create table ACT_RE_PROCDEF (
    ID_ varchar(64),
    CATEGORY_ varchar(255),
    NAME_ varchar(255),
    KEY_ varchar(255),
    VERSION_ integer,
    DEPLOYMENT_ID_ varchar(64),
    RESOURCE_NAME_ varchar(4000),
    DGRM_RESOURCE_NAME_ varchar(4000),
    HAS_START_FORM_KEY_ TINYINT,
    primary key (ID_)
);

create table ACT_RU_TASK (
    ID_ varchar(64),
    REV_ integer,
    EXECUTION_ID_ varchar(64),
    PROC_INST_ID_ varchar(64),
    PROC_DEF_ID_ varchar(64),
    NAME_ varchar(255),
    PARENT_TASK_ID_ varchar(64),
    DESCRIPTION_ varchar(4000),
    TASK_DEF_KEY_ varchar(255),
    OWNER_ varchar(64),
    ASSIGNEE_ varchar(64),
    DELEGATION_ varchar(64),
    PRIORITY_ integer,
    CREATE_TIME_ timestamp,
    DUE_DATE_ datetime,
    primary key (ID_)
);

create table ACT_RU_IDENTITYLINK (
    ID_ varchar(64),
    REV_ integer,
    GROUP_ID_ varchar(64),
    TYPE_ varchar(255),
    USER_ID_ varchar(64),
    TASK_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_RU_VARIABLE (
    ID_ varchar(64) not null,
    REV_ integer,
    TYPE_ varchar(255) not null,
    NAME_ varchar(255) not null,
    EXECUTION_ID_ varchar(64),
	  PROC_INST_ID_ varchar(64),
    TASK_ID_ varchar(64),
    BYTEARRAY_ID_ varchar(64),
    DOUBLE_ double,
    LONG_ bigint,
    TEXT_ varchar(4000),
    TEXT2_ varchar(4000),
    primary key (ID_)
);

create index ACT_IDX_EXEC_BUSKEY on ACT_RU_EXECUTION(BUSINESS_KEY_);
create index ACT_IDX_TASK_CREATE on ACT_RU_TASK(CREATE_TIME_);
create index ACT_IDX_IDENT_LNK_USER on ACT_RU_IDENTITYLINK(USER_ID_);
create index ACT_IDX_IDENT_LNK_GROUP on ACT_RU_IDENTITYLINK(GROUP_ID_);

alter table ACT_GE_BYTEARRAY
    add constraint ACT_FK_BYTEARR_DEPL 
    foreign key (DEPLOYMENT_ID_) 
    references ACT_RE_DEPLOYMENT (ID_);

alter table ACT_RU_EXECUTION
    add constraint ACT_FK_EXE_PROCINST 
    foreign key (PROC_INST_ID_) 
    references ACT_RU_EXECUTION (ID_) on delete cascade on update cascade;

alter table ACT_RU_EXECUTION
    add constraint ACT_FK_EXE_PARENT 
    foreign key (PARENT_ID_) 
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_EXECUTION
    add constraint ACT_FK_EXE_SUPER 
    foreign key (SUPER_EXEC_) 
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_IDENTITYLINK
    add constraint ACT_FK_TSKASS_TASK 
    foreign key (TASK_ID_) 
    references ACT_RU_TASK (ID_);
    
alter table ACT_RU_TASK
    add constraint ACT_FK_TASK_EXE
    foreign key (EXECUTION_ID_)
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_TASK
    add constraint ACT_FK_TASK_PROCINST
    foreign key (PROC_INST_ID_)
    references ACT_RU_EXECUTION (ID_);
    
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCDEF
  foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
  
alter table ACT_RU_VARIABLE 
    add constraint ACT_FK_VAR_EXE 
    foreign key (EXECUTION_ID_) 
    references ACT_RU_EXECUTION (ID_);

alter table ACT_RU_VARIABLE
    add constraint ACT_FK_VAR_PROCINST
    foreign key (PROC_INST_ID_)
    references ACT_RU_EXECUTION(ID_);

alter table ACT_RU_VARIABLE 
    add constraint ACT_FK_VAR_BYTEARRAY 
    foreign key (BYTEARRAY_ID_) 
    references ACT_GE_BYTEARRAY (ID_);

alter table ACT_RU_JOB 
    add constraint ACT_FK_JOB_EXCEPTION 
    foreign key (EXCEPTION_STACK_ID_) 
    references ACT_GE_BYTEARRAY (ID_);
create table ACT_HI_PROCINST (
    ID_ varchar(64) not null,
    PROC_INST_ID_ varchar(64) not null,
    BUSINESS_KEY_ varchar(255),
    PROC_DEF_ID_ varchar(64) not null,
    START_TIME_ datetime not null,
    END_TIME_ datetime,
    DURATION_ bigint,
    START_USER_ID_ varchar(255),
    START_ACT_ID_ varchar(255),
    END_ACT_ID_ varchar(255),
    primary key (ID_),
    unique (PROC_INST_ID_),
    unique ACT_UNIQ_HI_BUS_KEY (PROC_DEF_ID_, BUSINESS_KEY_)
);

create table ACT_HI_ACTINST (
    ID_ varchar(64) not null,
    PROC_DEF_ID_ varchar(64) not null,
    PROC_INST_ID_ varchar(64) not null,
    EXECUTION_ID_ varchar(64) not null,
    ACT_ID_ varchar(255) not null,
    ACT_NAME_ varchar(255),
    ACT_TYPE_ varchar(255) not null,
    ASSIGNEE_ varchar(64),
    START_TIME_ datetime not null,
    END_TIME_ datetime,
    DURATION_ bigint,
    primary key (ID_)
);

create table ACT_HI_TASKINST (
    ID_ varchar(64) not null,
    PROC_DEF_ID_ varchar(64),
    TASK_DEF_KEY_ varchar(255),
    PROC_INST_ID_ varchar(64),
    EXECUTION_ID_ varchar(64),
    NAME_ varchar(255),
    PARENT_TASK_ID_ varchar(64),
    DESCRIPTION_ varchar(4000),
    OWNER_ varchar(64),
    ASSIGNEE_ varchar(64),
    START_TIME_ datetime not null,
    END_TIME_ datetime,
    DURATION_ bigint,
    DELETE_REASON_ varchar(4000),
    PRIORITY_ integer,
    DUE_DATE_ datetime,
    primary key (ID_)
);

create table ACT_HI_DETAIL (
    ID_ varchar(64) not null,
    TYPE_ varchar(255) not null,
    PROC_INST_ID_ varchar(64) not null,
    EXECUTION_ID_ varchar(64) not null,
    TASK_ID_ varchar(64),
    ACT_INST_ID_ varchar(64),
    NAME_ varchar(255) not null,
    VAR_TYPE_ varchar(255),
    REV_ integer,
    TIME_ datetime not null,
    BYTEARRAY_ID_ varchar(64),
    DOUBLE_ double,
    LONG_ bigint,
    TEXT_ varchar(4000),
    TEXT2_ varchar(4000),
    primary key (ID_)
);

create table ACT_HI_COMMENT (
    ID_ varchar(64) not null,
    TYPE_ varchar(255),
    TIME_ datetime not null,
    USER_ID_ varchar(255),
    TASK_ID_ varchar(64),
    PROC_INST_ID_ varchar(64),
    ACTION_ varchar(255),
    MESSAGE_ varchar(4000),
    FULL_MSG_ LONGBLOB,
    primary key (ID_)
);

create table ACT_HI_ATTACHMENT (
    ID_ varchar(64) not null,
    REV_ integer,
    USER_ID_ varchar(255),
    NAME_ varchar(255),
    DESCRIPTION_ varchar(4000),
    TYPE_ varchar(255),
    TASK_ID_ varchar(64),
    PROC_INST_ID_ varchar(64),
    URL_ varchar(4000),
    CONTENT_ID_ varchar(64),
    primary key (ID_)
);

create index ACT_IDX_HI_PRO_INST_END on ACT_HI_PROCINST(END_TIME_);
create index ACT_IDX_HI_PRO_I_BUSKEY on ACT_HI_PROCINST(BUSINESS_KEY_);
create index ACT_IDX_HI_ACT_INST_START on ACT_HI_ACTINST(START_TIME_);
create index ACT_IDX_HI_ACT_INST_END on ACT_HI_ACTINST(END_TIME_);
create index ACT_IDX_HI_DETAIL_PROC_INST on ACT_HI_DETAIL(PROC_INST_ID_);
create index ACT_IDX_HI_DETAIL_ACT_INST on ACT_HI_DETAIL(ACT_INST_ID_);
create index ACT_IDX_HI_DETAIL_TIME on ACT_HI_DETAIL(TIME_);
create index ACT_IDX_HI_DETAIL_NAME on ACT_HI_DETAIL(NAME_);
create table ACT_ID_GROUP (
    ID_ varchar(64),
    REV_ integer,
    NAME_ varchar(255),
    TYPE_ varchar(255),
    primary key (ID_)
);

create table ACT_ID_MEMBERSHIP (
    USER_ID_ varchar(64),
    GROUP_ID_ varchar(64),
    primary key (USER_ID_, GROUP_ID_)
);

create table ACT_ID_USER (
    ID_ varchar(64),
    REV_ integer,
    FIRST_ varchar(255),
    LAST_ varchar(255),
    EMAIL_ varchar(255),
    PWD_ varchar(255),
    PICTURE_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_ID_INFO (
    ID_ varchar(64),
    REV_ integer,
    USER_ID_ varchar(64),
    TYPE_ varchar(64),
    KEY_ varchar(255),
    VALUE_ varchar(255),
    PASSWORD_ LONGBLOB,
    PARENT_ID_ varchar(255),
    primary key (ID_)
);

alter table ACT_ID_MEMBERSHIP 
    add constraint ACT_FK_MEMB_GROUP 
    foreign key (GROUP_ID_) 
    references ACT_ID_GROUP (ID_);

alter table ACT_ID_MEMBERSHIP 
    add constraint ACT_FK_MEMB_USER 
    foreign key (USER_ID_) 
    references ACT_ID_USER (ID_);

create table ACT_CY_CONN_CONFIG (
	ID_ varchar(255) NOT NULL,
	PLUGIN_ID_ varchar(255) NOT NULL,
	INSTANCE_NAME_ varchar(255) NOT NULL, 
	INSTANCE_ID_ varchar(255) NOT NULL,  
	USER_ varchar(255),
	GROUP_ varchar(255),
	VALUES_ text,	
	primary key (ID_)
);

create table ACT_CY_CONFIG (
	ID_ varchar(255) NOT NULL,
	GROUP_ varchar(255) NOT NULL,
	KEY_ varchar(255) NOT NULL,
	VALUE_ text,
	primary key (ID_)
);

create table ACT_CY_LINK (
	ID_ varchar(255) NOT NULL,
	SOURCE_CONNECTOR_ID_ varchar(255),
	SOURCE_ARTIFACT_ID_ varchar(550),
	SOURCE_ELEMENT_ID_ varchar(255) DEFAULT NULL,
	SOURCE_ELEMENT_NAME_ varchar(255) DEFAULT NULL,
	SOURCE_REVISION_ bigint DEFAULT NULL,
	TARGET_CONNECTOR_ID_ varchar(255),	
	TARGET_ARTIFACT_ID_ varchar(550),
	TARGET_ELEMENT_ID_ varchar(255) DEFAULT NULL,
	TARGET_ELEMENT_NAME_ varchar(255) DEFAULT NULL,
	TARGET_REVISION_ bigint DEFAULT NULL,
	LINK_TYPE_ varchar(255) ,
	COMMENT_ varchar(1000),
	LINKED_BOTH_WAYS_ boolean,
	primary key(ID_)
);

create table ACT_CY_PEOPLE_LINK (
	ID_ varchar(255) NOT NULL,
	SOURCE_CONNECTOR_ID_ varchar(255),
	SOURCE_ARTIFACT_ID_ varchar(550),
	SOURCE_REVISION_ bigint DEFAULT NULL,
	USER_ID_ varchar(255),
	GROUP_ID_ varchar(255),
	LINK_TYPE_ varchar(255),
	COMMENT_ varchar(1000),
	primary key(ID_)
);

create table ACT_CY_TAG (
	ID_ varchar(255),
	NAME_ varchar(255),
	CONNECTOR_ID_ varchar(255),
	ARTIFACT_ID_ varchar(550),
	ALIAS_ varchar(255),
	primary key(ID_)	
);

create table ACT_CY_COMMENT (
	ID_ varchar(255) NOT NULL,
	CONNECTOR_ID_ varchar(255) NOT NULL,
	NODE_ID_ varchar(550) NOT NULL,
	ELEMENT_ID_ varchar(255) DEFAULT NULL,
	CONTENT_ text NOT NULL,
	AUTHOR_ varchar(255),
	DATE_ timestamp NOT NULL,
	ANSWERED_COMMENT_ID_ varchar(255) DEFAULT NULL,
	primary key(ID_)
);

create index ACT_CY_IDX_COMMENT on ACT_CY_COMMENT(ANSWERED_COMMENT_ID_);
alter table ACT_CY_COMMENT 
    add constraint FK_CY_COMMENT_COMMENT 
    foreign key (ANSWERED_COMMENT_ID_) 
    references ACT_CY_COMMENT (ID_);

create table ACT_CY_PROCESS_SOLUTION (
	ID_ varchar(128) NOT NULL,
	LABEL_ varchar(255) NOT NULL,
	STATE_ varchar(32) NOT NULL,
	primary key(ID_)
);

create table ACT_CY_V_FOLDER (
	ID_ varchar(128) NOT NULL,
	LABEL_ varchar(255) NOT NULL,
	CONNECTOR_ID_ varchar(128) NOT NULL,
	REFERENCED_NODE_ID_ varchar(550) NOT NULL,
	PROCESS_SOLUTION_ID_ varchar(128) NOT NULL,
	TYPE_ varchar(32) NOT NULL,
	primary key(ID_)
);

create index ACT_CY_IDX_V_FOLDER on ACT_CY_V_FOLDER(PROCESS_SOLUTION_ID_);
alter table ACT_CY_V_FOLDER 
    add constraint FK_CY_PROCESS_SOLUTION 
    foreign key (PROCESS_SOLUTION_ID_) 
    references ACT_CY_PROCESS_SOLUTION (ID_);
