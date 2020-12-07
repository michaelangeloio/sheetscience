-- MariaDB dump 10.18  Distrib 10.5.8-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sheetsciencedb
-- ------------------------------------------------------
-- Server version	10.5.8-MariaDB-1:10.5.8+maria~focal

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
-- Table structure for table `access_tokens`
--

DROP TABLE IF EXISTS `access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_tokens` (
  `token` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `last_activity_at` datetime NOT NULL,
  `lifetime_seconds` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`token`),
  KEY `access_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `access_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_tokens`
--

LOCK TABLES `access_tokens` WRITE;
/*!40000 ALTER TABLE `access_tokens` DISABLE KEYS */;
INSERT INTO `access_tokens` VALUES ('CW1SnXXyUQyT7Obr7PIoHFhPWYWnXZnEZgEjCiVI',3,'2020-11-29 21:46:46',157680000,'2020-11-29 03:39:40'),('oEhOT07Iin23JrzOrpxAcidWx3nfRT7U9L7ox9N0',1,'2020-11-30 03:02:41',3600,'2020-11-30 03:02:41'),('Xc8umbAZB96uml8ZkshOeivsFJxJFOGkA0UtS91g',1,'2020-12-01 02:04:23',157680000,'2020-11-30 16:43:04');
/*!40000 ALTER TABLE `access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_keys` (
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `allowed_ips` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `last_activity_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_keys_key_unique` (`key`),
  KEY `api_keys_user_id_foreign` (`user_id`),
  CONSTRAINT `api_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_keys`
--

LOCK TABLES `api_keys` WRITE;
/*!40000 ALTER TABLE `api_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussion_tag`
--

DROP TABLE IF EXISTS `discussion_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussion_tag` (
  `discussion_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`discussion_id`,`tag_id`),
  KEY `discussion_tag_tag_id_foreign` (`tag_id`),
  CONSTRAINT `discussion_tag_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discussion_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussion_tag`
--

