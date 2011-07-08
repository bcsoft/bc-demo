-- ##bc平台的mysql建表脚本##

-- 测试用的表
create table ZTEST_EXAMPLE (
    ID int NOT NULL auto_increment,
    NAME varchar(255) NOT NULL,
    CODE varchar(255),
    primary key (ID)
);

-- 系统标识相关模块
-- 系统资源
create table BC_IDENTITY_RESOURCE (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) COMMENT '全局标识',
    TYPE_ int(1) NOT NULL COMMENT '类型：1-文件夹,2-内部链接,3-外部链接,4-html',
    STATUS_ int(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    INNER_ int(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    BELONG int COMMENT '所隶属的资源',
    ORDER_ varchar(100) NOT NULL COMMENT '排序号',
    NAME varchar(255) NOT NULL COMMENT '名称',
    URL varchar(255) COMMENT '地址',
    ICONCLASS varchar(255) COMMENT '图标样式',
    OPTION_ text COMMENT '扩展参数',
    primary key (ID)
) COMMENT='系统资源';

-- 角色
create table BC_IDENTITY_ROLE (
    ID int NOT NULL auto_increment,
    CODE varchar(100) NOT NULL COMMENT '编码',
    ORDER_ varchar(100) NOT NULL COMMENT '排序号',
    NAME varchar(255) NOT NULL COMMENT '名称',
    
    UID_ varchar(36) COMMENT '全局标识',
   	TYPE_ int(1) NOT NULL COMMENT '类型',
    STATUS_ int(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    INNER_ int(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    primary key (ID)
) COMMENT='角色';

-- 角色与模块的关联
create table BC_IDENTITY_ROLE_RESOURCE (
    RID int NOT NULL COMMENT '角色ID',
    SID int NOT NULL COMMENT '资源ID',
    primary key (RID,SID)
) COMMENT='角色与资源的关联：角色可以访问哪些资源';
ALTER TABLE BC_IDENTITY_ROLE_RESOURCE ADD CONSTRAINT FK_RS_ROLE FOREIGN KEY (RID) 
	REFERENCES BC_IDENTITY_ROLE (ID);
ALTER TABLE BC_IDENTITY_ROLE_RESOURCE ADD CONSTRAINT FK_RS_RESOURCE FOREIGN KEY (SID) 
	REFERENCES BC_IDENTITY_RESOURCE (ID);

-- 职务
create table BC_IDENTITY_DUTY (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) COMMENT '全局标识',
    STATUS_ int(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    INNER_ int(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    CODE varchar(100) NOT NULL COMMENT '编码',
    NAME varchar(255) NOT NULL COMMENT '名称',
    primary key (ID)
) COMMENT='职务';

-- 参与者的扩展属性
create table BC_IDENTITY_ACTOR_DETAIL (
    ID int NOT NULL auto_increment,
    CREATE_DATE datetime COMMENT '创建时间',
    WORK_DATE date COMMENT 'user-入职时间',
    SEX int(1) NOT NULL default 0 COMMENT 'user-性别：0-未设置,1-男,2-女',
   	CARD varchar(20) COMMENT 'user-身份证',
    DUTY_ID int COMMENT 'user-职务ID',
   	COMMENT varchar(1000) COMMENT '备注',
    primary key (ID)
) COMMENT='参与者的扩展属性';
ALTER TABLE BC_IDENTITY_ACTOR_DETAIL ADD CONSTRAINT FK_ACTORDETAIL_DUTY FOREIGN KEY (DUTY_ID) 
	REFERENCES BC_IDENTITY_DUTY (ID);

-- 参与者
create table BC_IDENTITY_ACTOR (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) NOT NULL COMMENT '全局标识',
    TYPE_ int(1) NOT NULL COMMENT '类型：1-用户,2-单位,3-部门,4-岗位',
    STATUS_ int(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    INNER_ int(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    CODE varchar(100) NOT NULL COMMENT '编码',
    NAME varchar(255) NOT NULL COMMENT '名称',
    PY varchar(255) COMMENT '名称的拼音',
    ORDER_ varchar(100) COMMENT '同类参与者之间的排序号',
    EMAIL varchar(255) COMMENT '邮箱',
    PHONE varchar(255) COMMENT '联系电话',
    DETAIL_ID int COMMENT '扩展表的ID',
    primary key (ID)
) COMMENT='参与者(代表一个人或组织，组织也可以是单位、部门、岗位、团队等)';
ALTER TABLE BC_IDENTITY_ACTOR ADD CONSTRAINT FK_ACTOR_ACTORDETAIL FOREIGN KEY (DETAIL_ID) 
	REFERENCES BC_IDENTITY_ACTOR_DETAIL (ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE BC_IDENTITY_ACTOR ADD INDEX IDX_ACTOR_TYPE (TYPE_);

-- 参与者之间的关联关系
create table BC_IDENTITY_ACTOR_RELATION (
    TYPE_ int(2) NOT NULL COMMENT '关联类型',
    MASTER_ID int NOT NULL COMMENT '主控方ID',
   	FOLLOWER_ID int NOT NULL COMMENT '从属方ID',
    ORDER_ varchar(100) COMMENT '从属方之间的排序号',
    primary key (MASTER_ID,FOLLOWER_ID,TYPE_)
) COMMENT='参与者之间的关联关系';
ALTER TABLE BC_IDENTITY_ACTOR_RELATION ADD CONSTRAINT FK_AR_MASTER FOREIGN KEY (MASTER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_IDENTITY_ACTOR_RELATION ADD CONSTRAINT FK_AR_FOLLOWER FOREIGN KEY (FOLLOWER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_IDENTITY_ACTOR_RELATION ADD INDEX IDX_AR_TM (TYPE_, MASTER_ID),ADD INDEX IDX_AR_TF (TYPE_, FOLLOWER_ID);

-- 认证信息
create table BC_IDENTITY_AUTH (
    ID int NOT NULL auto_increment COMMENT '与Actor表的id对应',
    PASSWORD varchar(32) NOT NULL COMMENT '密码',
    primary key (ID)
) COMMENT='认证信息';
ALTER TABLE BC_IDENTITY_AUTH ADD CONSTRAINT FK_AUTH_ACTOR FOREIGN KEY (ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);

-- 标识生成器
CREATE TABLE BC_IDENTITY_IDGENERATOR (
  TYPE_ VARCHAR(45) NOT NULL COMMENT '分类',
  VALUE INT NOT NULL COMMENT '当前值',
  FORMAT VARCHAR(45) COMMENT '格式模板,如“case-${V}”、“${T}-${V}”,V代表value的值，T代表type_的值' ,
  PRIMARY KEY (TYPE_)
) COMMENT = '标识生成器,用于生成主键或唯一编码用';

-- 参与者与角色的关联
create table BC_IDENTITY_ROLE_ACTOR (
    AID int NOT NULL COMMENT '参与者ID',
    RID int NOT NULL COMMENT '角色ID',
    primary key (AID,RID)
) COMMENT='参与者与角色的关联：参与者拥有哪些角色';
ALTER TABLE BC_IDENTITY_ROLE_ACTOR ADD CONSTRAINT FK_RA_ACTOR FOREIGN KEY (AID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_IDENTITY_ROLE_ACTOR ADD CONSTRAINT FK_RA_ROLE FOREIGN KEY (RID) 
	REFERENCES BC_IDENTITY_ROLE (ID);
-- 系统桌面相关模块
-- 桌面快捷方式
create table BC_DESKTOP_SHORTCUT (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) COMMENT '全局标识',
    STATUS_ int(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    INNER_ int(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    ORDER_ varchar(100) NOT NULL COMMENT '排序号',
    STANDALONE int(1) NOT NULL COMMENT '是否在独立的浏览器窗口中打开',
    NAME varchar(255) COMMENT '名称,为空则使用资源的名称',
    URL varchar(255) COMMENT '地址,为空则使用资源的地址',
    ICONCLASS varchar(255) COMMENT '图标样式',
    SID int COMMENT '对应的资源ID',
    AID int COMMENT '所属的参与者(如果为上级参与者,如单位部门,则其下的所有参与者都拥有该快捷方式)',
    primary key (ID)
) COMMENT='桌面快捷方式';
ALTER TABLE BC_DESKTOP_SHORTCUT ADD CONSTRAINT FK_SHORTCUT_RESOURCE FOREIGN KEY (SID) 
	REFERENCES BC_IDENTITY_RESOURCE (ID);
ALTER TABLE BC_DESKTOP_SHORTCUT ADD CONSTRAINT FK_SHORTCUT_ACTOR FOREIGN KEY (AID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);

-- 个人设置
create table BC_DESKTOP_PERSONAL (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) COMMENT '全局标识',
    STATUS_ int(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    INNER_ int(1) NOT NULL COMMENT '是否为内置对象:0-否,1-是',
    FONT varchar(2) NOT NULL COMMENT '字体大小，如12、14、16',
    THEME varchar(255) NOT NULL COMMENT '主题名称,如base',
    AID int COMMENT '所属的参与者',
    primary key (ID)
) COMMENT='个人设置';
ALTER TABLE BC_DESKTOP_PERSONAL ADD CONSTRAINT FK_PERSONAL_ACTOR FOREIGN KEY (AID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_DESKTOP_PERSONAL ADD UNIQUE INDEX PERSONAL_AID_UNIQUE (AID) ;
-- 消息模块
create table BC_MESSAGE (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) COMMENT '全局标识',
    STATUS_ int(1) NOT NULL default 0 COMMENT '状态：0-发送中,1-已发送,2-已删除,3-发送失败',
    INNER_ int(1) NOT NULL default 0 COMMENT '未用',
    TYPE_ int(1) NOT NULL default 0 COMMENT '消息类型',
    SENDER_ID int NOT NULL COMMENT '发送者',
    SEND_DATE datetime NOT NULL COMMENT '发送时间',
    RECEIVER_ID int NOT NULL COMMENT '接收者',
    READ_ int(1) NOT NULL default 0 COMMENT '已阅标记',
    FROM_ID int COMMENT '来源标识',
    FROM_TYPE int COMMENT '来源类型',
    SUBJECT varchar(255) NOT NULL COMMENT '标题',
    CONTENT text COMMENT '内容',
    primary key (ID)
) COMMENT='消息';
ALTER TABLE BC_MESSAGE ADD CONSTRAINT FK_MESSAGE_SENDER FOREIGN KEY (SENDER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_MESSAGE ADD CONSTRAINT FK_MESSAGE_REVEIVER FOREIGN KEY (RECEIVER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_MESSAGE ADD INDEX IDX_MESSAGE_FROMID (FROM_ID);
ALTER TABLE BC_MESSAGE ADD INDEX IDX_MESSAGE_TYPE (TYPE_);

-- 工作事项
create table BC_WORK (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) COMMENT '全局标识',
    STATUS_ int(1) NOT NULL default 0 COMMENT '状态',
    INNER_ int(1) NOT NULL default 0 COMMENT '未用',
    
    CLASSIFIER varchar(500) NOT NULL COMMENT '分类词,可多级分类,级间使用/连接,如“发文类/正式发文”',
    SUBJECT varchar(255) NOT NULL COMMENT '标题',
    FROM_ID int COMMENT '来源标识',
    FROM_TYPE int COMMENT '来源类型',
    FROM_INFO varchar(255) COMMENT '来源描述',
    OPEN_URL varchar(255) COMMENT '打开的Url模板',
    CONTENT text COMMENT '内容',
    primary key (ID)
) COMMENT='工作事项';
ALTER TABLE BC_WORK ADD INDEX IDX_WORK_FROMID (FROM_ID);

-- 待办事项
create table BC_WORK_TODO (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) COMMENT '未用',
    STATUS_ int(1) NOT NULL default 0 COMMENT '未用',
    INNER_ int(1) NOT NULL default 0 COMMENT '未用',
    
    WORK_ID int NOT NULL COMMENT '工作事项ID',
    SENDER_ID int NOT NULL COMMENT '发送者',
    SEND_DATE datetime NOT NULL COMMENT '发送时间',
    WORKER_ID int NOT NULL COMMENT '发送者',
    INFO varchar(255) COMMENT '附加说明',
    primary key (ID)
) COMMENT='待办事项';
ALTER TABLE BC_WORK_TODO ADD CONSTRAINT FK_TODOWORK_WORK FOREIGN KEY (WORK_ID) 
	REFERENCES BC_WORK (ID);
ALTER TABLE BC_WORK_TODO ADD CONSTRAINT FK_TODOWORK_SENDER FOREIGN KEY (SENDER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_WORK_TODO ADD CONSTRAINT FK_TODOWORK_WORKER FOREIGN KEY (WORKER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);

-- 已办事项
create table BC_WORK_DONE (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) COMMENT '未用',
    STATUS_ int(1) NOT NULL default 0 COMMENT '未用',
    INNER_ int(1) NOT NULL default 0 COMMENT '未用',
    
    FINISH_DATE datetime NOT NULL COMMENT '完成时间',
    FINISH_YEAR int(4) NOT NULL COMMENT '完成时间的年度',
    FINISH_MONTH int(2) NOT NULL COMMENT '完成时间的月份(1-12)',
    FINISH_DAY int(2) NOT NULL COMMENT '完成时间的日(1-31)',

    WORK_ID int NOT NULL COMMENT '工作事项ID',
    SENDER_ID int NOT NULL COMMENT '发送者',
    SEND_DATE datetime NOT NULL COMMENT '发送时间',
    WORKER_ID int NOT NULL COMMENT '发送者',
    INFO varchar(255) COMMENT '附加说明',
    primary key (ID)
) COMMENT='已办事项';
ALTER TABLE BC_WORK_DONE ADD CONSTRAINT FK_DONEWORK_WORK FOREIGN KEY (WORK_ID) 
	REFERENCES BC_WORK (ID);
ALTER TABLE BC_WORK_DONE ADD CONSTRAINT FK_DONEWORK_SENDER FOREIGN KEY (SENDER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_WORK_DONE ADD CONSTRAINT FK_DONEWORK_WORKER FOREIGN KEY (WORKER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_WORK_DONE ADD INDEX IDX_DONEWORK_FINISHDATE (FINISH_YEAR,FINISH_MONTH,FINISH_DAY);

-- 系统日志
create table BC_LOG_SYSTEM (
    ID int NOT NULL auto_increment,
    TYPE_ int(1) NOT NULL COMMENT '类别：0-登录,1-主动注销,2-超时注销',
    
    CREATE_DATE datetime NOT NULL COMMENT '创建时间',
    SUBJECT varchar(500) NOT NULL COMMENT '标题',
    CREATER_ID int NOT NULL COMMENT '创建人ID',
    CREATER_NAME varchar(255) NOT NULL COMMENT '创建人姓名',
    DEPART_ID int COMMENT '用户所在部门ID，如果用户直接隶属于单位，则为null',
    DEPART_NAME varchar(255) COMMENT '用户所在部门名称，如果用户直接隶属于单位，则为null',
    UNIT_ID int NOT NULL COMMENT '用户所在单位ID',
    UNIT_NAME varchar(255) NOT NULL COMMENT '用户所在单位名称',

    C_IP varchar(100) COMMENT '用户机器IP',
    C_NAME varchar(100) COMMENT '用户机器名称',
    C_INFO varchar(1000) COMMENT '用户浏览器信息：User-Agent',
    S_IP varchar(100) COMMENT '服务器IP',
    S_NAME varchar(100) COMMENT '服务器名称',
    S_INFO varchar(1000) COMMENT '服务器信息',

    CONTENT text COMMENT '详细内容',
    
    UID_ varchar(36) COMMENT '未用',
    STATUS_ int(1) default 0 COMMENT '未用',
    INNER_ int(1) default 0 COMMENT '未用',
    primary key (ID)
) COMMENT='系统日志';
ALTER TABLE BC_LOG_SYSTEM ADD CONSTRAINT FK_SYSLOG_USER FOREIGN KEY (CREATER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_LOG_SYSTEM ADD INDEX IDX_SYSLOG_ACTOR (UNIT_ID,DEPART_ID,CREATER_ID);
ALTER TABLE BC_LOG_SYSTEM ADD INDEX IDX_SYSLOG_CLIENT (C_IP);
ALTER TABLE BC_LOG_SYSTEM ADD INDEX IDX_SYSLOG_SERVER (S_IP);

-- 公告模块
create table BC_BULLETIN (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) NOT NULL COMMENT '关联附件的标识号',
    SCOPE int(1) NOT NULL COMMENT '公告发布范围：0-本单位,1-全系统',
    STATUS_ int(1) NOT NULL COMMENT '状态:0-草稿,1-已发布,2-已过期',
   
    FILE_DATE datetime NOT NULL COMMENT '创建时间',
    OVERDUE_DATE datetime COMMENT '过期日期：为空代表永不过期',
   	ISSUE_DATE datetime COMMENT '发布时间',
    FILE_YEAR int(4) COMMENT '发布时间的年度yyyy',
    FILE_MONTH int(2) COMMENT '发布时间的月份(1-12)',
    FILE_DAY int(2) COMMENT '发布时间的日(1-31)',
    ISSUER_ID int COMMENT '发布人ID',
    ISSUER_NAME varchar(100) COMMENT '发布人姓名',
    
    SUBJECT varchar(500) NOT NULL COMMENT '标题',
    
    AUTHOR_ID int NOT NULL COMMENT '创建人ID',
    AUTHOR_NAME varchar(100) NOT NULL COMMENT '创建人姓名',
    DEPART_ID int COMMENT '创建人所在部门ID，如果用户直接隶属于单位，则为null',
    DEPART_NAME varchar(255) COMMENT '创建人所在部门名称，如果用户直接隶属于单位，则为null',
    UNIT_ID int NOT NULL COMMENT '创建人所在单位ID',
    UNIT_NAME varchar(255) NOT NULL COMMENT '创建人所在单位名称',

    CONTENT text NOT NULL COMMENT '详细内容',
    
    INNER_ int(1) default 0 COMMENT '未用',
    primary key (ID)
) COMMENT='公告模块';
ALTER TABLE BC_BULLETIN ADD CONSTRAINT FK_BULLETIN_ISSUER FOREIGN KEY (ISSUER_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_BULLETIN ADD INDEX IDX_BULLETIN_SEARCH (SCOPE,UNIT_ID,STATUS_);
ALTER TABLE BC_BULLETIN ADD INDEX IDX_BULLETIN_ARCHIVE (SCOPE,UNIT_ID,STATUS_,FILE_YEAR,FILE_MONTH,FILE_DAY);

-- 文档附件
create table BC_DOCS_ATTACH (
    ID int NOT NULL auto_increment,
    FILE_DATE datetime NOT NULL COMMENT '创建时间',
    STATUS_ int(1) NOT NULL COMMENT '状态：0-已禁用,1-启用中,2-已删除',
    PTYPE varchar(36) NOT NULL COMMENT '所关联文档的类型',
    PUID varchar(36) NOT NULL COMMENT '所关联文档的UID',
   
    SIZE int NOT NULL COMMENT '文件的大小(单位为字节)',
    COUNT_ int NOT NULL default 0 COMMENT '文件的下载次数',
    EXT varchar(10) COMMENT '文件扩展名：如png、doc、mp3等',
    APPPATH int(1) NOT NULL COMMENT '指定path的值是相对于应用部署目录下路径还是相对于全局配置的app.data目录下的路径',
    SUBJECT varchar(500) NOT NULL COMMENT '文件名称(不带路径的部分)',
    PATH varchar(500) NOT NULL COMMENT '物理文件保存的相对路径(相对于全局配置的附件根目录下的子路径，如"2011/bulletin/xxxx.doc")',
    
    AUTHOR_ID int NOT NULL COMMENT '创建人ID',
    AUTHOR_NAME varchar(100) NOT NULL COMMENT '创建人姓名',
    DEPART_ID int COMMENT '创建人所在部门ID，如果用户直接隶属于单位，则为null',
    DEPART_NAME varchar(255) COMMENT '创建人所在部门名称，如果用户直接隶属于单位，则为null',
    UNIT_ID int NOT NULL COMMENT '创建人所在单位ID',
    UNIT_NAME varchar(255) NOT NULL COMMENT '创建人所在单位名称',
    primary key (ID)
) COMMENT='文档附件,记录文档与其相关附件之间的关系';
ALTER TABLE BC_DOCS_ATTACH ADD CONSTRAINT FK_ATTACH_AUTHOR FOREIGN KEY (AUTHOR_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_DOCS_ATTACH ADD INDEX IDX_ATTACH_PUID (PUID);
ALTER TABLE BC_DOCS_ATTACH ADD INDEX IDX_ATTACH_PTYPE (PTYPE);

-- 附件处理痕迹
create table BC_DOCS_ATTACH_HISTORY (
    ID int NOT NULL auto_increment,
    FILE_DATE datetime NOT NULL COMMENT '处理时间',
    AID int NOT NULL COMMENT '附件ID',
    TYPE_ int NOT NULL COMMENT '处理类型：0-下载,1-在线查看,2-格式转换',
    SUBJECT varchar(500) NOT NULL COMMENT '简单说明',
    FORMAT varchar(10) COMMENT '下载的文件格式或转换后的文件格式：如pdf、doc、mp3等',
    
    AUTHOR_ID int NOT NULL COMMENT '处理人ID',
    AUTHOR_NAME varchar(100) NOT NULL COMMENT '处理人姓名',
    DEPART_ID int COMMENT '处理人所在部门ID，如果用户直接隶属于单位，则为null',
    DEPART_NAME varchar(255) COMMENT '处理人所在部门名称，如果用户直接隶属于单位，则为null',
    UNIT_ID int NOT NULL COMMENT '处理人所在单位ID',
    UNIT_NAME varchar(255) NOT NULL COMMENT '处理人所在单位名称',

    C_IP varchar(100) COMMENT '客户端IP',
    C_INFO varchar(1000) COMMENT '浏览器信息：User-Agent',
    
    MEMO varchar(2000) COMMENT '备注',
    primary key (ID)
) COMMENT='附件处理痕迹';
ALTER TABLE BC_DOCS_ATTACH_HISTORY ADD CONSTRAINT FK_ATTACHHISTORY_AUTHOR FOREIGN KEY (AUTHOR_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_DOCS_ATTACH_HISTORY ADD CONSTRAINT FK_ATTACHHISTORY_ATTACH FOREIGN KEY (AID) 
	REFERENCES BC_DOCS_ATTACH (ID);

-- 用户反馈
create table BC_FEEDBACK (
    ID int NOT NULL auto_increment,
    UID_ varchar(36) NOT NULL COMMENT '关联附件的标识号',
    STATUS_ int(1) NOT NULL COMMENT '状态:0-草稿,1-已提交,2-已受理',
   
    FILE_DATE datetime NOT NULL COMMENT '创建时间',
    FILE_YEAR int(4) COMMENT '发布时间的年度yyyy',
    FILE_MONTH int(2) COMMENT '发布时间的月份(1-12)',
    FILE_DAY int(2) COMMENT '发布时间的日(1-31)',
    
    SUBJECT varchar(500) NOT NULL COMMENT '标题',
    
    AUTHOR_ID int NOT NULL COMMENT '创建人ID',
    AUTHOR_NAME varchar(100) NOT NULL COMMENT '创建人姓名',
    DEPART_ID int COMMENT '创建人所在部门ID，如果用户直接隶属于单位，则为null',
    DEPART_NAME varchar(255) COMMENT '创建人所在部门名称，如果用户直接隶属于单位，则为null',
    UNIT_ID int NOT NULL COMMENT '创建人所在单位ID',
    UNIT_NAME varchar(255) NOT NULL COMMENT '创建人所在单位名称',

    CONTENT text NOT NULL COMMENT '详细内容',
    
    INNER_ int(1) default 0 COMMENT '未用',
    primary key (ID)
) COMMENT='用户反馈';
ALTER TABLE BC_FEEDBACK ADD CONSTRAINT FK_FEEDBACK_AUTHOR FOREIGN KEY (AUTHOR_ID) 
	REFERENCES BC_IDENTITY_ACTOR (ID);
ALTER TABLE BC_FEEDBACK ADD INDEX IDX_FEEDBACK_SEARCH (UNIT_ID,STATUS_);
ALTER TABLE BC_FEEDBACK ADD INDEX IDX_FEEDBACK_ARCHIVE (UNIT_ID,STATUS_,FILE_YEAR,FILE_MONTH,FILE_DAY);


