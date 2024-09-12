-- PostgreSQL dump converted from MySQL

-- Table structure for table "auth_group"
DROP TABLE IF EXISTS "auth_group" CASCADE;
CREATE TABLE IF NOT EXISTS "auth_group" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(150) NOT NULL,
  UNIQUE ("name")
);

-- Table structure for table "auth_group_permissions"
DROP TABLE IF EXISTS "auth_group_permissions" CASCADE;
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
  "id" SERIAL PRIMARY KEY,
  "group_id" INTEGER NOT NULL,
  "permission_id" INTEGER NOT NULL,
  UNIQUE ("group_id", "permission_id"),
  FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id"),
  FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id")
);

-- Table structure for table "auth_permission"
DROP TABLE IF EXISTS "auth_permission" CASCADE;
CREATE TABLE IF NOT EXISTS "auth_permission" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "content_type_id" INTEGER NOT NULL,
  "codename" VARCHAR(100) NOT NULL,
  UNIQUE ("content_type_id", "codename"),
  FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id")
);

-- Dumping data for table "auth_permission"
INSERT INTO "auth_permission" (id, name, content_type_id, codename) VALUES 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session')
ON CONFLICT (id) DO NOTHING;

-- Table structure for table "auth_user"
DROP TABLE IF EXISTS "auth_user" CASCADE;
CREATE TABLE IF NOT EXISTS "auth_user" (
  "id" SERIAL PRIMARY KEY,
  "password" VARCHAR(128) NOT NULL,
  "last_login" TIMESTAMP DEFAULT NULL,
  "is_superuser" BOOLEAN NOT NULL,
  "username" VARCHAR(150) NOT NULL,
  "first_name" VARCHAR(150) NOT NULL,
  "last_name" VARCHAR(150) NOT NULL,
  "email" VARCHAR(254) NOT NULL,
  "is_staff" BOOLEAN NOT NULL,
  "is_active" BOOLEAN NOT NULL,
  "date_joined" TIMESTAMP NOT NULL,
  UNIQUE ("username")
);

-- Dumping data for table "auth_user"
INSERT INTO "auth_user" (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES 
(5,'pbkdf2_sha256$720000$bXyVgvHbyGbfMZhvkmBQk6$HN3WcDQOW5BgEadmGp/mGcek9gOHEKGdi2itk9KBjRU=','2024-07-23 15:19:37.030679',false,'James','','','james@gmail.com',false,true,'2024-07-09 23:20:32.287056'),
(12,'pbkdf2_sha256$720000$YqYXrlfKruH1KJpn0G77v2$Zr7pZ9sG03BFmonaP3CcjQ8Aa9Th0p6jHRc5tvvaqcE=','2024-08-30 23:33:26.749418',true,'David_admin','','','davideduardo@gmail.com',true,true,'2024-08-25 01:34:50.480859'),
(15,'pbkdf2_sha256$720000$fNAU5IgPt7QtNYZ03m3T1W$P4GpQsq+JkTyEimGg1hSpHp0YKrfjkc17v96sjE7S7U=','2024-08-29 17:03:41.871226',false,'Davis','','','davis@gmail.com',false,true,'2024-08-29 16:46:50.672349'),
(16,'pbkdf2_sha256$720000$B0eKpu8gCzMOSV2JjcFv5j$5o9Xse5nqV3NelqBxWOmyUVg0Cu5iOXhY8YMeH0tVxw=','2024-08-30 01:57:36.038848',false,'Kevin','','','kevin@gmail.com',false,true,'2024-08-30 01:56:40.785329'),
(18,'pbkdf2_sha256$720000$Ounv9kXGTOnAeXGgVNTon8$dSEp7PEeIxO2HIYyYH7sUQl5z23JvkRZ6xZjQi7nyd0=','2024-09-03 23:02:53.172256',true,'Caio','','','caio@gmail.com',true,true,'2024-09-03 23:02:48.227501')
ON CONFLICT (id) DO NOTHING;

-- Table structure for table "auth_user_groups"
DROP TABLE IF EXISTS "auth_user_groups" CASCADE;
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "group_id" INTEGER NOT NULL,
  UNIQUE ("user_id", "group_id"),
  FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id"),
  FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id")
);

-- Table structure for table "auth_user_user_permissions"
DROP TABLE IF EXISTS "auth_user_user_permissions" CASCADE;
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "permission_id" INTEGER NOT NULL,
  UNIQUE ("user_id", "permission_id"),
  FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id"),
  FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id")
);

