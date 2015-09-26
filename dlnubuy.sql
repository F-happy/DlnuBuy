/*
Navicat MySQL Data Transfer

Source Server         : dlnubuy
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : dlnubuy

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2015-05-04 11:28:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_0e939a4f` (`group_id`),
  KEY `auth_group_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_58c48ba9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_417f1b1c` (`content_type_id`),
  CONSTRAINT `auth_permissi_content_type_id_51277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add permission', '1', 'add_permission');
INSERT INTO `auth_permission` VALUES ('2', 'Can change permission', '1', 'change_permission');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete permission', '1', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('4', 'Can add group', '2', 'add_group');
INSERT INTO `auth_permission` VALUES ('5', 'Can change group', '2', 'change_group');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete group', '2', 'delete_group');
INSERT INTO `auth_permission` VALUES ('7', 'Can add user', '3', 'add_user');
INSERT INTO `auth_permission` VALUES ('8', 'Can change user', '3', 'change_user');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete user', '3', 'delete_user');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('16', 'Can add users', '6', 'add_users');
INSERT INTO `auth_permission` VALUES ('17', 'Can change users', '6', 'change_users');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete users', '6', 'delete_users');
INSERT INTO `auth_permission` VALUES ('19', 'Can add product', '7', 'add_product');
INSERT INTO `auth_permission` VALUES ('20', 'Can change product', '7', 'change_product');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete product', '7', 'delete_product');
INSERT INTO `auth_permission` VALUES ('22', 'Can add buy', '8', 'add_buy');
INSERT INTO `auth_permission` VALUES ('23', 'Can change buy', '8', 'change_buy');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete buy', '8', 'delete_buy');
INSERT INTO `auth_permission` VALUES ('25', 'Can add classification', '9', 'add_classification');
INSERT INTO `auth_permission` VALUES ('26', 'Can change classification', '9', 'change_classification');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete classification', '9', 'delete_classification');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$15000$rBrq1HlebLqx$tWm5+oJ90+xXX0nlPANeMhbw3Uus+2gyAUpY2RpoO3Q=', '2015-03-24 09:34:05', '1', '123', '', '', '', '1', '1', '2015-03-24 09:34:05');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_e8701ad4` (`user_id`),
  KEY `auth_user_groups_0e939a4f` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_30a071c9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_24702650_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_e8701ad4` (`user_id`),
  KEY `auth_user_user_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_user_user_permissions_user_id_7cd7acb6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_3ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'permission', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('2', 'group', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('3', 'user', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('4', 'content type', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('5', 'session', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('6', 'users', 'dlnubuy', 'users');
INSERT INTO `django_content_type` VALUES ('7', 'product', 'dlnubuy', 'product');
INSERT INTO `django_content_type` VALUES ('8', 'buy', 'dlnubuy', 'buy');
INSERT INTO `django_content_type` VALUES ('9', 'classification', 'dlnubuy', 'classification');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2015-03-24 09:33:53');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2015-03-24 09:33:53');
INSERT INTO `django_migrations` VALUES ('3', 'sessions', '0001_initial', '2015-03-24 09:33:53');
INSERT INTO `django_migrations` VALUES ('4', 'dlnubuy', '0001_initial', '2015-03-24 09:34:25');
INSERT INTO `django_migrations` VALUES ('5', 'dlnubuy', '0002_auto_20150331_1433', '2015-03-31 06:33:46');
INSERT INTO `django_migrations` VALUES ('6', 'dlnubuy', '0003_auto_20150405_0948', '2015-04-05 01:48:51');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for dlnubuy_buy
-- ----------------------------
DROP TABLE IF EXISTS `dlnubuy_buy`;
CREATE TABLE `dlnubuy_buy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pdid` int(11) NOT NULL,
  `buytime` datetime NOT NULL,
  `transaction_status` varchar(10) NOT NULL,
  `buyid` int(11) NOT NULL,
  `esllid` int(11) NOT NULL,
  `buymoney` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dlnubuy_buy
-- ----------------------------
INSERT INTO `dlnubuy_buy` VALUES ('21', '37', '2015-05-01 03:28:14', '1', '1', '2', '151');
INSERT INTO `dlnubuy_buy` VALUES ('22', '40', '2015-05-01 03:28:14', '1', '1', '2', '152');
INSERT INTO `dlnubuy_buy` VALUES ('23', '41', '2015-05-01 03:28:14', '1', '1', '2', '153');
INSERT INTO `dlnubuy_buy` VALUES ('24', '42', '2015-05-01 03:28:14', '1', '1', '2', '154');
INSERT INTO `dlnubuy_buy` VALUES ('25', '43', '2015-05-01 03:28:14', '1', '1', '2', '155');
INSERT INTO `dlnubuy_buy` VALUES ('26', '44', '2015-05-01 03:28:14', '1', '1', '2', '156');
INSERT INTO `dlnubuy_buy` VALUES ('27', '45', '2015-05-01 03:28:14', '1', '1', '2', '157');
INSERT INTO `dlnubuy_buy` VALUES ('28', '46', '2015-05-01 03:28:14', '1', '1', '2', '158');
INSERT INTO `dlnubuy_buy` VALUES ('29', '47', '2015-05-01 03:28:14', '1', '1', '2', '159');
INSERT INTO `dlnubuy_buy` VALUES ('30', '48', '2015-05-01 03:28:14', '1', '1', '2', '160');
INSERT INTO `dlnubuy_buy` VALUES ('31', '49', '2015-05-01 03:28:14', '0', '3', '4', '151');
INSERT INTO `dlnubuy_buy` VALUES ('32', '50', '2015-05-01 03:28:14', '0', '3', '4', '152');
INSERT INTO `dlnubuy_buy` VALUES ('33', '51', '2015-05-01 03:28:14', '0', '3', '4', '153');
INSERT INTO `dlnubuy_buy` VALUES ('34', '52', '2015-05-01 03:28:14', '0', '3', '4', '154');
INSERT INTO `dlnubuy_buy` VALUES ('35', '53', '2015-05-01 03:28:14', '0', '3', '4', '155');
INSERT INTO `dlnubuy_buy` VALUES ('36', '54', '2015-05-01 03:28:14', '0', '3', '4', '156');
INSERT INTO `dlnubuy_buy` VALUES ('37', '55', '2015-05-01 03:28:14', '0', '3', '4', '157');
INSERT INTO `dlnubuy_buy` VALUES ('38', '38', '2015-05-01 03:28:14', '0', '3', '4', '158');
INSERT INTO `dlnubuy_buy` VALUES ('39', '39', '2015-05-01 03:28:14', '0', '3', '4', '159');
INSERT INTO `dlnubuy_buy` VALUES ('40', '58', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('41', '59', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('42', '60', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('43', '61', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('44', '62', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('45', '63', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('46', '64', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('48', '65', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('50', '66', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('51', '67', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('52', '68', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('53', '69', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('54', '70', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('55', '71', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('56', '56', '2015-05-01 03:28:14', '0', '3', '4', '160');
INSERT INTO `dlnubuy_buy` VALUES ('57', '57', '2015-05-01 03:28:14', '0', '3', '4', '160');

-- ----------------------------
-- Table structure for dlnubuy_classification
-- ----------------------------
DROP TABLE IF EXISTS `dlnubuy_classification`;
CREATE TABLE `dlnubuy_classification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CFname` varchar(300) NOT NULL,
  `CFnumber` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `parent` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dlnubuy_classification
-- ----------------------------
INSERT INTO `dlnubuy_classification` VALUES ('1', '图书教辅', '100000', '1', '0');
INSERT INTO `dlnubuy_classification` VALUES ('2', '生活百货', '200000', '1', '0');
INSERT INTO `dlnubuy_classification` VALUES ('3', '遗弃猫狗', '300000', '1', '0');
INSERT INTO `dlnubuy_classification` VALUES ('4', '户外健身', '400000', '1', '0');
INSERT INTO `dlnubuy_classification` VALUES ('5', '工艺品', '500000', '1', '0');
INSERT INTO `dlnubuy_classification` VALUES ('6', '教辅资料', '101000', '2', '100000');
INSERT INTO `dlnubuy_classification` VALUES ('7', '考研教材', '101010', '3', '101000');
INSERT INTO `dlnubuy_classification` VALUES ('8', '考研数学', '101011', '4', '101010');
INSERT INTO `dlnubuy_classification` VALUES ('9', '图书', '102000', '2', '100000');
INSERT INTO `dlnubuy_classification` VALUES ('10', '言情小说', '102010', '3', '102000');
INSERT INTO `dlnubuy_classification` VALUES ('11', '不一样的美男', '102011', '4', '102010');
INSERT INTO `dlnubuy_classification` VALUES ('12', '外语考试', '101020', '3', '101000');
INSERT INTO `dlnubuy_classification` VALUES ('13', '英语四/六级', '101021', '4', '101020');
INSERT INTO `dlnubuy_classification` VALUES ('14', '托福考试', '101022', '4', '101020');
INSERT INTO `dlnubuy_classification` VALUES ('15', 'GRE考试', '101023', '4', '101020');
INSERT INTO `dlnubuy_classification` VALUES ('16', '考研英语', '101012', '4', '101010');
INSERT INTO `dlnubuy_classification` VALUES ('17', '考研政治', '101013', '4', '101010');
INSERT INTO `dlnubuy_classification` VALUES ('18', '考研专业课', '101014', '4', '101010');
INSERT INTO `dlnubuy_classification` VALUES ('19', '公务员考试', '101030', '3', '101000');
INSERT INTO `dlnubuy_classification` VALUES ('20', '其他类考试', '101040', '3', '101000');
INSERT INTO `dlnubuy_classification` VALUES ('21', '储物', '201000', '2', '200000');
INSERT INTO `dlnubuy_classification` VALUES ('22', '书房', '202000', '2', '200000');
INSERT INTO `dlnubuy_classification` VALUES ('23', '灯具', '203000', '2', '200000');
INSERT INTO `dlnubuy_classification` VALUES ('24', '烹饪', '204000', '2', '200000');
INSERT INTO `dlnubuy_classification` VALUES ('25', '居家日用', '205000', '2', '200000');
INSERT INTO `dlnubuy_classification` VALUES ('26', '猫', '301000', '2', '300000');
INSERT INTO `dlnubuy_classification` VALUES ('27', '狗', '302000', '2', '300000');
INSERT INTO `dlnubuy_classification` VALUES ('28', '其他', '303000', '2', '300000');
INSERT INTO `dlnubuy_classification` VALUES ('29', '户外装备', '401000', '2', '400000');
INSERT INTO `dlnubuy_classification` VALUES ('30', '体育娱乐', '402000', '2', '400000');
INSERT INTO `dlnubuy_classification` VALUES ('31', '乐器', '501000', '2', '500000');
INSERT INTO `dlnubuy_classification` VALUES ('32', '饰品', '502000', '2', '500000');
INSERT INTO `dlnubuy_classification` VALUES ('33', '鞋架', '201010', '3', '201000');
INSERT INTO `dlnubuy_classification` VALUES ('34', '衣帽架', '201020', '3', '201000');
INSERT INTO `dlnubuy_classification` VALUES ('35', '收纳家具', '201030', '3', '201000');
INSERT INTO `dlnubuy_classification` VALUES ('36', '书柜书架', '202010', '3', '202000');
INSERT INTO `dlnubuy_classification` VALUES ('37', '书桌', '202020', '3', '202000');
INSERT INTO `dlnubuy_classification` VALUES ('38', '电脑桌椅', '202030', '3', '202000');
INSERT INTO `dlnubuy_classification` VALUES ('39', '台灯', '203010', '3', '203000');
INSERT INTO `dlnubuy_classification` VALUES ('40', '简射灯', '203020', '3', '203000');
INSERT INTO `dlnubuy_classification` VALUES ('41', '各种锅', '204010', '3', '204000');
INSERT INTO `dlnubuy_classification` VALUES ('42', '各种壶', '204020', '3', '204000');
INSERT INTO `dlnubuy_classification` VALUES ('43', '水具', '204030', '3', '204000');
INSERT INTO `dlnubuy_classification` VALUES ('44', '收纳箱', '205010', '3', '205000');
INSERT INTO `dlnubuy_classification` VALUES ('45', '日用品', '205020', '3', '205000');
INSERT INTO `dlnubuy_classification` VALUES ('46', '野猫', '301010', '3', '301000');
INSERT INTO `dlnubuy_classification` VALUES ('47', '家猫', '301020', '3', '301000');
INSERT INTO `dlnubuy_classification` VALUES ('48', '野狗', '302010', '3', '302000');
INSERT INTO `dlnubuy_classification` VALUES ('49', '家狗', '302020', '3', '302000');
INSERT INTO `dlnubuy_classification` VALUES ('50', '野生', '303010', '3', '303000');
INSERT INTO `dlnubuy_classification` VALUES ('51', '家养', '303020', '3', '303000');
INSERT INTO `dlnubuy_classification` VALUES ('52', '帐篷', '401010', '3', '401000');
INSERT INTO `dlnubuy_classification` VALUES ('53', '户外背包', '401020', '3', '401000');
INSERT INTO `dlnubuy_classification` VALUES ('54', '睡袋', '401030', '3', '401000');
INSERT INTO `dlnubuy_classification` VALUES ('55', '工具', '401040', '3', '401000');
INSERT INTO `dlnubuy_classification` VALUES ('56', '篮球', '402010', '3', '402000');
INSERT INTO `dlnubuy_classification` VALUES ('57', '足球', '402020', '3', '402000');
INSERT INTO `dlnubuy_classification` VALUES ('58', '乒乓球', '402030', '3', '402000');
INSERT INTO `dlnubuy_classification` VALUES ('59', '网球', '402040', '3', '402000');
INSERT INTO `dlnubuy_classification` VALUES ('60', '轮滑', '402050', '3', '402000');
INSERT INTO `dlnubuy_classification` VALUES ('61', '羽毛球', '402060', '3', '402000');
INSERT INTO `dlnubuy_classification` VALUES ('62', '其他', '402070', '3', '402000');
INSERT INTO `dlnubuy_classification` VALUES ('63', '口琴', '501010', '3', '501000');
INSERT INTO `dlnubuy_classification` VALUES ('64', '吉他', '501020', '3', '501000');
INSERT INTO `dlnubuy_classification` VALUES ('65', '乐器配件', '501030', '3', '501000');
INSERT INTO `dlnubuy_classification` VALUES ('66', '手链', '502010', '3', '502000');
INSERT INTO `dlnubuy_classification` VALUES ('67', '耳饰', '502020', '3', '502000');
INSERT INTO `dlnubuy_classification` VALUES ('68', '其他', '502030', '3', '502000');
INSERT INTO `dlnubuy_classification` VALUES ('69', '财会类考试', '101041', '4', '101040');
INSERT INTO `dlnubuy_classification` VALUES ('70', '建筑类考试', '101042', '4', '101040');
INSERT INTO `dlnubuy_classification` VALUES ('71', '申论', '101031', '4', '101030');
INSERT INTO `dlnubuy_classification` VALUES ('72', '行测', '101032', '4', '101030');
INSERT INTO `dlnubuy_classification` VALUES ('73', '鞋架', '201011', '4', '201010');
INSERT INTO `dlnubuy_classification` VALUES ('74', '衣帽架', '201021', '4', '201020');
INSERT INTO `dlnubuy_classification` VALUES ('75', '收纳用品', '201031', '4', '201030');
INSERT INTO `dlnubuy_classification` VALUES ('76', '书柜', '202011', '4', '202010');
INSERT INTO `dlnubuy_classification` VALUES ('77', '书架', '202012', '4', '202010');
INSERT INTO `dlnubuy_classification` VALUES ('78', '书桌', '202021', '4', '202020');
INSERT INTO `dlnubuy_classification` VALUES ('79', '电脑桌椅', '202031', '4', '202030');
INSERT INTO `dlnubuy_classification` VALUES ('80', '充电台灯', '203011', '4', '203010');
INSERT INTO `dlnubuy_classification` VALUES ('81', '射灯', '203021', '4', '203020');
INSERT INTO `dlnubuy_classification` VALUES ('82', '小锅', '204011', '4', '204010');
INSERT INTO `dlnubuy_classification` VALUES ('83', '水壶', '204021', '4', '204020');
INSERT INTO `dlnubuy_classification` VALUES ('84', '茶具', '204031', '4', '204030');
INSERT INTO `dlnubuy_classification` VALUES ('85', '整理箱', '205011', '4', '205010');
INSERT INTO `dlnubuy_classification` VALUES ('86', '螺丝刀', '205021', '4', '205020');
INSERT INTO `dlnubuy_classification` VALUES ('87', '公猫', '301011', '4', '301010');
INSERT INTO `dlnubuy_classification` VALUES ('88', '母猫', '301012', '4', '301010');
INSERT INTO `dlnubuy_classification` VALUES ('89', '公狗', '302011', '4', '302010');
INSERT INTO `dlnubuy_classification` VALUES ('90', '母狗', '302012', '4', '302010');
INSERT INTO `dlnubuy_classification` VALUES ('91', '公猫', '301021', '4', '301020');
INSERT INTO `dlnubuy_classification` VALUES ('92', '母猫', '301022', '4', '301020');
INSERT INTO `dlnubuy_classification` VALUES ('93', '公狗', '302021', '4', '302020');
INSERT INTO `dlnubuy_classification` VALUES ('94', '母狗', '302022', '4', '302020');
INSERT INTO `dlnubuy_classification` VALUES ('95', '野生', '303011', '4', '303010');
INSERT INTO `dlnubuy_classification` VALUES ('96', '家养', '303021', '4', '303020');
INSERT INTO `dlnubuy_classification` VALUES ('97', '多人帐篷', '401011', '4', '401010');
INSERT INTO `dlnubuy_classification` VALUES ('98', '双人帐篷', '401012', '4', '401010');
INSERT INTO `dlnubuy_classification` VALUES ('99', '户外登山包', '401021', '4', '401010');
INSERT INTO `dlnubuy_classification` VALUES ('100', '单人睡袋', '401031', '4', '401030');
INSERT INTO `dlnubuy_classification` VALUES ('101', '多人睡袋', '401032', '4', '401030');
INSERT INTO `dlnubuy_classification` VALUES ('102', '登山工具', '401041', '4', '401040');
INSERT INTO `dlnubuy_classification` VALUES ('103', '垂钓工具', '401042', '4', '401040');
INSERT INTO `dlnubuy_classification` VALUES ('104', '篮球', '402011', '4', '402010');
INSERT INTO `dlnubuy_classification` VALUES ('105', '足球', '402021', '4', '402020');
INSERT INTO `dlnubuy_classification` VALUES ('106', '乒乓球', '402031', '4', '402030');
INSERT INTO `dlnubuy_classification` VALUES ('107', '网球', '402041', '4', '402040');
INSERT INTO `dlnubuy_classification` VALUES ('108', '轮滑用品', '402051', '4', '402050');
INSERT INTO `dlnubuy_classification` VALUES ('109', '羽毛球', '402061', '4', '402060');
INSERT INTO `dlnubuy_classification` VALUES ('110', '其他', '402071', '4', '402070');
INSERT INTO `dlnubuy_classification` VALUES ('111', '口琴', '501011', '4', '501010');
INSERT INTO `dlnubuy_classification` VALUES ('112', '吉他', '501021', '4', '501020');
INSERT INTO `dlnubuy_classification` VALUES ('113', '各种配件', '501031', '4', '501030');
INSERT INTO `dlnubuy_classification` VALUES ('114', '各种手链', '502011', '4', '502010');
INSERT INTO `dlnubuy_classification` VALUES ('115', '各种挂饰', '502021', '4', '502020');
INSERT INTO `dlnubuy_classification` VALUES ('116', '其它', '502031', '4', '502030');

-- ----------------------------
-- Table structure for dlnubuy_product
-- ----------------------------
DROP TABLE IF EXISTS `dlnubuy_product`;
CREATE TABLE `dlnubuy_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pdname` varchar(200) NOT NULL,
  `money` int(11) NOT NULL,
  `begintime` datetime NOT NULL,
  `description` longtext NOT NULL,
  `requirement` longtext NOT NULL,
  `category` int(11) NOT NULL,
  `pdimg` varchar(100) NOT NULL,
  `pdimg2` varchar(100) NOT NULL,
  `pdimg3` varchar(100) NOT NULL,
  `userid` int(11) NOT NULL,
  `likes` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dlnubuy_product
-- ----------------------------
INSERT INTO `dlnubuy_product` VALUES ('37', 'test1', '151', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_100_226.jpg', 'static/images/warp/warp_101_226.jpg', 'static/images/warp/000001.jpg', '1', '666');
INSERT INTO `dlnubuy_product` VALUES ('38', 'test2', '152', '2015-05-02 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_101_226.jpg', 'static/images/warp/warp_102_226.jpg', 'static/images/warp/000001.jpg', '1', '999');
INSERT INTO `dlnubuy_product` VALUES ('39', 'test3', '153', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_102_226.jpg', 'static/images/warp/warp_103_226.jpg', 'static/images/warp/000001.jpg', '1', '111');
INSERT INTO `dlnubuy_product` VALUES ('40', 'test4', '154', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_103_226.jpg', 'static/images/warp/warp_104_226.jpg', 'static/images/warp/000001.jpg', '1', '222');
INSERT INTO `dlnubuy_product` VALUES ('41', 'test5', '155', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_104_226.jpg', 'static/images/warp/warp_105_226.jpg', 'static/images/warp/000001.jpg', '1', '333');
INSERT INTO `dlnubuy_product` VALUES ('42', 'test6', '156', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_105_226.jpg', 'static/images/warp/warp_106_226.jpg', 'static/images/warp/000001.jpg', '1', '444');
INSERT INTO `dlnubuy_product` VALUES ('43', 'test7', '157', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_106_226.jpg', 'static/images/warp/warp_107_226.jpg', 'static/images/warp/000001.jpg', '1', '555');
INSERT INTO `dlnubuy_product` VALUES ('44', 'test8', '158', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_107_226.jpg', 'static/images/warp/warp_108_226.jpg', 'static/images/warp/000001.jpg', '1', '666');
INSERT INTO `dlnubuy_product` VALUES ('45', 'test9', '159', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_108_226.jpg', 'static/images/warp/warp_109_226.jpg', 'static/images/warp/000001.jpg', '2', '777');
INSERT INTO `dlnubuy_product` VALUES ('46', 'test10', '160', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_109_226.jpg', 'static/images/warp/warp_110_226.jpg', 'static/images/warp/000001.jpg', '2', '888');
INSERT INTO `dlnubuy_product` VALUES ('47', 'test11', '161', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_110_226.jpg', 'static/images/warp/warp_111_226.jpg', 'static/images/warp/000001.jpg', '2', '999');
INSERT INTO `dlnubuy_product` VALUES ('48', 'test12', '162', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_111_226.jpg', 'static/images/warp/warp_112_226.jpg', 'static/images/warp/000001.jpg', '2', '11');
INSERT INTO `dlnubuy_product` VALUES ('49', 'test13', '163', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_112_226.jpg', 'static/images/warp/warp_113_226.jpg', 'static/images/warp/000001.jpg', '2', '22');
INSERT INTO `dlnubuy_product` VALUES ('50', 'test14', '164', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_113_226.jpg', 'static/images/warp/warp_114_226.jpg', 'static/images/warp/000001.jpg', '2', '33');
INSERT INTO `dlnubuy_product` VALUES ('51', 'test15', '165', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_114_226.jpg', 'static/images/warp/warp_115_226.jpg', 'static/images/warp/000001.jpg', '2', '44');
INSERT INTO `dlnubuy_product` VALUES ('52', 'test16', '166', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_115_226.jpg', 'static/images/warp/warp_116_226.jpg', 'static/images/warp/000001.jpg', '2', '55');
INSERT INTO `dlnubuy_product` VALUES ('53', 'test17', '167', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_116_226.jpg', 'static/images/warp/warp_117_226.jpg', 'static/images/warp/000001.jpg', '2', '66');
INSERT INTO `dlnubuy_product` VALUES ('54', 'test18', '168', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_117_226.jpg', 'static/images/warp/warp_118_226.jpg', 'static/images/warp/000001.jpg', '2', '77');
INSERT INTO `dlnubuy_product` VALUES ('55', 'test19', '169', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_118_226.jpg', 'static/images/warp/warp_119_226.jpg', 'static/images/warp/000001.jpg', '2', '88');
INSERT INTO `dlnubuy_product` VALUES ('56', 'test20', '170', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_119_226.jpg', 'static/images/warp/warp_120_226.jpg', 'static/images/warp/000001.jpg', '2', '99');
INSERT INTO `dlnubuy_product` VALUES ('57', 'test21', '171', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_120_226.jpg', 'static/images/warp/warp_121_226.jpg', 'static/images/warp/000001.jpg', '2', '100');
INSERT INTO `dlnubuy_product` VALUES ('58', 'test22', '172', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '101011', 'static/images/warp/warp_121_226.jpg', 'static/images/warp/warp_122_226.jpg', 'static/images/warp/000001.jpg', '2', '200');
INSERT INTO `dlnubuy_product` VALUES ('59', 'test23', '173', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_122_226.jpg', 'static/images/warp/warp_123_226.jpg', 'static/images/warp/000001.jpg', '2', '300');
INSERT INTO `dlnubuy_product` VALUES ('60', 'test24', '174', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_123_226.jpg', 'static/images/warp/warp_124_226.jpg', 'static/images/warp/000001.jpg', '2', '400');
INSERT INTO `dlnubuy_product` VALUES ('61', 'test25', '175', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_124_226.jpg', 'static/images/warp/warp_125_226.jpg', 'static/images/warp/000001.jpg', '2', '500');
INSERT INTO `dlnubuy_product` VALUES ('62', 'test26', '176', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_125_226.jpg', 'static/images/warp/warp_126_226.jpg', 'static/images/warp/000001.jpg', '2', '600');
INSERT INTO `dlnubuy_product` VALUES ('63', 'test27', '177', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_126_226.jpg', 'static/images/warp/warp_127_226.jpg', 'static/images/warp/000001.jpg', '2', '700');
INSERT INTO `dlnubuy_product` VALUES ('64', 'test28', '178', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_127_226.jpg', 'static/images/warp/warp_128_226.jpg', 'static/images/warp/000001.jpg', '2', '800');
INSERT INTO `dlnubuy_product` VALUES ('65', 'test29', '179', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_128_226.jpg', 'static/images/warp/warp_129_226.jpg', 'static/images/warp/000001.jpg', '2', '900');
INSERT INTO `dlnubuy_product` VALUES ('66', 'test30', '180', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_129_226.jpg', 'static/images/warp/warp_130_226.jpg', 'static/images/warp/000001.jpg', '2', '50');
INSERT INTO `dlnubuy_product` VALUES ('67', 'test31', '181', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_130_226.jpg', 'static/images/warp/warp_131_226.jpg', 'static/images/warp/000001.jpg', '2', '60');
INSERT INTO `dlnubuy_product` VALUES ('68', 'test32', '182', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_131_226.jpg', 'static/images/warp/warp_132_226.jpg', 'static/images/warp/000001.jpg', '2', '70');
INSERT INTO `dlnubuy_product` VALUES ('69', 'test33', '183', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_132_226.jpg', 'static/images/warp/warp_133_226.jpg', 'static/images/warp/000001.jpg', '2', '80');
INSERT INTO `dlnubuy_product` VALUES ('70', 'test34', '184', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_133_226.jpg', 'static/images/warp/warp_134_226.jpg', 'static/images/warp/000001.jpg', '2', '90');
INSERT INTO `dlnubuy_product` VALUES ('71', 'test35', '185', '2015-05-01 03:28:14', '这些是导入的测试数据', '这些是导入的测试数据', '102011', 'static/images/warp/warp_134_226.jpg', 'static/images/warp/warp_135_226.jpg', 'static/images/warp/000001.jpg', '2', '88');

-- ----------------------------
-- Table structure for dlnubuy_users
-- ----------------------------
DROP TABLE IF EXISTS `dlnubuy_users`;
CREATE TABLE `dlnubuy_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `userphone` varchar(50) NOT NULL,
  `registration_date` datetime NOT NULL,
  `schoolAddress` varchar(200) NOT NULL,
  `userimg` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dlnubuy_users
-- ----------------------------
INSERT INTO `dlnubuy_users` VALUES ('1', 'jonnyf', '123456', '18642636963', '2015-03-26 01:38:23', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('2', 'test1', '123456', '18642636963', '2015-04-02 03:09:26', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('3', 'test2', '123456', '18642636963', '2015-04-02 03:09:26', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('4', 'test3', '123456', '18642636963', '2015-04-02 03:09:26', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('5', 'test4', '123456', '18642636963', '2015-04-02 03:09:26', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('6', 'test5', '123456', '18642636963', '2015-04-02 03:09:26', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('7', 'test6', '123456', '18642636963', '2015-04-02 03:09:26', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('8', 'test7', '123456', '18642636963', '2015-04-02 03:09:26', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('9', 'test8', '123456', '18642636963', '2015-04-02 03:09:26', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('10', 'test9', '123456', '18642636963', '2015-04-02 03:09:26', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('11', 'test10', '123456', '18642636963', '2015-04-02 03:09:26', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('12', '123456', 'ODNDMDLDKDJD', '18642636963', '2015-04-29 06:24:01', '金石滩校区', 'static/images/users/user.jpg');
INSERT INTO `dlnubuy_users` VALUES ('13', '付会翔', 'ODNDMDLDKDJD', '18642636964', '2015-04-29 06:24:01', '金石滩校区', 'static/images/users/user.jpg');
