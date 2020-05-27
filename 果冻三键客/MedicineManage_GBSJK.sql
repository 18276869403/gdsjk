--DROP DATABASE MedicineManage_GBSJK
CREATE DATABASE MedicineManage_GBSJK
GO

USE MedicineManage_GBSJK
GO

CREATE TABLE Classify--药品分类表								
(
ID int primary key identity(1,1) not null,
ClassifyName nvarchar(50) not null --分类名称
)
GO

CREATE TABLE DosageType--医药性状类别表
(
ID int primary key identity(1,1) not null,
DosageName nvarchar(50) not null,--类别名称
FatheID int not null--父类ID
)
GO		

CREATE TABLE Reposit--贮藏方式表								
(
ID int primary key identity(1,1) not null,
RepositName nvarchar(50) not null--方式名称
)
GO

CREATE TABLE PackTable --包装方式表
(
ID int primary key identity(1,1),
PackName varchar(50) not null
)

CREATE TABLE EnterCompany--供应商信息表							
(
ID int primary key identity(1,1) not null,
E_Name nvarchar(50) not null,--企业名称
Address nvarchar(50) not null,--地址
E_Zip int not null,--邮政编码
E_Phone nvarchar(50) not null,--联系电话
E_Fax nvarchar(50) not null,--传真号码
Register_Address nvarchar(50) not null,--注册地址
E_Url  nvarchar(50) not null--网址
)
GO

--drop table MedicineInfo
CREATE TABLE MedicineInfo --医药信息表
(
ID int primary key identity(1,1) not null, 
ChineseName nvarchar(50) not null,--中文名称-
ForeignName nvarchar(50) not null,--外文名称-
MedicineID nvarchar(50) unique not null,--医药编号-
M_Function nvarchar(255) not null,--功能主治-
Ingredient nvarchar(255) not null, --成分-
ClassifyID int not null, --分类编号-
DosageID int not null,--剂型编号-
--StateDate datetime default (getdate()) null,--生产日期-
--ExpirationDate datetime not null, --保质期-
Etalon nvarchar(50) null,--规格-
Taboo nvarchar(255) not null,--禁忌-
Notes nvarchar(255) not null,--注意事项-
Pharmacology nvarchar(255) null,--药理-
RepositID int not null, --贮藏编号-
PackID int not null, --包装-
EnterCompanyID int null, --企业编号-
)
GO


CREATE TABLE Inventory --库存数量表
(
ID int primary key identity(1,1) not null,--价格编号
MedicineID nvarchar(50) not null,--药品编号
Number int not null,--数量
)

--drop table UserInfo

CREATE TABLE UserInfo --用户信息表				
(
ID int primary key identity(1,1) not null, 
UserName nvarchar(50) not null,--用户名
UserPwd char(32) not null,--密码
UserPhone nvarchar(50) not null,--联系电话
DepartmentID int not null, --部门编号
UserID int unique not null,--身份编号
Sex int not null,--性别
AddTime datetime default getdate() not null,--添加时间
DelFlag int not null,--是否删除0，1
)
GO

Insert into UserInfo values
('鲨鱼辣椒','e10adc3949ba59abbe56e057f20f883e','12345678978',1,1,0,default,0),
('蜻蜓队长','e10adc3949ba59abbe56e057f20f883e','12345678978',2,2,1,default,0),
('蝎子莱莱','e10adc3949ba59abbe56e057f20f883e','12345678978',3,3,0,default,0)


CREATE TABLE Department --部门表
(
DepartmentID int primary key identity(1,1), --部门ID
DepartmentName nvarchar(50) not null, --部门名称
Description nvarchar(255) null --描述
)

insert into Department values
('工务部',null),
('财务部',null),
('人事部',null),
('后勤部',null)

select * from Department

CREATE TABLE MarketInfo	--销售信息表		
(
ID int primary key identity(1,1) not null, 
MedicineID nvarchar(50) not null,--药品编号
MarketNumber int null,--数量
UserID int null,--用户编号
SellTime datetime  default(getdate()) null,--出售时间
PriceID int not null,
)
GO
--drop table Price
CREATE TABLE PriceInfo
(
ID int primary key identity(1,1) not null,
MedicineID nvarchar(50) not null,
Price money not null
)

