INSERT INTO FB_User (USER_ID, FIRST_NAME , LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER) SELECT MIN(USER_ID), FIRST_NAME , LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER FROM keykholt.PUBLIC_USER_INFORMATION GROUP BY USER_ID, FIRST_NAME , LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER;

INSERT INTO Education (USER_ID, PROGRAM_YEAR, INSTITUTION_NAME, PROGRAM_DEGREE, PROGRAM_CONCENTRATION) SELECT MIN(USER_ID), PROGRAM_YEAR, INSTITUTION_NAME, PROGRAM_DEGREE, PROGRAM_CONCENTRATION FROM keykholt.PUBLIC_USER_INFORMATION GROUP BY USER_ID, PROGRAM_YEAR, INSTITUTION_NAME, PROGRAM_DEGREE, PROGRAM_CONCENTRATION;


INSERT INTO Event (EVENT_ID, EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_LOCATION, EVENT_START_TIME, EVENT_END_TIME) SELECT MIN(EVENT_ID), EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_LOCATION, EVENT_START_TIME, EVENT_END_TIME FROM keykholt.PUBLIC_EVENT_INFORMATION GROUP BY EVENT_ID, EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_LOCATION, EVENT_START_TIME, EVENT_END_TIME;


INSERT INTO Location (CITY, STATE, COUNTRY, USER_ID, EVENT_ID, CHECK_USER, CHECK_HOME) 
SELECT DISTINCT HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY, USER_ID, NULL, FIRST_NAME, FIRST_NAME FROM keykholt.PUBLIC_USER_INFORMATION 
UNION 
SELECT DISTINCT CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY, USER_ID, NULL, FIRST_NAME, NULL FROM keykholt.PUBLIC_USER_INFORMATION 
UNION 
SELECT DISTINCT EVENT_CITY, EVENT_STATE, EVENT_COUNTRY, NULL, EVENT_ID, NULL, NULL FROM keykholt.PUBLIC_EVENT_INFORMATION;


INSERT INTO Photo (ALBUM_ID, OWNER_ID, COVER_PHOTO_ID, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_NAME, ALBUM_LINK, ALBUM_VISIBILITY, PHOTO_ID, PHOTO_CAPTION, PHOTO_LINK, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME) SELECT ALBUM_ID, OWNER_ID, COVER_PHOTO_ID, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_NAME, ALBUM_LINK, ALBUM_VISIBILITY, MIN(PHOTO_ID), PHOTO_CAPTION, PHOTO_LINK, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME FROM keykholt.PUBLIC_PHOTO_INFORMATION GROUP BY ALBUM_ID, OWNER_ID, COVER_PHOTO_ID, ALBUM_NAME, ALBUM_LINK, ALBUM_VISIBILITY, PHOTO_ID, PHOTO_CAPTION, PHOTO_LINK, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME;

INSERT INTO Tag (PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE) SELECT MIN(PHOTO_ID), TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE FROM keykholt.PUBLIC_TAG_INFORMATION GROUP BY PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE;

INSERT INTO UserHasFriend (USER1_ID, USER2_ID) SELECT DISTINCT USER1_ID, USER2_ID FROM keykholt.PUBLIC_ARE_FRIENDS;

DELETE FROM UserHasFriend t1 WHERE 
	EXISTS (SELECT * FROM UserHasFriend t2 WHERE t2.USER1_ID = t1.USER2_ID AND t2.USER2_ID = t1.USER1_ID AND t1.USER1_ID > t2.USER1_ID);
