-- MariaDB dump 10.19  Distrib 10.6.16-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: configure
-- ------------------------------------------------------
-- Server version	10.6.16-MariaDB-0ubuntu0.22.04.1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AdjacentExternalSite`
--

DROP TABLE IF EXISTS `AdjacentExternalSite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AdjacentExternalSite` (
  `AdjacentExternalSite` varchar(50) NOT NULL DEFAULT '',
  `ExternalSite` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`AdjacentExternalSite`,`ExternalSite`),
  KEY `AdjacentExternal_ibfk_1` (`ExternalSite`),
  CONSTRAINT `AdjacentExternal_adfk_1` FOREIGN KEY (`AdjacentExternalSite`) REFERENCES `SiteController` (`SiteController`) ON UPDATE CASCADE,
  CONSTRAINT `AdjacentExternal_ibfk_1` FOREIGN KEY (`ExternalSite`) REFERENCES `ExternalSite` (`ExternalSite`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdjacentExternalSite`
--

LOCK TABLES `AdjacentExternalSite` WRITE;
/*!40000 ALTER TABLE `AdjacentExternalSite` DISABLE KEYS */;
/*!40000 ALTER TABLE `AdjacentExternalSite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AdjacentSite`
--

DROP TABLE IF EXISTS `AdjacentSite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AdjacentSite` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `AdjacentSite` varchar(50) NOT NULL DEFAULT '',
  `SiteController` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`),
  KEY `AdjacentSite_ibfk_2` (`SiteController`),
  KEY `AdjacentSite` (`AdjacentSite`,`SiteController`),
  CONSTRAINT `AdjacentSite_ibfk_1` FOREIGN KEY (`AdjacentSite`) REFERENCES `SiteController` (`SiteController`) ON UPDATE CASCADE,
  CONSTRAINT `AdjacentSite_ibfk_2` FOREIGN KEY (`SiteController`) REFERENCES `SiteController` (`SiteController`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdjacentSite`
--

LOCK TABLES `AdjacentSite` WRITE;
/*!40000 ALTER TABLE `AdjacentSite` DISABLE KEYS */;
/*!40000 ALTER TABLE `AdjacentSite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Agency`
--

DROP TABLE IF EXISTS `Agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Agency` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Agency` varchar(50) NOT NULL,
  `Description` varchar(128) DEFAULT '',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Agency` (`Agency`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Agency`
--

LOCK TABLES `Agency` WRITE;
/*!40000 ALTER TABLE `Agency` DISABLE KEYS */;
INSERT INTO `Agency` (`Id`, `Agency`, `Description`) VALUES (1,'Default','The default agency');
/*!40000 ALTER TABLE `Agency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AgencyExternalDeviceXref`
--

DROP TABLE IF EXISTS `AgencyExternalDeviceXref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AgencyExternalDeviceXref` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ExternalDevice` varchar(50) NOT NULL,
  `Agency` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `AgencyExternalDeviceXref_UN` (`Agency`,`ExternalDevice`),
  KEY `ExternalDevice` (`ExternalDevice`),
  KEY `Agency` (`Agency`),
  CONSTRAINT `AgencyExternalDeviceXref_UK_Agency` FOREIGN KEY (`Agency`) REFERENCES `Agency` (`Agency`) ON UPDATE CASCADE,
  CONSTRAINT `AgencyExternalDeviceXref_UK_ExternalDevice` FOREIGN KEY (`ExternalDevice`) REFERENCES `ExternalDevice` (`ExternalDevice`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AgencyExternalDeviceXref`
--

LOCK TABLES `AgencyExternalDeviceXref` WRITE;
/*!40000 ALTER TABLE `AgencyExternalDeviceXref` DISABLE KEYS */;
/*!40000 ALTER TABLE `AgencyExternalDeviceXref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AuditLog`
--

DROP TABLE IF EXISTS `AuditLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuditLog` (
  `Id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(50) NOT NULL DEFAULT '',
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `UserIpAddress` varchar(20) NOT NULL DEFAULT 'localhost',
  `LoggedInUser` varchar(20) NOT NULL DEFAULT 'root',
  `LogDescription` varchar(200) DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuditLog`
--

LOCK TABLES `AuditLog` WRITE;
/*!40000 ALTER TABLE `AuditLog` DISABLE KEYS */;
INSERT INTO `AuditLog` (`Id`, `Type`, `Date`, `UserIpAddress`, `LoggedInUser`, `LogDescription`) VALUES (1,'Database','2013-07-26 01:42:15','localhost','root','Created AuditLog table on upgrade');
/*!40000 ALTER TABLE `AuditLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AuthConfig`
--

DROP TABLE IF EXISTS `AuthConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthConfig` (
  `Id` tinyint(4) NOT NULL,
  `EnforceStrongPasswords` tinyint(4) NOT NULL DEFAULT 0,
  `FallbackAllowed` tinyint(4) NOT NULL DEFAULT 0,
  `RemoteMode` tinyint(4) NOT NULL DEFAULT 0,
  `LdapRules` text NOT NULL DEFAULT '',
  `LdapSearchBase` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuthConfig`
--

LOCK TABLES `AuthConfig` WRITE;
/*!40000 ALTER TABLE `AuthConfig` DISABLE KEYS */;
INSERT INTO `AuthConfig` (`Id`, `EnforceStrongPasswords`, `FallbackAllowed`, `RemoteMode`, `LdapRules`, `LdapSearchBase`) VALUES (0,0,0,0,'','');
/*!40000 ALTER TABLE `AuthConfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CallProfile`
--

DROP TABLE IF EXISTS `CallProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CallProfile` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `CallProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `PreemptIdleUplinkCallsOnly` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `UnitTrxSyncTimeMs` int(10) DEFAULT 50,
  `MinTimeGrantToTrafficRecvdMs` int(10) DEFAULT 1000,
  `MaxQueueTimeSecs` int(10) DEFAULT 10,
  `UnitToPstnInterDigitTimeoutMs` int(10) DEFAULT 3000,
  `UnitCallAnswerTimeoutSecs` int(10) DEFAULT 30,
  `NumberCallTerminators` int(10) DEFAULT 3,
  `OspMaxRetryCount` int(10) DEFAULT 3,
  `UnitToPstnMinDigits` int(10) DEFAULT 3,
  `PreemptivePriorityLevel` int(10) DEFAULT 32,
  `OspRetryTimeMs` int(10) DEFAULT 500,
  `UnitProcedureHangTimeMs` int(10) DEFAULT 500,
  `MaxQueueCallRequests` int(10) DEFAULT 5,
  `CallTypePriorityGroup` int(10) DEFAULT 7,
  `CallTypePriorityUnitToUnit` int(10) DEFAULT 5,
  `CallTypePriorityPstn` int(10) DEFAULT 3,
  `CallTypePriorityData` int(10) DEFAULT 1,
  `IdleGroupCallTimeSecs` int(10) DEFAULT 30,
  `StickyGroupCallEmergency` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `AllowNormalGroupCallWhileAnnouncementGroupCall` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `AllowLocalCallWhenEnterExitSiteTrunking` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `AllowLocalCallAfterNoRfssResponse` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `UnitCallInactivityTimeoutMs` int(10) DEFAULT 10000,
  `PstnCallInactivityTimeoutMs` int(10) DEFAULT 10000,
  `AllowPacketDataOnInhibit` tinyint(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `CallProfile` (`CallProfile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CallProfile`
--

LOCK TABLES `CallProfile` WRITE;
/*!40000 ALTER TABLE `CallProfile` DISABLE KEYS */;
INSERT INTO `CallProfile` (`Id`, `CallProfile`, `PreemptIdleUplinkCallsOnly`, `UnitTrxSyncTimeMs`, `MinTimeGrantToTrafficRecvdMs`, `MaxQueueTimeSecs`, `UnitToPstnInterDigitTimeoutMs`, `UnitCallAnswerTimeoutSecs`, `NumberCallTerminators`, `OspMaxRetryCount`, `UnitToPstnMinDigits`, `PreemptivePriorityLevel`, `OspRetryTimeMs`, `UnitProcedureHangTimeMs`, `MaxQueueCallRequests`, `CallTypePriorityGroup`, `CallTypePriorityUnitToUnit`, `CallTypePriorityPstn`, `CallTypePriorityData`, `IdleGroupCallTimeSecs`, `StickyGroupCallEmergency`, `AllowNormalGroupCallWhileAnnouncementGroupCall`, `AllowLocalCallWhenEnterExitSiteTrunking`, `AllowLocalCallAfterNoRfssResponse`, `UnitCallInactivityTimeoutMs`, `PstnCallInactivityTimeoutMs`, `AllowPacketDataOnInhibit`) VALUES (1,'Default',1,50,1000,10,3000,30,3,3,3,32,500,500,5,7,5,3,1,30,1,1,0,0,10000,10000,0);
/*!40000 ALTER TABLE `CallProfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ChannelGroup`
--

DROP TABLE IF EXISTS `ChannelGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ChannelGroup` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `ChannelGroup` varchar(50) NOT NULL DEFAULT 'Default',
  `SiteController` int(10) NOT NULL DEFAULT 1,
  `RxFrequency` int(10) DEFAULT 450000000,
  `TxFrequency` int(10) DEFAULT 459000000,
  `FrequencyPlan` varchar(50) DEFAULT 'Default',
  `SelectionPriority` int(5) DEFAULT 0,
  `ControlChannelType` varchar(50) NOT NULL DEFAULT 'PRIMARY',
  `SuTxFreqCalcMethod` varchar(10) NOT NULL DEFAULT 'IMPLICIT',
  `FrequencyPlanRx` varchar(50) NOT NULL DEFAULT 'Default',
  `TrafficChannelUsage` tinyint(2) NOT NULL DEFAULT 0,
  `FdmaEnabled` tinyint(1) NOT NULL DEFAULT 1,
  `TdmaEnabled` tinyint(1) NOT NULL DEFAULT 0,
  `FrequencyPlanTdma` varchar(50) NOT NULL DEFAULT 'Default',
  `FrequencyPlanTdmaRx` varchar(50) NOT NULL DEFAULT 'Default',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UNI_NAME_ON_SITE` (`SiteController`,`ChannelGroup`),
  KEY `SiteController` (`SiteController`),
  KEY `FrequencyPlan` (`FrequencyPlan`),
  KEY `Channel_ibfk_3` (`FrequencyPlanRx`),
  KEY `Channel_ibfk_4` (`FrequencyPlanTdma`),
  KEY `Channel_ibfk_5` (`FrequencyPlanTdmaRx`),
  CONSTRAINT `Channel_ibfk_1` FOREIGN KEY (`SiteController`) REFERENCES `SiteController` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `Channel_ibfk_2` FOREIGN KEY (`FrequencyPlan`) REFERENCES `FrequencyPlan` (`FrequencyPlan`) ON UPDATE CASCADE,
  CONSTRAINT `Channel_ibfk_3` FOREIGN KEY (`FrequencyPlanRx`) REFERENCES `FrequencyPlan` (`FrequencyPlan`) ON UPDATE CASCADE,
  CONSTRAINT `Channel_ibfk_4` FOREIGN KEY (`FrequencyPlanTdma`) REFERENCES `FrequencyPlan` (`FrequencyPlan`) ON UPDATE CASCADE,
  CONSTRAINT `Channel_ibfk_5` FOREIGN KEY (`FrequencyPlanTdmaRx`) REFERENCES `FrequencyPlan` (`FrequencyPlan`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ChannelGroup`
--

LOCK TABLES `ChannelGroup` WRITE;
/*!40000 ALTER TABLE `ChannelGroup` DISABLE KEYS */;
INSERT INTO `ChannelGroup` (`Id`, `ChannelGroup`, `SiteController`, `RxFrequency`, `TxFrequency`, `FrequencyPlan`, `SelectionPriority`, `ControlChannelType`, `SuTxFreqCalcMethod`, `FrequencyPlanRx`, `TrafficChannelUsage`, `FdmaEnabled`, `TdmaEnabled`, `FrequencyPlanTdma`, `FrequencyPlanTdmaRx`) VALUES (1,'Default',1,450000000,459000000,'Default',0,'PRIMARY','IMPLICIT','Default',0,1,0,'Default','Default');
/*!40000 ALTER TABLE `ChannelGroup` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `channel_group_before_ins_trig` BEFORE INSERT ON `ChannelGroup` FOR EACH ROW BEGIN
                     IF NEW.`SuTxFreqCalcMethod` = "IMPLICIT" THEN
                         
                         SET @offset_sign = (SELECT `OffsetSign` FROM `FrequencyPlan` WHERE  `FrequencyPlan` = NEW.`FrequencyPlan`);
                         SET @transmit_offset = (SELECT `TransmitOffset` FROM `FrequencyPlan` WHERE  `FrequencyPlan`.`FrequencyPlan` = NEW.`FrequencyPlan`);
                         IF @offset_sign = "+" THEN
                             SET NEW.`RxFrequency` = NEW.`TxFrequency` + @transmit_offset;
                         ELSE
                             SET NEW.`RxFrequency` = NEW.`TxFrequency` - @transmit_offset;
                         END IF;
                     END IF;
                 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `channel_group_before_upd_trig` BEFORE UPDATE ON `ChannelGroup` FOR EACH ROW BEGIN
                     IF NEW.`FrequencyPlan` != OLD.`FrequencyPlan` || NEW.`TxFrequency` != OLD.`TxFrequency` || NEW.`SuTxFreqCalcMethod` != OLD.`SuTxFreqCalcMethod` THEN
                         IF NEW.`SuTxFreqCalcMethod` = "IMPLICIT" THEN
                             
                             SET @offset_sign = (SELECT `OffsetSign` FROM `FrequencyPlan` WHERE  `FrequencyPlan` = NEW.`FrequencyPlan`);
                             SET @transmit_offset = (SELECT `TransmitOffset` FROM `FrequencyPlan` WHERE  `FrequencyPlan`.`FrequencyPlan` = NEW.`FrequencyPlan`);
                             IF @offset_sign = "+" THEN
                                 SET NEW.`RxFrequency` = NEW.`TxFrequency` + @transmit_offset;
                             ELSE
                                 SET NEW.`RxFrequency` = NEW.`TxFrequency` - @transmit_offset;
                             END IF;
                         END IF;
                     END IF;
                 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ControlChannelProfile`
--

DROP TABLE IF EXISTS `ControlChannelProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ControlChannelProfile` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `ControlChannelProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `CloseControlChannelOnNetworkDown` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `CycleControlChannel` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `DeniedRegistrationTimeSecs` int(10) DEFAULT 0,
  `ControlChannelSlotSize` int(10) DEFAULT 5,
  `ControlChannelRefreshSecs` int(10) DEFAULT 600,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `ControlChannelProfile` (`ControlChannelProfile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ControlChannelProfile`
--

LOCK TABLES `ControlChannelProfile` WRITE;
/*!40000 ALTER TABLE `ControlChannelProfile` DISABLE KEYS */;
INSERT INTO `ControlChannelProfile` (`Id`, `ControlChannelProfile`, `CloseControlChannelOnNetworkDown`, `CycleControlChannel`, `DeniedRegistrationTimeSecs`, `ControlChannelSlotSize`, `ControlChannelRefreshSecs`) VALUES (1,'Default',0,0,0,5,600);
/*!40000 ALTER TABLE `ControlChannelProfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventProfile`
--

DROP TABLE IF EXISTS `EventProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventProfile` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `EventProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `EnableCallEventRecords` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `EnableEventRecords` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `EnableMobilityEventRecords` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `EnableSuppServiceEventRecords` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `EnablePacketDataTransactionRecords` tinyint(2) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `EventProfile` (`EventProfile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventProfile`
--

LOCK TABLES `EventProfile` WRITE;
/*!40000 ALTER TABLE `EventProfile` DISABLE KEYS */;
INSERT INTO `EventProfile` (`Id`, `EventProfile`, `EnableCallEventRecords`, `EnableEventRecords`, `EnableMobilityEventRecords`, `EnableSuppServiceEventRecords`, `EnablePacketDataTransactionRecords`) VALUES (1,'Default',1,1,1,1,1);
/*!40000 ALTER TABLE `EventProfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExternalAdjacentSite`
--

DROP TABLE IF EXISTS `ExternalAdjacentSite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ExternalAdjacentSite` (
  `ExternalAdjacentSite` varchar(50) NOT NULL DEFAULT '',
  `SiteController` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`ExternalAdjacentSite`,`SiteController`),
  KEY `ExternalAdjacentSite_ibfk_1` (`SiteController`),
  CONSTRAINT `ExternalAdjacentSite_FK` FOREIGN KEY (`ExternalAdjacentSite`) REFERENCES `ExternalSite` (`ExternalSite`) ON UPDATE CASCADE,
  CONSTRAINT `ExternalAdjacentSite_ibfk_1` FOREIGN KEY (`SiteController`) REFERENCES `SiteController` (`SiteController`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExternalAdjacentSite`
--

LOCK TABLES `ExternalAdjacentSite` WRITE;
/*!40000 ALTER TABLE `ExternalAdjacentSite` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExternalAdjacentSite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExternalDevice`
--

DROP TABLE IF EXISTS `ExternalDevice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ExternalDevice` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `ExternalDevice` varchar(50) NOT NULL DEFAULT 'Default',
  `ExternalDeviceIpAddress` varchar(20) DEFAULT '127.0.0.1',
  `ExternalDeviceRfssId` int(10) DEFAULT 4,
  `ExternalDeviceSystemId` int(10) DEFAULT 5,
  `ExternalDeviceWacnId` int(10) DEFAULT 6,
  `ExternalDeviceDescription` varchar(200) DEFAULT '',
  `ExternalDeviceType` varchar(50) DEFAULT 'RFSS',
  `ExternalDeviceUse4HexDigitRfssId` tinyint(1) NOT NULL DEFAULT 0,
  `RfssCapabilityPollTime` int(11) DEFAULT 0,
  `ExternalDeviceAgency` varchar(50) DEFAULT NULL,
  `ExternalDeviceVocoderModeCapability` tinyint(1) DEFAULT 3,
  `ExternalDeviceAgencies` varchar(200) DEFAULT NULL,
  `U2URecordingEnabled` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `ExternalDevice` (`ExternalDevice`),
  KEY `ExternalDevice_fk` (`ExternalDeviceAgency`),
  CONSTRAINT `ExternalDevice_fk` FOREIGN KEY (`ExternalDeviceAgency`) REFERENCES `Agency` (`Agency`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExternalDevice`
--

LOCK TABLES `ExternalDevice` WRITE;
/*!40000 ALTER TABLE `ExternalDevice` DISABLE KEYS */;
INSERT INTO `ExternalDevice` (`Id`, `ExternalDevice`, `ExternalDeviceIpAddress`, `ExternalDeviceRfssId`, `ExternalDeviceSystemId`, `ExternalDeviceWacnId`, `ExternalDeviceDescription`, `ExternalDeviceType`, `ExternalDeviceUse4HexDigitRfssId`, `RfssCapabilityPollTime`, `ExternalDeviceAgency`, `ExternalDeviceVocoderModeCapability`, `ExternalDeviceAgencies`, `U2URecordingEnabled`) VALUES (1,'Default','127.0.0.1',4,5,6,'','RFSS',0,0,NULL,3,NULL,0);
/*!40000 ALTER TABLE `ExternalDevice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExternalSite`
--

DROP TABLE IF EXISTS `ExternalSite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ExternalSite` (
  `Id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `ExternalSite` varchar(50) NOT NULL DEFAULT 'Default',
  `ExternalDevice` varchar(50) NOT NULL DEFAULT '',
  `ExternalSiteId` int(11) DEFAULT 0,
  `ExternalSiteLra` int(10) NOT NULL DEFAULT 0,
  `ExternalFreqTx` int(10) NOT NULL DEFAULT 1,
  `ExternalFreqRx` int(10) NOT NULL DEFAULT 1,
  `ExternalServClass` int(10) NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `ExternalSiteName_ibfk_1` (`ExternalSite`),
  UNIQUE KEY `ExternalSiteIdKey` (`ExternalDevice`,`ExternalSiteId`),
  CONSTRAINT `ExternalRFSS_ibfk_2` FOREIGN KEY (`ExternalDevice`) REFERENCES `ExternalDevice` (`ExternalDevice`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExternalSite`
--

LOCK TABLES `ExternalSite` WRITE;
/*!40000 ALTER TABLE `ExternalSite` DISABLE KEYS */;
INSERT INTO `ExternalSite` (`Id`, `ExternalSite`, `ExternalDevice`, `ExternalSiteId`, `ExternalSiteLra`, `ExternalFreqTx`, `ExternalFreqRx`, `ExternalServClass`) VALUES (1,'Default','Default',1,1,1,1,1);
/*!40000 ALTER TABLE `ExternalSite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FleetManager`
--

DROP TABLE IF EXISTS `FleetManager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FleetManager` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `FleetManager` varchar(50) NOT NULL DEFAULT 'Default',
  `FMIpAddress` varchar(20) DEFAULT '127.0.0.1',
  `FMHostname` varchar(50) NOT NULL DEFAULT '',
  `FMSiteId` int(10) DEFAULT 0,
  `FmSuid` int(10) NOT NULL DEFAULT 0,
  `RFSSController` varchar(50) DEFAULT 'Default',
  `LogProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `NifProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `SipProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `McProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `FmIsColocatedWithRfssController` tinyint(1) NOT NULL DEFAULT 1,
  `FmIsHa` tinyint(1) NOT NULL DEFAULT 0,
  `FmHaIpA` varchar(20) DEFAULT '127.0.0.1',
  `FmHaIpB` varchar(20) DEFAULT '127.0.0.1',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `FleetManager` (`FleetManager`),
  KEY `LogProfile` (`LogProfile`),
  KEY `NifProfile` (`NifProfile`),
  KEY `SipProfile` (`SipProfile`),
  KEY `McProfile` (`McProfile`),
  KEY `RlrController_ibfk_5` (`RFSSController`),
  CONSTRAINT `RlrController_ibfk_1` FOREIGN KEY (`LogProfile`) REFERENCES `LogProfile` (`LogProfile`) ON UPDATE CASCADE,
  CONSTRAINT `RlrController_ibfk_2` FOREIGN KEY (`NifProfile`) REFERENCES `NifProfile` (`NifProfile`) ON UPDATE CASCADE,
  CONSTRAINT `RlrController_ibfk_3` FOREIGN KEY (`SipProfile`) REFERENCES `SipProfile` (`SipProfile`) ON UPDATE CASCADE,
  CONSTRAINT `RlrController_ibfk_4` FOREIGN KEY (`McProfile`) REFERENCES `McProfile` (`McProfile`) ON UPDATE CASCADE,
  CONSTRAINT `RlrController_ibfk_5` FOREIGN KEY (`RFSSController`) REFERENCES `RFSSController` (`RFSSController`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FleetManager`
--

LOCK TABLES `FleetManager` WRITE;
/*!40000 ALTER TABLE `FleetManager` DISABLE KEYS */;
INSERT INTO `FleetManager` (`Id`, `FleetManager`, `FMIpAddress`, `FMHostname`, `FMSiteId`, `FmSuid`, `RFSSController`, `LogProfile`, `NifProfile`, `SipProfile`, `McProfile`, `FmIsColocatedWithRfssController`, `FmIsHa`, `FmHaIpA`, `FmHaIpB`) VALUES (1,'Default','127.0.0.1','',0,0,'Default','Default','Default','Default','Default',1,0,'127.0.0.1','127.0.0.1');
/*!40000 ALTER TABLE `FleetManager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FrequencyPlan`
--

DROP TABLE IF EXISTS `FrequencyPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FrequencyPlan` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `FrequencyPlan` varchar(50) NOT NULL DEFAULT 'Default',
  `ChannelIdentifier` int(5) DEFAULT -2,
  `FrequencyPlanId` int(5) DEFAULT -1,
  `FneRxBaseFreq` int(10) DEFAULT 450000000,
  `FneTxBaseFreq` int(10) DEFAULT 459000000,
  `ChannelBandwidthHz` int(10) DEFAULT 12500,
  `ChannelSpacingHz` int(10) DEFAULT 12500,
  `ChannelsInUhfVhfRange` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `OffsetSign` varchar(2) NOT NULL DEFAULT '+',
  `TransmitOffset` int(10) NOT NULL DEFAULT 0,
  `ChannelType` varchar(20) NOT NULL DEFAULT 'FDMA',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `FrequencyPlan` (`FrequencyPlan`),
  UNIQUE KEY `ChannelIdentifier` (`ChannelIdentifier`),
  UNIQUE KEY `FrequencyPlanId` (`FrequencyPlanId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FrequencyPlan`
--

LOCK TABLES `FrequencyPlan` WRITE;
/*!40000 ALTER TABLE `FrequencyPlan` DISABLE KEYS */;
INSERT INTO `FrequencyPlan` (`Id`, `FrequencyPlan`, `ChannelIdentifier`, `FrequencyPlanId`, `FneRxBaseFreq`, `FneTxBaseFreq`, `ChannelBandwidthHz`, `ChannelSpacingHz`, `ChannelsInUhfVhfRange`, `OffsetSign`, `TransmitOffset`, `ChannelType`) VALUES (1,'Default',-1,0,450000000,459000000,12500,12500,1,'-',9000000,'FDMA');
/*!40000 ALTER TABLE `FrequencyPlan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `FrequencyPlan_before_ins_trig` BEFORE INSERT ON `FrequencyPlan` FOR EACH ROW BEGIN
  SET @chanId = NEW.ChannelIdentifier;
  SET @freqPlanId = NEW.FrequencyPlanId;
  IF @freqPlanId != @chanId + 1 THEN
    IF @freqPlanId >= 1 && @freqPlanId <= 16 THEN
      SET NEW.ChannelIdentifier = @freqPlanId - 1;
    ELSE
      IF @chanId >= 0 && @chanId <= 15 THEN
        SET NEW.FrequencyPlanId = @chanId + 1;
      END IF;
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Frequency_plan_before_upd_trig` BEFORE UPDATE ON `FrequencyPlan` FOR EACH ROW BEGIN
  SET @chanId = NEW.ChannelIdentifier;
  SET @freqPlanId = NEW.FrequencyPlanId;
  IF @freqPlanId != @chanId + 1 THEN
    IF @freqPlanId >= 1 && @freqPlanId <= 16 && @freqPlanId != OLD.FrequencyPlanId THEN
      SET NEW.ChannelIdentifier = @freqPlanId - 1;
    ELSE
      IF @chanId >= 0 && @chanId <= 15 THEN
        SET NEW.FrequencyPlanId = @chanId + 1;
      END IF;
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `frequency_plan_after_upd_trig` AFTER UPDATE ON `FrequencyPlan` FOR EACH ROW BEGIN
                     
                     UPDATE `ChannelGroup` AS `CG`
                     SET `CG`.`RxFrequency` = `CG`.`TxFrequency` + NEW.`TransmitOffset`
                     WHERE NEW.`FrequencyPlan` = `CG`.`FrequencyPlan` && `CG`.`SuTxFreqCalcMethod` = "IMPLICIT" && NEW.`OffsetSign` = "+" ;
                     
                     UPDATE `ChannelGroup` AS `CG`
                     SET `CG`.`RxFrequency` = `CG`.`TxFrequency` - NEW.`TransmitOffset`
                     WHERE NEW.`FrequencyPlan` = `CG`.`FrequencyPlan` && `CG`.`SuTxFreqCalcMethod` = "IMPLICIT" && NEW.`OffsetSign` = "-" ;
                     
                 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `LocalProfile`
--

DROP TABLE IF EXISTS `LocalProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LocalProfile` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `LocalProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `LocalGroupServicesAllowed` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `LocalForcedRegOnExitSiteTrunking` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `CommandedRegLimitPerSecond` int(10) DEFAULT 1,
  `LocalRegistrationTimeSecs` int(11) DEFAULT 86400,
  `LocalWorkingUnitIdMin` int(10) DEFAULT 9000000,
  `LocalWorkingUnitIdMax` int(10) DEFAULT 9999999,
  `LocalWorkingGroupIdMin` int(10) DEFAULT 60000,
  `LocalWorkingGroupIdMax` int(10) DEFAULT 65535,
  `GroupRegroupCmdBcastIntervalSec` int(10) DEFAULT 20,
  `GroupRegroupDeleteCmdRepeatCount` int(10) DEFAULT 3,
  `GroupRegroupDeleteCmdRepeatIntervalMs` int(10) DEFAULT 150,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `LocalProfile` (`LocalProfile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LocalProfile`
--

LOCK TABLES `LocalProfile` WRITE;
/*!40000 ALTER TABLE `LocalProfile` DISABLE KEYS */;
INSERT INTO `LocalProfile` (`Id`, `LocalProfile`, `LocalGroupServicesAllowed`, `LocalForcedRegOnExitSiteTrunking`, `CommandedRegLimitPerSecond`, `LocalRegistrationTimeSecs`, `LocalWorkingUnitIdMin`, `LocalWorkingUnitIdMax`, `LocalWorkingGroupIdMin`, `LocalWorkingGroupIdMax`, `GroupRegroupCmdBcastIntervalSec`, `GroupRegroupDeleteCmdRepeatCount`, `GroupRegroupDeleteCmdRepeatIntervalMs`) VALUES (1,'Default',1,0,1,86400,9000000,9999999,60000,65534,20,3,150);
/*!40000 ALTER TABLE `LocalProfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LogProfile`
--

DROP TABLE IF EXISTS `LogProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LogProfile` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `LogProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `ScLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `LoggingSipStack` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `LoggingSipStackLevel` varchar(50) DEFAULT 'NORMAL',
  `RtpLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `NifLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `McLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `GeneralLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `RegistryLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `ThreadLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `SocketLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `RtiLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `ControllerLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `LinkLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `FaultMgrLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `TransceiverLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `ConfiguratorLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `InformationLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `SipaLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `TrxaLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `DataLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `AcctLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `SnmpLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `VlrLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `DfsiVoiceLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `LrIfLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `RgLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `PstngLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `MobileIpLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `PdSnContextLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `PacketDataLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `PdMonLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `DapiLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `OptionsLoggingLevel` varchar(50) DEFAULT 'NORMAL',
  `SanicDebugLog` tinyint(2) unsigned DEFAULT 0,
  `SysloggingIpaddr` varchar(50) NOT NULL DEFAULT 'localhost',
  `SysloggingPort` int(10) unsigned NOT NULL DEFAULT 514,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `LogProfile` (`LogProfile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LogProfile`
--

LOCK TABLES `LogProfile` WRITE;
/*!40000 ALTER TABLE `LogProfile` DISABLE KEYS */;
INSERT INTO `LogProfile` (`Id`, `LogProfile`, `ScLoggingLevel`, `LoggingSipStack`, `LoggingSipStackLevel`, `RtpLoggingLevel`, `NifLoggingLevel`, `McLoggingLevel`, `GeneralLoggingLevel`, `RegistryLoggingLevel`, `ThreadLoggingLevel`, `SocketLoggingLevel`, `RtiLoggingLevel`, `ControllerLoggingLevel`, `LinkLoggingLevel`, `FaultMgrLoggingLevel`, `TransceiverLoggingLevel`, `ConfiguratorLoggingLevel`, `InformationLoggingLevel`, `SipaLoggingLevel`, `TrxaLoggingLevel`, `DataLoggingLevel`, `AcctLoggingLevel`, `SnmpLoggingLevel`, `VlrLoggingLevel`, `DfsiVoiceLoggingLevel`, `LrIfLoggingLevel`, `RgLoggingLevel`, `PstngLoggingLevel`, `MobileIpLoggingLevel`, `PdSnContextLoggingLevel`, `PacketDataLoggingLevel`, `PdMonLoggingLevel`, `DapiLoggingLevel`, `OptionsLoggingLevel`, `SanicDebugLog`, `SysloggingIpaddr`, `SysloggingPort`) VALUES (1,'Default','NORMAL',1,'NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL','NORMAL',0,'localhost',514);
/*!40000 ALTER TABLE `LogProfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `McProfile`
--

DROP TABLE IF EXISTS `McProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `McProfile` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `McProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `RtpMulticastLoopback` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `UseHeartbeat` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `TearDownCallIfNoHeartbeat` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `HeartbeatInterval` int(10) DEFAULT 10,
  `NumberVoiceFramesPerRtpPacket` int(10) DEFAULT 1,
  `GrantedPttNoVoiceTimeout` int(10) DEFAULT 1000,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `McProfile` (`McProfile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `McProfile`
--

LOCK TABLES `McProfile` WRITE;
/*!40000 ALTER TABLE `McProfile` DISABLE KEYS */;
INSERT INTO `McProfile` (`Id`, `McProfile`, `RtpMulticastLoopback`, `UseHeartbeat`, `TearDownCallIfNoHeartbeat`, `HeartbeatInterval`, `NumberVoiceFramesPerRtpPacket`, `GrantedPttNoVoiceTimeout`) VALUES (1,'Default',0,1,1,10,1,1000);
/*!40000 ALTER TABLE `McProfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MobileIpHomeAgent`
--

DROP TABLE IF EXISTS `MobileIpHomeAgent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MobileIpHomeAgent` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MobileIpHomeAgent` varchar(50) NOT NULL,
  `MiphaIpAddress` varchar(20) DEFAULT '127.0.0.1',
  `MiphaKey` varchar(40) DEFAULT '',
  `ExternalDevice` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `MobileIpHomeAgent` (`MobileIpHomeAgent`),
  KEY `MobileIpHomeAgent_fk` (`ExternalDevice`),
  CONSTRAINT `MobileIpHomeAgent_fk` FOREIGN KEY (`ExternalDevice`) REFERENCES `ExternalDevice` (`ExternalDevice`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MobileIpHomeAgent`
--

LOCK TABLES `MobileIpHomeAgent` WRITE;
/*!40000 ALTER TABLE `MobileIpHomeAgent` DISABLE KEYS */;
/*!40000 ALTER TABLE `MobileIpHomeAgent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NetworkSettings`
--

DROP TABLE IF EXISTS `NetworkSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NetworkSettings` (
  `Id` int(2) DEFAULT 1,
  `NtpServerIpAddress1` varchar(20) NOT NULL DEFAULT '127.0.0.1',
  `NtpServerIpAddress2` varchar(20) NOT NULL DEFAULT '',
  `NtpServerIpAddress3` varchar(20) NOT NULL DEFAULT '',
  `SnmpForwardAddress` varchar(20) NOT NULL DEFAULT '127.0.0.1',
  `SnmpCommunity` varchar(32) NOT NULL DEFAULT 'tait_p25',
  `SnmpSysLocation` varchar(255) NOT NULL DEFAULT '',
  `SnmpSysContact` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NetworkSettings`
--

LOCK TABLES `NetworkSettings` WRITE;
/*!40000 ALTER TABLE `NetworkSettings` DISABLE KEYS */;
INSERT INTO `NetworkSettings` (`Id`, `NtpServerIpAddress1`, `NtpServerIpAddress2`, `NtpServerIpAddress3`, `SnmpForwardAddress`, `SnmpCommunity`, `SnmpSysLocation`, `SnmpSysContact`) VALUES (1,'127.0.0.1','','','127.0.0.1','tait_p25','','');
/*!40000 ALTER TABLE `NetworkSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NifProfile`
--

DROP TABLE IF EXISTS `NifProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NifProfile` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `NifProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `Use4HexDigitRfssId` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `UseIssiHeaderWord` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `SNMPEnabled` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `NetworkStatusCheckRespondToPoll` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `NetworkStatusCheckNumRetries` int(10) DEFAULT 0,
  `MinRtpPort` int(10) DEFAULT 17000,
  `MaxRtpPort` int(10) DEFAULT 19998,
  `ResponseTimeout` int(10) DEFAULT 3500,
  `EndToEndTimeout` int(10) DEFAULT 3800,
  `SecondaryResponseTimeout` int(10) DEFAULT 3800,
  `NetworkStatusCheckPeriodWhileDown` int(10) DEFAULT 1,
  `NetworkStatusCheckHitsBeforeUp` int(10) DEFAULT 1,
  `NetworkStatusCheckMissesBeforeDown` int(10) DEFAULT 10,
  `NetworkStatusCheckPeriodWhileUp` int(10) DEFAULT 1,
  `RtpQosDscp` int(10) DEFAULT 46,
  `SipQosDscp` int(10) DEFAULT 26,
  `SNMPNtpSyncStateEnabled` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `SNMPLicenseExpiryDaysRemaining` int(11) DEFAULT 0,
  `SNMPDownlinkTsbkThreshold` int(10) DEFAULT 0,
  `SNMPUplinkTsbkThreshold` int(10) DEFAULT 0,
  `SiteAdjRefreshTime` int(11) DEFAULT 120,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `NifProfile` (`NifProfile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NifProfile`
--

LOCK TABLES `NifProfile` WRITE;
/*!40000 ALTER TABLE `NifProfile` DISABLE KEYS */;
INSERT INTO `NifProfile` (`Id`, `NifProfile`, `Use4HexDigitRfssId`, `UseIssiHeaderWord`, `SNMPEnabled`, `NetworkStatusCheckRespondToPoll`, `NetworkStatusCheckNumRetries`, `MinRtpPort`, `MaxRtpPort`, `ResponseTimeout`, `EndToEndTimeout`, `SecondaryResponseTimeout`, `NetworkStatusCheckPeriodWhileDown`, `NetworkStatusCheckHitsBeforeUp`, `NetworkStatusCheckMissesBeforeDown`, `NetworkStatusCheckPeriodWhileUp`, `RtpQosDscp`, `SipQosDscp`, `SNMPNtpSyncStateEnabled`, `SNMPLicenseExpiryDaysRemaining`, `SNMPDownlinkTsbkThreshold`, `SNMPUplinkTsbkThreshold`, `SiteAdjRefreshTime`) VALUES (1,'Default',0,1,1,1,0,17000,19998,3500,3800,3800,1,1,10,1,46,26,0,0,0,0,120);
/*!40000 ALTER TABLE `NifProfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PSTNGateway`
--

DROP TABLE IF EXISTS `PSTNGateway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PSTNGateway` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `PSTNGateway` varchar(50) NOT NULL DEFAULT 'Default',
  `PSTNGIpAddress` varchar(20) DEFAULT '127.0.0.1',
  `PSTNGHostname` varchar(50) NOT NULL DEFAULT '',
  `PSTNGSiteId` int(10) DEFAULT 0,
  `RFSSController` varchar(50) DEFAULT 'Default',
  `RouterIpAddress` varchar(20) DEFAULT '0.0.0.0',
  `MaxUnitCallDuration` int(10) DEFAULT 90,
  `MaxGroupCallDuration` int(10) DEFAULT 90,
  `CallDurationWarning` int(10) DEFAULT 5,
  `CollectDigitsTimeout` int(10) DEFAULT 15,
  `NetworkConnectingTimeout` int(10) DEFAULT 35,
  `PstnVolumeOffset` int(10) DEFAULT 5,
  `NetworkVolumeOffset` int(10) DEFAULT 5,
  `UsePcmUlaw` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `LogProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `NifProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `SipProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `McProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `PSTNGVocoderModeCapability` tinyint(1) DEFAULT 1,
  `PSTNGIsColocatedWithRfss` tinyint(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `PSTNGateway` (`PSTNGateway`),
  KEY `LogProfile` (`LogProfile`),
  KEY `NifProfile` (`NifProfile`),
  KEY `SipProfile` (`SipProfile`),
  KEY `McProfile` (`McProfile`),
  KEY `PSTNGateway_ibfk_5` (`RFSSController`),
  CONSTRAINT `PSTNGateway_ibfk_1` FOREIGN KEY (`LogProfile`) REFERENCES `LogProfile` (`LogProfile`) ON UPDATE CASCADE,
  CONSTRAINT `PSTNGateway_ibfk_2` FOREIGN KEY (`NifProfile`) REFERENCES `NifProfile` (`NifProfile`) ON UPDATE CASCADE,
  CONSTRAINT `PSTNGateway_ibfk_3` FOREIGN KEY (`SipProfile`) REFERENCES `SipProfile` (`SipProfile`) ON UPDATE CASCADE,
  CONSTRAINT `PSTNGateway_ibfk_4` FOREIGN KEY (`McProfile`) REFERENCES `McProfile` (`McProfile`) ON UPDATE CASCADE,
  CONSTRAINT `PSTNGateway_ibfk_5` FOREIGN KEY (`RFSSController`) REFERENCES `RFSSController` (`RFSSController`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PSTNGateway`
--

LOCK TABLES `PSTNGateway` WRITE;
/*!40000 ALTER TABLE `PSTNGateway` DISABLE KEYS */;
INSERT INTO `PSTNGateway` (`Id`, `PSTNGateway`, `PSTNGIpAddress`, `PSTNGHostname`, `PSTNGSiteId`, `RFSSController`, `RouterIpAddress`, `MaxUnitCallDuration`, `MaxGroupCallDuration`, `CallDurationWarning`, `CollectDigitsTimeout`, `NetworkConnectingTimeout`, `PstnVolumeOffset`, `NetworkVolumeOffset`, `UsePcmUlaw`, `LogProfile`, `NifProfile`, `SipProfile`, `McProfile`, `PSTNGVocoderModeCapability`, `PSTNGIsColocatedWithRfss`) VALUES (1,'Default','127.0.0.1','',0,'Default','0.0.0.0',90,90,10,28,35,5,5,0,'Default','Default','Default','Default',1,0);
/*!40000 ALTER TABLE `PSTNGateway` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PstngEncryptionKeys`
--

DROP TABLE IF EXISTS `PstngEncryptionKeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PstngEncryptionKeys` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PstngEncryptionKeyAlgId` int(2) NOT NULL,
  `PstngEncryptionKeyId` int(5) NOT NULL,
  `PstngEncryptionKeyStatus` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `PstngEncryptionKeys_UN` (`PstngEncryptionKeyAlgId`,`PstngEncryptionKeyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PstngEncryptionKeys`
--

LOCK TABLES `PstngEncryptionKeys` WRITE;
/*!40000 ALTER TABLE `PstngEncryptionKeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `PstngEncryptionKeys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RFSSController`
--

DROP TABLE IF EXISTS `RFSSController`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RFSSController` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `RFSSController` varchar(50) NOT NULL DEFAULT 'Default',
  `RFSSIpAddress` varchar(20) DEFAULT '127.0.0.1',
  `RfssHostname` varchar(50) NOT NULL DEFAULT '',
  `RfssId` int(10) DEFAULT 3,
  `SystemId` int(10) DEFAULT 2,
  `WacnId` int(10) DEFAULT 1,
  `LocalPstngExists` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `LocalPstngSiteAddress` int(10) DEFAULT 180,
  `ConsoleLabel` varchar(50) DEFAULT 'Zetrec Console',
  `TagLabel` varchar(50) DEFAULT 'Main Tag',
  `LrIfDatabaseName` varchar(50) DEFAULT 'rlr',
  `LrIfDatabaseUser` varchar(50) DEFAULT 'RncUser',
  `LrIfDatabasePassword` varchar(50) DEFAULT 'taitadmin',
  `AllowVisitingSUServiceHomeNotAvail` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `NumDstLegsConnectedBeforeCallActive` int(10) DEFAULT 0,
  `CallLegRetryPeriod` int(10) DEFAULT 3000,
  `RegValidationGuardPeriod` int(10) DEFAULT 30,
  `ActiveCallNoPttTimeout` int(10) DEFAULT 30,
  `GroupCallHangTimeExtensionMs` int(10) DEFAULT 100,
  `RfssVocoderModeCapability` varchar(20) DEFAULT 'FullRate',
  `SdCalledHomeTimeout` int(10) DEFAULT 3500,
  `RegistrationPeriod` int(11) DEFAULT 86400,
  `RegValidationPeriod` int(11) DEFAULT 3600,
  `SdCalledServingTimeout` int(10) DEFAULT 3800,
  `SdEndToEndTimeout` int(10) DEFAULT 3800,
  `UnconfConsoleGroupVoicePttArbTimeExtMs` int(10) DEFAULT 3000,
  `LrIfMinVisitorWorkingGroupId` int(10) DEFAULT 60000,
  `LrIfMaxVisitorWorkingGroupId` int(10) DEFAULT 65535,
  `LrIfMinVisitorWorkingUnitId` int(10) DEFAULT 9000000,
  `LrIfMaxVisitorWorkingUnitId` int(10) DEFAULT 9999999,
  `LogProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `NifProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `SipProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `McProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `RfssSystemInfoPort` int(10) DEFAULT 3333,
  `Rfss_IsHA` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `RfssHAIP_A` varchar(20) DEFAULT '127.0.0.1',
  `RfssHAIP_B` varchar(20) DEFAULT '127.0.0.1',
  `RfssHAhost_A` varchar(50) DEFAULT 'localhost',
  `RfssHAhost_B` varchar(50) DEFAULT 'localhost',
  `RfssDRBD_A` varchar(20) DEFAULT '127.0.0.1',
  `RfssDRBD_B` varchar(20) DEFAULT '127.0.0.1',
  `RfssDRBDNetmask` varchar(20) DEFAULT '255.255.255.0',
  `RfssDRBDBandwidth` int(10) DEFAULT 1000,
  `RfssNetCheckIP` varchar(20) DEFAULT '127.0.0.1',
  `EnablePacketData` tinyint(1) DEFAULT 0,
  `SndcpStandbyTime` tinyint(2) NOT NULL DEFAULT 7,
  `LocalMobileIpHomeAgent` varchar(50) DEFAULT NULL,
  `LicenseExpiry_A` varchar(20) DEFAULT '',
  `LicenseExpiry_B` varchar(20) DEFAULT '',
  `LicenseACCESS_A` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicenseACCESS_B` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicensePSTNG_A` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicensePSTNG_B` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicenseINTRAISSI_A` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicenseINTRAISSI_B` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicenseINTERISSI_A` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicenseINTERISSI_B` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicenseENABLEIP_A` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicenseENABLEIP_B` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicenseCSSICON_A` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `LicenseCSSICON_B` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `LicenseTAGCON_A` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `LicenseTAGCON_B` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `LicenseVRCON_A` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `LicenseVRCON_B` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `LicenseCHANWORLD_A` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `LicenseCHANWORLD_B` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `LicenseCHANAUST_A` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `LicenseCHANAUST_B` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `LicenseHA_A` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicenseHA_B` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `RfssDapiEnabled` tinyint(2) NOT NULL DEFAULT 0,
  `RfssDapiIpAddress` varchar(50) NOT NULL DEFAULT '127.0.0.1',
  `RfssDapiPort` int(10) unsigned NOT NULL DEFAULT 3000,
  `MaxNumOfSupergroups` int(10) DEFAULT 20,
  `MaxNumOfSupergroupMembers` int(10) DEFAULT 10,
  `AllowLocalAffiliationToForeignGroup` tinyint(2) NOT NULL DEFAULT 1,
  `EnableExtendedCallRecords` tinyint(2) NOT NULL DEFAULT 0,
  `NumberCallsTrapThreshold` tinyint(3) unsigned NOT NULL DEFAULT 99,
  `NumberCallLegsTrapThreshold` tinyint(3) unsigned NOT NULL DEFAULT 199,
  `CallTrapsRateLimit` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `GroupCallPttDurationLimitSecs` int(10) unsigned NOT NULL DEFAULT 0,
  `UnitCallPttDurationLimitSecs` int(10) unsigned NOT NULL DEFAULT 0,
  `PstngCallPttDurationLimitSecs` int(10) unsigned NOT NULL DEFAULT 0,
  `EnableFneSndcpActivation` tinyint(2) NOT NULL DEFAULT 0,
  `QosChannelPartitionThreshold` tinyint(2) NOT NULL DEFAULT 10,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RFSSController` (`RFSSController`),
  KEY `LogProfile` (`LogProfile`),
  KEY `NifProfile` (`NifProfile`),
  KEY `SipProfile` (`SipProfile`),
  KEY `McProfile` (`McProfile`),
  KEY `RfssController_ibfk_5` (`LocalMobileIpHomeAgent`),
  CONSTRAINT `RfssController_ibfk_1` FOREIGN KEY (`LogProfile`) REFERENCES `LogProfile` (`LogProfile`) ON UPDATE CASCADE,
  CONSTRAINT `RfssController_ibfk_2` FOREIGN KEY (`NifProfile`) REFERENCES `NifProfile` (`NifProfile`) ON UPDATE CASCADE,
  CONSTRAINT `RfssController_ibfk_3` FOREIGN KEY (`SipProfile`) REFERENCES `SipProfile` (`SipProfile`) ON UPDATE CASCADE,
  CONSTRAINT `RfssController_ibfk_4` FOREIGN KEY (`McProfile`) REFERENCES `McProfile` (`McProfile`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RFSSController`
--

LOCK TABLES `RFSSController` WRITE;
/*!40000 ALTER TABLE `RFSSController` DISABLE KEYS */;
INSERT INTO `RFSSController` (`Id`, `RFSSController`, `RFSSIpAddress`, `RfssHostname`, `RfssId`, `SystemId`, `WacnId`, `LocalPstngExists`, `LocalPstngSiteAddress`, `ConsoleLabel`, `TagLabel`, `LrIfDatabaseName`, `LrIfDatabaseUser`, `LrIfDatabasePassword`, `AllowVisitingSUServiceHomeNotAvail`, `NumDstLegsConnectedBeforeCallActive`, `CallLegRetryPeriod`, `RegValidationGuardPeriod`, `ActiveCallNoPttTimeout`, `GroupCallHangTimeExtensionMs`, `RfssVocoderModeCapability`, `SdCalledHomeTimeout`, `RegistrationPeriod`, `RegValidationPeriod`, `SdCalledServingTimeout`, `SdEndToEndTimeout`, `UnconfConsoleGroupVoicePttArbTimeExtMs`, `LrIfMinVisitorWorkingGroupId`, `LrIfMaxVisitorWorkingGroupId`, `LrIfMinVisitorWorkingUnitId`, `LrIfMaxVisitorWorkingUnitId`, `LogProfile`, `NifProfile`, `SipProfile`, `McProfile`, `RfssSystemInfoPort`, `Rfss_IsHA`, `RfssHAIP_A`, `RfssHAIP_B`, `RfssHAhost_A`, `RfssHAhost_B`, `RfssDRBD_A`, `RfssDRBD_B`, `RfssDRBDNetmask`, `RfssDRBDBandwidth`, `RfssNetCheckIP`, `EnablePacketData`, `SndcpStandbyTime`, `LocalMobileIpHomeAgent`, `LicenseExpiry_A`, `LicenseExpiry_B`, `LicenseACCESS_A`, `LicenseACCESS_B`, `LicensePSTNG_A`, `LicensePSTNG_B`, `LicenseINTRAISSI_A`, `LicenseINTRAISSI_B`, `LicenseINTERISSI_A`, `LicenseINTERISSI_B`, `LicenseENABLEIP_A`, `LicenseENABLEIP_B`, `LicenseCSSICON_A`, `LicenseCSSICON_B`, `LicenseTAGCON_A`, `LicenseTAGCON_B`, `LicenseVRCON_A`, `LicenseVRCON_B`, `LicenseCHANWORLD_A`, `LicenseCHANWORLD_B`, `LicenseCHANAUST_A`, `LicenseCHANAUST_B`, `LicenseHA_A`, `LicenseHA_B`, `RfssDapiEnabled`, `RfssDapiIpAddress`, `RfssDapiPort`, `MaxNumOfSupergroups`, `MaxNumOfSupergroupMembers`, `AllowLocalAffiliationToForeignGroup`, `EnableExtendedCallRecords`, `NumberCallsTrapThreshold`, `NumberCallLegsTrapThreshold`, `CallTrapsRateLimit`, `GroupCallPttDurationLimitSecs`, `UnitCallPttDurationLimitSecs`, `PstngCallPttDurationLimitSecs`, `EnableFneSndcpActivation`, `QosChannelPartitionThreshold`) VALUES (1,'Default','127.0.0.1','',3,2,1,0,180,'Zetrec','Main','rlr','RncUser','taitadmin',0,0,3000,30,30,100,'FullRate',3500,86400,3600,3800,3800,3000,60000,65534,9000000,9999999,'Default','Default','Default','Default',3333,0,'127.0.0.1','127.0.0.1','localhost','localhost','127.0.0.1','127.0.0.1','255.255.255.0',1000,'127.0.0.1',0,7,NULL,'','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'127.0.0.1',3000,20,10,1,0,99,199,1,0,0,0,0,10);
/*!40000 ALTER TABLE `RFSSController` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RegistrationProfile`
--

DROP TABLE IF EXISTS `RegistrationProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RegistrationProfile` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `RegistrationProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `EmergencyCallsPreemptive` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `IdleUnitCallTimeSecs` int(10) DEFAULT 0,
  `CommandedRegNoResponseTimeMs` int(10) DEFAULT 1000,
  `CommandedRegNumRetries` int(10) DEFAULT 4,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RegistrationProfile` (`RegistrationProfile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RegistrationProfile`
--

LOCK TABLES `RegistrationProfile` WRITE;
/*!40000 ALTER TABLE `RegistrationProfile` DISABLE KEYS */;
INSERT INTO `RegistrationProfile` (`Id`, `RegistrationProfile`, `EmergencyCallsPreemptive`, `IdleUnitCallTimeSecs`, `CommandedRegNoResponseTimeMs`, `CommandedRegNumRetries`) VALUES (1,'Default',1,0,1000,4);
/*!40000 ALTER TABLE `RegistrationProfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SipProfile`
--

DROP TABLE IF EXISTS `SipProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SipProfile` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `SipProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `LocalPort` int(10) DEFAULT 5060,
  `RetransmissionsOn` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `ShutdownThreadWaitMs` int(10) DEFAULT 100,
  `NoAckTimeout` int(10) DEFAULT 30,
  `NoResponseTimeout` int(10) DEFAULT 30,
  `StrictIssi` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `LocalAllow` varchar(50) DEFAULT 'ACK, BYE, CANCEL, INVITE, REGISTER',
  `LocalAccept` varchar(60) DEFAULT '',
  `SipTransmitOrDieLimit` int(10) unsigned NOT NULL DEFAULT 1000,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `SipProfile` (`SipProfile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SipProfile`
--

LOCK TABLES `SipProfile` WRITE;
/*!40000 ALTER TABLE `SipProfile` DISABLE KEYS */;
INSERT INTO `SipProfile` (`Id`, `SipProfile`, `LocalPort`, `RetransmissionsOn`, `ShutdownThreadWaitMs`, `NoAckTimeout`, `NoResponseTimeout`, `StrictIssi`, `LocalAllow`, `LocalAccept`, `SipTransmitOrDieLimit`) VALUES (1,'Default',5060,1,100,30,30,0,'ACK, BYE, CANCEL, INVITE, REGISTER','application/sdp;level=1, application/x-tia-p25-issi',1000);
/*!40000 ALTER TABLE `SipProfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SiteController`
--

DROP TABLE IF EXISTS `SiteController`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SiteController` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `SiteController` varchar(50) NOT NULL DEFAULT 'Default',
  `SCIpAddress` varchar(20) DEFAULT '',
  `SiteHostname` varchar(50) NOT NULL DEFAULT '',
  `SiteId` int(10) DEFAULT 0,
  `RFSSController` varchar(50) NOT NULL DEFAULT 'Default',
  `TccpVoiceSSRC` int(10) DEFAULT 1,
  `TccpConnectionTimeoutMs` int(10) DEFAULT 30000,
  `TccpHeartbeatPeriodMs` int(10) DEFAULT 5000,
  `Lra` int(10) DEFAULT 0,
  `Nac` int(10) DEFAULT 659,
  `RfssRspTimeMs` int(10) DEFAULT 500,
  `RfssFinalRspTimeSecs` int(10) DEFAULT 6,
  `TccpLocalVoiceRepeat` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `QOSDSCPControl` int(10) DEFAULT 26,
  `QOSDSCPVoice` int(10) DEFAULT 46,
  `SendGroupChannelGrantUpdates` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `RegCmdSourceAddress` varchar(50) DEFAULT 'NoUnit',
  `EventRecordsDirectory` varchar(50) DEFAULT '/home/taitnet/p25sc/event',
  `VlrDirectory` varchar(50) DEFAULT '/home/taitnet/p25sc/vlr',
  `AdjacentSite` varchar(50) DEFAULT '',
  `ControlChannelProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `TrafficChannelProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `LogProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `NifProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `SipProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `McProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `RegistrationProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `CallProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `EventProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `LocalProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `SiteSystemInfoPort` int(10) DEFAULT 3333,
  `Site_IsHA` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `SiteHAIP_A` varchar(20) DEFAULT '127.0.0.1',
  `SiteHAIP_B` varchar(20) DEFAULT '127.0.0.1',
  `SiteHAhost_A` varchar(50) DEFAULT 'localhost',
  `SiteHAhost_B` varchar(50) DEFAULT 'localhost',
  `SiteDRBD_A` varchar(20) DEFAULT '127.0.0.1',
  `SiteDRBD_B` varchar(20) DEFAULT '127.0.0.1',
  `SiteDRBDNetmask` varchar(20) DEFAULT '255.255.255.0',
  `SiteDRBDBandwidth` int(10) DEFAULT 1000,
  `SiteNetCheckIP` varchar(20) DEFAULT '127.0.0.1',
  `SndcpOutboundMsgQTime` int(10) NOT NULL DEFAULT 15,
  `SndcpReadyTime` tinyint(2) unsigned NOT NULL DEFAULT 6,
  `MaxSusPerDataChannel` tinyint(3) unsigned NOT NULL DEFAULT 32,
  `SiteLicenseExpiry_A` varchar(20) DEFAULT '',
  `SiteLicenseExpiry_B` varchar(20) DEFAULT '',
  `LicensePHASE1_A` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `LicensePHASE1_B` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `LicensePHASE2_A` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `LicensePHASE2_B` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `SiteLicenseHA_A` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `SiteLicenseHA_B` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `SiteIsColocatedWithRfss` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `SiteDapiEnabled` tinyint(2) NOT NULL DEFAULT 0,
  `SiteDapiIpAddress` varchar(50) NOT NULL DEFAULT '127.0.0.1',
  `SiteDapiPort` int(10) unsigned NOT NULL DEFAULT 3000,
  `SiteControllerVocoderModeCapability` tinyint(1) DEFAULT 3,
  `SiteSshPort` int(10) unsigned NOT NULL DEFAULT 22,
  `QosChannelPartitionReservedChannels` tinyint(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `SiteController` (`SiteController`),
  KEY `LogProfile` (`LogProfile`),
  KEY `NifProfile` (`NifProfile`),
  KEY `SipProfile` (`SipProfile`),
  KEY `McProfile` (`McProfile`),
  KEY `RegistrationProfile` (`RegistrationProfile`),
  KEY `CallProfile` (`CallProfile`),
  KEY `EventProfile` (`EventProfile`),
  KEY `LocalProfile` (`LocalProfile`),
  KEY `RFSSController` (`RFSSController`),
  KEY `ControlChannelProfile` (`ControlChannelProfile`),
  KEY `TrafficChannelProfile` (`TrafficChannelProfile`),
  CONSTRAINT `SiteController_ibfk_1` FOREIGN KEY (`LogProfile`) REFERENCES `LogProfile` (`LogProfile`) ON UPDATE CASCADE,
  CONSTRAINT `SiteController_ibfk_10` FOREIGN KEY (`ControlChannelProfile`) REFERENCES `ControlChannelProfile` (`ControlChannelProfile`) ON UPDATE CASCADE,
  CONSTRAINT `SiteController_ibfk_11` FOREIGN KEY (`TrafficChannelProfile`) REFERENCES `TrafficChannelProfile` (`TrafficChannelProfile`) ON UPDATE CASCADE,
  CONSTRAINT `SiteController_ibfk_2` FOREIGN KEY (`EventProfile`) REFERENCES `EventProfile` (`EventProfile`) ON UPDATE CASCADE,
  CONSTRAINT `SiteController_ibfk_3` FOREIGN KEY (`LocalProfile`) REFERENCES `LocalProfile` (`LocalProfile`) ON UPDATE CASCADE,
  CONSTRAINT `SiteController_ibfk_4` FOREIGN KEY (`NifProfile`) REFERENCES `NifProfile` (`NifProfile`) ON UPDATE CASCADE,
  CONSTRAINT `SiteController_ibfk_5` FOREIGN KEY (`SipProfile`) REFERENCES `SipProfile` (`SipProfile`) ON UPDATE CASCADE,
  CONSTRAINT `SiteController_ibfk_6` FOREIGN KEY (`McProfile`) REFERENCES `McProfile` (`McProfile`) ON UPDATE CASCADE,
  CONSTRAINT `SiteController_ibfk_7` FOREIGN KEY (`RegistrationProfile`) REFERENCES `RegistrationProfile` (`RegistrationProfile`) ON UPDATE CASCADE,
  CONSTRAINT `SiteController_ibfk_8` FOREIGN KEY (`CallProfile`) REFERENCES `CallProfile` (`CallProfile`) ON UPDATE CASCADE,
  CONSTRAINT `SiteController_ibfk_9` FOREIGN KEY (`RFSSController`) REFERENCES `RFSSController` (`RFSSController`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SiteController`
--

LOCK TABLES `SiteController` WRITE;
/*!40000 ALTER TABLE `SiteController` DISABLE KEYS */;
INSERT INTO `SiteController` (`Id`, `SiteController`, `SCIpAddress`, `SiteHostname`, `SiteId`, `RFSSController`, `TccpVoiceSSRC`, `TccpConnectionTimeoutMs`, `TccpHeartbeatPeriodMs`, `Lra`, `Nac`, `RfssRspTimeMs`, `RfssFinalRspTimeSecs`, `TccpLocalVoiceRepeat`, `QOSDSCPControl`, `QOSDSCPVoice`, `SendGroupChannelGrantUpdates`, `RegCmdSourceAddress`, `EventRecordsDirectory`, `VlrDirectory`, `AdjacentSite`, `ControlChannelProfile`, `TrafficChannelProfile`, `LogProfile`, `NifProfile`, `SipProfile`, `McProfile`, `RegistrationProfile`, `CallProfile`, `EventProfile`, `LocalProfile`, `SiteSystemInfoPort`, `Site_IsHA`, `SiteHAIP_A`, `SiteHAIP_B`, `SiteHAhost_A`, `SiteHAhost_B`, `SiteDRBD_A`, `SiteDRBD_B`, `SiteDRBDNetmask`, `SiteDRBDBandwidth`, `SiteNetCheckIP`, `SndcpOutboundMsgQTime`, `SndcpReadyTime`, `MaxSusPerDataChannel`, `SiteLicenseExpiry_A`, `SiteLicenseExpiry_B`, `LicensePHASE1_A`, `LicensePHASE1_B`, `LicensePHASE2_A`, `LicensePHASE2_B`, `SiteLicenseHA_A`, `SiteLicenseHA_B`, `SiteIsColocatedWithRfss`, `SiteDapiEnabled`, `SiteDapiIpAddress`, `SiteDapiPort`, `SiteControllerVocoderModeCapability`, `SiteSshPort`, `QosChannelPartitionReservedChannels`) VALUES (1,'Default','127.0.0.1','',0,'Default',1,30000,5000,0,659,500,6,1,26,46,1,'NoUnit','/home/taitnet/p25sc/event','/home/taitnet/p25sc/vlr','','Default','Default','Default','Default','Default','Default','Default','Default','Default','Default',3333,0,'127.0.0.1','127.0.0.1','localhost','localhost','127.0.0.1','127.0.0.1','255.255.255.0',1000,'127.0.0.1',15,6,32,'','',1,1,0,0,0,0,0,0,'127.0.0.1',3000,3,22,0);
/*!40000 ALTER TABLE `SiteController` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SndcpContext`
--

DROP TABLE IF EXISTS `SndcpContext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SndcpContext` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SndcpContext` varchar(50) NOT NULL,
  `Nsapi` int(5) DEFAULT 0,
  `Priority` int(5) DEFAULT 1,
  `MobileIpHomeAgent` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `SndcpContext` (`SndcpContext`),
  UNIQUE KEY `SndcpContext_ibfk_2` (`Nsapi`,`MobileIpHomeAgent`),
  KEY `SndcpContext_ibfk_1` (`MobileIpHomeAgent`),
  CONSTRAINT `SndcpContext_ibfk_1` FOREIGN KEY (`MobileIpHomeAgent`) REFERENCES `MobileIpHomeAgent` (`MobileIpHomeAgent`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SndcpContext`
--

LOCK TABLES `SndcpContext` WRITE;
/*!40000 ALTER TABLE `SndcpContext` DISABLE KEYS */;
/*!40000 ALTER TABLE `SndcpContext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SystemDefaults`
--

DROP TABLE IF EXISTS `SystemDefaults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SystemDefaults` (
  `WatchdogMaxResponseTime` int(10) unsigned NOT NULL DEFAULT 10000,
  `SlowDbaseLogThresholdMs` int(10) unsigned NOT NULL DEFAULT 50
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SystemDefaults`
--

LOCK TABLES `SystemDefaults` WRITE;
/*!40000 ALTER TABLE `SystemDefaults` DISABLE KEYS */;
INSERT INTO `SystemDefaults` (`WatchdogMaxResponseTime`, `SlowDbaseLogThresholdMs`) VALUES (15000,50);
/*!40000 ALTER TABLE `SystemDefaults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TableUpdateStatus`
--

DROP TABLE IF EXISTS `TableUpdateStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TableUpdateStatus` (
  `Status` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `SyncStatus` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TableUpdateStatus`
--

LOCK TABLES `TableUpdateStatus` WRITE;
/*!40000 ALTER TABLE `TableUpdateStatus` DISABLE KEYS */;
INSERT INTO `TableUpdateStatus` (`Status`, `SyncStatus`) VALUES (2,1);
/*!40000 ALTER TABLE `TableUpdateStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TrafficChannelProfile`
--

DROP TABLE IF EXISTS `TrafficChannelProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TrafficChannelProfile` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `TrafficChannelProfile` varchar(50) NOT NULL DEFAULT 'Default',
  `TrafficChannelGroupHangTimeOverride` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `TrafficLcMirrorToControlChannel` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `TrafficChannelGroupHangTime` int(10) DEFAULT 0,
  `TrafficChannelPstnHangTime` int(10) DEFAULT 10000,
  `TrafficChannelUnitHangTime` int(10) DEFAULT 10000,
  `TrafficLcRepeatInterval` int(10) DEFAULT 3,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `TrafficChannelProfile` (`TrafficChannelProfile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TrafficChannelProfile`
--

LOCK TABLES `TrafficChannelProfile` WRITE;
/*!40000 ALTER TABLE `TrafficChannelProfile` DISABLE KEYS */;
INSERT INTO `TrafficChannelProfile` (`Id`, `TrafficChannelProfile`, `TrafficChannelGroupHangTimeOverride`, `TrafficLcMirrorToControlChannel`, `TrafficChannelGroupHangTime`, `TrafficChannelPstnHangTime`, `TrafficChannelUnitHangTime`, `TrafficLcRepeatInterval`) VALUES (1,'Default',0,0,0,10000,10000,3);
/*!40000 ALTER TABLE `TrafficChannelProfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transceiver`
--

DROP TABLE IF EXISTS `Transceiver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Transceiver` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `Transceiver` varchar(50) NOT NULL DEFAULT 'Default',
  `ChannelGroup` int(10) NOT NULL DEFAULT 1,
  `TransceiverType` varchar(50) DEFAULT 'TB9100',
  `TccpIpAddress` varchar(20) DEFAULT '0.0.0.0',
  `TccpPort` int(10) DEFAULT 50000,
  `TccpRole` varchar(50) DEFAULT 'PRIMARY',
  `TccpVoicePort` int(10) DEFAULT 50002,
  `TccpConnection` tinyint(2) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UNI_NAME_ON_CHANNEL` (`ChannelGroup`,`Transceiver`),
  KEY `ChannelGroup` (`ChannelGroup`),
  CONSTRAINT `Transceiver_ibfk_1` FOREIGN KEY (`ChannelGroup`) REFERENCES `ChannelGroup` (`Id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transceiver`
--

LOCK TABLES `Transceiver` WRITE;
/*!40000 ALTER TABLE `Transceiver` DISABLE KEYS */;
INSERT INTO `Transceiver` (`Id`, `Transceiver`, `ChannelGroup`, `TransceiverType`, `TccpIpAddress`, `TccpPort`, `TccpRole`, `TccpVoicePort`, `TccpConnection`) VALUES (1,'Default',1,'TB9100','127.0.0.1',50000,'PRIMARY',50002,1);
/*!40000 ALTER TABLE `Transceiver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `LoginName` varchar(50) NOT NULL,
  `Name` varchar(100) DEFAULT '',
  `Comment` varchar(255) DEFAULT '',
  `Password` varchar(100) DEFAULT 'b0dc8628268498345fd458b853b8f494',
  `PasswordTimestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `AccessLevel` tinyint(1) unsigned DEFAULT 0,
  `Role` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`Id`,`LoginName`),
  UNIQUE KEY `LoginName` (`LoginName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` (`Id`, `LoginName`, `Name`, `Comment`, `Password`, `PasswordTimestamp`, `AccessLevel`, `Role`) VALUES (1,'taitnet','taitnet','','bdaf6c547b976d37758139360a2ccc25','0000-00-00 00:00:00',4,0);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ValidateData`
--

DROP TABLE IF EXISTS `ValidateData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ValidateData` (
  `FieldName` varchar(50) NOT NULL,
  `TableName` varchar(50) DEFAULT NULL,
  `FieldType` varchar(50) NOT NULL,
  `MinValue` varchar(100) DEFAULT NULL,
  `MaxValue` varchar(100) DEFAULT NULL,
  `DefValue` varchar(50) DEFAULT NULL,
  `Visible` varchar(50) DEFAULT NULL,
  `ValidationMethod` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`FieldName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ValidateData`
--

LOCK TABLES `ValidateData` WRITE;
/*!40000 ALTER TABLE `ValidateData` DISABLE KEYS */;
INSERT INTO `ValidateData` (`FieldName`, `TableName`, `FieldType`, `MinValue`, `MaxValue`, `DefValue`, `Visible`, `ValidationMethod`) VALUES ('AcctLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('ActiveCallNoPttTimeout','RFSSController','Integer','1','86400','30','Internal',''),('AdjacentExternalSite','','Belongs','','','','Container','Name'),('AdjacentSite','','AdjacentSite','','','','Container',''),('AdjacentSiteName','','String','','','','Internal',''),('AdjacentSites','','String','','','','Internal',''),('AdjacentSitesList','','String','','','','Internal',''),('AdjChanChannelIdentifier','','Integer','0','15','0','Internal',''),('AdjChanChannelIdentifierRx','','Integer','0','15','0','Internal',''),('AdjChanLra','','Integer','0','254','0','Internal',''),('AdjChanRfssId','','HexDisplay','1','254','3','Internal',''),('AdjChanRxFrequency','','Integer','1','999999999','450000000','Internal',''),('AdjChanSiteId','','HexDisplay','1','254','1','Internal',''),('AdjChanSystemId','','HexDisplay','1','4094','2','Internal',''),('AdjChanTxFrequency','','Integer','1','999999999','450000000','Internal',''),('AdjChanWacnId','','HexDisplay','1','1048574','1','Internal',''),('AdjExtSitesNotifyList','','String','','','','Internal',''),('AdjExtSitesRfssList','','String','','','','Internal',''),('AdjRfssNotifyList','','String','','','','Internal',''),('AdjRfssRefreshList','','String','','','','Internal',''),('AdjSitesNotifyList','','String','','','','Internal',''),('AdjSitesRefreshList','','String','','','','Internal',''),('Agency','Agency','String','','','','WebGUI','Name'),('agt_name','ip_data_pool','String','','','','WebGUI',''),('AllowLocalAffiliationToForeignGroup','RFSSController','Boolean','','','FALSE','Internal',''),('AllowLocalCallAfterNoRfssResponse','CallProfile','Boolean','','','FALSE','WebGUI',''),('AllowLocalCallWhenEnterExitSiteTrunking','CallProfile','Boolean','','','FALSE','WebGUI',''),('AllowNormalGroupCallWhileAnnouncementGroupCall','CallProfile','Boolean','','','TRUE','WebGUI',''),('AllowPacketDataOnInhibit','CallProfile','Boolean','','','FALSE','WebGUI',''),('AllowVisitingSUServiceHomeNotAvail','RFSSController','Boolean','','','FALSE','WebGUI',''),('CallDurationWarning','PSTNGateway','Integer','0','999','5','Internal',''),('CallLegRetryPeriod','RFSSController','Integer','1000','20000','3000','Internal',''),('CallProfile','','Profile','9','','','Container','Name'),('CallTrapsRateLimit','RFSSController','Integer','1','600','1','WebGUI',''),('CallTypePriorityData','CallProfile','Integer','1','10','1','Internal',''),('CallTypePriorityGroup','CallProfile','Integer','1','10','7','Internal',''),('CallTypePriorityPstn','CallProfile','Integer','1','10','3','Internal',''),('CallTypePriorityUnitToUnit','CallProfile','Integer','1','10','5','Internal',''),('ChannelBandwidthHz','FrequencyPlan','Integer','6250','12500','12500','WebGUI',''),('ChannelGroup','','String','','','','Internal','Name'),('ChannelGroupId','','Integer','0','32','0','Internal',''),('ChannelGroupLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('ChannelGroups','','String','','','','Internal',''),('ChannelIdentifier','FrequencyPlan','Integer','0','15','-1','WebGUI',''),('ChannelIdentifierRx','ChannelGroup','Integer','0','15','-1','WebGUI',''),('ChannelIdentifierTdma','ChannelGroup','Integer','0','15','-1','WebGUI',''),('ChannelIdentifierTdmaRx','ChannelGroup','Integer','0','15','-1','WebGUI',''),('ChannelsInUhfVhfRange','FrequencyPlan','Boolean','','','TRUE','WebGUI – ReadOnly',''),('ChannelSpacingHz','FrequencyPlan','Integer','3125','50000','12500','WebGUI','divisible by 125'),('ChannelType','FrequencyPlan','Choice','FDMA TDMA','','FDMA','WebGUI',''),('CloseControlChannelOnNetworkDown','ControlChannelProfile','Boolean','','','FALSE','Internal',''),('CollectDigitsTimeout','PSTNGateway','Integer','0','999','15','Internal',''),('CommandedRegLimitPerSecond','LocalProfile','Integer','1','5','1','WebGUI',''),('CommandedRegNoResponseTimeMs','RegistrationProfile','Integer','0','99999','1000','Internal',''),('CommandedRegNumRetries','RegistrationProfile','Integer','0','10','4','Internal',''),('ConfiguratorLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('ConsoleLabel','RFSSController','String','','','Zetrec Console','Internal',''),('ControlChannelList','','String','','','','Internal',''),('ControlChannelProfile','','Profile','2','','','Container','Name'),('ControlChannelRefreshSecs','ControlChannelProfile','Integer','0','9999','600','Internal',''),('ControlChannelSlotSize','ControlChannelProfile','Integer','1','20','5','obsolete',''),('ControlChannelType','ChannelGroup','Choice','PRIMARY BACKUP NEVER','','PRIMARY','WebGUI',''),('ControllerLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('CycleControlChannel','ControlChannelProfile','Boolean','','','FALSE','Internal',''),('DapiLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('DataLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('DeniedRegistrationTimeSecs','ControlChannelProfile','Integer','0','99999','0','Internal',''),('Description','Agency','String','','','','WebGUI',''),('DfsiVoiceLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('EmergencyCallsPreemptive','RegistrationProfile','Boolean','','','TRUE','obsolete',''),('EnableCallEventRecords','EventProfile','Boolean','','','FALSE','Internal',''),('EnableEventRecords','EventProfile','Boolean','','','FALSE','Internal',''),('EnableExtendedCallRecords','RFSSController','Boolean','','','FALSE','Internal',''),('EnableFneSndcpActivation','RFSSController','Boolean','','','FALSE','Internal',''),('EnableMobilityEventRecords','EventProfile','Boolean','','','FALSE','Internal',''),('EnablePacketData','RFSSController','Boolean','','','FALSE','WebGUI',''),('EnablePacketDataTransactionRecords','EventProfile','Boolean','','','TRUE','WebGUI',''),('EnableSuppServiceEventRecords','EventProfile','Boolean','','','FALSE','Internal',''),('EndToEndTimeout','NifProfile','Integer','100','99999','3800','Internal',''),('EventProfile','','Profile','A','','','Container','Name'),('EventRecordsDirectory','SiteController','String','','','/home/taitnet/p25sc/event','Internal',''),('ExternalAdjacentSite','','Belongs','','','','Container','Name'),('ExternalAdjacentSites','','String','','','','Internal',''),('ExternalDevice','','Belongs','7','','','Container','Name'),('ExternalDeviceAgencies','ExternalDevice','String','','','','WebGUI',''),('ExternalDeviceAgency','ExternalDevice','String','','','','WebGUI',''),('ExternalDeviceDescription','ExternalDevice','String','','','','WebGUI',''),('ExternalDeviceIpAddress','ExternalDevice','IP','','','127.0.0.1','WebGUI',''),('ExternalDeviceRfssId','ExternalDevice','HexDisplay','1','65535','4','WebGUI',''),('ExternalDeviceSystemId','ExternalDevice','HexDisplay','1','4094','5','WebGUI',''),('ExternalDeviceType','ExternalDevice','Choice','RFSS Console_Subsystem Voice_Recorder Mobile_IP_Router','','RFSS','WebGUI',''),('ExternalDeviceUse4HexDigitRfssId','ExternalDevice','Boolean','','','FALSE','WebGUI',''),('ExternalDeviceVocoderModeCapability','ExternalDevice','Integer','0','4','3','WebGUI',''),('ExternalDeviceWacnId','ExternalDevice','HexDisplay','1','1048574','6','WebGUI',''),('ExternalFreqRx','ExternalSite','HexDisplay','0','65535','1','WebGUI',''),('ExternalFreqTx','ExternalSite','HexDisplay','0','65535','1','WebGUI',''),('ExternalRfssName','','String','','','','Internal',''),('ExternalServClass','ExternalSite','HexDisplay','0','255','1','WebGUI',''),('ExternalSite','','Belongs','8','','','Container','Name'),('ExternalSiteId','ExternalSite','HexDisplay','1','254','1','WebGUI',''),('ExternalSiteLra','ExternalSite','Integer','0','254','0','WebGUI',''),('FaultMgrLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('FdmaEnabled','ChannelGroup','Boolean','','','TRUE','WebGUI',''),('FleetManager','','Belongs','2','','','Container','Name'),('FleetManagerConfig','','String','','','','Internal',''),('FmHaIpA','FleetManager','IP','','','127.0.0.1','WebGUI',''),('FmHaIpB','FleetManager','IP','','','127.0.0.1','WebGUI',''),('FMHostname','FleetManager','String','','','','WebGUI','HostName'),('FMIpAddress','FleetManager','IP','','','127.0.0.1','WebGUI',''),('FmIsColocatedWithRfssController','FleetManager','Boolean','','','TRUE','WebGUI',''),('FmIsHa','FleetManager','Boolean','','','FALSE','WebGUI',''),('FMSiteId','FleetManager','SiteId','1','254','254','WebGUI',''),('FmSuid','FleetManager','HexDisplay','1','16777215','0','WebGUI',''),('FneRxBaseFreq','FrequencyPlan','Integer','1','999999999','450000000','WebGUI','divisible by 5'),('FneTxBaseFreq','FrequencyPlan','Integer','1','999999999','459000000','WebGUI','divisible by 5'),('FrequencyPlan','','String','1','','','Container','Name'),('FrequencyPlanId','FrequencyPlan','Integer','1','16','0','WebGUI',''),('FrequencyPlanRx','ChannelGroup','String','','','','WebGUI',''),('FrequencyPlans','','String','','','','Internal',''),('FrequencyPlanTdma','ChannelGroup','String','','','','WebGUI',''),('FrequencyPlanTdmaRx','ChannelGroup','String','','','','WebGUI',''),('GeneralLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('GrantedPttNoVoiceTimeout','McProfile','Integer','0','3000','1000','Internal',''),('GroupCallHangTimeExtensionMs','RFSSController','Integer','0','500','100','Internal',''),('GroupCallPttDurationLimitSecs','RFSSController','Integer','0','600','0','Internal',''),('GroupRegroupCmdBcastIntervalSec','LocalProfile','Integer','20','3600','20','WebGUI',''),('GroupRegroupDeleteCmdRepeatCount','LocalProfile','Integer','0','5','3','Internal',''),('GroupRegroupDeleteCmdRepeatIntervalMs','LocalProfile','Integer','50','5000','150','Internal',''),('HeartbeatInterval','McProfile','Integer','0','999','10','Internal',''),('Id','','Id','','','0','Internal',''),('IdleGroupCallTimeSecs','CallProfile','Integer','1','120','30','Internal',''),('IdleUnitCallTimeSecs','RegistrationProfile','Integer','0','0','0','Internal',''),('InformationLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('ip_address_start','ip_data_pool','String','','','127.0.0.1','WebGUI','IpCidr'),('ip_data_pool','ip_data_pool','String','','','','WebGUI','Name'),('IssiSndcpContexts','','String','','','','Internal',''),('Label','','String','','','','Internal',''),('License','RFSSController','String','','','','obsolete',''),('LicenseACCESS_A','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicenseACCESS_B','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicenseCHANAUST_A','RFSSController','Integer','0','100','0','WebGUI',''),('LicenseCHANAUST_B','RFSSController','Integer','0','100','0','WebGUI',''),('LicenseCHANWORLD_A','RFSSController','Integer','0','100','0','WebGUI',''),('LicenseCHANWORLD_B','RFSSController','Integer','0','100','0','WebGUI',''),('LicenseCSSICON_A','RFSSController','Integer','0','20','0','WebGUI',''),('LicenseCSSICON_B','RFSSController','Integer','0','20','0','WebGUI',''),('LicenseENABLEIP_A','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicenseENABLEIP_B','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicenseExpiry_A','RFSSController','String','','','','WebGUI',''),('LicenseExpiry_B','RFSSController','String','','','','WebGUI',''),('LicenseHA_A','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicenseHA_B','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicenseINTERISSI_A','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicenseINTERISSI_B','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicenseINTRAISSI_A','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicenseINTRAISSI_B','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicensePHASE1_A','SiteController','Boolean','','','TRUE','WebGUI',''),('LicensePHASE1_B','SiteController','Boolean','','','TRUE','WebGUI',''),('LicensePHASE2_A','SiteController','Boolean','','','FALSE','WebGUI',''),('LicensePHASE2_B','SiteController','Boolean','','','FALSE','WebGUI',''),('LicensePSTNG_A','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicensePSTNG_B','RFSSController','Boolean','','','FALSE','WebGUI',''),('LicenseTAGCON_A','RFSSController','Integer','0','20','0','WebGUI',''),('LicenseTAGCON_B','RFSSController','Integer','0','20','0','WebGUI',''),('LicenseVRCON_A','RFSSController','Integer','0','20','0','WebGUI',''),('LicenseVRCON_B','RFSSController','Integer','0','20','0','WebGUI',''),('LinkLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('LocalAccept','SipProfile','String','','','application/sdp;level=1, application/x-tia-p25-iss','Internal',''),('LocalAllow','SipProfile','String','','','ACK, BYE, CANCEL, INVITE, REGISTER','Internal',''),('LocalForcedRegOnExitSiteTrunking','LocalProfile','Boolean','','','FALSE','WebGUI',''),('LocalGroupServicesAllowed','LocalProfile','Boolean','','','TRUE','WebGUI',''),('LocalIpAddress','','String','','','','Internal',''),('LocalMobileIpHomeAgent','RFSSController','String','','','','WebGUI',''),('LocalPort','SipProfile','Integer','5060','5060','5060','Internal',''),('LocalProfile','','Profile','B','','','Container','Name'),('LocalPstngExists','RFSSController','Boolean','','','FALSE','Unknown',''),('LocalPstngSiteAddress','RFSSController','Integer','1','254','180','WebGUI',''),('LocalRegistrationTimeSecs','LocalProfile','Integer','5','86400','86400','WebGUI',''),('LocalSndcpContexts','','String','','','','Internal',''),('LocalWorkingGroupIdMax','LocalProfile','Integer','0','65534','65534','Internal',''),('LocalWorkingGroupIdMin','LocalProfile','Integer','0','65534','60000','Internal',''),('LocalWorkingUnitIdMax','LocalProfile','Integer','0','9999999','9999999','Internal',''),('LocalWorkingUnitIdMin','LocalProfile','Integer','0','9999999','9000000','Internal',''),('Location','','String','','','','Internal',''),('LoggingSipStack','LogProfile','Boolean','','','TRUE','WebGUI',''),('LoggingSipStackLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('LogProfile','','Profile','5','','','Container','Name'),('Lra','SiteController','Integer','0','254','0','WebGUI',''),('LrIfDatabaseHost','RFSSController','IP','','','127.0.0.1','Internal',''),('LrIfDatabaseName','RFSSController','String','','','rlr','Internal',''),('LrIfDatabasePassword','RFSSController','String','','','taitadmin','Internal',''),('LrIfDatabaseUser','RFSSController','String','','','RncUser','Internal',''),('LrIfLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('LrIfMaxVisitorWorkingGroupId','RFSSController','Integer','0','65535','65535','Internal',''),('LrIfMaxVisitorWorkingUnitId','RFSSController','Integer','0','9999999','9999999','Internal',''),('LrIfMinVisitorWorkingGroupId','RFSSController','Integer','0','65535','60000','Internal',''),('LrIfMinVisitorWorkingUnitId','RFSSController','Integer','0','9999999','9000000','Internal',''),('MaxGroupCallDuration','PSTNGateway','Integer','0','999','90','WebGUI',''),('MaxNumOfSupergroupMembers','RFSSController','Integer','2','10','10','WebGUI',''),('MaxNumOfSupergroups','RFSSController','Integer','0','50','50','WebGUI',''),('MaxQueueCallRequests','CallProfile','Integer','0','99','5','WebGUI',''),('MaxQueueTimeSecs','CallProfile','Integer','0','99','10','Internal',''),('MaxRtpPort','NifProfile','Integer','1025','65534','19998','Internal',''),('MaxSusPerDataChannel','SiteController','Integer','1','255','32','WebGUI',''),('MaxUnitCallDuration','PSTNGateway','Integer','0','999','90','WebGUI',''),('McLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('McProfile','','Profile','8','','','Container','Name'),('MinFdmaRfChannels','SiteController','Integer','0','32','0','WebGUI',''),('MinRtpPort','NifProfile','Integer','1025','65534','17000','Internal',''),('MinTdmaRfChannels','SiteController','Integer','0','32','0','WebGUI',''),('MinTimeGrantToTrafficRecvdMs','CallProfile','Integer','0','9999','1000','Internal',''),('MiphaIpAddress','MobileIpHomeAgent','IP','','','127.0.0.1','WebGUI',''),('MiphaKey','MobileIpHomeAgent','String','','','','WebGUI','MiphaKey'),('MobileIpHomeAgent','','String','','','','Internal','Name'),('MobileIpLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('Nac','SiteController','HexDisplay','1','65535','659','WebGUI',''),('NetworkConnectingTimeout','PSTNGateway','Integer','0','999','35','WebGUI',''),('NetworkStatusCheckHitsBeforeUp','NifProfile','Integer','0','99','1','WebGUI',''),('NetworkStatusCheckMissesBeforeDown','NifProfile','Integer','0','99','10','WebGUI',''),('NetworkStatusCheckNumRetries','NifProfile','Integer','0','99','0','Internal',''),('NetworkStatusCheckPeriodWhileDown','NifProfile','Integer','0','60','1','WebGUI',''),('NetworkStatusCheckPeriodWhileUp','NifProfile','Integer','0','60','1','WebGUI',''),('NetworkStatusCheckRespondToPoll','NifProfile','Boolean','','','TRUE','Internal',''),('NetworkVolumeOffset','PSTNGateway','Integer','0','99','5','Internal',''),('NifLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('NifProfile','','Profile','6','','','Container','Name'),('NoAckTimeout','SipProfile','Integer','0','600','30','Internal',''),('NoResponseTimeout','SipProfile','Integer','0','600','30','Internal',''),('Nsapi','SndcpContext','Integer','1','14','1','WebGUI',''),('NtpServerIpAddress1','NetworkSettings','IP','','','127.0.0.1','WebGUI',''),('NtpServerIpAddress2','NetworkSettings','IP','','','','WebGUI',''),('NtpServerIpAddress3','NetworkSettings','IP','','','','WebGUI',''),('NumberCallLegsTrapThreshold','RFSSController','Integer','1','199','199','WebGUI',''),('NumberCallsTrapThreshold','RFSSController','Integer','1','99','99','WebGUI',''),('NumberCallTerminators','CallProfile','Integer','0','9','3','Internal',''),('NumberOfConfiguredSites','RFSSController','Integer','0','20','0','Internal',''),('NumberOfConfiguredTransceivers','RFSSController','Integer','0','128','0','Internal',''),('NumberVoiceFramesPerRtpPacket','McProfile','Integer','1','3','1','Internal',''),('NumDstLegsConnectedBeforeCallActive','RFSSController','Integer','0','5','0','Internal',''),('OffsetSign','FrequencyPlan','Choice','+ -','','+','WebGUI',''),('OptionsLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('OspMaxRetryCount','CallProfile','Integer','0','99','3','Internal',''),('OspRetryTimeMs','CallProfile','Integer','0','9999','500','Internal',''),('PacketDataLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('PdMonLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('PdSnContextLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('PifLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','obsolete',''),('pool_type','ip_data_pool','Integer','0','1','0','WebGUI',''),('PreemptIdleUplinkCallsOnly','CallProfile','Boolean','','','TRUE','Internal',''),('PreemptivePriorityLevel','CallProfile','Integer','0','999','32','obsolete',''),('Priority','SndcpContext','Integer','0','15','1','WebGUI',''),('PSTNGateway','','Belongs','6','','','Container','Name'),('PSTNGatewayConfig','','String','','','','Internal',''),('PstngCallPttDurationLimitSecs','RFSSController','Integer','0','600','0','Internal',''),('PstngEncryptionKeyAlgId','PstngEncryptionKeys','Integer','0','0','','Internal',''),('PstngEncryptionKeyId','PstngEncryptionKeys','Integer','0','65535','','Internal',''),('PstngEncryptionKeys','','Belongs','','','','Container','Name'),('PstngEncryptionKeyStatus','PstngEncryptionKeys','Boolean','','','0','Internal',''),('PSTNGHostname','PSTNGateway','String','','','','WebGUI','HostName'),('PSTNGIpAddress','PSTNGateway','IP','','','127.0.0.1','WebGUI',''),('PSTNGIsColocatedWithRfss','PSTNGateway','Boolean','','','False','WebGUI',''),('PstngLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('PSTNGSiteId','PSTNGateway','SiteId','1','254','253','WebGUI',''),('PSTNGVocoderModeCapability','PSTNGateway','Integer','0','4','1','WebGUI',''),('PstnVolumeOffset','PSTNGateway','Integer','0','99','5','Internal',''),('QosChannelPartitionReservedChannels','SiteController','Integer','0','24','0','WebGUI',''),('QosChannelPartitionThreshold','RFSSController','Integer','2','10','10','WebGUI',''),('QOSDSCPControl','SiteController','Integer','0','63','26','WebGUI',''),('QOSDSCPVoice','SiteController','Integer','0','63','46','WebGUI',''),('RegCmdSourceAddress','SiteController','Choice','NoUnit RegDefault SystemDefault AllUnit MatchTargetAddress','','NoUnit','Internal',''),('RegistrationPeriod','RFSSController','Integer','1','172800','86400','WebGUI',''),('RegistrationProfile','','Profile','4','','','Container','Name'),('RegistryLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('RegValidationGuardPeriod','RFSSController','Integer','1','600','30','Internal',''),('RegValidationPeriod','RFSSController','Integer','0','4294967295','3600','Internal',''),('ResponseTimeout','NifProfile','Integer','100','99999','3500','Internal',''),('RetransmissionsOn','SipProfile','Boolean','','','TRUE','Internal',''),('RfssCapabilityPollTime','ExternalDevice','Integer','0','86400','0','WebGui',''),('RFSSController','','Belongs','1','','','Container','Name'),('RFSSControllerConfig','','String','','','','Internal',''),('RfssDapiEnabled','RFSSController','Boolean','','','FALSE','WebGUI',''),('RfssDapiIpAddress','RFSSController','IP','','','127.0.0.1','WebGUI',''),('RfssDapiPort','RFSSController','Integer','1023','65535','0','WebGUI',''),('RfssDRBDBandwidth','RFSSController','Integer','10','1000','1000','WebGUI',''),('RfssDRBDNetmask','RFSSController','IP','','','255.255.255.0','WebGUI',''),('RfssDRBD_A','RFSSController','IP','','','127.0.0.1','WebGUI',''),('RfssDRBD_B','RFSSController','IP','','','127.0.0.1','WebGUI',''),('RfssFinalRspTimeSecs','SiteController','Integer','0','99','6','Internal',''),('RfssHAhost_A','RFSSController','String','','','localhost','WebGUI','HostName'),('RfssHAhost_B','RFSSController','String','','','localhost','WebGUI','HostName'),('RfssHAIP_A','RFSSController','IP','','','127.0.0.1','WebGUI',''),('RfssHAIP_B','RFSSController','IP','','','127.0.0.1','WebGUI',''),('RfssHostname','RFSSController','String','','','','WebGUI','HostName'),('RfssId','RFSSController','HexDisplay','1','254','3','WebGUI',''),('RFSSIpAddress','RFSSController','IP','','','127.0.0.1','WebGUI',''),('RFSSManagerConfig','','String','','','','Internal',''),('RfssNetCheckIP','RFSSController','IP','','','127.0.0.1','WebGUI',''),('RfssRspTimeMs','SiteController','Integer','0','99999','500','Internal',''),('RfssSystemInfoPort','RFSSController','Integer','1024','49151','3333','WebGUI',''),('RfssVocoderModeCapability','RFSSController','Choice','FullRate HalfRate FullRate/HalfRate Native','','FullRate','obsolete',''),('Rfss_IsHA','RFSSController','Boolean','','','FALSE','WebGUI',''),('RgLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('RmAciListenHost','RM','String','','','localhost','WebGUI','HostName'),('RmAciListenPort','RM','Integer','1023','65535','6090','Internal',''),('RmCliListenHost','RM','String','','','localhost','WebGUI','HostName'),('RmCliListenPort','RM','Integer','1023','65535','6521','Internal',''),('RmNifListenPort','RM','Integer','1023','65535','6522','Internal',''),('RouterIpAddress','PSTNGateway','IP','','','0.0.0.0','WebGUI',''),('RtiLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('RtpLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('RtpMulticastLoopback','McProfile','Boolean','','','FALSE','Internal',''),('RtpQosDscp','NifProfile','Integer','0','63','46','WebGUI',''),('RxFrequency','ChannelGroup','Integer','1','999999999','450000000','WebGUI','divisible by 5'),('RxTransceivers','ChannelGroup','String','','','','Internal',''),('SanicDebugLog','LogProfile','Boolean','','','FALSE','WebGUI',''),('SCIpAddress','SiteController','IP','','','127.0.0.1','WebGUI',''),('ScLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('SdCalledHomeTimeout','RFSSController','Integer','500','9500','3500','Internal',''),('SdCalledServingTimeout','RFSSController','Integer','800','9800','3800','Internal',''),('SdEndToEndTimeout','RFSSController','Integer','800','9800','3800','Internal',''),('SecondaryResponseTimeout','NifProfile','Integer','100','99999','3800','Internal',''),('SelectionPriority','ChannelGroup','Integer','0','9','0','Unknown',''),('SendGroupChannelGrantUpdates','SiteController','Boolean','','','TRUE','Internal',''),('ServerCompatibleVers','','','1000','1001','','Internal',''),('ShutdownThreadWaitMs','SipProfile','Integer','0','10000','100','Internal',''),('SipaLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('SipLoggingStackPath','SipProfile','String','','','','??????',''),('SipProfile','','Profile','7','','','Container','Name'),('SipQosDscp','NifProfile','Integer','0','63','26','WebGUI',''),('SipTransmitOrDieLimit','SipProfile','Integer','0','10000','1000','Internal',''),('SiteAdjRefreshTime','NifProfile','Integer','0','86400','120','WebGui',''),('SiteController','','Belongs','3','','','Container','Name'),('SiteControllerConfig','','String','','','','Internal',''),('SiteControllerVocoderModeCapability','SiteController','Integer','0','4','3','WebGUI',''),('SiteDapiEnabled','SiteController','Boolean','','','FALSE','WebGUI',''),('SiteDapiIpAddress','SiteController','IP','','','127.0.0.1','WebGUI',''),('SiteDapiPort','SiteController','Integer','1023','65535','0','WebGUI',''),('SiteDRBDBandwidth','SiteController','Integer','10','1000','1000','WebGUI',''),('SiteDRBDNetmask','SiteController','IP','','','255.255.255.0','WebGUI',''),('SiteDRBD_A','SiteController','IP','','','127.0.0.1','WebGUI',''),('SiteDRBD_B','SiteController','IP','','','127.0.0.1','WebGUI',''),('SiteHAhost_A','SiteController','String','','','localhost','WebGUI','HostName'),('SiteHAhost_B','SiteController','String','','','localhost','WebGUI','HostName'),('SiteHAIP_A','SiteController','IP','','','127.0.0.1','WebGUI',''),('SiteHAIP_B','SiteController','IP','','','127.0.0.1','WebGUI',''),('SiteHostname','SiteController','String','','','','WebGUI','HostName'),('SiteId','SiteController','SiteId','1','254','12','WebGUI',''),('SiteIsColocatedWithRfss','SiteController','Boolean','','','FALSE','WebGUI',''),('SiteLicenseExpiry_A','SiteController','String','','','','WebGUI',''),('SiteLicenseExpiry_B','SiteController','String','','','','WebGUI',''),('SiteLicenseHA_A','SiteController','Boolean','','','FALSE','WebGUI',''),('SiteLicenseHA_B','SiteController','Boolean','','','FALSE','WebGUI',''),('SiteNetCheckIP','SiteController','IP','','','127.0.0.1','WebGUI',''),('Sites','','String','','','','Internal',''),('SiteSshPort','SiteController','Integer','0','65535','22','WebGUI',''),('SiteSystemInfoPort','SiteController','Integer','1024','49151','3333','WebGUI',''),('Site_IsHA','SiteController','Boolean','','','FALSE','WebGUI',''),('SlowDbaseLogThresholdMs','SystemDefaults','Integer','10','60000','50','Internal',''),('SndcpContext','','String','','','','Internal','Name'),('SndcpContexts','','String','','','','Internal',''),('SndcpOutboundMsgQTime','SiteController','Integer','4','60','15','WebGUI',''),('SndcpReadyTime','SiteController','Integer','1','15','6','WebGUI',''),('SndcpStandbyTime','RFSSController','Integer','1','15','7','WebGUI',''),('SnmpCommunity','NetworkSettings','String','','','','WebGUI',''),('SNMPDownlinkTsbkThreshold','NifProfile','Integer','0','100','0','WebGUI',''),('SNMPEnabled','NifProfile','Boolean','','','FALSE','WebGUI',''),('SnmpForwardAddress','NetworkSettings','IP','','','','WebGUI',''),('SNMPLicenseExpiryDaysRemaining','NifProfile','Integer','0','4294967295','0','WebGUI',''),('SnmpLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('SNMPNtpSyncStateEnabled','NifProfile','Boolean','','','FALSE','WebGUI',''),('SnmpSysContact','NetworkSettings','String','','','','WebGUI',''),('SnmpSysLocation','NetworkSettings','String','','','','WebGUI',''),('SNMPUplinkTsbkThreshold','NifProfile','Integer','0','100','0','WebGUI',''),('SocketLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('status','','String','','','','Internal',''),('StickyGroupCallEmergency','CallProfile','Boolean','','','FALSE','WebGUI',''),('StrictIssi','SipProfile','Boolean','','','FALSE','Internal',''),('SuTxFreqCalcMethod','ChannelGroup','Choice','IMPLICIT EXPLICIT','','IMPLICIT','WebGUI',''),('SysloggingIpaddr','LogProfile','String','','','localhost','WebGUI',''),('SysloggingPort','LogProfile','Integer','1','65535','514','WebGUI',''),('SystemId','RFSSController','HexDisplay','1','4094','2','WebGUI',''),('SystemInfoPort','','Integer','1024','49151','3333','Internal',''),('TagLabel','RFSSController','String','','','Main Tag','Internal',''),('TccpConnection','Transceiver','Boolean','','','TRUE','WebGUI',''),('TccpConnectionTimeoutMs','SiteController','Integer','1000','200000','30000','WebGUI',''),('TccpHeartbeatPeriodMs','SiteController','Integer','1000','30000','5000','WebGUI',''),('TccpIpAddress','Transceiver','IP','','','0.0.0.0','WebGUI',''),('TccpLocalVoiceRepeat','SiteController','Boolean','','','TRUE','WebGUI','obsolete'),('TccpPort','Transceiver','Integer','50000','65535','50000','WebGUI',''),('TccpRole','Transceiver','Choice','PRIMARY SECONDARY SLAVE','','PRIMARY','WebGUI',''),('TccpVoicePort','Transceiver','Integer','50000','65535','50002','WebGUI',''),('TccpVoiceSSRC','SiteController','Integer','0','4294967296','1','Internal',''),('TdmaEnabled','ChannelGroup','Boolean','','','FALSE','WebGUI',''),('TearDownCallIfNoHeartbeat','McProfile','Boolean','','','TRUE','Internal',''),('TestConfig','','String','','','','Internal',''),('ThreadLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('TrafficChannelGroupHangTime','TrafficChannelProfile','Integer','0','30000','0','Internal',''),('TrafficChannelGroupHangTimeOverride','TrafficChannelProfile','Boolean','','','FALSE','Internal',''),('TrafficChannelProfile','','Profile','3','','','Container','Name'),('TrafficChannelPstnHangTime','TrafficChannelProfile','Integer','0','99999','10000','WebGUI',''),('TrafficChannelUnitHangTime','TrafficChannelProfile','Integer','0','99999','10000','Internal',''),('TrafficChannelUsage','ChannelGroup','Integer','0','2','1','WebGUI',''),('TrafficLcMirrorToControlChannel','TrafficChannelProfile','Boolean','','','FALSE','Internal',''),('TrafficLcRepeatInterval','TrafficChannelProfile','Integer','0','9','3','Internal',''),('Transceiver','','Belongs','5','','','Container','Name'),('TransceiverLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('Transceivers','','String','','','','Internal',''),('TransceiverType','Transceiver','Choice','TB9100 TB9400 TB7300','','TB9100','',''),('TransmitOffset','FrequencyPlan','Integer','5','999999995','450000000','WebGUI','divisible by 5'),('TrxaLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('TxFrequency','ChannelGroup','Integer','1','999999999','459000000','WebGUI',''),('U2URecordingEnabled','ExternalDevice','Boolean','','','FALSE','WebGui',''),('UnconfConsoleGroupVoicePttArbTimeExtMs','RFSSController','Integer','0','3000','3000','Internal',''),('UnitCallAnswerTimeoutSecs','CallProfile','Integer','0','99','30','WebGUI',''),('UnitCallInactivityTimeoutMs','CallProfile','Integer','0','30000','10000','WebGUI',''),('UnitCallPttDurationLimitSecs','RFSSController','Integer','0','600','0','Internal',''),('UnitProcedureHangTimeMs','CallProfile','Integer','0','9999','500','Internal',''),('UnitToPstnInterDigitTimeoutMs','CallProfile','Integer','0','9999','3000','Internal',''),('UnitToPstnMinDigits','CallProfile','Integer','0','99','3','Internal',''),('UnitTrxSyncTimeMs','CallProfile','Integer','0','9999','50','Internal',''),('Use4HexDigitRfssId','NifProfile','Boolean','','','FALSE','Internal',''),('UseControlChannelList','ControlChannelProfile','Boolean','','','','Internal',''),('UseHeartbeat','McProfile','Boolean','','','TRUE','Internal',''),('UseIssiHeaderWord','NifProfile','Boolean','','','TRUE','Internal',''),('UsePcmUlaw','PSTNGateway','Boolean','','','TRUE','WebGUI',''),('VlrDirectory','SiteController','String','','','/home/taitnet/p25sc/vlr','Internal',''),('VlrLoggingLevel','LogProfile','Choice','DEBUG DETAILED NORMAL EXCEPTION CRITICAL','','NORMAL','WebGUI',''),('WacnId','RFSSController','HexDisplay','1','1048574','1','WebGUI',''),('WatchdogMaxResponseTime','SystemDefaults','Integer','100','120000','10000','Internal','');
/*!40000 ALTER TABLE `ValidateData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_data_pool`
--

DROP TABLE IF EXISTS `ip_data_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_data_pool` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_data_pool` varchar(10) NOT NULL DEFAULT '',
  `ip_address_start` varchar(32) NOT NULL DEFAULT '',
  `pool_type` varchar(10) NOT NULL DEFAULT '',
  `agt_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `ip_data_pool` (`ip_data_pool`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_data_pool`
--

LOCK TABLES `ip_data_pool` WRITE;
/*!40000 ALTER TABLE `ip_data_pool` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_data_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `DBSchemaVers` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`DBSchemaVers`) VALUES (2004);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_guard`
--

DROP TABLE IF EXISTS `template_guard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_guard` (
  `Profile` varchar(50) NOT NULL DEFAULT 'Default',
  `id` int(10) NOT NULL DEFAULT 1,
  PRIMARY KEY (`Profile`),
  KEY `template_guard_ibfk_17` (`id`),
  CONSTRAINT `template_guard_ibfk_10` FOREIGN KEY (`Profile`) REFERENCES `RegistrationProfile` (`RegistrationProfile`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_11` FOREIGN KEY (`Profile`) REFERENCES `SipProfile` (`SipProfile`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_12` FOREIGN KEY (`Profile`) REFERENCES `TrafficChannelProfile` (`TrafficChannelProfile`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_13` FOREIGN KEY (`id`) REFERENCES `ChannelGroup` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_14` FOREIGN KEY (`Profile`) REFERENCES `FleetManager` (`FleetManager`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_15` FOREIGN KEY (`Profile`) REFERENCES `RFSSController` (`RFSSController`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_16` FOREIGN KEY (`Profile`) REFERENCES `SiteController` (`SiteController`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_17` FOREIGN KEY (`id`) REFERENCES `Transceiver` (`Id`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_18` FOREIGN KEY (`Profile`) REFERENCES `PSTNGateway` (`PSTNGateway`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_19` FOREIGN KEY (`Profile`) REFERENCES `ExternalDevice` (`ExternalDevice`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_2` FOREIGN KEY (`Profile`) REFERENCES `CallProfile` (`CallProfile`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_3` FOREIGN KEY (`Profile`) REFERENCES `FrequencyPlan` (`FrequencyPlan`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_4` FOREIGN KEY (`Profile`) REFERENCES `ControlChannelProfile` (`ControlChannelProfile`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_5` FOREIGN KEY (`Profile`) REFERENCES `EventProfile` (`EventProfile`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_6` FOREIGN KEY (`Profile`) REFERENCES `LocalProfile` (`LocalProfile`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_7` FOREIGN KEY (`Profile`) REFERENCES `LogProfile` (`LogProfile`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_8` FOREIGN KEY (`Profile`) REFERENCES `McProfile` (`McProfile`) ON UPDATE CASCADE,
  CONSTRAINT `template_guard_ibfk_9` FOREIGN KEY (`Profile`) REFERENCES `NifProfile` (`NifProfile`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_guard`
--

LOCK TABLES `template_guard` WRITE;
/*!40000 ALTER TABLE `template_guard` DISABLE KEYS */;
INSERT INTO `template_guard` (`Profile`, `id`) VALUES ('Default',1);
/*!40000 ALTER TABLE `template_guard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view_ipaddress`
--

DROP TABLE IF EXISTS `view_ipaddress`;
/*!50001 DROP VIEW IF EXISTS `view_ipaddress`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_ipaddress` AS SELECT
 1 AS `ipaddr`,
  1 AS `element`,
  1 AS `name`,
  1 AS `field` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_siteid`
--

DROP TABLE IF EXISTS `view_siteid`;
/*!50001 DROP VIEW IF EXISTS `view_siteid`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_siteid` AS SELECT
 1 AS `siteid`,
  1 AS `rfssid`,
  1 AS `element`,
  1 AS `name` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'configure'
--

--
-- Final view structure for view `view_ipaddress`
--

/*!50001 DROP VIEW IF EXISTS `view_ipaddress`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_ipaddress` AS select `RFSS`.`RFSSIpAddress` AS `ipaddr`,_latin1'RFSSController' AS `element`,`RFSS`.`RFSSController` AS `name`,_latin1'RFSSIpAddress' AS `field` from `RFSSController` `RFSS` union select `RFSS`.`RfssHAIP_A` AS `RfssHAIP_A`,_latin1'RFSSController' AS `RFSSController`,`RFSS`.`RFSSController` AS `RFSSController`,_latin1'RfssHAIP_A' AS `RfssHAIP_A` from `RFSSController` `RFSS` union select `RFSS`.`RfssHAIP_B` AS `RfssHAIP_B`,_latin1'RFSSController' AS `RFSSController`,`RFSS`.`RFSSController` AS `RFSSController`,_latin1'RfssHAIP_B' AS `RfssHAIP_B` from `RFSSController` `RFSS` union select `RFSS`.`RfssDRBD_A` AS `RfssDRBD_A`,_latin1'RFSSController' AS `RFSSController`,`RFSS`.`RFSSController` AS `RFSSController`,_latin1'RfssDRBD_A' AS `RfssDRBD_A` from `RFSSController` `RFSS` union select `RFSS`.`RfssDRBD_B` AS `RfssDRBD_B`,_latin1'RFSSController' AS `RFSSController`,`RFSS`.`RFSSController` AS `RFSSController`,_latin1'RfssDRBD_B' AS `RfssDRBD_B` from `RFSSController` `RFSS` union select `SC`.`SCIpAddress` AS `SCIpAddress`,_latin1'SiteController' AS `SiteController`,`SC`.`SiteController` AS `SiteController`,_latin1'SCIpAddress' AS `SCIpAddress` from `SiteController` `SC` union select `SC`.`SiteHAIP_A` AS `SiteHAIP_A`,_latin1'SiteController' AS `SiteController`,`SC`.`SiteController` AS `SiteController`,_latin1'SiteHAIP_A' AS `SiteHAIP_A` from `SiteController` `SC` union select `SC`.`SiteHAIP_B` AS `SiteHAIP_B`,_latin1'SiteController' AS `SiteController`,`SC`.`SiteController` AS `SiteController`,_latin1'SiteHAIP_B' AS `SiteHAIP_B` from `SiteController` `SC` union select `SC`.`SiteDRBD_A` AS `SiteDRBD_A`,_latin1'SiteController' AS `SiteController`,`SC`.`SiteController` AS `SiteController`,_latin1'SiteDRBD_A' AS `SiteDRBD_A` from `SiteController` `SC` union select `SC`.`SiteDRBD_B` AS `SiteDRBD_B`,_latin1'SiteController' AS `SiteController`,`SC`.`SiteController` AS `SiteController`,_latin1'SiteDRBD_B' AS `SiteDRBD_B` from `SiteController` `SC` union select `FM`.`FMIpAddress` AS `FMIpAddress`,_latin1'FleetManager' AS `FleetManager`,`FM`.`FleetManager` AS `Fleetmanager`,_latin1'FMIpAddress' AS `FMIpAddress` from `FleetManager` `FM` union select `TRX`.`TccpIpAddress` AS `TccpIpAddress`,_latin1'Transceiver' AS `Transceiver`,`TRX`.`Transceiver` AS `Transceiver`,_latin1'TccpIpAddress' AS `TccpIpAddress` from `Transceiver` `TRX` union select `PG`.`PSTNGIpAddress` AS `PSTNGIpAddress`,_latin1'PSTNGateway' AS `PSTNGateway`,`PG`.`PSTNGateway` AS `PSTNGateway`,_latin1'PSTNGIpAddress' AS `PSTNGIpAddress` from `PSTNGateway` `PG` union select `ED`.`ExternalDeviceIpAddress` AS `ExternalDeviceIpAddress`,_latin1'ExternalDevice' AS `ExternalDevice`,`ED`.`ExternalDevice` AS `ExternalDevice`,_latin1'ExternalDeviceIpAddress' AS `ExternalDeviceIpAddress` from `ExternalDevice` `ED` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_siteid`
--

/*!50001 DROP VIEW IF EXISTS `view_siteid`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_siteid` AS select `SC`.`SiteId` AS `siteid`,`RFSS`.`RfssId` AS `rfssid`,'SiteController' AS `element`,`SC`.`SiteController` AS `name` from (`SiteController` `SC` join `RFSSController` `RFSS` on(`RFSS`.`RFSSController` = `SC`.`RFSSController`)) union select `FM`.`FMSiteId` AS `FMSiteId`,`RFSS`.`RfssId` AS `RfssId`,'FleetManager' AS `FleetManager`,`FM`.`FleetManager` AS `FleetManager` from (`FleetManager` `FM` join `RFSSController` `RFSS` on(`RFSS`.`RFSSController` = `FM`.`RFSSController`)) union select `PG`.`PSTNGSiteId` AS `PSTNGSiteId`,`RFSS`.`RfssId` AS `RfssId`,'PSTNGateway' AS `PSTNGateway`,`PG`.`PSTNGateway` AS `PSTNGateway` from (`PSTNGateway` `PG` join `RFSSController` `RFSS` on(`RFSS`.`RFSSController` = `PG`.`RFSSController`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-10 11:16:56
