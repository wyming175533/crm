/*
Navicat MySQL Data Transfer

Source Server         : localhost：3306
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2022-03-11 21:16:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_activity
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity
-- ----------------------------
INSERT INTO `tbl_activity` VALUES ('3e89df9c146e4e4b864a2c5bb4cddf62', '06f5fc056eac41558a964f96daa7f27c', '寻找李四1', '2022-03-05', '2022-03-09', '321', '111', '2022-03-05 20:30:08', '李四', null, null);
INSERT INTO `tbl_activity` VALUES ('de4766a0c37d47289b43e960c52ff190', '06f5fc056eac41558a964f96daa7f27c', '寻找李四2', '2022-03-05', '2022-03-17', '300', '1111', '2022-03-05 20:28:07', '李四', null, null);
INSERT INTO `tbl_activity` VALUES ('fa90f17bfe79448aaa925626003317f9', '06f5fc056eac41558a964f96daa7f27c', '寻找李四3', '2022-03-02', '2022-03-16', '11', '22', '2022-03-04 18:24:47', '李四', null, null);
INSERT INTO `tbl_activity` VALUES ('fa90f17bfe79448aaa925626003317oo', '40f6cdea0bd34aceb77492a1656d9fb3', '寻找李四4', '2022-03-05', '2022-03-18', '34', '34', '2022-03-04 18:24:49', '李四', null, null);

-- ----------------------------
-- Table structure for tbl_activity_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity_remark
-- ----------------------------
INSERT INTO `tbl_activity_remark` VALUES ('3e89df9c146e4e4b864a2c5bb4cddf62', '市场活动备注1', '2022-03-05', '2022-03-09', null, null, '0', '3e89df9c146e4e4b864a2c5bb4cddf62');
INSERT INTO `tbl_activity_remark` VALUES ('3e89df9c146e4e4b864a2c5bb4cddf63', '市场活动备注2', '2022-03-06', '2022-03-09', null, null, '0', '3e89df9c146e4e4b864a2c5bb4cddf62');
INSERT INTO `tbl_activity_remark` VALUES ('3e89df9c146e4e4b864a2c5bb4cddf64', '市场活动备注3', '2022-03-07', '2022-03-09', null, null, '0', '3e89df9c146e4e4b864a2c5bb4cddf62');
INSERT INTO `tbl_activity_remark` VALUES ('3e89df9c146e4e4b864a2c5bb4cddf65', '市场活动备注4', '2022-03-08', '2022-03-09', null, null, '0', 'de4766a0c37d47289b43e960c52ff190');

-- ----------------------------
-- Table structure for tbl_clue
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue
-- ----------------------------
INSERT INTO `tbl_clue` VALUES ('3e89df9c146e4e4b864a2c5bb4cddf64', '李四', '博士', '06f5fc056eac41558a964f96daa7f27c', '百度', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for tbl_clue_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_activity_relation
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_clue_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_remark
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_contacts
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts
-- ----------------------------
INSERT INTO `tbl_contacts` VALUES ('ad09124f9d184ff49e13241183442ef9', '06f5fc056eac41558a964f96daa7f27c', '内部研讨会', '80e8291443634830a89ff957e1d10ac0', '李四', '先生', '123', '123', 'ceo', null, '李四', '2022-03-10 10:44:10', null, null, '123', '123', '2022-03-05', '123');

-- ----------------------------
-- Table structure for tbl_contacts_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_activity_relation
-- ----------------------------
INSERT INTO `tbl_contacts_activity_relation` VALUES ('1e7bd429a5e644da838e0350e4f8e91a', 'ad09124f9d184ff49e13241183442ef9', '3e89df9c146e4e4b864a2c5bb4cddf62');

-- ----------------------------
-- Table structure for tbl_contacts_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_remark
-- ----------------------------
INSERT INTO `tbl_contacts_remark` VALUES ('cced15a0cd5041f5a7af1b68849dd660', null, '李四', '2022-03-10 10:44:10', null, null, null, 'ad09124f9d184ff49e13241183442ef9');

-- ----------------------------
-- Table structure for tbl_customer
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('80e8291443634830a89ff957e1d10ac0', '06f5fc056eac41558a964f96daa7f27c', '泰坦尼克号', '123', '123', '李四', '2022-03-10 10:44:10', null, null, '123', '2022-03-05', '123', '123');
INSERT INTO `tbl_customer` VALUES ('923f51f4eb8a47b181a7607466a86096', '06f5fc056eac41558a964f96daa7f27c', '新建', null, null, '李四', '2022-03-10 19:23:04', null, null, '22222222', '2022-03-16', '22222222', null);
INSERT INTO `tbl_customer` VALUES ('d3c5d65df81c46a1a3ce85f2b5fe419e', '06f5fc056eac41558a964f96daa7f27c', '', null, null, '李四', '2022-03-11 21:11:41', null, null, '', '2022-03-08', '', null);
INSERT INTO `tbl_customer` VALUES ('eda92c0b08d44ee98f4e6564f7812f6e', '06f5fc056eac41558a964f96daa7f27c', '1', null, null, '李四', '2022-03-11 21:12:01', null, null, '', '', '', null);

-- ----------------------------
-- Table structure for tbl_customer_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer_remark
-- ----------------------------
INSERT INTO `tbl_customer_remark` VALUES ('af7c46dd62e7494e879c6883dc68d057', null, '李四', '2022-03-10 10:44:10', null, null, '0', '80e8291443634830a89ff957e1d10ac0');

-- ----------------------------
-- Table structure for tbl_dic_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '编码是主键，不能为空，不能含有中文。',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_type
-- ----------------------------
INSERT INTO `tbl_dic_type` VALUES ('appellation', '称呼', '');
INSERT INTO `tbl_dic_type` VALUES ('clueState', '线索状态', '');
INSERT INTO `tbl_dic_type` VALUES ('returnPriority', '回访优先级', '');
INSERT INTO `tbl_dic_type` VALUES ('returnState', '回访状态', '');
INSERT INTO `tbl_dic_type` VALUES ('source', '来源', '');
INSERT INTO `tbl_dic_type` VALUES ('stage', '阶段', '');
INSERT INTO `tbl_dic_type` VALUES ('transactionType', '交易类型', '');

-- ----------------------------
-- Table structure for tbl_dic_value
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT '主键，采用UUID',
  `value` varchar(255) DEFAULT NULL COMMENT '不能为空，并且要求同一个字典类型下字典值不能重复，具有唯一性。',
  `text` varchar(255) DEFAULT NULL COMMENT '可以为空',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '可以为空，但不为空的时候，要求必须是正整数',
  `typeCode` varchar(255) DEFAULT NULL COMMENT '外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_value
-- ----------------------------
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source');
INSERT INTO `tbl_dic_value` VALUES ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source');
INSERT INTO `tbl_dic_value` VALUES ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('29805c804dd94974b568cfc9017b2e4c', '07成交', '07成交', '7', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('310e6a49bd8a4962b3f95a1d92eb76f4', '试图联系', '试图联系', '1', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('37ef211719134b009e10b7108194cf46', '01资质审查', '01资质审查', '1', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('391807b5324d4f16bd58c882750ee632', '08丢失的线索', '08丢失的线索', '8', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source');
INSERT INTO `tbl_dic_value` VALUES ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source');
INSERT INTO `tbl_dic_value` VALUES ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source');
INSERT INTO `tbl_dic_value` VALUES ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('68a1b1e814d5497a999b8f1298ace62b', '09因竞争丢失关闭', '09因竞争丢失关闭', '9', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source');
INSERT INTO `tbl_dic_value` VALUES ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source');
INSERT INTO `tbl_dic_value` VALUES ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source');
INSERT INTO `tbl_dic_value` VALUES ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('9ff57750fac04f15b10ce1bbb5bb8bab', '02需求分析', '02需求分析', '2', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('ab8c2a3dc05f4e3dbc7a0405f721b040', '05提案/报价', '05提案/报价', '5', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source');
INSERT INTO `tbl_dic_value` VALUES ('c13ad8f9e2f74d5aa84697bb243be3bb', '03价值建议', '03价值建议', '3', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source');
INSERT INTO `tbl_dic_value` VALUES ('e44be1d99158476e8e44778ed36f4355', '04确定决策者', '04确定决策者', '4', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('e81577d9458f4e4192a44650a3a3692b', '06谈判/复审', '06谈判/复审', '6', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source');
INSERT INTO `tbl_dic_value` VALUES ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');

-- ----------------------------
-- Table structure for tbl_tran
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran
-- ----------------------------
INSERT INTO `tbl_tran` VALUES ('045d32b4808a4db5afde52e8f488e814', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '01资质审查', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:14:10', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('14f9e6f0964e4a65bb0529f2bf80e8dc', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '07成交', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:13:04', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('1a50141e342a4b7e823c5b1a003ac159', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '02需求分析', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:14:14', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('27ce53214c874ce698a6f7be60f97c7f', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '09因竞争丢失关闭', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:12:15', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('2dc8cca2991d4ccbb2f6690faf317e33', '06f5fc056eac41558a964f96daa7f27c', '212', '大项目', '2022-02-17', null, '03价值建议', '新业务', '外部介绍', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-10 19:23:04', null, null, '22222222', '22222222', '2022-03-16');
INSERT INTO `tbl_tran` VALUES ('36346edb223a473288234b40f643e411', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '02需求分析', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:13:43', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('374c5d13696d4aabacf00ee4e1c2a088', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '07成交', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:14:27', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('44f991835c7a409ba7ebffde4d9a1411', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '06谈判/复审', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:13:57', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('47927cebffc643b69a40c0c94de81270', null, null, null, null, null, null, null, null, null, null, '李四', '2022-03-10 18:09:42', null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('7ef9d79a5027448ea8ce9653cdecf7f3', '06f5fc056eac41558a964f96daa7f27c', '11111111111', '好东西', '1899-12-12', '80e8291443634830a89ff957e1d10ac0', '03价值建议', null, '内部研讨会', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-10 10:44:10', '李四', '2022-03-11 17:35:27', '123', '123', '2022-03-05');
INSERT INTO `tbl_tran` VALUES ('8814ab88c2204a2c86c65899f67493c2', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '02需求分析', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:12:54', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('8bb9ad24c5714a64b2a861b882ce2a35', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '01资质审查', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:13:22', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('92a45101fdfe496dbd41cb5a141d0e17', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '02需求分析', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:13:26', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('935b647ef329403a9df3702b785cda16', '06f5fc056eac41558a964f96daa7f27c', '100000', '阿里把把', '2022-03-16', null, '02需求分析', '已有业务', '外部介绍', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:11:41', null, null, '', '', '2022-03-08');
INSERT INTO `tbl_tran` VALUES ('93f357a6801d4466bd2916a3e87db34b', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '06谈判/复审', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:12:25', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('986351b369224a8ca1195609c450e260', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '03价值建议', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:13:47', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('b09ecda9dc244a6c84b278824f8696a4', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '01资质审查', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:14:18', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('b3bc0eb30b214295b3220271160dcf9e', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '03价值建议', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:12:30', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('b633a60021824c57990b5688f570cff8', '06f5fc056eac41558a964f96daa7f27c', '22222222222', 'aa', '1899-12-19', null, '03价值建议', '已有业务', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:12:01', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('bf0f4b6316c54d9883f72114b60f2a19', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '07成交', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:14:02', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('bf8f4648e28e4768be796c1130311fdc', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '05提案/报价', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:12:57', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('c203152d738343319b13e06c08483218', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '01资质审查', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:14:06', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('c3f8a7408a9e413ab5a9fa83b49b60f8', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '05提案/报价', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:12:21', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('cfc7b757852c435183ba5e77a78ea7a4', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '05提案/报价', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:13:52', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('d1d15491e29742088699ca40425f0372', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '07成交', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:12:10', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('df750cefc73a42d4a6a0199fe3344c6a', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '01资质审查', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:12:07', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('e1d8e2d3c27944f18d656a50f70f1bb5', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '05提案/报价', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:14:23', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('ef06a8395adc47668f6710677beabc51', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '06谈判/复审', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:13:01', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('f33dd3806faf4566b57212a0d32f24f0', '06f5fc056eac41558a964f96daa7f27c', '', '', '', 'd3c5d65df81c46a1a3ce85f2b5fe419e', '01资质审查', '', '', '3e89df9c146e4e4b864a2c5bb4cddf62', 'ad09124f9d184ff49e13241183442ef9', '李四', '2022-03-11 21:12:50', null, null, '', '', '');

-- ----------------------------
-- Table structure for tbl_tran_history
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_history
-- ----------------------------
INSERT INTO `tbl_tran_history` VALUES ('1aa703e974964ca5ac40a13b91d68ca3', '07成交', '11111111111', '1899-12-12', '2022-03-11 17:35:24', '李四', '7ef9d79a5027448ea8ce9653cdecf7f3');
INSERT INTO `tbl_tran_history` VALUES ('2d10503d556d4658aa2457225c5a0482', '02需求分析', '', '', '2022-03-11 21:12:54', '李四', '8814ab88c2204a2c86c65899f67493c2');
INSERT INTO `tbl_tran_history` VALUES ('343430130f5a407a8c21bf8069b5ce09', '01资质审查', '', '', '2022-03-11 21:14:18', '李四', 'b09ecda9dc244a6c84b278824f8696a4');
INSERT INTO `tbl_tran_history` VALUES ('3762222831e443f7873f5ce50419d7ff', '05提案/报价', '11111111111', '1899-12-12', '2022-03-11 17:34:22', '李四', '7ef9d79a5027448ea8ce9653cdecf7f3');
INSERT INTO `tbl_tran_history` VALUES ('3a612b04c03141088740d1d894321411', '05提案/报价', '', '', '2022-03-11 21:12:57', '李四', 'bf8f4648e28e4768be796c1130311fdc');
INSERT INTO `tbl_tran_history` VALUES ('4464e749748b468aa305ba1fddac472f', '05提案/报价', '', '', '2022-03-11 21:12:21', '李四', 'c3f8a7408a9e413ab5a9fa83b49b60f8');
INSERT INTO `tbl_tran_history` VALUES ('47580fc0e19c46ff8364706f9d4e1d2b', '07成交', '11111111111', '1899-12-12', '2022-03-10 10:44:10', '李四', '7ef9d79a5027448ea8ce9653cdecf7f3');
INSERT INTO `tbl_tran_history` VALUES ('556dda53d49d464a94eab7b5b15791bc', '01资质审查', '', '', '2022-03-11 21:12:50', '李四', 'f33dd3806faf4566b57212a0d32f24f0');
INSERT INTO `tbl_tran_history` VALUES ('608304157c524b9dafc0bc5dba5bd8b3', '02需求分析', '', '', '2022-03-11 21:13:26', '李四', '92a45101fdfe496dbd41cb5a141d0e17');
INSERT INTO `tbl_tran_history` VALUES ('6542d4ae861d40228e48ba6d67ca40a9', '02需求分析', '', '', '2022-03-11 21:14:14', '李四', '1a50141e342a4b7e823c5b1a003ac159');
INSERT INTO `tbl_tran_history` VALUES ('69322aabf4154ac7a79d4a9a066cf1cf', '01资质审查', '', '', '2022-03-11 21:14:06', '李四', 'c203152d738343319b13e06c08483218');
INSERT INTO `tbl_tran_history` VALUES ('721064dca1b34ed8bf57f213d07aa935', '05提案/报价', '', '', '2022-03-11 21:14:23', '李四', 'e1d8e2d3c27944f18d656a50f70f1bb5');
INSERT INTO `tbl_tran_history` VALUES ('721e7e882ae744af956e933b06181aa5', '03价值建议', '', '', '2022-03-11 21:13:47', '李四', '986351b369224a8ca1195609c450e260');
INSERT INTO `tbl_tran_history` VALUES ('745b5b9fd8f9457ab8a5434c3b1c979d', '01资质审查', '', '', '2022-03-11 21:12:07', '李四', 'df750cefc73a42d4a6a0199fe3344c6a');
INSERT INTO `tbl_tran_history` VALUES ('7b4d18c0c4894f5e960101e2c04b810c', '03价值建议', '', '', '2022-03-11 21:12:30', '李四', 'b3bc0eb30b214295b3220271160dcf9e');
INSERT INTO `tbl_tran_history` VALUES ('9214f5a60b474171b5f9d88ed7da3527', '04确定决策者', '11111111111', '1899-12-12', '2022-03-11 16:46:11', '李四', '7ef9d79a5027448ea8ce9653cdecf7f3');
INSERT INTO `tbl_tran_history` VALUES ('9bacdd2b7ba64ad5825df97b39802782', '07成交', '', '', '2022-03-11 21:14:02', '李四', 'bf0f4b6316c54d9883f72114b60f2a19');
INSERT INTO `tbl_tran_history` VALUES ('9be615f534ac461095efa45a7943cbe7', '06谈判/复审', '11111111111', '1899-12-12', '2022-03-11 17:35:19', '李四', '7ef9d79a5027448ea8ce9653cdecf7f3');
INSERT INTO `tbl_tran_history` VALUES ('9be81ec558154cf6af681e11c5c82f7d', '01资质审查', '', '', '2022-03-11 21:14:10', '李四', '045d32b4808a4db5afde52e8f488e814');
INSERT INTO `tbl_tran_history` VALUES ('a8ceb10f16d94c749ee1478bd2426c3c', '03价值建议', '11111111111', '1899-12-12', '2022-03-11 17:35:27', '李四', '7ef9d79a5027448ea8ce9653cdecf7f3');
INSERT INTO `tbl_tran_history` VALUES ('aa2ad4856f364cb583fa16821cfb9398', '07成交', '', '', '2022-03-11 21:14:27', '李四', '374c5d13696d4aabacf00ee4e1c2a088');
INSERT INTO `tbl_tran_history` VALUES ('afa6897b6f964c2f924435f8fdd77084', '05提案/报价', '11111111111', '1899-12-12', '2022-03-11 16:44:59', '李四', '7ef9d79a5027448ea8ce9653cdecf7f3');
INSERT INTO `tbl_tran_history` VALUES ('b27dac2c56244f93a09914863392ba99', '06谈判/复审', '', '', '2022-03-11 21:12:25', '李四', '93f357a6801d4466bd2916a3e87db34b');
INSERT INTO `tbl_tran_history` VALUES ('bf66748beb704c24a0e8aa2892482848', '01资质审查', '', '', '2022-03-11 21:13:22', '李四', '8bb9ad24c5714a64b2a861b882ce2a35');
INSERT INTO `tbl_tran_history` VALUES ('c8c49b05f3d04258ae61788cb4c47387', '03价值建议', '22222222222', '1899-12-19', '2022-03-11 21:12:01', '李四', 'b633a60021824c57990b5688f570cff8');
INSERT INTO `tbl_tran_history` VALUES ('cb1732eaf06749409b47bee3e2e460ad', '08丢失的线索', '11111111111', '1899-12-12', '2022-03-11 17:35:25', '李四', '7ef9d79a5027448ea8ce9653cdecf7f3');
INSERT INTO `tbl_tran_history` VALUES ('d2cc8fe360b8497db6d60231e2997c9f', '05提案/报价', '', '', '2022-03-11 21:13:52', '李四', 'cfc7b757852c435183ba5e77a78ea7a4');
INSERT INTO `tbl_tran_history` VALUES ('d4b430516ff442eab4b6cac00ced17bc', '06谈判/复审', '', '', '2022-03-11 21:13:01', '李四', 'ef06a8395adc47668f6710677beabc51');
INSERT INTO `tbl_tran_history` VALUES ('d6680ebbb7f542aa9c6a7f78a6f23ccd', '07成交', '', '', '2022-03-11 21:13:04', '李四', '14f9e6f0964e4a65bb0529f2bf80e8dc');
INSERT INTO `tbl_tran_history` VALUES ('d6c1ba033a6148ada07136d5565b5154', '09因竞争丢失关闭', '', '', '2022-03-11 21:12:15', '李四', '27ce53214c874ce698a6f7be60f97c7f');
INSERT INTO `tbl_tran_history` VALUES ('d9813c1050f34125b6a46326f98db0e0', '02需求分析', '', '', '2022-03-11 21:13:43', '李四', '36346edb223a473288234b40f643e411');
INSERT INTO `tbl_tran_history` VALUES ('e14f242873cd4b599511fb503568a30a', '05提案/报价', '11111111111', '1899-12-12', '2022-03-11 17:35:21', '李四', '7ef9d79a5027448ea8ce9653cdecf7f3');
INSERT INTO `tbl_tran_history` VALUES ('e4ebc6d162664c359d0a7cf5d7f5bbc1', '02需求分析', '100000', '2022-03-16', '2022-03-11 21:11:41', '李四', '935b647ef329403a9df3702b785cda16');
INSERT INTO `tbl_tran_history` VALUES ('eabb9cf8fa25470083ceabca216b0387', '07成交', '', '', '2022-03-11 21:12:10', '李四', 'd1d15491e29742088699ca40425f0372');
INSERT INTO `tbl_tran_history` VALUES ('fb29c48139544ae2bb83b6d041a5ae08', '06谈判/复审', '', '', '2022-03-11 21:13:57', '李四', '44f991835c7a409ba7ebffde4d9a1411');

-- ----------------------------
-- Table structure for tbl_tran_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_remark
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\r\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '202cb962ac59075b964b07152d234b70', 'ls@163.com', '2022-11-27 21:50:05', '1', 'A001', '192.168.1.1，127.0.0.1', '2018-11-22 12:11:40', '李四', null, null);
INSERT INTO `tbl_user` VALUES ('1', '123', '123', '123', null, '2018-11-30 23:50:55', '1', null, '192.168.1.1,192.168.1.2,127.0.0.1', '2018-11-22 11:37:34', null, null, null);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '202cb962ac59075b964b07152d234b70', 'zs@qq.com', '2022-11-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2018-11-22 11:37:34', '张三', null, null);