CREATE TABLE RoleInfo--角色信息表
(
ID int primary key identity(1,1) not null,
RoleID int unique not null, --角色编号
RoleName nvarchar(50) not null, --角色名称
Description nvarchar(50) not null, --部门
AddTime datetime default getdate() not null,--添加时间
DelFlag int not null,--是否删除0/1
)

--drop table RoleInfo

insert into RoleInfo values
(1,'CEO','管理整个系统',default,0),
(2,'经理','管理用户信息、药品信息、仓库信息',default,0),
(3,'店长','管理销售信息、库存信息',default,0),
(4,'店员','管理销售信息（只包括添加销售信息、和查询）',default,0),
(5,'用户','可以添加销售信息',default,0)

CREATE TABLE R_UserInfo_RoleInfo--用户角色表
(
ID int primary key identity(1,1) not null,
UserID int not null,--用户编号
RoleID int not null,--角色编号
)

insert into R_UserInfo_RoleInfo values 
(1,1),
(2,2),
(2,3),
(2,4),
(3,3)
		
CREATE TABLE EnterInfo--进货信息表
(
ID int primary key identity(1,1) not null, --编号
MedicineID nvarchar(50) not null,--药品编号
MarketNumber int not null, --数量
EnterCompanyID int not null, --企业编号
EnterDate datetime default getdate() not null, --进货日期
EndDate datetime not null, --到期日期
EnterPrice money not null --进货价
)
GO

--drop table PowerInfo

CREATE TABLE PowerInfo--权限表
(
ID int primary key identity(1,1) not null,
PowerID int unique not null,--权限编号
MenuName nvarchar(50) not null,--菜单名称
ActionUrl nvarchar(50) not null,--行动URL
IsMenu int not null, --是否目录
ParentID int not null,--父亲编号
MenuIconUrl nvarchar(50) not null,--菜单突图标
HttpMethod int not null,--HTTP方法
Description nvarchar(50) not null,--描述
)

insert into PowerInfo values 
(1, '药品管理' , '' , 1 , 0 , '/images/Medicine1.png' , '' , '菜单：管理药品信息'),
(2, '销售管理' , '' , 1 , 0 , '/images/SS.png' , '' , '菜单：管理出售进货信息'),
(3, '供应商管理' , '' , 1 ,0 , '/images/GYS.png','','菜单：管理供应商信息'),
(4, '系统管理' , '' , 1 , 0 , '/images/XT.png' , '' , '菜单：管理用户信息'),
(5, '仓库管理' , '', 1 , 0 , '/images/CK.png' , '' , '菜单：管理仓库信息'),

(6, '药品信息管理' , '/Medicine/Index' , 1 , 1 , '/images/YPInfo.png' , '' , '页面：药品信息管理'),
(7,'添加药品信息','/Medicine/AddMedicineInfo',0,1,'','','页面：添加药品信息'),
(8,'修改药品信息','/Medicine/ModifyMedicineInfo',0,1,'','','页面：修改药品信息'),
(9,'','/Medicine/Add',0,1,'','','功能：添加药品'),
(10,'','/Medicine/GetJson',0,1,'','','功能：查询药品'),
(11,'','/Medicine/Modify',0,1,'','','功能：修改药品'),
(12,'','/Medicine/DelMedicineInfoByID',0,1,'','','功能：删除药品'),

(13, '成员管理' , '/UserInfo/Index' , 1 , 4 , '/images/YH.png' , '' , '页面：用户信息管理'),
(14, '添加用户信息' , '/UserInfo/AddUserInfo',0,4,'','','页面：添加用户信息'),
(15, '修改用户信息' , '/UserInfo/ModifyUserInfo',0,4,'','','页面：修改用户信息'),
(16, '', '/UserInfo/Modify',0,4,'','','功能：修改用户信息'),
(17, '', '/UserInfo/Add',0,4,'','','功能：添加用户信息'),
(18, '', '/UserInfo/GetJson',0,4,'','','功能：查询用户信息'),
(19, '', '/UserInfo/ModifyDelFlag',0,4,'','','功能：用户启用/禁用'),
(20, '', '/UserInfo/AddRole',0,4,'','','功能：分配用户角色'),
(21, '', '/UserInfo/GetRoleJson',0,4,'','','功能：查询角色信息'),
(22, '分配用户角色', '/UserInfo/AllotRole',0,4,'','','页面：分配用户角色'),

