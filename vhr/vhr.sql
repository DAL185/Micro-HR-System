/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : vhr

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 25/07/2019 13:19:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for adjustsalary
-- ----------------------------
DROP TABLE IF EXISTS `adjustsalary`;
CREATE TABLE `adjustsalary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL,
  `asDate` date NULL DEFAULT NULL COMMENT '调薪日期',
  `beforeSalary` int(11) NULL DEFAULT NULL COMMENT '调前薪资',
  `afterSalary` int(11) NULL DEFAULT NULL COMMENT '调后薪资',
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调薪原因',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `adjustsalary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of adjustsalary
-- ----------------------------
INSERT INTO `adjustsalary` VALUES (6, 00000004, '2019-07-10', 5000, 6000, 'Work Hard', 'Pip');
INSERT INTO `adjustsalary` VALUES (7, 00000005, '2019-07-14', 8000, 7000, 'Work not hard', 'Pip');
INSERT INTO `adjustsalary` VALUES (8, 00000003, '2019-07-10', 6000, 7000, 'Good attitute', 'Promotion');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `parentId` int(11) NULL DEFAULT NULL,
  `depPath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `enabled` tinyint(1) NULL DEFAULT 1,
  `isParent` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, 'Manager Group', -1, '.1', 1, 1);
INSERT INTO `department` VALUES (4, 'Marketing Group', 1, '.1.4', 1, 1);
INSERT INTO `department` VALUES (5, 'IT Group', 1, '.1.4.5', 1, 1);
INSERT INTO `department` VALUES (8, 'Finance Group', 1, '.1.4.5.8', 1, 0);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `gender` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `idCard` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `wedlock` enum('Married','Unmarried','Divorced') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `nationId` int(8) NULL DEFAULT NULL COMMENT '民族',
  `nativePlace` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '籍贯',
  `politicId` int(20) NULL DEFAULT NULL COMMENT '政治面貌',
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `departmentId` int(20) NULL DEFAULT NULL COMMENT '所属部门',
  `jobLevelId` int(11) NULL DEFAULT NULL COMMENT '职称ID',
  `posId` int(11) NULL DEFAULT NULL COMMENT '职位ID',
  `engageForm` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '聘用形式',
  `tiptopDegree` enum('Phd','Master','Bachelor','College','High School','junior high school','Primary School','Other') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最高学历',
  `specialty` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属专业',
  `school` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业院校',
  `beginDate` date NULL DEFAULT NULL COMMENT '入职日期',
  `workState` enum('On-the-job','Off-the-job') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'On-the-job' COMMENT '在职状态',
  `workID` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号',
  `contractTerm` double NULL DEFAULT NULL COMMENT '合同期限',
  `conversionTime` date NULL DEFAULT NULL COMMENT '转正日期',
  `notWorkDate` date NULL DEFAULT NULL COMMENT '离职日期',
  `beginContract` date NULL DEFAULT NULL COMMENT '合同起始日期',
  `endContract` date NULL DEFAULT NULL COMMENT '合同终止日期',
  `workAge` int(11) NULL DEFAULT NULL COMMENT '工龄',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `departmentId`(`departmentId`) USING BTREE,
  INDEX `jobId`(`jobLevelId`) USING BTREE,
  INDEX `dutyId`(`posId`) USING BTREE,
  INDEX `nationId`(`nationId`) USING BTREE,
  INDEX `politicId`(`politicId`) USING BTREE,
  INDEX `workID_key`(`workID`) USING BTREE,
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`departmentId`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`jobLevelId`) REFERENCES `joblevel` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`posId`) REFERENCES `position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_4` FOREIGN KEY (`nationId`) REFERENCES `nation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_5` FOREIGN KEY (`politicId`) REFERENCES `politicsstatus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1524 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, 'David', 'M', '1990-01-01', '610122199001011256', 'Married', 1, 'Pittsburgh', 13, 'laowang@qq.com', '18565558897', '3245 Parkview Ave', 1, 9, 29, 'Contract', 'Bachelor', 'Information Science', 'University of Pittsburgh', '2018-01-01', 'On-the-job', '00000001', 2, '2018-04-01', NULL, '2018-01-01', '2020-01-01', NULL);
INSERT INTO `employee` VALUES (2, 'Peter', 'M', '1989-02-01', '421288198902011234', 'Married', 1, 'Cleveland', 1, 'chenjing@qq.com', '18795556693', '1000 Pen Ave', 1, 10, 30, 'Contract', 'High School', 'Marketing', 'Carnegie Mellon University', '2015-06-09', 'On-the-job', '00000002', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (3, 'Mary', 'F', '1993-03-04', '610122199303041456', 'Married', 1, 'Dallas', 3, 'zhao@qq.com', '15698887795', '5224 Forbes Ave', 1, 10, 33, 'Staff', 'Phd', 'Marketing', 'University of Pittsburgh', '2018-01-01', 'On-the-job', '00000003', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (4, 'Doris', 'F', '1990-01-03', '610122199001031456', 'Married', 1, 'Miami', 3, 'zhao@qq.com', '15612347795', '174 Smallman St', 4, 12, 34, 'Staff', 'Master', 'Math', 'University of Pittsburgh', '2018-01-01', 'On-the-job', '00000004', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (5, 'William', 'M', '1991-02-05', '610122199102058952', 'Divorced', 1, 'Orlando', 3, 'yaosen@qq.com', '14785559936', '3452 Dowson St', 5, 17, 34, 'Staff', 'Master', 'Pharmacy', 'Carnegie Mellon University', '2017-01-02', 'On-the-job', '00000005', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (6, 'Bill', 'M', '1993-01-05', '610122199301054789', 'Married', 1, 'New York', 1, 'yunxing@qq.com', '15644442252', '500 Schlney Dr', 4, 16, 34, 'Contract', 'Bachelor', 'Electronic Engineering', 'University of Pittsburgh', '2018-01-01', 'On-the-job', '00000006', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (7, 'Olivia', 'F', '1993-11-11', '610122199311111234', 'Divorced', 1, 'Cranberry', 4, 'jiaxuming@qq.com', '15644441234', '1900 Blvd of the Allies', 8, 15, 33, 'Staff', 'Bachelor', 'Engineering', 'University of Pittsburgh', '2018-01-01', 'On-the-job', '00000007', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (8, 'Jay', 'M', '1991-02-01', '610144199102014569', 'Divorced', 1, 'Los Angeles', 6, 'zhangliming@qq.com', '18979994478', '9234 Fifth Ave', 4, 15, 33, 'Contract', 'Master', 'History', 'Carnegie Mellon University', '2018-01-01', 'On-the-job', '00000008', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (9, 'Charles', 'M', '1992-07-01', '610144199207017895', 'Divorced', 1, 'Las Vegas', 13, 'xuelei@qq.com', '15648887741', '2389 Fifth Ave', 5, 14, 34, 'Staff', 'Bachelor', 'Education', 'Ohio State University', '2018-01-01', 'On-the-job', '00000009', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (10, 'Laura', 'F', '1990-10-09', '420177199010093652', 'Married', 1, 'Page', 5, 'zhangjie@qq.com', '13695557742', '2344 12th St', 8, 16, 34, 'Contract', 'Bachelor', 'Computer Science', 'Carnegie Mellon University', '2018-01-01', 'On-the-job', '00000010', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (11, 'Lauren', 'F', '1990-01-01', '610122199001011256', 'Married', 1, 'GreenBurgh', 13, 'laowang@qq.com', '18565558897', '4829 Youngman St', 4, 16, 29, 'Contract', 'Master', 'Management Information Systems', 'Penn State University', '2018-01-01', 'On-the-job', '00000011', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (12, 'Alex', 'M', '1989-02-01', '421288198902011234', 'Married', 1, 'JohnBurgh', 1, 'chenjing@qq.com', '18795556693', '7992 Forbes Ave', 5, 12, 30, 'Staff', 'Bachelor', 'Marketing', 'Carnegie Mellon University', '2015-06-09', 'On-the-job', '00000012', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (13, 'Phil', 'M', '1993-03-04', '610122199303041456', 'Unmarried', 1, 'Anabor', 3, 'zhao@qq.com', '15698887795', '2388 Shady Ave', 8, 12, 33, 'Staff', 'Bachelor', 'Information Science', 'Penn State Universit', '2018-01-01', 'On-the-job', '00000013', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (14, 'Nolan', 'M', '1990-01-03', '610122199001031456', 'Unmarried', 1, 'Cleveland', 3, 'zhao@qq.com', '15612347795', '9973 6th Ave', 4, 12, 34, 'Contract', 'Master', 'Information Science', 'Penn State Universit', '2018-01-01', 'On-the-job', '00000014', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (15, 'Dennis', 'M', '1991-02-05', '610122199102058952', 'Married', 1, 'Pittsburgh', 3, 'yaosen@qq.com', '14785559936', '7266 Bigman St', 5, 15, 34, 'Staff', 'Bachelor', 'UI Design', 'Northeast University', '2017-01-02', 'On-the-job', '00000015', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (16, 'Tyrell', 'M', '1993-01-05', '610122199301054789', 'Divorced', 1, 'Orlando', 1, 'yunxing@qq.com', '15644442252', '2376 Robert St', 8, 16, 34, 'Staff', 'Master', 'Information Science', 'MIT', '2018-01-01', 'On-the-job', '00000016', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (17, 'Andrey', 'M', '1993-11-11', '610122199311111234', 'Unmarried', 1, 'Miami', 4, 'jiaxuming@qq.com', '15644441234', '8774 Fifth Ave', 5, 15, 33, 'Staff', 'Bachelor', 'Information Science', 'Harvard University', '2018-01-01', 'On-the-job', '00000017', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (18, 'Amy', 'F', '1991-02-01', '610144199102014569', 'Unmarried', 1, 'Los Angeles', 6, 'zhangliming@qq.com', '18979994478', '7638 Parkview Ave', 91, 15, 33, 'Contract', 'Phd', 'Computer Science', 'Boston University', '2018-01-01', 'On-the-job', '00000018', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (19, 'Jason', 'M', '1992-07-01', '610144199207017895', 'Unmarried', 1, 'Dallas', 13, 'xuelei@qq.com', '15648887741', '9873 Parkview Ave', 4, 14, 34, 'Staff', 'Bachelor', 'Math', 'MIT', '2018-01-01', 'On-the-job', '00000019', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (20, 'Ana', 'F', '1990-10-09', '420177199010093652', 'Unmarried', 1, 'Dallas', 5, 'zhangjie@qq.com', '13695557742', '9877 Forbes Ave', 8, 16, 34, 'Contract', 'Phd', 'Math', 'MIT', '2018-01-01', 'On-the-job', '00000020', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);


-- ----------------------------
-- Table structure for employeeec
-- ----------------------------
DROP TABLE IF EXISTS `employeeec`;
CREATE TABLE `employeeec`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL COMMENT '员工编号',
  `ecDate` date NULL DEFAULT NULL COMMENT '奖罚日期',
  `ecReason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '奖罚原因',
  `ecPoint` int(11) NULL DEFAULT NULL COMMENT '奖罚分',
  `ecType` int(11) NULL DEFAULT NULL COMMENT '奖罚类别，0：Reward，1：Punishment',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `employeeec_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employeeec
-- ----------------------------
INSERT INTO `employeeec` VALUES (1, 1, '2019-06-20', 'Late of Work', NULL, NULL, 'qqn');
INSERT INTO `employeeec` VALUES (2, 1, '2019-06-11', 'Late of Work', NULL, NULL, 'qqnl');
INSERT INTO `employeeec` VALUES (3, 3, '2019-06-28', 'Late of Work', NULL, 0, 'dfas');
INSERT INTO `employeeec` VALUES (4, 1, '2019-06-04', 'Late of Work', NULL, 0, '');
INSERT INTO `employeeec` VALUES (5, 1, '2019-06-27', 'Late of Work', NULL, 0, '');
INSERT INTO `employeeec` VALUES (6, 1, '2019-06-30', 'Late of Work', NULL, 1, '123');

-- ----------------------------
-- Table structure for employeeremove
-- ----------------------------
DROP TABLE IF EXISTS `employeeremove`;
CREATE TABLE `employeeremove`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL,
  `afterDepId` int(11) NULL DEFAULT NULL COMMENT '调动后部门',
  `afterJobId` int(11) NULL DEFAULT NULL COMMENT '调动后职位',
  `removeDate` date NULL DEFAULT NULL COMMENT '调动日期',
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调动原因',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `employeeremove_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employeeremove
-- ----------------------------
INSERT INTO `employeeremove` VALUES (4, 5, 89, 17, '2019-07-26', 'Marketing shortage of employee', 'None');
INSERT INTO `employeeremove` VALUES (5, 36, 92, 15, '2019-07-28', 'Developing team needs support', 'None');
INSERT INTO `employeeremove` VALUES (6, 11, 82, 16, '2019-07-19', 'Hiring Team needs support', 'None');

-- ----------------------------
-- Table structure for employeetrain
-- ----------------------------
DROP TABLE IF EXISTS `employeetrain`;
CREATE TABLE `employeetrain`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL COMMENT '员工编号',
  `trainDate` date NULL DEFAULT NULL COMMENT '培训日期',
  `trainContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '培训内容',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `employeetrain_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employeetrain
-- ----------------------------
INSERT INTO `employeetrain` VALUES (7, 1, '2019-06-30', 'Data Structure', 'Learning data structure');
INSERT INTO `employeetrain` VALUES (9, 11, '2019-07-17', 'spring boot framework', 'Getting basic knowledge of spring boot framework');
INSERT INTO `employeetrain` VALUES (10, 24, '2019-07-08', 'spring cloud framework', 'Getting basic knowledge of spring cloud framework');

-- ----------------------------
-- Table structure for empsalary
-- ----------------------------
DROP TABLE IF EXISTS `empsalary`;
CREATE TABLE `empsalary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL,
  `sid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `eid`(`eid`) USING BTREE,
  INDEX `empsalary_ibfk_2`(`sid`) USING BTREE,
  CONSTRAINT `empsalary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `empsalary_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `salary` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of empsalary
-- ----------------------------
INSERT INTO `empsalary` VALUES (6, 4, 10);
INSERT INTO `empsalary` VALUES (7, 3, 9);
INSERT INTO `empsalary` VALUES (8, 1, 10);
INSERT INTO `empsalary` VALUES (10, 5, 9);
INSERT INTO `empsalary` VALUES (11, 6, 13);
INSERT INTO `empsalary` VALUES (12, 7, 13);
INSERT INTO `empsalary` VALUES (13, 2, 13);
INSERT INTO `empsalary` VALUES (14, 8, 10);
INSERT INTO `empsalary` VALUES (15, 9, 10);
INSERT INTO `empsalary` VALUES (16, 10, 13);
INSERT INTO `empsalary` VALUES (17, 11, 9);
INSERT INTO `empsalary` VALUES (18, 13, 9);
INSERT INTO `empsalary` VALUES (19, 12, 10);
INSERT INTO `empsalary` VALUES (20, 14, 13);
INSERT INTO `empsalary` VALUES (21, 15, 13);
INSERT INTO `empsalary` VALUES (22, 16, 9);
INSERT INTO `empsalary` VALUES (23, 17, 10);
INSERT INTO `empsalary` VALUES (24, 18, 10);
INSERT INTO `empsalary` VALUES (25, 19, 9);
INSERT INTO `empsalary` VALUES (26, 20, 10);

-- ----------------------------
-- Table structure for hr
-- ----------------------------
DROP TABLE IF EXISTS `hr`;
CREATE TABLE `hr`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'hrID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `telephone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '住宅电话',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `enabled` tinyint(1) NULL DEFAULT 1,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `userface` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hr
-- ----------------------------
INSERT INTO `hr` VALUES (3, 'Da Lyu', '18568887789', '029-82881234', 'Pittsburgh', 1, 'admin', '$2a$10$ySG2lkvjFHY5O0./CPIE1OI8VJsuKYEzOYzqIa7AJR6sEgSzUFOAm', 'http://bpic.588ku.com/element_pic/01/40/00/64573ce2edc0728.jpg', NULL);
INSERT INTO `hr` VALUES (5, 'Peter', '18568123489', '029-82123434', 'Cranberry', 1, 'Peter', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', NULL);
INSERT INTO `hr` VALUES (10, 'Jason', '18568123666', '029-82111555', 'Pittsburgh', 1, 'Jason', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', NULL);
INSERT INTO `hr` VALUES (11, 'Jay', '18568123377', '029-82111333', 'Cranberry', 1, 'Jay', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', NULL);
INSERT INTO `hr` VALUES (12, 'Kazie', '18568128888', '029-82111222', 'Pittsburgh', 1, 'Kazie', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517070040185&di=be0375e0c3db6c311b837b28c208f318&imgtype=0&src=http%3A%2F%2Fimg2.soyoung.com%2Fpost%2F20150213%2F6%2F20150213141918532.jpg', NULL);

-- ----------------------------
-- Table structure for hr_role
-- ----------------------------
DROP TABLE IF EXISTS `hr_role`;
CREATE TABLE `hr_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hrid` int(11) NULL DEFAULT NULL,
  `rid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  INDEX `hr_role_ibfk_1`(`hrid`) USING BTREE,
  CONSTRAINT `hr_role_ibfk_1` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `hr_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hr_role
-- ----------------------------
INSERT INTO `hr_role` VALUES (1, 3, 6);
INSERT INTO `hr_role` VALUES (35, 12, 4);
INSERT INTO `hr_role` VALUES (36, 12, 3);
INSERT INTO `hr_role` VALUES (37, 12, 2);
INSERT INTO `hr_role` VALUES (43, 11, 3);
INSERT INTO `hr_role` VALUES (44, 11, 2);
INSERT INTO `hr_role` VALUES (45, 11, 4);
INSERT INTO `hr_role` VALUES (46, 11, 5);
INSERT INTO `hr_role` VALUES (48, 10, 3);
INSERT INTO `hr_role` VALUES (49, 10, 4);
INSERT INTO `hr_role` VALUES (51, 5, 2);
INSERT INTO `hr_role` VALUES (52, 5, 13);

-- ----------------------------
-- Table structure for joblevel
-- ----------------------------
DROP TABLE IF EXISTS `joblevel`;
CREATE TABLE `joblevel`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职称名称',
  `titleLevel` enum('Senior','Intermediate','Primary','Internship') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createDate` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of joblevel
-- ----------------------------
INSERT INTO `joblevel` VALUES (9, 'President', 'Senior', '2018-01-11 21:19:14', 1);
INSERT INTO `joblevel` VALUES (10, 'Vice President', 'Senior', '2018-01-11 21:19:20', 1);
INSERT INTO `joblevel` VALUES (12, 'Senior Recruiter', 'Primary', '2018-01-11 21:35:39', 1);
INSERT INTO `joblevel` VALUES (13, 'Senior SDE', 'Intermediate', '2018-01-11 22:42:12', 1);
INSERT INTO `joblevel` VALUES (14, 'Junior SDE', 'Intermediate', '2018-01-14 16:18:50', 1);
INSERT INTO `joblevel` VALUES (15, 'Internship', 'Senior', '2018-01-14 16:19:00', 1);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `path` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `iconCls` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keepAlive` tinyint(1) NULL DEFAULT NULL,
  `requireAuth` tinyint(1) NULL DEFAULT NULL,
  `parentId` int(11) NULL DEFAULT NULL,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parentId`(`parentId`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '/', NULL, NULL, 'All', NULL, NULL, NULL, NULL, 1);
INSERT INTO `menu` VALUES (2, '/', '/home', 'Home', 'Staff Information', 'fa fa-user-circle-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (3, '/', '/home', 'Home', 'Employee Management', 'fa fa-address-card-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (4, '/', '/home', 'Home', 'Salary Management', 'fa fa-money', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (5, '/', '/home', 'Home', 'Statistics Management', 'fa fa-bar-chart', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (6, '/', '/home', 'Home', 'System Management', 'fa fa-windows', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (7, '/employee/basic/**', '/emp/basic', 'EmpBasic', 'Basic Information', NULL, NULL, 1, 2, 1);
INSERT INTO `menu` VALUES (8, '/employee/advanced/**', '/emp/adv', 'EmpAdv', 'Senior Information', NULL, NULL, 1, 2, 0);
INSERT INTO `menu` VALUES (9, '/personnel/emp/**', '/per/emp', 'PerEmp', 'Employee Information', NULL, NULL, 1, 3, 0);
INSERT INTO `menu` VALUES (10, '/personnel/ec/**', '/per/ec', 'PerEc', 'Employee Reward and Punishment', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (11, '/personnel/train/**', '/per/train', 'PerTrain', 'Employee Traning', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (12, '/personnel/salary/**', '/per/salary', 'PerSalary', 'Employee Salary Adjustment', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (13, '/personnel/remove/**', '/per/mv', 'PerMv', 'Employee Transfer', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (14, '/salary/sob/**', '/sal/sob', 'SalSob', 'Payroll Set Management', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (15, '/salary/sobcfg/**', '/sal/sobcfg', 'SalSobCfg', 'Employee Account Set', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (16, '/salary/table/**', '/sal/table', 'SalTable', 'Payroll Management', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (18, '/salary/search/**', '/sal/search', 'SalSearch', 'Payroll Inquiry', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (19, '/statistics/all/**', '/sta/all', 'StaAll', 'Comprehensive Information Statistics', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (22, '/statistics/recored/**', '/sta/record', 'StaRecord', 'Personnel Record Statistics', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (23, '/system/basic/**', '/sys/basic', 'SysBasic', 'Basic Information Settings', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (26, '/system/hr/**', '/sys/hr', 'SysHr', 'Operator Management', NULL, NULL, 1, 6, 1);

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NULL DEFAULT NULL,
  `rid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mid`(`mid`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  CONSTRAINT `menu_role_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `menu_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 281 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES (161, 7, 3);
INSERT INTO `menu_role` VALUES (162, 7, 6);
INSERT INTO `menu_role` VALUES (163, 9, 6);
INSERT INTO `menu_role` VALUES (164, 10, 6);
INSERT INTO `menu_role` VALUES (165, 11, 6);
INSERT INTO `menu_role` VALUES (166, 12, 6);
INSERT INTO `menu_role` VALUES (167, 13, 6);
INSERT INTO `menu_role` VALUES (168, 14, 6);
INSERT INTO `menu_role` VALUES (169, 15, 6);
INSERT INTO `menu_role` VALUES (170, 16, 6);
INSERT INTO `menu_role` VALUES (172, 18, 6);
INSERT INTO `menu_role` VALUES (173, 19, 6);
INSERT INTO `menu_role` VALUES (176, 22, 6);
INSERT INTO `menu_role` VALUES (177, 23, 6);
INSERT INTO `menu_role` VALUES (179, 26, 6);
INSERT INTO `menu_role` VALUES (247, 7, 4);
INSERT INTO `menu_role` VALUES (248, 8, 4);
INSERT INTO `menu_role` VALUES (249, 11, 4);
INSERT INTO `menu_role` VALUES (250, 7, 2);
INSERT INTO `menu_role` VALUES (251, 8, 2);
INSERT INTO `menu_role` VALUES (252, 9, 2);
INSERT INTO `menu_role` VALUES (253, 10, 2);
INSERT INTO `menu_role` VALUES (254, 12, 2);
INSERT INTO `menu_role` VALUES (255, 13, 2);
INSERT INTO `menu_role` VALUES (256, 7, 1);
INSERT INTO `menu_role` VALUES (257, 8, 1);
INSERT INTO `menu_role` VALUES (258, 9, 1);
INSERT INTO `menu_role` VALUES (259, 10, 1);
INSERT INTO `menu_role` VALUES (260, 11, 1);
INSERT INTO `menu_role` VALUES (261, 12, 1);
INSERT INTO `menu_role` VALUES (262, 13, 1);
INSERT INTO `menu_role` VALUES (263, 14, 1);
INSERT INTO `menu_role` VALUES (264, 15, 1);
INSERT INTO `menu_role` VALUES (265, 16, 1);
INSERT INTO `menu_role` VALUES (267, 18, 1);
INSERT INTO `menu_role` VALUES (268, 19, 1);
INSERT INTO `menu_role` VALUES (271, 22, 1);
INSERT INTO `menu_role` VALUES (272, 23, 1);
INSERT INTO `menu_role` VALUES (275, 26, 1);
INSERT INTO `menu_role` VALUES (278, 23, 13);
INSERT INTO `menu_role` VALUES (279, 26, 13);

-- ----------------------------
-- Table structure for msgcontent
-- ----------------------------
DROP TABLE IF EXISTS `msgcontent`;
CREATE TABLE `msgcontent`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createDate` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of msgcontent
-- ----------------------------
INSERT INTO `msgcontent` VALUES (14, 'Announcement Title', 'Announcement Details', '2018-02-02 20:46:19');
INSERT INTO `msgcontent` VALUES (15, 'Meeting', 'Meeting at 4pm', '2018-02-02 21:45:57');
INSERT INTO `msgcontent` VALUES (16, 'Announcement Title1', 'Announcement1', '2018-02-03 11:41:39');
INSERT INTO `msgcontent` VALUES (17, 'Announcement Title2', 'Announcement2', '2018-02-03 11:52:37');
INSERT INTO `msgcontent` VALUES (18, 'Announcement Title3', 'Announcement3', '2018-02-03 12:19:41');
INSERT INTO `msgcontent` VALUES (19, 'Vacation', 'Vacation Tomorrow', '2019-05-30 11:04:52');
INSERT INTO `msgcontent` VALUES (20, 'Working Progress', 'Please arrange your working progress', '2019-07-24 17:09:46');

-- ----------------------------
-- Table structure for nation
-- ----------------------------
DROP TABLE IF EXISTS `nation`;
CREATE TABLE `nation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nation
-- ----------------------------
INSERT INTO `nation` VALUES (1, 'Han');
INSERT INTO `nation` VALUES (2, 'Mengu');
INSERT INTO `nation` VALUES (3, 'Hui');
INSERT INTO `nation` VALUES (4, 'Zang');
INSERT INTO `nation` VALUES (5, 'Han');
INSERT INTO `nation` VALUES (6, 'Zang');
INSERT INTO `nation` VALUES (7, 'Han');
INSERT INTO `nation` VALUES (8, 'Hui');
INSERT INTO `nation` VALUES (9, 'Han');
INSERT INTO `nation` VALUES (10, 'Zang');
INSERT INTO `nation` VALUES (11, 'Han');
INSERT INTO `nation` VALUES (12, 'Zang');
INSERT INTO `nation` VALUES (13, 'Han');
INSERT INTO `nation` VALUES (14, 'Hui');
INSERT INTO `nation` VALUES (15, 'Han');
INSERT INTO `nation` VALUES (16, 'Hui');
INSERT INTO `nation` VALUES (17, 'Han');
INSERT INTO `nation` VALUES (18, 'Hui');
INSERT INTO `nation` VALUES (19, 'Han');


-- ----------------------------
-- Table structure for politicsstatus
-- ----------------------------
DROP TABLE IF EXISTS `politicsstatus`;
CREATE TABLE `politicsstatus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of politicsstatus
-- ----------------------------
INSERT INTO `politicsstatus` VALUES (1, 'Communist');
INSERT INTO `politicsstatus` VALUES (2, 'Pre Communist');
INSERT INTO `politicsstatus` VALUES (3, 'Junior Communist');
INSERT INTO `politicsstatus` VALUES (4, 'Senior Communist');
INSERT INTO `politicsstatus` VALUES (5, 'Communist');
INSERT INTO `politicsstatus` VALUES (6, 'Communist');
INSERT INTO `politicsstatus` VALUES (7, 'Communist');
INSERT INTO `politicsstatus` VALUES (8, 'Communist');
INSERT INTO `politicsstatus` VALUES (9, 'Communist');
INSERT INTO `politicsstatus` VALUES (10, 'Communist');
INSERT INTO `politicsstatus` VALUES (11, 'Communist');
INSERT INTO `politicsstatus` VALUES (12, 'Communist');
INSERT INTO `politicsstatus` VALUES (13, 'Communist');

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位',
  `createDate` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of position
-- ----------------------------
INSERT INTO `position` VALUES (29, 'Technical Director', '2018-01-11 21:13:42', 1);
INSERT INTO `position` VALUES (30, 'Director of Operations', '2018-01-11 21:13:48', 1);
INSERT INTO `position` VALUES (31, 'Marketing Director', '2018-01-11 21:13:56', 1);
INSERT INTO `position` VALUES (32, 'Manager', '2018-01-11 21:35:07', 1);
INSERT INTO `position` VALUES (33, 'Software Enginner', '2018-01-14 16:07:11', 1);
INSERT INTO `position` VALUES (34, 'QA', '2018-01-14 16:11:41', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nameZh` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ROLE_manager', 'Manager Group');
INSERT INTO `role` VALUES (2, 'ROLE_personnel', 'HR');
INSERT INTO `role` VALUES (4, 'ROLE_train', 'IT Group');
INSERT INTO `role` VALUES (5, 'ROLE_performance', 'Finance Group');
INSERT INTO `role` VALUES (6, 'ROLE_admin', 'System Manager');


-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basicSalary` int(11) NULL DEFAULT NULL COMMENT '基本工资',
  `bonus` int(11) NULL DEFAULT NULL COMMENT '奖金',
  `lunchSalary` int(11) NULL DEFAULT NULL COMMENT '午餐补助',
  `trafficSalary` int(11) NULL DEFAULT NULL COMMENT '交通补助',
  `allSalary` int(11) NULL DEFAULT NULL COMMENT '应发工资',
  `pensionBase` int(11) NULL DEFAULT NULL COMMENT '养老金基数',
  `pensionPer` float NULL DEFAULT NULL COMMENT '养老金比率',
  `createDate` timestamp(0) NULL DEFAULT NULL COMMENT '启用时间',
  `medicalBase` int(11) NULL DEFAULT NULL COMMENT '医疗基数',
  `medicalPer` float NULL DEFAULT NULL COMMENT '医疗保险比率',
  `accumulationFundBase` int(11) NULL DEFAULT NULL COMMENT '公积金基数',
  `accumulationFundPer` float NULL DEFAULT NULL COMMENT '公积金比率',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salary
-- ----------------------------
INSERT INTO `salary` VALUES (9, 9000, 4000, 800, 500, NULL, 2000, 0.07, '2018-01-24 00:00:00', 2000, 0.07, 2000, 0.07, 'Marketing Team');
INSERT INTO `salary` VALUES (10, 2000, 2000, 400, 1000, NULL, 2000, 0.07, '2018-01-01 00:00:00', 2000, 0.07, 2000, 0.07, 'HR Team');
INSERT INTO `salary` VALUES (13, 10000, 3000, 500, 500, NULL, 4000, 0.07, '2018-01-25 00:00:00', 4000, 0.07, 4000, 0.07, 'Manager Team');

-- ----------------------------
-- Table structure for sysmsg
-- ----------------------------
DROP TABLE IF EXISTS `sysmsg`;
CREATE TABLE `sysmsg`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NULL DEFAULT NULL COMMENT '消息id',
  `type` int(11) NULL DEFAULT 0 COMMENT '0表示群发消息',
  `hrid` int(11) NULL DEFAULT NULL COMMENT '这条消息是给谁的',
  `state` int(11) NULL DEFAULT 0 COMMENT '0 未读 1 已读',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `hrid`(`hrid`) USING BTREE,
  INDEX `sysmsg_ibfk_1`(`mid`) USING BTREE,
  CONSTRAINT `sysmsg_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `msgcontent` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sysmsg_ibfk_2` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sysmsg
-- ----------------------------
INSERT INTO `sysmsg` VALUES (57, 14, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (58, 14, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (59, 14, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (60, 14, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (61, 14, 0, 12, 1);
INSERT INTO `sysmsg` VALUES (62, 15, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (63, 15, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (64, 15, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (65, 15, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (66, 15, 0, 12, 1);
INSERT INTO `sysmsg` VALUES (67, 16, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (68, 16, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (69, 16, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (70, 16, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (71, 16, 0, 12, 1);
INSERT INTO `sysmsg` VALUES (72, 17, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (73, 17, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (74, 17, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (75, 17, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (76, 17, 0, 12, 1);
INSERT INTO `sysmsg` VALUES (77, 18, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (78, 18, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (79, 18, 0, 10, 0);
INSERT INTO `sysmsg` VALUES (80, 18, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (81, 18, 0, 12, 1);
INSERT INTO `sysmsg` VALUES (82, 19, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (83, 19, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (84, 19, 0, 10, 0);
INSERT INTO `sysmsg` VALUES (85, 19, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (86, 19, 0, 12, 1);
INSERT INTO `sysmsg` VALUES (87, 20, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (88, 20, 0, 5, 0);
INSERT INTO `sysmsg` VALUES (89, 20, 0, 10, 0);
INSERT INTO `sysmsg` VALUES (90, 20, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (91, 20, 0, 12, 1);

-- ----------------------------
-- Procedure structure for addDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `addDep`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addDep`(in depName varchar(32),in parentId int,in enabled boolean,out result int,out result2 int)
begin
  declare did int;
  declare pDepPath varchar(64);
  insert into department set name=depName,parentId=parentId,enabled=enabled;
  select row_count() into result;
  select last_insert_id() into did;
  set result2=did;
  select depPath into pDepPath from department where id=parentId;
  update department set depPath=concat(pDepPath,'.',did) where id=did;
  update department set isParent=true where id=parentId;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for deleteDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteDep`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDep`(in did int,out result int)
begin
  declare ecount int;
  declare pid int;
  declare pcount int;
  select count(*) into ecount from employee where departmentId=did;
  if ecount>0 then set result=-1;
  else
  select parentId into pid from department where id=did;
  delete from department where id=did and isParent=false;
  select row_count() into result;
  select count(*) into pcount from department where parentId=pid;
  if pcount=0 then update department set isParent=false where id=pid;
  end if;
  end if;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
