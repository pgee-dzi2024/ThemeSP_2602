-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране: 14 март 2026 в 20:44
-- Версия на сървъра: 10.4.32-MariaDB
-- Версия на PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данни: `dzi_sp_2602`
--

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add Карта', 7, 'add_card'),
(26, 'Can change Карта', 7, 'change_card'),
(27, 'Can delete Карта', 7, 'delete_card'),
(28, 'Can view Карта', 7, 'view_card'),
(29, 'Can add Лог на достъп', 8, 'add_accesslog'),
(30, 'Can change Лог на достъп', 8, 'change_accesslog'),
(31, 'Can delete Лог на достъп', 8, 'delete_accesslog'),
(32, 'Can view Лог на достъп', 8, 'view_accesslog');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$pJRajdCm2DQwz9SJHhfNL3$QGMcd/F7e8mclzzSBiKQLLhwjWgYVThq2YvOo1Qa8VA=', '2026-03-14 19:42:40.669865', 1, 'user_26', '', '', '', 1, 1, '2026-02-09 10:11:21.376273');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(8, 'main', 'accesslog'),
(7, 'main', 'card'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Структура на таблица `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-02-09 10:10:03.110388'),
(2, 'auth', '0001_initial', '2026-02-09 10:10:03.520718'),
(3, 'admin', '0001_initial', '2026-02-09 10:10:03.616667'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-02-09 10:10:03.622229'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-02-09 10:10:03.627833'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-02-09 10:10:03.677876'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-02-09 10:10:03.727320'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-02-09 10:10:03.736528'),
(9, 'auth', '0004_alter_user_username_opts', '2026-02-09 10:10:03.743590'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-02-09 10:10:03.779003'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-02-09 10:10:03.782574'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-02-09 10:10:03.789575'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-02-09 10:10:03.800603'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-02-09 10:10:03.813079'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-02-09 10:10:03.824066'),
(16, 'auth', '0011_update_proxy_permissions', '2026-02-09 10:10:03.829445'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-02-09 10:10:03.840690'),
(18, 'sessions', '0001_initial', '2026-02-09 10:10:03.872291'),
(19, 'main', '0001_initial', '2026-03-13 20:16:36.498610');

-- --------------------------------------------------------

--
-- Структура на таблица `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('jub7ulq0fk6krq9cxcpzjy1vrc97gy2x', '.eJxVjMsOwiAQRf-FtSHDw0Jduu83kIEZpGogKe3K-O_apAvd3nPOfYmA21rC1nkJM4mLUOL0u0VMD647oDvWW5Op1XWZo9wVedAup0b8vB7u30HBXr41WCBjyRnIkAcc2ZGyipI_Z7aGKGFm5ViPGqKNmUDDEJP2oLw3ZEm8P-sIOBw:1vpOF6:mOrMYPzQdhpe5saB6DgvvsTi9GbwOeLkv7R8ZQurcd4', '2026-02-23 10:11:44.550409'),
('lk7apt1ujrw0aeqv071zn06rofc35zdd', '.eJxVjMsOwiAQRf-FtSHDw0Jduu83kIEZpGogKe3K-O_apAvd3nPOfYmA21rC1nkJM4mLUOL0u0VMD647oDvWW5Op1XWZo9wVedAup0b8vB7u30HBXr41WCBjyRnIkAcc2ZGyipI_Z7aGKGFm5ViPGqKNmUDDEJP2oLw3ZEm8P-sIOBw:1w1Usi:Em_T6KbQCUqudxED9CGEt_9rRkGq7eBnNb77wFCFbvM', '2026-03-28 19:42:40.672375');

-- --------------------------------------------------------

--
-- Структура на таблица `main_accesslog`
--

CREATE TABLE `main_accesslog` (
  `id` bigint(20) NOT NULL,
  `unknown_uid` varchar(50) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `event_type` varchar(20) NOT NULL,
  `card_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_accesslog`
--

INSERT INTO `main_accesslog` (`id`, `unknown_uid`, `timestamp`, `event_type`, `card_id`) VALUES
(1, '1E FB E4 06', '2026-03-13 20:38:06.874995', 'DENIED_UNKNOWN', NULL),
(2, '1E FB E4 06', '2026-03-13 20:42:24.757091', 'DENIED_UNKNOWN', NULL),
(3, '1E FB E4 06', '2026-03-13 20:54:30.800275', 'DENIED_UNKNOWN', NULL),
(4, '1E FB E4 06', '2026-03-13 21:30:28.232612', 'DENIED_UNKNOWN', NULL),
(5, '1E FB E4 06', '2026-03-14 15:08:46.695109', 'DENIED_UNKNOWN', NULL),
(6, '1E FB E4 06', '2026-03-14 15:08:59.674241', 'DENIED_UNKNOWN', NULL),
(7, '1E FB E4 06', '2026-03-14 15:09:17.242457', 'DENIED_UNKNOWN', NULL),
(8, NULL, '2026-03-14 17:10:28.614503', 'GRANTED', 2),
(9, NULL, '2026-03-14 17:11:22.260812', 'DENIED_INACTIVE', 2),
(10, NULL, '2026-03-14 17:11:33.595031', 'DENIED_INACTIVE', 2),
(11, NULL, '2026-03-14 19:10:51.932743', 'DENIED_INACTIVE', 2),
(12, NULL, '2026-03-14 19:10:58.602875', 'DENIED_INACTIVE', 2),
(13, NULL, '2026-03-14 19:11:04.849242', 'DENIED_INACTIVE', 2),
(14, 'E7 73 23 07', '2026-03-14 19:11:09.909753', 'DENIED_UNKNOWN', NULL),
(15, NULL, '2026-03-14 19:11:25.274844', 'GRANTED', 2);

-- --------------------------------------------------------

--
-- Структура на таблица `main_card`
--

CREATE TABLE `main_card` (
  `id` bigint(20) NOT NULL,
  `uid` varchar(50) NOT NULL,
  `owner_name` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_card`
--

INSERT INTO `main_card` (`id`, `uid`, `owner_name`, `is_active`, `created_at`) VALUES
(1, 'de e4 24 32', 'test test', 1, '2026-03-14 16:03:15.629780'),
(2, '1E FB E4 06', 'Иван Петров', 1, '2026-03-14 16:04:23.881681');

--
-- Indexes for dumped tables
--

--
-- Индекси за таблица `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индекси за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Индекси за таблица `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Индекси за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Индекси за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Индекси за таблица `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Индекси за таблица `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Индекси за таблица `main_accesslog`
--
ALTER TABLE `main_accesslog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_accesslog_card_id_4988e37d_fk_main_card_id` (`card_id`);

--
-- Индекси за таблица `main_card`
--
ALTER TABLE `main_card`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `main_accesslog`
--
ALTER TABLE `main_accesslog`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `main_card`
--
ALTER TABLE `main_card`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения за дъмпнати таблици
--

--
-- Ограничения за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ограничения за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `main_accesslog`
--
ALTER TABLE `main_accesslog`
  ADD CONSTRAINT `main_accesslog_card_id_4988e37d_fk_main_card_id` FOREIGN KEY (`card_id`) REFERENCES `main_card` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