LOCK TABLES `discussion_tag` WRITE;
/*!40000 ALTER TABLE `discussion_tag` DISABLE KEYS */;
INSERT INTO `discussion_tag` VALUES (2,2),(2,3),(2,4),(2,11);
/*!40000 ALTER TABLE `discussion_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussion_user`
--

DROP TABLE IF EXISTS `discussion_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussion_user` (
  `user_id` int(10) unsigned NOT NULL,
  `discussion_id` int(10) unsigned NOT NULL,
  `last_read_at` datetime DEFAULT NULL,
  `last_read_post_number` int(10) unsigned DEFAULT NULL,
  `subscription` enum('follow','ignore') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bookmarked_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`discussion_id`),
  KEY `discussion_user_discussion_id_foreign` (`discussion_id`),
  CONSTRAINT `discussion_user_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discussion_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussion_user`
--

LOCK TABLES `discussion_user` WRITE;
/*!40000 ALTER TABLE `discussion_user` DISABLE KEYS */;
INSERT INTO `discussion_user` VALUES (1,1,'2020-11-29 03:41:47',1,NULL,NULL),(1,2,'2020-11-30 22:42:52',4,NULL,NULL),(2,2,'2020-11-30 03:02:07',4,NULL,NULL),(3,1,'2020-11-29 03:41:38',1,NULL,NULL);
/*!40000 ALTER TABLE `discussion_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussion_views`
--

DROP TABLE IF EXISTS `discussion_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussion_views` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `discussion_id` int(10) unsigned NOT NULL,
  `ip` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visited_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `discussion_views_discussion_id_foreign` (`discussion_id`),
  KEY `discussion_views_user_id_foreign` (`user_id`),
  CONSTRAINT `discussion_views_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discussion_views_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussion_views`
--

LOCK TABLES `discussion_views` WRITE;
/*!40000 ALTER TABLE `discussion_views` DISABLE KEYS */;
INSERT INTO `discussion_views` VALUES (1,1,2,'162.158.187.246','2020-11-29 22:55:46'),(2,1,2,'162.158.187.246','2020-11-29 23:00:25'),(3,1,2,'162.158.187.102','2020-11-30 02:01:16'),(4,1,2,'162.158.187.102','2020-11-30 02:01:22'),(5,1,2,'162.158.187.102','2020-11-30 02:01:25'),(6,1,2,'162.158.187.102','2020-11-30 02:40:44'),(7,1,2,'162.158.187.102','2020-11-30 02:45:41'),(8,2,2,'162.158.187.102','2020-11-30 03:01:50'),(9,2,2,'162.158.187.102','2020-11-30 03:01:59'),(10,1,2,'162.158.187.102','2020-11-30 03:03:35'),(11,1,2,'162.158.187.122','2020-11-30 22:42:52');
/*!40000 ALTER TABLE `discussion_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussions`
--

DROP TABLE IF EXISTS `discussions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_count` int(11) NOT NULL DEFAULT 1,
  `participant_count` int(10) unsigned NOT NULL DEFAULT 0,
  `post_number_index` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `first_post_id` int(10) unsigned DEFAULT NULL,
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_user_id` int(10) unsigned DEFAULT NULL,
  `last_post_id` int(10) unsigned DEFAULT NULL,
  `last_post_number` int(10) unsigned DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int(10) unsigned DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 0,
  `is_approved` tinyint(1) NOT NULL DEFAULT 1,
  `is_locked` tinyint(1) NOT NULL DEFAULT 0,
  `is_sticky` tinyint(1) NOT NULL DEFAULT 0,
  `best_answer_post_id` int(10) unsigned DEFAULT NULL,
  `best_answer_user_id` int(10) unsigned DEFAULT NULL,
  `best_answer_notified` tinyint(1) NOT NULL,
  `best_answer_set_at` datetime DEFAULT NULL,
  `view_count` int(11) NOT NULL DEFAULT 0,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `discussions_hidden_user_id_foreign` (`hidden_user_id`),
  KEY `discussions_first_post_id_foreign` (`first_post_id`),
  KEY `discussions_last_post_id_foreign` (`last_post_id`),
  KEY `discussions_last_posted_at_index` (`last_posted_at`),
  KEY `discussions_last_posted_user_id_index` (`last_posted_user_id`),
  KEY `discussions_created_at_index` (`created_at`),
  KEY `discussions_user_id_index` (`user_id`),
  KEY `discussions_comment_count_index` (`comment_count`),
  KEY `discussions_participant_count_index` (`participant_count`),
  KEY `discussions_hidden_at_index` (`hidden_at`),
  KEY `discussions_is_locked_index` (`is_locked`),
  KEY `discussions_is_sticky_created_at_index` (`is_sticky`,`created_at`),
  KEY `discussions_best_answer_post_id_foreign` (`best_answer_post_id`),
  KEY `discussions_best_answer_user_id_foreign` (`best_answer_user_id`),
  KEY `discussions_best_answer_set_at_index` (`best_answer_set_at`),
  FULLTEXT KEY `title` (`title`),
  CONSTRAINT `discussions_best_answer_post_id_foreign` FOREIGN KEY (`best_answer_post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `discussions_best_answer_user_id_foreign` FOREIGN KEY (`best_answer_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `discussions_first_post_id_foreign` FOREIGN KEY (`first_post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `discussions_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `discussions_last_post_id_foreign` FOREIGN KEY (`last_post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `discussions_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `discussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussions`
--

LOCK TABLES `discussions` WRITE;
/*!40000 ALTER TABLE `discussions` DISABLE KEYS */;
INSERT INTO `discussions` VALUES (1,'Test',1,1,1,'2020-11-29 03:41:38',3,1,'2020-11-29 03:41:38',3,1,1,'2020-11-30 02:01:14',1,'test',0,1,0,0,NULL,NULL,0,NULL,0,0),(2,'RCC 2009 Snare Closer',1,1,4,'2020-11-29 14:34:06',1,2,'2020-11-29 14:34:06',1,2,1,NULL,NULL,'rcc-2009-snare-closer',0,1,0,0,NULL,NULL,0,NULL,11,0);
/*!40000 ALTER TABLE `discussions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `relationships` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime NOT NULL,
  `scheduled_for` datetime DEFAULT NULL,
  `scheduled_validation_error` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_user_id_foreign` (`user_id`),
  CONSTRAINT `drafts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
INSERT INTO `drafts` VALUES (2,1,'RCC 2009 Closer','','{\"tags\":{\"data\":[{\"type\":\"tags\",\"id\":\"4\"},{\"type\":\"tags\",\"id\":\"2\"}]}}','2020-11-29 14:33:39',NULL,NULL,'162.158.187.90','{\"title\":\"\"}'),(5,1,'','','{\"discussion\":{\"data\":{\"type\":\"discussions\",\"id\":\"2\"}}}','2020-11-30 02:41:40',NULL,NULL,'162.158.187.102',''),(6,1,'','','{\"discussion\":{\"data\":{\"type\":\"discussions\",\"id\":\"2\"}}}','2020-11-30 02:41:46',NULL,NULL,'162.158.187.102','');
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_tokens`
--

DROP TABLE IF EXISTS `email_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_tokens` (
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `email_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `email_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_tokens`
--

LOCK TABLES `email_tokens` WRITE;
/*!40000 ALTER TABLE `email_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flags`
--

DROP TABLE IF EXISTS `flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason_detail` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `flags_post_id_foreign` (`post_id`),
  KEY `flags_user_id_foreign` (`user_id`),
  KEY `flags_created_at_index` (`created_at`),
  CONSTRAINT `flags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flags_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flags`
--

LOCK TABLES `flags` WRITE;
/*!40000 ALTER TABLE `flags` DISABLE KEYS */;
INSERT INTO `flags` VALUES (1,5,'approval',NULL,NULL,NULL,'2020-11-30 03:02:07');
/*!40000 ALTER TABLE `flags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fof_linguist_strings`
--

DROP TABLE IF EXISTS `fof_linguist_strings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fof_linguist_strings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `locale` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fof_linguist_strings_key_locale_unique` (`key`,`locale`),
  KEY `fof_linguist_strings_key_index` (`key`),
  KEY `fof_linguist_strings_locale_index` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fof_linguist_strings`
--

LOCK TABLES `fof_linguist_strings` WRITE;
/*!40000 ALTER TABLE `fof_linguist_strings` DISABLE KEYS */;
INSERT INTO `fof_linguist_strings` VALUES (1,'core.forum.header.search_placeholder',NULL,'Search SheetScience','2020-11-29 13:58:28','2020-11-29 13:58:28'),(2,'fof-forum-statistics-widget.forum.navbar.widget_title',NULL,'Community Stats','2020-11-29 22:23:14','2020-11-29 22:23:14');
/*!40000 ALTER TABLE `fof_linguist_strings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fof_terms_policies`
--

DROP TABLE IF EXISTS `fof_terms_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fof_terms_policies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sort` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terms_updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fof_terms_policies_sort_index` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fof_terms_policies`
--

LOCK TABLES `fof_terms_policies` WRITE;
/*!40000 ALTER TABLE `fof_terms_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `fof_terms_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fof_terms_policy_user`
--

DROP TABLE IF EXISTS `fof_terms_policy_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fof_terms_policy_user` (
  `policy_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `accepted_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`policy_id`,`user_id`),
  KEY `fof_terms_policy_user_user_id_foreign` (`user_id`),
  KEY `fof_terms_policy_user_accepted_at_index` (`accepted_at`),
  CONSTRAINT `fof_terms_policy_user_policy_id_foreign` FOREIGN KEY (`policy_id`) REFERENCES `fof_terms_policies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fof_terms_policy_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fof_terms_policy_user`
--

LOCK TABLES `fof_terms_policy_user` WRITE;
/*!40000 ALTER TABLE `fof_terms_policy_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `fof_terms_policy_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fof_upload_downloads`
--

DROP TABLE IF EXISTS `fof_upload_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fof_upload_downloads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(10) unsigned NOT NULL,
  `discussion_id` int(10) unsigned DEFAULT NULL,
  `post_id` int(10) unsigned DEFAULT NULL,
  `actor_id` int(10) unsigned DEFAULT NULL,
  `downloaded_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fof_upload_downloads_file_id_foreign` (`file_id`),
  KEY `fof_upload_downloads_discussion_id_foreign` (`discussion_id`),
  KEY `fof_upload_downloads_actor_id_foreign` (`actor_id`),
  KEY `fof_upload_downloads_post_id_foreign` (`post_id`),
  CONSTRAINT `fof_upload_downloads_actor_id_foreign` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fof_upload_downloads_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fof_upload_downloads_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `fof_upload_files` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fof_upload_downloads_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fof_upload_downloads`
--

LOCK TABLES `fof_upload_downloads` WRITE;
/*!40000 ALTER TABLE `fof_upload_downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `fof_upload_downloads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fof_upload_files`
--

DROP TABLE IF EXISTS `fof_upload_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fof_upload_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `actor_id` int(10) unsigned DEFAULT NULL,
  `discussion_id` int(10) unsigned DEFAULT NULL,
  `post_id` int(10) unsigned DEFAULT NULL,
  `base_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `upload_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `remote_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fof_upload_files`
--

LOCK TABLES `fof_upload_files` WRITE;
/*!40000 ALTER TABLE `fof_upload_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `fof_upload_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_permission`
--

DROP TABLE IF EXISTS `group_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_permission` (
  `group_id` int(10) unsigned NOT NULL,
  `permission` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`group_id`,`permission`),
  CONSTRAINT `group_permission_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_permission`
--

LOCK TABLES `group_permission` WRITE;
/*!40000 ALTER TABLE `group_permission` DISABLE KEYS */;
INSERT INTO `group_permission` VALUES (2,'viewDiscussions'),(3,'discussion.flagPosts'),(3,'discussion.likePosts'),(3,'discussion.reply'),(3,'discussion.replyWithoutApproval'),(3,'discussion.selectBestAnswerOwnDiscussion'),(3,'discussion.startWithoutApproval'),(3,'startDiscussion'),(3,'viewUserList'),(4,'discussion.approvePosts'),(4,'discussion.editPosts'),(4,'discussion.hide'),(4,'discussion.hidePosts'),(4,'discussion.lock'),(4,'discussion.rename'),(4,'discussion.sticky'),(4,'discussion.tag'),(4,'discussion.viewFlags'),(4,'discussion.viewIpsPosts'),(4,'user.saveDrafts'),(4,'user.scheduleDrafts'),(4,'user.suspend'),(4,'user.viewLastSeenAt');
/*!40000 ALTER TABLE `group_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_user`
--

DROP TABLE IF EXISTS `group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_user` (
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_user_group_id_foreign` (`group_id`),
  CONSTRAINT `group_user_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `group_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_user`
--

LOCK TABLES `group_user` WRITE;
/*!40000 ALTER TABLE `group_user` DISABLE KEYS */;
INSERT INTO `group_user` VALUES (1,1);
/*!40000 ALTER TABLE `group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name_singular` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_plural` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Admin','Admins','#B72A2A','fas fa-wrench',0),(2,'Guest','Guests',NULL,NULL,0),(3,'Member','Members',NULL,NULL,0),(4,'Mod','Moderators','#80349E','fas fa-bolt',0);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int(11) DEFAULT NULL,
  `is_internal` tinyint(1) NOT NULL DEFAULT 0,
  `is_newtab` tinyint(1) NOT NULL DEFAULT 0,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `links_parent_id_foreign` (`parent_id`),
  CONSTRAINT `links_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `links` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `links`
--

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
INSERT INTO `links` VALUES (1,'SHEETSCIENCE','https://sheetscience.io',0,1,0,NULL,''),(3,'About','https://info.sheetscience.io',NULL,0,1,NULL,''),(4,'Users','https://sheetscience.io/users',NULL,1,0,NULL,'');
/*!40000 ALTER TABLE `links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_providers`
--

DROP TABLE IF EXISTS `login_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_providers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_providers_provider_identifier_unique` (`provider`,`identifier`),
  KEY `login_providers_user_id_foreign` (`user_id`),
  CONSTRAINT `login_providers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_providers`
--

LOCK TABLES `login_providers` WRITE;
/*!40000 ALTER TABLE `login_providers` DISABLE KEYS */;
INSERT INTO `login_providers` VALUES (1,1,'facebook','103980151562419','2020-11-29 03:10:05','2020-11-29 03:10:05'),(2,2,'facebook','3494269980665039','2020-11-29 03:12:33','2020-11-30 03:01:22'),(3,2,'google','108573403322459560152','2020-11-29 03:30:28','2020-11-29 03:30:28'),(4,3,'google','100047259204885030636','2020-11-29 03:39:40','2020-11-29 03:39:40');
/*!40000 ALTER TABLE `login_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2015_02_24_000000_create_access_tokens_table',NULL),(2,'2015_02_24_000000_create_api_keys_table',NULL),(3,'2015_02_24_000000_create_config_table',NULL),(4,'2015_02_24_000000_create_discussions_table',NULL),(5,'2015_02_24_000000_create_email_tokens_table',NULL),(6,'2015_02_24_000000_create_groups_table',NULL),(7,'2015_02_24_000000_create_notifications_table',NULL),(8,'2015_02_24_000000_create_password_tokens_table',NULL),(9,'2015_02_24_000000_create_permissions_table',NULL),(10,'2015_02_24_000000_create_posts_table',NULL),(11,'2015_02_24_000000_create_users_discussions_table',NULL),(12,'2015_02_24_000000_create_users_groups_table',NULL),(13,'2015_02_24_000000_create_users_table',NULL),(14,'2015_09_15_000000_create_auth_tokens_table',NULL),(15,'2015_09_20_224327_add_hide_to_discussions',NULL),(16,'2015_09_22_030432_rename_notification_read_time',NULL),(17,'2015_10_07_130531_rename_config_to_settings',NULL),(18,'2015_10_24_194000_add_ip_address_to_posts',NULL),(19,'2015_12_05_042721_change_access_tokens_columns',NULL),(20,'2015_12_17_194247_change_settings_value_column_to_text',NULL),(21,'2016_02_04_095452_add_slug_to_discussions',NULL),(22,'2017_04_07_114138_add_is_private_to_discussions',NULL),(23,'2017_04_07_114138_add_is_private_to_posts',NULL),(24,'2018_01_11_093900_change_access_tokens_columns',NULL),(25,'2018_01_11_094000_change_access_tokens_add_foreign_keys',NULL),(26,'2018_01_11_095000_change_api_keys_columns',NULL),(27,'2018_01_11_101800_rename_auth_tokens_to_registration_tokens',NULL),(28,'2018_01_11_102000_change_registration_tokens_rename_id_to_token',NULL),(29,'2018_01_11_102100_change_registration_tokens_created_at_to_datetime',NULL),(30,'2018_01_11_120604_change_posts_table_to_innodb',NULL),(31,'2018_01_11_155200_change_discussions_rename_columns',NULL),(32,'2018_01_11_155300_change_discussions_add_foreign_keys',NULL),(33,'2018_01_15_071700_rename_users_discussions_to_discussion_user',NULL),(34,'2018_01_15_071800_change_discussion_user_rename_columns',NULL),(35,'2018_01_15_071900_change_discussion_user_add_foreign_keys',NULL),(36,'2018_01_15_072600_change_email_tokens_rename_id_to_token',NULL),(37,'2018_01_15_072700_change_email_tokens_add_foreign_keys',NULL),(38,'2018_01_15_072800_change_email_tokens_created_at_to_datetime',NULL),(39,'2018_01_18_130400_rename_permissions_to_group_permission',NULL),(40,'2018_01_18_130500_change_group_permission_add_foreign_keys',NULL),(41,'2018_01_18_130600_rename_users_groups_to_group_user',NULL),(42,'2018_01_18_130700_change_group_user_add_foreign_keys',NULL),(43,'2018_01_18_133000_change_notifications_columns',NULL),(44,'2018_01_18_133100_change_notifications_add_foreign_keys',NULL),(45,'2018_01_18_134400_change_password_tokens_rename_id_to_token',NULL),(46,'2018_01_18_134500_change_password_tokens_add_foreign_keys',NULL),(47,'2018_01_18_134600_change_password_tokens_created_at_to_datetime',NULL),(48,'2018_01_18_135000_change_posts_rename_columns',NULL),(49,'2018_01_18_135100_change_posts_add_foreign_keys',NULL),(50,'2018_01_30_112238_add_fulltext_index_to_discussions_title',NULL),(51,'2018_01_30_220100_create_post_user_table',NULL),(52,'2018_01_30_222900_change_users_rename_columns',NULL),(53,'2018_07_21_000000_seed_default_groups',NULL),(54,'2018_07_21_000100_seed_default_group_permissions',NULL),(55,'2018_09_15_041340_add_users_indicies',NULL),(56,'2018_09_15_041828_add_discussions_indicies',NULL),(57,'2018_09_15_043337_add_notifications_indices',NULL),(58,'2018_09_15_043621_add_posts_indices',NULL),(59,'2018_09_22_004100_change_registration_tokens_columns',NULL),(60,'2018_09_22_004200_create_login_providers_table',NULL),(61,'2018_10_08_144700_add_shim_prefix_to_group_icons',NULL),(62,'2019_06_24_145100_change_posts_content_column_to_mediumtext',NULL),(63,'2019_10_12_195349_change_posts_add_discussion_foreign_key',NULL),(64,'2020_03_19_134512_change_discussions_default_comment_count',NULL),(65,'2020_04_21_130500_change_permission_groups_add_is_hidden',NULL),(66,'2015_09_21_011527_add_is_approved_to_discussions','flarum-approval'),(67,'2015_09_21_011706_add_is_approved_to_posts','flarum-approval'),(68,'2017_07_22_000000_add_default_permissions','flarum-approval'),(69,'2018_09_29_060444_replace_emoji_shorcuts_with_unicode','flarum-emoji'),(70,'2015_09_02_000000_add_flags_read_time_to_users_table','flarum-flags'),(71,'2015_09_02_000000_create_flags_table','flarum-flags'),(72,'2017_07_22_000000_add_default_permissions','flarum-flags'),(73,'2018_06_27_101500_change_flags_rename_time_to_created_at','flarum-flags'),(74,'2018_06_27_101600_change_flags_add_foreign_keys','flarum-flags'),(75,'2018_06_27_105100_change_users_rename_flags_read_time_to_read_flags_at','flarum-flags'),(76,'2018_09_15_043621_add_flags_indices','flarum-flags'),(77,'2019_10_22_000000_change_reason_text_col_type','flarum-flags'),(78,'2015_05_11_000000_create_posts_likes_table','flarum-likes'),(79,'2015_09_04_000000_add_default_like_permissions','flarum-likes'),(80,'2018_06_27_100600_rename_posts_likes_to_post_likes','flarum-likes'),(81,'2018_06_27_100700_change_post_likes_add_foreign_keys','flarum-likes'),(82,'2015_02_24_000000_add_locked_to_discussions','flarum-lock'),(83,'2017_07_22_000000_add_default_permissions','flarum-lock'),(84,'2018_09_15_043621_add_discussions_indices','flarum-lock'),(85,'2015_05_11_000000_create_mentions_posts_table','flarum-mentions'),(86,'2015_05_11_000000_create_mentions_users_table','flarum-mentions'),(87,'2018_06_27_102000_rename_mentions_posts_to_post_mentions_post','flarum-mentions'),(88,'2018_06_27_102100_rename_mentions_users_to_post_mentions_user','flarum-mentions'),(89,'2018_06_27_102200_change_post_mentions_post_rename_mentions_id_to_mentions_post_id','flarum-mentions'),(90,'2018_06_27_102300_change_post_mentions_post_add_foreign_keys','flarum-mentions'),(91,'2018_06_27_102400_change_post_mentions_user_rename_mentions_id_to_mentions_user_id','flarum-mentions'),(92,'2018_06_27_102500_change_post_mentions_user_add_foreign_keys','flarum-mentions'),(93,'2015_02_24_000000_add_sticky_to_discussions','flarum-sticky'),(94,'2017_07_22_000000_add_default_permissions','flarum-sticky'),(95,'2018_09_15_043621_add_discussions_indices','flarum-sticky'),(96,'2015_05_11_000000_add_subscription_to_users_discussions_table','flarum-subscriptions'),(97,'2015_05_11_000000_add_suspended_until_to_users_table','flarum-suspend'),(98,'2015_09_14_000000_rename_suspended_until_column','flarum-suspend'),(99,'2017_07_22_000000_add_default_permissions','flarum-suspend'),(100,'2018_06_27_111400_change_users_rename_suspend_until_to_suspended_until','flarum-suspend'),(101,'2015_02_24_000000_create_discussions_tags_table','flarum-tags'),(102,'2015_02_24_000000_create_tags_table','flarum-tags'),(103,'2015_02_24_000000_create_users_tags_table','flarum-tags'),(104,'2015_02_24_000000_set_default_settings','flarum-tags'),(105,'2015_10_19_061223_make_slug_unique','flarum-tags'),(106,'2017_07_22_000000_add_default_permissions','flarum-tags'),(107,'2018_06_27_085200_change_tags_columns','flarum-tags'),(108,'2018_06_27_085300_change_tags_add_foreign_keys','flarum-tags'),(109,'2018_06_27_090400_rename_users_tags_to_tag_user','flarum-tags'),(110,'2018_06_27_100100_change_tag_user_rename_read_time_to_marked_as_read_at','flarum-tags'),(111,'2018_06_27_100200_change_tag_user_add_foreign_keys','flarum-tags'),(112,'2018_06_27_103000_rename_discussions_tags_to_discussion_tag','flarum-tags'),(113,'2018_06_27_103100_add_discussion_tag_foreign_keys','flarum-tags'),(114,'2019_04_21_000000_add_icon_to_tags_table','flarum-tags'),(115,'2020_06_07_000000_migrate_extension_settings','fof-oauth'),(116,'2019_09_22_01_rename_flagrow_tables','fof-linguist'),(117,'2019_09_22_02_create_strings_table','fof-linguist'),(118,'2020_07_01_000000_create_bio_column','fof-user-bio'),(119,'2019_06_10_000000_rename_permissions','fof-user-directory'),(120,'2016_02_13_000000_create_links_table','fof-links'),(121,'2016_04_19_065618_change_links_columns','fof-links'),(122,'2020_03_16_000000_add_child_links','fof-links'),(123,'2020_09_10_000000_add_icon_to_links_table','fof-links'),(124,'2019_08_02_171300_create_drafts_table','fof-drafts'),(125,'2019_08_02_172100_add_drafts_foreign_keys','fof-drafts'),(126,'2019_08_03_171600_add_default_permissions','fof-drafts'),(127,'2019_08_04_151000_change_content_to_medium_text','fof-drafts'),(128,'2020_05_24_000000_add_scheduled_at_column','fof-drafts'),(129,'2020_05_24_000001_add_schedule_post_permission','fof-drafts'),(130,'2020_05_24_000002_add_error_and_ip_columns','fof-drafts'),(131,'2020_05_24_000003_add_scheduled_post_setting','fof-drafts'),(132,'2020_08_16_000000_add_extra_to_drafts','fof-drafts'),(133,'2019_11_04_000001_add_columns_to_discussions_table','fof-best-answer'),(134,'2019_11_04_000002_add_foreign_keys_to_best_anwer_columns','fof-best-answer'),(135,'2019_11_04_000003_migrate_extension_settings','fof-best-answer'),(136,'2020_02_04_205300_add_best_answer_set_timestamp','fof-best-answer'),(137,'2020_06_27_000000_set_default_theme','fof-nightmode'),(138,'2020_07_12_000000_migrate_old_user_settings','fof-nightmode'),(139,'2016_04_11_182821__create_pages_table','fof-pages'),(140,'2016_08_28_180020_add_is_html','fof-pages'),(141,'2020_02_26_010000_add_is_restricted','fof-pages'),(142,'2020_09_09_173600_increase_char_limit','fof-pages'),(143,'2020_06_07_000000_set_default','fof-sitemap'),(144,'2020_10_06_alter_users_add_approval_count','clarkwinkelmann-first-post-approval'),(145,'2020_03_19_000000_add_post_count_column','askvortsov-categories'),(146,'2019_10_22_01_rename_permissions','fof-terms'),(147,'2019_10_22_02_rename_settings','fof-terms'),(148,'2019_10_22_03_rename_flagrow_tables','fof-terms'),(149,'2019_10_22_04_remove_flagrow_migrations','fof-terms'),(150,'2019_10_22_05_create_terms_policies','fof-terms'),(151,'2019_10_22_06_create_terms_policy_user','fof-terms'),(152,'2020_07_15_000000_add_default_settings','fof-forum-statistics-widget'),(153,'2017_11_07_223624_discussions_add_views','michaelbelgium-discussion-views'),(154,'2018_11_30_141817_discussions_rename_views','michaelbelgium-discussion-views'),(155,'2020_01_11_220612_add_discussionviews_table','michaelbelgium-discussion-views'),(156,'2020_01_17_110823_add_default_settings','michaelbelgium-discussion-views'),(157,'2020_01_19_131055_add_viewlist_settings','michaelbelgium-discussion-views'),(158,'2020_09_20_alter_discussion_user_add_bookmarked','clarkwinkelmann-bookmarks'),(159,'2020_07_07_alter_discussions_add_is_popular_column','clarkwinkelmann-popular-discussion-badge'),(160,'2020_02_06_01_rename_flagrow_permissions','fof-upload'),(161,'2020_02_06_02_rename_flagrow_settings','fof-upload'),(162,'2020_02_06_03_rename_flagrow_tables','fof-upload'),(163,'2020_02_06_04_remove_flagrow_migrations','fof-upload'),(164,'2020_02_06_05_create_files_table','fof-upload'),(165,'2020_02_06_06_create_downloads_table','fof-upload'),(166,'2020_02_06_07_alter_downloads_add_post_constraint','fof-upload');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `from_user_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `data` blob DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_from_user_id_foreign` (`from_user_id`),
  KEY `notifications_user_id_index` (`user_id`),
  CONSTRAINT `notifications_from_user_id_foreign` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `edit_time` datetime DEFAULT NULL,
  `content` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' ',
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  `is_html` tinyint(1) NOT NULL DEFAULT 0,
  `is_restricted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_tokens`
--

DROP TABLE IF EXISTS `password_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_tokens` (
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `password_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `password_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_tokens`
--

LOCK TABLES `password_tokens` WRITE;
/*!40000 ALTER TABLE `password_tokens` DISABLE KEYS */;
INSERT INTO `password_tokens` VALUES ('1q4YpwPdphUG8MO0NXWJrCwHjK1lOTO4GSiG3WHm',2,'2020-11-30 03:00:00');
/*!40000 ALTER TABLE `password_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_likes`
--

DROP TABLE IF EXISTS `post_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_likes` (
  `post_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `post_likes_user_id_foreign` (`user_id`),
  CONSTRAINT `post_likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `post_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_likes`
--

LOCK TABLES `post_likes` WRITE;
/*!40000 ALTER TABLE `post_likes` DISABLE KEYS */;
INSERT INTO `post_likes` VALUES (5,2);
/*!40000 ALTER TABLE `post_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_mentions_post`
--

DROP TABLE IF EXISTS `post_mentions_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_mentions_post` (
  `post_id` int(10) unsigned NOT NULL,
  `mentions_post_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`mentions_post_id`),
  KEY `post_mentions_post_mentions_post_id_foreign` (`mentions_post_id`),
  CONSTRAINT `post_mentions_post_mentions_post_id_foreign` FOREIGN KEY (`mentions_post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `post_mentions_post_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_mentions_post`
--

LOCK TABLES `post_mentions_post` WRITE;
/*!40000 ALTER TABLE `post_mentions_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_mentions_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_mentions_user`
--

DROP TABLE IF EXISTS `post_mentions_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_mentions_user` (
  `post_id` int(10) unsigned NOT NULL,
  `mentions_user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`mentions_user_id`),
  KEY `post_mentions_user_mentions_user_id_foreign` (`mentions_user_id`),
  CONSTRAINT `post_mentions_user_mentions_user_id_foreign` FOREIGN KEY (`mentions_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `post_mentions_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_mentions_user`
--

LOCK TABLES `post_mentions_user` WRITE;
/*!40000 ALTER TABLE `post_mentions_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_mentions_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_user`
--

DROP TABLE IF EXISTS `post_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_user` (
  `post_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `post_user_user_id_foreign` (`user_id`),
  CONSTRAINT `post_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `post_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_user`
--

LOCK TABLES `post_user` WRITE;
/*!40000 ALTER TABLE `post_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discussion_id` int(10) unsigned NOT NULL,
  `number` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' ',
  `edited_at` datetime DEFAULT NULL,
  `edited_user_id` int(10) unsigned DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 0,
  `is_approved` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_discussion_id_number_unique` (`discussion_id`,`number`),
  KEY `posts_edited_user_id_foreign` (`edited_user_id`),
  KEY `posts_hidden_user_id_foreign` (`hidden_user_id`),
  KEY `posts_discussion_id_number_index` (`discussion_id`,`number`),
  KEY `posts_discussion_id_created_at_index` (`discussion_id`,`created_at`),
  KEY `posts_user_id_created_at_index` (`user_id`,`created_at`),
  FULLTEXT KEY `content` (`content`),
  CONSTRAINT `posts_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `posts_edited_user_id_foreign` FOREIGN KEY (`edited_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `posts_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,1,'2020-11-29 03:41:38',3,'comment','<t><p>Test</p></t>',NULL,NULL,NULL,NULL,'172.69.63.236',0,1),(2,2,1,'2020-11-29 14:34:06',1,'comment','<r><p><URL url=\"https://drive.google.com/drive/folders/0BwD3Iu6JiH1ffmFkQ1ZVQWxVMWU5X2J5cy1XWWlpNElKWUNhX2p1Q2hwSDNhdFFSNHBUTWs\">https://drive.google.com/drive/folders/0BwD3Iu6JiH1ffmFkQ1ZVQWxVMWU5X2J5cy1XWWlpNElKWUNhX2p1Q2hwSDNhdFFSNHBUTWs</URL></p></r>',NULL,NULL,NULL,NULL,'162.158.187.90',0,1),(3,2,2,'2020-11-30 02:00:51',1,'discussionTagged','[[2,4],[2,3,4,11]]',NULL,NULL,NULL,NULL,NULL,0,1),(4,2,3,'2020-11-30 02:01:07',1,'discussionRenamed','[\"RCC 2009 Closer\",\"RCC 2009 Snare Closer\"]',NULL,NULL,NULL,NULL,NULL,0,1),(5,2,4,'2020-11-30 03:02:07',2,'comment','<t><p>nice!</p></t>',NULL,NULL,NULL,NULL,'162.158.187.102',1,0);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_tokens`
--

DROP TABLE IF EXISTS `registration_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration_tokens` (
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_attributes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_tokens`
--

LOCK TABLES `registration_tokens` WRITE;
/*!40000 ALTER TABLE `registration_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES ('allow_post_editing','reply'),('allow_renaming','10'),('allow_sign_up','1'),('askvortsov-categories.child-bare-icon',''),('askvortsov-categories.compact-mobile','0'),('askvortsov-categories.full-page-desktop',''),('askvortsov-categories.keep-tags-nav','1'),('askvortsov-categories.parent-remove-description',''),('askvortsov-categories.parent-remove-icon',''),('askvortsov-categories.parent-remove-last-discussion',''),('askvortsov-categories.parent-remove-stats',''),('askvortsov-categories.small-forum-optimized',''),('clarkwinkelmann-first-post-approval.discussionCount','0'),('clarkwinkelmann-first-post-approval.postCount','1'),('custom_less',''),('default_locale','en'),('default_route','/all'),('display_name_driver','username'),('extensions_enabled','[\"flarum-approval\",\"flarum-bbcode\",\"flarum-emoji\",\"flarum-lang-english\",\"flarum-flags\",\"flarum-likes\",\"flarum-lock\",\"flarum-markdown\",\"flarum-mentions\",\"flarum-statistics\",\"flarum-sticky\",\"flarum-subscriptions\",\"flarum-suspend\",\"flarum-tags\",\"fof-oauth\",\"luuhai48-oauth-google\",\"fof-linguist\",\"fof-user-bio\",\"fof-user-directory\",\"fof-links\",\"fof-drafts\",\"fof-best-answer\",\"fof-nightmode\",\"fof-pages\",\"fof-sitemap\",\"flarum-pusher\",\"matpompili-favicon\",\"clarkwinkelmann-first-post-approval\",\"askvortsov-categories\",\"fof-spamblock\",\"fof-terms\",\"fof-subscribed\",\"fof-forum-statistics-widget\",\"michaelbelgium-discussion-views\",\"clarkwinkelmann-bookmarks\",\"clarkwinkelmann-popular-discussion-badge\",\"fof-upload\"]'),('favicon_path','favicon-42oseugw.png'),('flarum-tags.max_primary_tags','4'),('flarum-tags.max_secondary_tags','3'),('flarum-tags.min_primary_tags','1'),('flarum-tags.min_secondary_tags','0'),('fof-best-answer.schedule_on_one_server','0'),('fof-best-answer.stop_overnight','0'),('fof-best-answer.store_log_output','1'),('fof-drafts.enable_scheduled_drafts','1'),('fof-forum-statistics-widget.ignore_private_discussions','1'),('fof-forum-statistics-widget.widget_order','0'),('fof-nightmode.default_theme','0'),('fof-oauth.discord',''),('fof-oauth.discord.client_id',''),('fof-oauth.discord.client_secret',''),('fof-oauth.facebook','1'),('fof-oauth.facebook.app_id','420561222298244'),('fof-oauth.facebook.app_secret','00cce238c047098c12df9956ac8a6bbf'),('fof-oauth.github',''),('fof-oauth.github.client_id',''),('fof-oauth.github.client_secret',''),('fof-oauth.gitlab',''),('fof-oauth.gitlab.client_id',''),('fof-oauth.gitlab.client_secret',''),('fof-oauth.gitlab.domain',''),('fof-oauth.google','1'),('fof-oauth.google.client_id','792509938479-hc9qqiahr74j4g6laq4trdh803crffm6.apps.googleusercontent.com'),('fof-oauth.google.client_secret','GSqhtm0HYD1bLvKsjv1hfwV9'),('fof-oauth.only_icons',''),('fof-oauth.twitter',''),('fof-oauth.twitter.api_key',''),('fof-oauth.twitter.api_secret',''),('fof-sitemap.frequency','daily'),('fof-sitemap.mode','run'),('fof-user-directory-link',''),('fof-user-directory.default-sort',''),('forum_description','A community for the Marching Arts'),('forum_title','SheetScience'),('logo_path','logo-l9nvupzp.png'),('mail_driver','mail'),('mail_from','noreply@161.35.54.21'),('michaelbelgium-discussionviews.abbr_numbers','0'),('michaelbelgium-discussionviews.max_listcount','5'),('michaelbelgium-discussionviews.show_filter','1'),('michaelbelgium-discussionviews.show_viewlist','1'),('michaelbelgium-discussionviews.track_unique','0'),('show_language_selector','1'),('theme_colored_header','0'),('theme_dark_mode','0'),('theme_primary_color','#7e9cc4'),('theme_secondary_color','#4D698E'),('version','0.1.0-beta.14.1'),('welcome_message','A community for the Marching Arts. \nThis is beta software and your data will not be saved. '),('welcome_title','Welcome to SheetScience');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_user`
--

DROP TABLE IF EXISTS `tag_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_user` (
  `user_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  `marked_as_read_at` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`tag_id`),
  KEY `tag_user_tag_id_foreign` (`tag_id`),
  CONSTRAINT `tag_user_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tag_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_user`
--

LOCK TABLES `tag_user` WRITE;
/*!40000 ALTER TABLE `tag_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_mode` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `default_sort` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_restricted` tinyint(1) NOT NULL DEFAULT 0,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  `discussion_count` int(10) unsigned NOT NULL DEFAULT 0,
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_discussion_id` int(10) unsigned DEFAULT NULL,
  `last_posted_user_id` int(10) unsigned DEFAULT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `post_count` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_slug_unique` (`slug`),
  KEY `tags_parent_id_foreign` (`parent_id`),
  KEY `tags_last_posted_user_id_foreign` (`last_posted_user_id`),
  KEY `tags_last_posted_discussion_id_foreign` (`last_posted_discussion_id`),
  CONSTRAINT `tags_last_posted_discussion_id_foreign` FOREIGN KEY (`last_posted_discussion_id`) REFERENCES `discussions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tags_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tags_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `tags` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (2,'WGI','wgi','','#72cc9e',NULL,NULL,1,NULL,NULL,0,0,3,'2020-11-29 14:34:06',2,1,'fas fa-users',1),(3,'Drumline','drumline','','#db9569',NULL,NULL,2,NULL,NULL,0,0,2,'2020-11-29 14:34:06',2,1,'fas fa-drum',0),(4,'RCC','rcc','','',NULL,NULL,0,2,NULL,0,0,3,'2020-11-29 14:34:06',2,1,'',1),(5,'DCI','dci','','#94bee0',NULL,NULL,0,NULL,NULL,0,0,0,NULL,NULL,NULL,'fas fa-users',0),(6,'Bluecoats','bluecoats','','',NULL,NULL,1,5,NULL,0,0,0,NULL,NULL,NULL,'',0),(7,'Front Ensemble','front-ensemble','','#db9569',NULL,NULL,4,NULL,NULL,0,0,0,NULL,NULL,NULL,'fas fa-ruler-horizontal',0),(8,'Brass','brass','','#db9569',NULL,NULL,3,NULL,NULL,0,0,0,NULL,NULL,NULL,'fas fa-volume-up',0),(9,'Community Announcements','community-announcements','','',NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,'',0),(10,'Full Battery','full-battery','','',NULL,NULL,0,3,NULL,0,0,0,NULL,NULL,NULL,'fas fa-users',0),(11,'Snare','snare','','',NULL,NULL,3,3,NULL,0,0,2,'2020-11-29 14:34:06',2,1,'fas fa-hockey-puck',0),(12,'Bass Drums','bass-drums','','',NULL,NULL,2,3,NULL,0,0,0,NULL,NULL,NULL,'fas fa-grip-lines-vertical',0),(13,'Tenors','tenors','','',NULL,NULL,1,3,NULL,0,0,0,NULL,NULL,NULL,'fab fa-mendeley',0),(14,'Blue Devils','blue-devils','','',NULL,NULL,2,5,NULL,0,0,0,NULL,NULL,NULL,'',0),(15,'Licks','licks','','',NULL,NULL,6,NULL,NULL,0,0,0,NULL,NULL,NULL,'fas fa-music',0),(16,'Santa Clara Vanguard','santa-clara-vanguard','','',NULL,NULL,5,5,NULL,0,0,0,NULL,NULL,NULL,'',0),(17,'Carolina Crown','carolina-crown','','',NULL,NULL,0,5,NULL,0,0,0,NULL,NULL,NULL,'',0),(18,'The Cavaliers','the-cavaliers','','',NULL,NULL,6,5,NULL,0,0,0,NULL,NULL,NULL,'',0),(19,'Boston Crusaders','boston-crusaders','','',NULL,NULL,4,5,NULL,0,0,0,NULL,NULL,NULL,'',0),(20,'Blue Knights','blue-knights','','',NULL,NULL,3,5,NULL,0,0,0,NULL,NULL,NULL,'',0),(21,'Transcriptions','transcriptions','','',NULL,NULL,5,NULL,NULL,0,0,0,NULL,NULL,NULL,'fas fa-music',0),(22,'Drumset','drumset','','',NULL,NULL,0,7,NULL,0,0,0,NULL,NULL,NULL,'fas fa-drum',0);
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_email_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferences` blob DEFAULT NULL,
  `joined_at` datetime DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `marked_all_as_read_at` datetime DEFAULT NULL,
  `read_notifications_at` datetime DEFAULT NULL,
  `discussion_count` int(10) unsigned NOT NULL DEFAULT 0,
  `comment_count` int(10) unsigned NOT NULL DEFAULT 0,
  `read_flags_at` datetime DEFAULT NULL,
  `suspended_until` datetime DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_post_approval_count` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `first_discussion_approval_count` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_joined_at_index` (`joined_at`),
  KEY `users_last_seen_at_index` (`last_seen_at`),
  KEY `users_discussion_count_index` (`discussion_count`),
  KEY `users_comment_count_index` (`comment_count`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'sheetsciadmin','sheetscience@outlook.com',1,'$2y$10$u.b7g047lwwbSaGVKHrK2uE5iPqpQXaDWlmuIQ1VKdFQmhBsyiZsW','3MYor3HNCbRfIl2L.png','{\"draftAutosaveEnable\":true,\"draftAutosaveInterval\":6,\"notify_discussionRenamed_alert\":true,\"notify_postLiked_alert\":true,\"notify_discussionLocked_alert\":true,\"notify_postMentioned_alert\":true,\"notify_postMentioned_email\":false,\"notify_userMentioned_alert\":true,\"notify_userMentioned_email\":false,\"notify_newPost_alert\":true,\"notify_newPost_email\":true,\"notify_userSuspended_alert\":true,\"notify_userUnsuspended_alert\":true,\"notify_selectBestAnswer_alert\":true,\"notify_selectBestAnswer_email\":true,\"notify_awardedBestAnswer_alert\":true,\"notify_awardedBestAnswer_email\":false,\"notify_bestAnswerInDiscussion_alert\":false,\"notify_bestAnswerInDiscussion_email\":false,\"notify_discussionCreated_alert\":false,\"notify_discussionCreated_email\":false,\"notify_postUnapproved_alert\":false,\"notify_postUnapproved_email\":false,\"notify_userCreated_alert\":false,\"notify_userCreated_email\":false,\"followAfterReply\":false,\"fofNightMode\":1,\"fofNightMode_perDevice\":false,\"discloseOnline\":true,\"indexProfile\":true,\"locale\":null}','2020-11-29 02:14:05','2020-12-01 02:04:23',NULL,'2020-11-29 13:58:59',1,1,'2020-11-30 22:42:47',NULL,NULL,0,0),(2,'michaelangrivera','michael.angelo.rivera.ga@gmail.com',1,'$2y$10$DewuMjnAwyoVAGkjU8oCcOru695hVwdo8EuWqVzFI6qKcCfZuKg6q','f8FZXF2g0g9scDQC.png','{\"draftAutosaveEnable\":true,\"draftAutosaveInterval\":6,\"notify_discussionRenamed_alert\":true,\"notify_postLiked_alert\":true,\"notify_discussionLocked_alert\":true,\"notify_postMentioned_alert\":true,\"notify_postMentioned_email\":false,\"notify_userMentioned_alert\":true,\"notify_userMentioned_email\":false,\"notify_newPost_alert\":true,\"notify_newPost_email\":true,\"notify_userSuspended_alert\":true,\"notify_userUnsuspended_alert\":true,\"notify_selectBestAnswer_alert\":true,\"notify_selectBestAnswer_email\":true,\"notify_awardedBestAnswer_alert\":true,\"notify_awardedBestAnswer_email\":false,\"notify_bestAnswerInDiscussion_alert\":false,\"notify_bestAnswerInDiscussion_email\":false,\"notify_discussionCreated_alert\":false,\"notify_discussionCreated_email\":false,\"notify_postUnapproved_alert\":false,\"notify_postUnapproved_email\":false,\"notify_userCreated_alert\":false,\"notify_userCreated_email\":false,\"followAfterReply\":false,\"fofNightMode\":1,\"fofNightMode_perDevice\":false,\"discloseOnline\":true,\"indexProfile\":true,\"locale\":null}','2020-11-29 03:12:33','2020-11-30 03:02:35',NULL,NULL,0,0,NULL,NULL,NULL,0,0),(3,'testuser','afshan.bhatia@gmail.com',1,'$2y$10$7hEbyq9sQiZTQMYmUI8x4eS4/T7hXi.8zf3x9LfX9ztcv9wMOeN6m','hJskavSbAG7c0kZe.png',NULL,'2020-11-29 03:39:40','2020-11-29 21:46:46',NULL,NULL,1,1,NULL,NULL,NULL,0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-01  2:09:11