-- Table structure for table "django_admin_log"
DROP TABLE IF EXISTS "django_admin_log" CASCADE;
CREATE TABLE IF NOT EXISTS "django_admin_log" (
  "id" SERIAL PRIMARY KEY,
  "action_time" TIMESTAMP NOT NULL,
  "object_id" TEXT,
  "object_repr" VARCHAR(200) NOT NULL,
  "action_flag" SMALLINT NOT NULL,
  "change_message" TEXT NOT NULL,
  "content_type_id" INTEGER,
  "user_id" INTEGER NOT NULL,
  FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id"),
  FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id"),
  CHECK ("action_flag" >= 0)
);

-- Table structure for table "django_content_type"
DROP TABLE IF EXISTS "django_content_type" CASCADE;
CREATE TABLE IF NOT EXISTS "django_content_type" (
  "id" SERIAL PRIMARY KEY,
  "app_label" VARCHAR(100) NOT NULL,
  "model" VARCHAR(100) NOT NULL,
  UNIQUE ("app_label", "model")
);

-- Dumping data for table "django_content_type"
INSERT INTO "django_content_type" (id, app_label, model) VALUES 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(6,'sessions','session')
ON CONFLICT (id) DO NOTHING;

-- Table structure for table "django_migrations"
DROP TABLE IF EXISTS "django_migrations" CASCADE;
CREATE TABLE IF NOT EXISTS "django_migrations" (
  "id" SERIAL PRIMARY KEY,
  "app" VARCHAR(255) NOT NULL,
  "name" VARCHAR(255) NOT NULL,
  "applied" TIMESTAMP NOT NULL
);

-- Dumping data for table "django_migrations"
INSERT INTO "django_migrations" (id, app, name, applied) VALUES 
(1,'contenttypes','0001_initial','2024-06-28 16:27:25.267714'),
(2,'auth','0001_initial','2024-06-28 16:27:25.998090'),
(3,'admin','0001_initial','2024-06-28 16:27:26.138318'),
(4,'admin','0002_logentry_remove_auto_add','2024-06-28 16:27:26.145320'),
(5,'admin','0003_logentry_add_action_flag_choices','2024-06-28 16:27:26.152326'),
(6,'contenttypes','0002_remove_content_type_name','2024-06-28 16:27:26.222262'),
(7,'auth','0002_alter_permission_name_max_length','2024-06-28 16:27:26.287769'),
(8,'auth','0003_alter_user_email_max_length','2024-06-28 16:27:26.321777'),
(9,'auth','0004_alter_user_username_opts','2024-06-28 16:27:26.328779'),
(10,'auth','0005_alter_user_last_login_null','2024-06-28 16:27:26.388078'),
(11,'auth','0006_require_contenttypes_0002','2024-06-28 16:27:26.390081'),
(12,'auth','0007_alter_validators_add_error_messages','2024-06-28 16:27:26.396085'),
(13,'auth','0008_alter_user_username_max_length','2024-06-28 16:27:26.485489'),
(14,'auth','0009_alter_user_last_name_max_length','2024-06-28 16:27:26.551505'),
(15,'auth','0010_alter_group_name_max_length','2024-06-28 16:27:26.570506'),
(16,'auth','0011_update_proxy_permissions','2024-06-28 16:27:26.576508'),
(17,'auth','0012_alter_user_first_name_max_length','2024-06-28 16:27:26.644524'),
(18,'sessions','0001_initial','2024-06-28 16:27:26.678538')
ON CONFLICT (id) DO NOTHING;

-- Table structure for table "django_session"
DROP TABLE IF EXISTS "django_session" CASCADE;
CREATE TABLE IF NOT EXISTS "django_session" (
  "session_key" VARCHAR(40) NOT NULL,
  "session_data" TEXT NOT NULL,
  "expire_date" TIMESTAMP NOT NULL,
  PRIMARY KEY ("session_key")
);

-- Dumping data for table "django_session"
INSERT INTO "django_session" (session_key, session_data, expire_date) VALUES 
('cgqhwkhc6ljjb06b527oyrlgo9sxc597','e30:1slcOr:pxbDJAqKsHE1Y_4FLN_YYWV_PfRr1xTuVA4S0V5rcBw','2024-09-17 22:53:25.613127')
ON CONFLICT (session_key) DO NOTHING;

-- Table structure for table "usuarios"
DROP TABLE IF EXISTS "usuarios" CASCADE;
CREATE TABLE IF NOT EXISTS "usuarios" (
  "id" SERIAL PRIMARY KEY,
  "nome" VARCHAR(100) NOT NULL,
  "email" VARCHAR(100) NOT NULL,
  "senha" VARCHAR(100) NOT NULL,
  "data_aniversario" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