(23, '进货信息' , '/EnterInfo/Index',1,5,'/images/JH.png','','页面：仓库信息管理'),
(24, '添加进货信息' , '/EnterInfo/AddEnterInfo',0,5,'','','页面：添加进货信息'),
(25, '修改进货信息' , '/EnterInfo/ModifyEnterInfo',0,5,'','','页面：修改进货信息'),
(26, '','/EnterInfo/GetJson',0,5,'','','功能：查询库存信息'),
(27, '','/EnterInfo/DelEnterInfoByID',0,5,'','','功能：删除库存信息'),
(28, '','/EnterInfo/Add',0,5,'','','功能：添加进货同时修改库存数量信息'),
(29, '','/EnterInfo/Modify',0,5,'','','功能：修改库存信息'),

(30, '供应商信息','/EnterCompany/Index',1,3,'/images/GYSADD.png','','页面：供应商信息管理'),
(31, '添加供应商信息','/EnterCompany/AddEnterCompany',0,3,'','','页面：添加供应商信息'),
(32, '修改供应商信息','/EnterCompany/ModifyEnterCompany',0,3,'','','页面：修改供应商信息'),
(33, '','/EnterCompany/Add',0,3,'','','功能：添加供应商信息'),
(34, '','/EnterCompany/Modify',0,3,'','','功能：修改供应商信息'),
(35, '','/EnterCompany/DelEnterCompanyByID',0,3,'','','功能：删除供应商信息'),
(36, '','/EnterCompany/GetJson',0,3,'','','功能：查询供应商信息'),

(37, '销售管理','/MarketInfo/Index',1,2,'/images/SS1.png','','页面：销售信息管理'),
(38, '添加销售信息','/MarketInfo/AddMarketInfo',0,2,'','','页面：添加销售信息'),
(39, '','/MarketInfo/GetJson',0,2,'','','功能：查询销售信息'),
(40, '','/MarketInfo/DelMarketInfoByID',0,2,'','','功能：删除销售信息'),

(41, '仓库信息','/Inventory/Index',1,5,'/images/CKInfo.png','','页面：仓库信息管理'),
(42, '','/Inventory/GetJson',0,5,'','','功能：查询仓库信息管理'),

(43, '角色权限管理','/RoleInfo/Index',1,4,'/images/JS.png','','页面：角色信息管理'),
(44, '添加角色信息','/RoleInfo/AddRoleInfo',0,4,'','','页面：添加角色信息页'),
(45, '修改角色信息','/RoleInfo/ModifyRoleInfo',0,4,'','','页面：修改角色信息页'),
(46, '分配权限页面','/RoleInfo/AllotPower',0,4,'','','页面：分配权限页'),
(47, '','/RoleInfo/GetPowerAllotJson',0,4,'','','功能：查询权限信息'),
(48, '','/RoleInfo/ModifyAllot',0,4,'','','功能：分配权限'),
(49, '','/RoleInfo/Modify',0,4,'','','功能：修改角色信息'),
(50, '','/RoleInfo/GetJson',0,4,'','','功能：查询角色信息'),
(51, '','/RoleInfo/Add',0,4,'','','功能：添加角色信息'),
(52, '','/RoleInfo/ModifyDelFlag',0,4,'','','功能：修改角色状态'),
(53, '','/RoleInfo/Delete',0,4,'','','功能：删除角色信息'),

(54,'','/UserInfo/isRepeat',0,4,'','','辅助功能：查询用户编号是否存在'),
(55, '','/EnterInfo/isRepeatMedicineID',0,5,'','','辅助功能：查询药品编号'),
(56, '','/EnterInfo/isRepeatCompanyID',0,5,'','','辅助功能：查询供应商编号'),

(57, '','/EnterInfo/AddToEnterInfo',0,5,'','','功能：批量添加库存信息'),
(58, '','/EnterInfo/BacthAddTo',0,5,'','','功能：批量添加库存')

--update PowerInfo set IsMenu = 0 where ID = 42


CREATE TABLE R_RoleInfo_PowerInfo
(
ID int identity(1,1) primary key not null,
PowerID int not null,--权限编号
RoleID int not null,--角色编号
)


insert into R_RoleInfo_PowerInfo values 
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),

(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),
(18,1),
(19,1),

