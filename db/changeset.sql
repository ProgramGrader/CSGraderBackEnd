-- liquibase formatted sql

-- changeset liquibase:1
CREATE TYPE IF NOT EXISTS "csgrader".daterange (
  "start_time" timestamp,
  "end_time" timestamp
);

CREATE TABLE IF NOT EXISTS "csgrader"."semester" (
    "org_id" timeuuid,
    "year" date,
    "spring" frozen<daterange>,
    "summer" frozen<daterange>,
    "fall" frozen<daterange>,
    "winter" frozen<daterange>,
    PRIMARY KEY (("org_id", "year"))
);

CREATE TABLE IF NOT EXISTS "csgrader"."atemplate" (
    "id" uuid,
    "ctemplate_id" uuid,
    "Number" int,
    "Name" varchar,
    "repository_url" varchar,
    PRIMARY KEY ("id", "ctemplate_id", "Number")
) WITH CLUSTERING ORDER BY ("ctemplate_id" ASC, "Number" ASC);

CREATE TABLE IF NOT EXISTS "csgrader"."ctemplate" (
    "id" uuid,
    "org_id" timeuuid,
    "short_id" varchar,
    "name" varchar,
    "description" varchar,
    PRIMARY KEY ("id", "org_id")
) WITH CLUSTERING ORDER BY ("org_id" ASC);

CREATE TABLE IF NOT EXISTS "csgrader"."Course" (
    "long_id" uuid,
    "short_id" varchar,
    "Name" text,
    "description" varchar,
    PRIMARY KEY ("long_id")
);

CREATE TABLE IF NOT EXISTS "csgrader"."Users" (
    "id" timeuuid,
    "first_name" text,
    "last_name" text,
    "phone_number" varchar,
    "gender" varchar,
    "birth_year" varchar,
    "email" varchar,
    PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "csgrader"."org" (
    "id" timeuuid,
    "parent_org" uuid,
    "name" varchar STATIC,
    "verified" boolean,
    PRIMARY KEY ("id", "parent_org")
) WITH CLUSTERING ORDER BY ("parent_org" ASC);

CREATE TABLE IF NOT EXISTS "csgrader"."user_per_org" (
    "org_id" uuid,
    "user_id" uuid,
    "role" int,
    PRIMARY KEY (("org_id", "user_id"))
);

CREATE TABLE IF NOT EXISTS "csgrader"."assigned_assignments" (
    "aa_id" uuid,
    "assignment_id" uuid,
    "course_id" uuid,
    "user_id" timeuuid,
    "Repo Url" varchar,
    "extended" boolean,
    "hard_close_time" timestamp,
    PRIMARY KEY ("aa_id", "assignment_id", "course_id", "user_id")
) WITH CLUSTERING ORDER BY ("assignment_id" ASC, "course_id" ASC, "user_id" ASC);

CREATE TABLE IF NOT EXISTS "csgrader"."course_assignment" (
    "id" uuid,
    "order" smallint,
    "ctemplate_id" uuid,
    "Name" varchar,
    "Number" int,
    "repository_url" varchar,
    "open_time" date,
    "close_time" timestamp,
    "publish_time" timestamp,
    "published" boolean,
    PRIMARY KEY ("id", "order")
) WITH CLUSTERING ORDER BY ("order" ASC);

CREATE TABLE IF NOT EXISTS "csgrader"."course_role" (
    "e" timeuuid,
    "course_id" uuid,
    "role" varchar,
    PRIMARY KEY (("e", "course_id"))
    );