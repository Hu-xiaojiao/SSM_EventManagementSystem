/*
 Navicat Premium Data Transfer

 Source Server         : Mysql_Localhost
 Source Server Type    : MySQL
 Source Server Version : 80030
 Source Host           : localhost:3306
 Source Schema         : eventmanagementsystem

 Target Server Type    : MySQL
 Target Server Version : 80030
 File Encoding         : 65001

 Date: 17/12/2024 23:44:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for attends
-- ----------------------------
DROP TABLE IF EXISTS `attends`;
CREATE TABLE `attends`  (
  `AttendID` int(0) NOT NULL AUTO_INCREMENT,
  `EventID` int(0) NOT NULL,
  `UserID` int(0) NOT NULL,
  `AttendStatus` enum('Confirmed','Pending','Declined') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'Pending',
  `CreatedAt` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`AttendID`) USING BTREE,
  INDEX `EventID`(`EventID`) USING BTREE,
  INDEX `UserID`(`UserID`) USING BTREE,
  UNIQUE INDEX `UniqueEventUser` (`EventID`, `UserID`) USING BTREE,
  CONSTRAINT `attends_ibfk_1` FOREIGN KEY (`EventID`) REFERENCES `events` (`EventID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `attends_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of attends
-- ----------------------------
INSERT INTO `attends` VALUES (1, 1, 3, 'Confirmed', '2024-12-17 21:51:08', '2024-12-17 22:39:21');
INSERT INTO `attends` VALUES (2, 2, 2, 'Pending', '2024-12-17 23:10:17', '2024-12-17 23:10:17');
INSERT INTO `attends` VALUES (6, 5, 5, 'Pending', '2024-12-17 23:40:17', '2024-12-17 23:40:17');

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events`  (
  `EventID` int(0) NOT NULL AUTO_INCREMENT,
  `EventName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `EventDescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `EventStartDate` datetime(0) NULL,
  `EventEndDate` datetime(0) NULL,
  `Location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Status` enum('Progressing','Completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CreatedAt` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`EventID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES (1, '春季运动会', '春季运动会将于校园体育场举行，包括跑步、跳远等多个项目。', '2023-04-15 08:00:00', '2023-04-15 17:00:00', '校园体育场', 'Progressing', '2024-12-15 23:44:18', '2024-12-16 23:04:40');
INSERT INTO `events` VALUES (2, '编程马拉松', '编程马拉松活动，邀请各路编程高手齐聚一堂，共同竞技。', '2023-05-20 09:00:00', '2023-05-21 21:00:00', '科技园会议中心', 'Progressing', '2024-12-15 23:44:18', '2024-12-16 23:04:40');
INSERT INTO `events` VALUES (3, '文学讲座', '邀请知名作家进行文学讲座，分享创作心得。', '2023-06-10 14:00:00', '2023-06-10 16:00:00', '图书馆报告厅', 'Progressing', '2024-12-15 23:44:18', '2024-12-16 23:04:40');
INSERT INTO `events` VALUES (4, '夏日音乐会', '夏日音乐会，邀请多位知名歌手现场演唱。', '2023-07-15 19:00:00', '2023-07-15 22:00:00', '市体育馆', 'Progressing', '2024-12-15 23:44:18', '2024-12-16 23:04:40');
INSERT INTO `events` VALUES (5, '亲子活动日', '亲子活动日，家长与孩子共同参与多项趣味游戏。', '2023-08-20 10:00:00', '2023-08-20 16:00:00', '公园游乐场', 'Completed', '2024-12-15 23:44:18', '2024-12-16 23:04:51');
INSERT INTO `events` VALUES (6, '摄影大赛', '摄影大赛，征集优秀摄影作品。', '2023-09-10 09:00:00', '2023-09-30 23:59:00', '美术馆展厅', 'Progressing', '2024-12-15 23:44:18', '2024-12-16 23:04:40');
INSERT INTO `events` VALUES (7, '科技论坛', '科技论坛，邀请行业专家进行技术分享。', '2023-10-15 13:30:00', '2023-10-15 17:00:00', '科技大厦会议室', 'Completed', '2024-12-15 23:44:18', '2024-12-16 23:04:51');
INSERT INTO `events` VALUES (8, '美食节', '美食节，品尝各地美食。', '2023-11-05 10:00:00', '2023-11-05 22:00:00', '会展中心', 'Progressing', '2024-12-15 23:44:18', '2024-12-16 23:04:40');
INSERT INTO `events` VALUES (9, '环保公益活动', '环保公益活动，倡导绿色生活。', '2023-11-20 09:00:00', '2023-11-20 12:00:00', '社区广场', 'Completed', '2024-12-15 23:44:18', '2024-12-16 23:04:51');
INSERT INTO `events` VALUES (10, '读书会', '每月一次的读书会，分享阅读心得。', '2023-12-10 15:00:00', '2023-12-10 17:00:00', '咖啡馆', 'Completed', '2024-12-15 23:44:18', '2024-12-16 23:04:51');
INSERT INTO `events` VALUES (11, '新年晚会', '新年晚会，迎接新的一年。', '2024-01-01 19:00:00', '2024-01-01 22:00:00', '大剧院', 'Progressing', '2024-12-15 23:44:18', '2024-12-16 23:04:40');
INSERT INTO `events` VALUES (12, '书法比赛', '书法比赛，弘扬传统文化。', '2024-02-15 10:00:00', '2024-02-15 16:00:00', '文化馆', 'Completed', '2024-12-15 23:44:18', '2024-12-16 23:04:51');
INSERT INTO `events` VALUES (13, '户外徒步', '户外徒步活动，锻炼身体，享受自然。', '2024-03-10 08:00:00', '2024-03-10 17:00:00', '郊外公园', 'Progressing', '2024-12-15 23:44:18', '2024-12-16 23:04:40');
INSERT INTO `events` VALUES (14, '舞蹈大赛', '舞蹈大赛，展示舞蹈才华。1', '2024-04-20 14:00:00', '2024-04-20 21:00:00', '体育馆', 'Progressing', '2024-12-15 23:44:18', '2024-12-17 21:02:58');
INSERT INTO `events` VALUES (15, '创业讲座', '创业讲座，分享创业经验。24', '2024-05-15 13:00:00', '2024-05-15 15:00:00', '大学讲堂', 'Completed', '2024-12-15 23:44:18', '2024-12-17 21:04:58');
INSERT INTO `events` VALUES (16, '儿童画展', '儿童画展，展示儿童绘画作品。1', '2024-06-10 10:00:00', '2024-06-10 17:00:00', '少年宫', 'Progressing', '2024-12-15 23:44:18', '2024-12-17 20:52:46');
INSERT INTO `events` VALUES (17, '音乐工作坊', '音乐工作坊，学习音乐制作。12', '2024-07-05 09:00:00', '2024-07-05 17:00:00', '音乐教室', 'Completed', '2024-12-15 23:44:18', '2024-12-17 21:06:22');
INSERT INTO `events` VALUES (18, '手工艺市集', '手工艺市集，展示和销售手工艺品。12', '2024-08-25 10:00:00', '2024-08-25 20:00:00', '市集广场', 'Progressing', '2024-12-15 23:44:18', '2024-12-17 21:00:53');
INSERT INTO `events` VALUES (19, '健康讲座', '健康讲座，分享健康知识。221', '2024-09-15 11:00:00', '2024-09-15 13:00:00', '社区中心', 'Completed', '2024-12-15 23:44:18', '2024-12-17 21:28:28');
INSERT INTO `events` VALUES (20, '电影之夜', '电影之夜，放映经典电影。1', '2024-10-10 19:00:00', '2024-10-10 22:00:00', '电影院', 'Completed', '2024-12-15 23:44:18', '2024-12-17 22:28:40');
INSERT INTO `events` VALUES (21, '20周年校庆', '20周年校庆1233222', '2024-12-17 00:07:00', '2024-12-18 00:07:00', '20周年校庆', 'Progressing', '2024-12-17 00:36:04', '2024-12-17 21:12:57');
INSERT INTO `events` VALUES (22, '12', '123', '2024-12-17 20:49:00', '2024-12-17 21:49:00', '1', 'Completed', '2024-12-17 20:49:23', '2024-12-17 21:25:05');
INSERT INTO `events` VALUES (23, '1', '1', '2024-12-08 21:27:00', '2024-12-17 23:27:00', '1', 'Progressing', '2024-12-17 21:27:30', '2024-12-17 21:27:30');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `UserID` int(0) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Role` enum('Participant','Admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'Participant',
  `CreatedAt` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` int(0) NULL DEFAULT NULL,
  `UpdatedAt` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`UserID`) USING BTREE,
  UNIQUE INDEX `Email`(`Email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'superadmin', 'admin@em.com', '123456', 'Admin', '2024-12-15 22:38:52', 0, '2024-12-15 23:41:36');
INSERT INTO `users` VALUES (2, 'zhangsan', 'zhangsan@em.com', '123456', 'Admin', '2024-12-15 23:41:15', 0, '2024-12-16 22:55:32');
INSERT INTO `users` VALUES (3, 'lisi', 'lisi@em.com', '123456', 'Admin', '2024-12-15 23:42:05', 0, '2024-12-16 22:55:32');
INSERT INTO `users` VALUES (4, 'wangwu', 'wangwu@em.com', '123456', 'Participant', '2024-12-15 23:42:21', 0, '2024-12-16 22:55:32');
INSERT INTO `users` VALUES (5, 'zhaoliu', 'zhaoliu@em.com', '123456', 'Participant', '2024-12-15 23:42:54', 0, '2024-12-16 21:02:46');
INSERT INTO `users` VALUES (7, 'sunqi', 'sunqi@em.com', '123456', 'Participant', '2024-12-15 23:43:14', 0, '2024-12-15 23:43:15');

SET FOREIGN_KEY_CHECKS = 1;