(20,1),
(21,1),
(22,1),
(23,1),
(24,1),
(25,1),
(26,1),
(27,1),
(28,1),
(29,1),
(30,1),
(31,1),
(32,1),
(33,1),
(34,1),
(35,1),
(36,1),
(37,1),
(38,1),
(39,1),
(40,1),
(41,1),
(42,1),
(43,1),
(44,1),

(45,1),
(46,1),
(47,1),
(48,1),
(49,1),
(50,1),
(51,1),
(52,1),

(53,1),
(54,1),
(55,1),
(56,1),
(57,1),
(58,1),

(4,2),
(13,2),
(14,2),
(15,2),
(16,2),
(17,2),
(18,2),
(19,2),
(20,2),
(21,2),
(22,2),

(1,2),
(6,2),
(7,2),
(8,2),
(9,2),
(10,2),
(11,2),
(12,2),

(41,2),
(42,2),
(43,2),
(44,2),
(45,2),
(46,2),
(47,2),
(48,2),
(49,2),
(50,2),
(51,2),
(52,2),
(53,2),
(54,2)

select * from R_RoleInfo_PowerInfo as a inner join PowerInfo as b on a.PowerID =b.PowerID


select * from R_RoleInfo_PowerInfo
select m.*,i.Number,c.ClassifyName,d.DosageName,r.RepositName from MedicineInfo m
inner join Inventory i on m.MedicineID = i.MedicineID
inner join Classify c on m.ClassifyID = c.ID
inner join DosageType d on m.DosageID=d.ID
inner join Reposit r on m.RepositID = r.ID
--供应商信息表
insert into EnterCompany values
('长春亚泰药业','吉林长春',130000,'13789561258','8659288887777','吉林长春','www.ccyt.cn'),
('九芝堂药业','广东佛山',556644,'13598569441','9879288887777','广东佛山','www.jiuzhitang.cn'),
('宝芝堂','广西玉林',610000,'13789512358','86592888877789','广西玉林','www.yulinzhiyao.cn')

insert into PackTable values
('散'),
('瓶'),
('袋'),
('盒')

--药品分类表
insert into Classify values
('中药'),
('西药'),
('中西混合')

--贮藏方式表
insert into Reposit values
('冷藏'),
('密封'),
('阴凉处'),
('密闭'),
('溶封或严封'),
('遮光容器'),
('凉暗处')

--剂型分类表
insert into DosageType values 
('片剂',0),
('胶囊剂',0),
('口服啶膏剂',0),
('口服丸剂',0),
('口服颗粒/粉/散剂',0),
('外用酊/膏/贴/粉剂',0),
('外用涂剂/栓剂',0),
('注射剂',0),
('兴奋剂',0),
('麻黄碱制剂',0),
('肠溶片',1),
('包衣片',1),
('薄膜衣片',1),
('糖衣片',1),
('浸膏片',1),
('分散片',1),
('划痕片',1),
('缓释片',1),
('缓释包衣片',1),
('控释片',1),
('硬胶囊',2),
('软胶囊（胶丸）',2),
('肠溶胶囊',2),
('缓释胶囊',2),
('控释胶囊',2),
('口服溶液剂',3),
('口服混悬剂',3),
('口服乳剂',3),
('胶浆剂',3),
('乳液',3),
('乳剂',3),
('胶体溶液',3),
('合剂',3),
('酊剂',3),
('滴剂',3),
('混悬滴剂',3),
('大丸剂',4),
('滴丸',4),
('蜜丸',4),
 ('颗粒剂',5),
('肠溶颗粒剂',5),
('干混悬剂',5),
('吸入性粉剂',5),
('干粉剂',5),
('干粉吸入剂',5),
('粉末吸入剂',5),
('干粉吸剂',5),
('散剂',5),
('药粉',5),
('粉剂',5),
('软膏剂',6),
('乳膏剂',6),
('霜剂',6),
('糊剂',6),
('油膏剂',6),
('硬膏剂',6),
('亲水硬膏剂',6),
('乳胶剂',6),
('凝胶剂',6),
('贴剂',6),
('贴膏剂',6),
('膜剂',6),
('贴剂',6),
('滴眼剂',6),
('滴眼液',6),
('滴耳剂',6),
('滴耳液',6),
('滴鼻剂',6),
('滴鼻液',6),
('散剂',6),
('粉剂',6),
('撒布剂',6),
('撒粉',6),
('栓剂',7),
('肛门栓',7),
('阴道栓',7),
('涂膜剂',7),
('涂布剂',7),
('注射剂',8),
('注射液',8),
('注射用溶液剂',8),
('静脉滴注用注射液',8),
('注射用混悬液',8),
('注射用无菌粉末',8),
('静脉注射针剂',8),
('水针',8),
('注射用乳剂',8),
('粉针剂',8),
('针剂',8),
('无菌粉针',8),
('冻干粉针',8),
('兴奋剂',9),
('麻黄碱制剂',10)

--drop table MedicineInfo
--医药信息表
insert into MedicineInfo values
('夏桑菊颗粒','XiaSangJuKeLi','Z45020076','清肝明目，疏风散热，并可作清凉饮料','夏枯草、野菊花、桑叶',1,11,'10g*10袋','尚不明确','忌烟、酒及辛辣、生冷、油腻食物',null,2,1,3),
('板蓝根','BanLanGenKeLi','Z45020001','	清热解毒，凉血利咽。用于肺胃热盛所致的咽喉肿痛、口咽干燥；急性扁桃体炎见上述证候者','板蓝根。辅料为蔗糖、糊精。',1,13,'10g*10袋','尚不明确','忌烟、酒及辛辣、生冷、油腻食物',null,2,2,1),
('阿莫西林胶囊','AmoXiLinJiaoNang','Z55020076','阿莫西林适用于敏感菌（不产β内酰胺酶菌株）所致的下列感染：1．溶血链球菌、肺炎链球菌、葡萄球菌或流感嗜血杆菌所致中耳炎','阿莫西林',2,12,'0.5g*8颗','尚不明确','忌烟、酒及辛辣、生冷、油腻食物',null,2,3,3),
('夏桑菊颗粒','XiaSangJuKeLi','Z45020074','清肝明目，疏风散热，并可作清凉饮料','夏枯草、野菊花、桑叶',1,15,'10g*10袋','尚不明确','忌烟、酒及辛辣、生冷、油腻食物',null,2,2,3),
('板蓝根','BanLanGenKeLi','Z45020007','	清热解毒，凉血利咽。用于肺胃热盛所致的咽喉肿痛、口咽干燥；急性扁桃体炎见上述证候者','板蓝根。辅料为蔗糖、糊精。',1,14,'10g*10袋','尚不明确','忌烟、酒及辛辣、生冷、油腻食物',null,2,4,2),
('阿莫西林胶囊','AmoXiLinJiaoNang','Z55020071','阿莫西林适用于敏感菌（不产β内酰胺酶菌株）所致的下列感染：1．溶血链球菌、肺炎链球菌、葡萄球菌或流感嗜血杆菌所致中耳炎','阿莫西林',2,16,'0.5g*8颗','尚不明确','忌烟、酒及辛辣、生冷、油腻食物',null,2,2,2)

insert into PriceInfo values 
('Z45020076',15),
('Z45020001',8),
('Z55020076',20),
('Z45020074',13),
('Z45020007',11),
('Z55020071',18)

--库存数量表
insert into Inventory values
('Z45020076',20),
('Z45020001',20),
('Z55020076',20),
('Z45020074',20),
('Z45020007',20),
('Z55020071',20)

select * from Inventory

--销售信息表
insert into MarketInfo values
('Z45020076',10,1,getdate(),1),
('Z45020001',5,2,getdate(),2),
('Z55020076',11,3,getdate(),3),
('Z45020076',10,1,getdate(),4),
('Z45020001',5,2,getdate(),5),
('Z55020076',11,3,getdate(),6)

--进货信息表
insert into EnterInfo values
('Z45020076',20,1,default,'2020-9-22',5),
('Z45020001',20,2,default,'2020-9-22',5),
('Z55020076',20,3,default,'2020-9-22',5),
('Z45020074',20,2,default,'2020-9-22',5),
('Z45020007',20,3,default,'2020-9-22',5),
('Z55020071',20,1,default,'2020-9-22',5)

select * from EnterInfo
select * from EnterCompany
select * from Classify
select * from Reposit
select * from DosageType
select * from MedicineInfo
select * from UserInfo
select * from MarketInfo
select * from Inventory

select * from UserInfo as u 
left join R_UserInfo_RoleInfo as r on u.UserID = r.UserID

select m.*,i.Number from MedicineInfo m
inner join Inventory i on m.MedicineID = i.MedicineID
inner join Classify c on m.ClassifyID = c.ID

