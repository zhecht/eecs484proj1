CREATE VIEW VIEW_USER_INFORMATION
(
USER_ID VARCHAR2(100),
FIRST_NAME VARCHAR2(100),
LAST_NAME VARCHAR2(100),
YEAR_OF_BIRTH NUMBER(38),
MONTH_OF_BIRTH NUMBER(38),
DAY_OF_BIRTH NUMBER(38),
GENDER VARCHAR2(100),
CURRENT_CITY VARCHAR2(100),
CURRENT_STATE VARCHAR2(100),
CURRENT_COUNTRY VARCHAR2(100),
HOMETOWN_CITY VARCHAR2(100),
HOMETOWN_STATE VARCHAR2(100),
HOMETOWN_COUNTRY VARCHAR2(100),
INSTITUTION_NAME VARCHAR2(100),
PROGRAM_YEAR NUMBER(38),
PROGRAM_CONCENTRATION CHAR(100),
PROGRAM_DEGREE VARCHAR2(100)
)
AS SELECT
U.USER_ID, U.FIRST_NAME, U.LAST_NAME, U.YEAR_OF_BIRTH, U.MONTH_OF_BIRTH, U.DAY_OF_BIRTH,
U.GENDER, L.CITY, L.STATE, L.COUNTRY, L.CITY, L.STATE, L.COUNTRY, E.INSTITUTION_NAME,
E.PROGRAM_YEAR, E.PROGRAM_CONCENTRATION, E.PROGRAM_DEGREE FROM
User U, Education E, Location L WHERE
E.USER_ID = U.USER_ID AND
L.USER_ID = U.USER_ID
;

CREATE VIEW VIEW_ARE_FRIENDS
(
USER1_ID VARCHAR2(100),
USER2_ID VARCHAR2(100)
)
AS SELECT
USER1_ID, USER2_ID FROM UserHasFriend;

CREATE VIEW VIEW_PHOTO_INFORMATION
(
ALBUM_ID VARCHAR2(100),
OWNER_ID VARCHAR2(100),
COVER_PHOTO_ID VARCHAR2(100),
ALBUM_NAME VARCHAR2(100),
ALBUM_CREATED_TIME TIMESTAMP(6),
ALBUM_MODIFIED_TIME TIMESTAMP(6),
ALBUM_LINK VARCHAR2(2000),
ALBUM_VISIBILITY VARCHAR2(100),
PHOTO_ID VARCHAR2(100),
PHOTO_CAPTION VARCHAR2(100),
PHOTO_CREATED_TIME TIMESTAMP(6),
PHOTO_MODIFIED_TIME TIMESTAMP(6),
PHOTO_LINK VARCHAR(2000)
#PRIMARY KEY (ALBUM_ID, OWNER_ID, COVER_PHOTO_ID),
#FOREIGN KEY (OWNER_ID) REFERENCES VIEW_USER_INFORMATION(USER_ID)
)
AS SELECT
P.ALBUM_ID, A.USER_ID, A.COVER_PHOTO_ID, A.ALBUM_NAME, A.ALBUM_CREATED_TIME, 
A.ALBUM_MODIFIED_TIME, A.ALBUM_LINK, A.ALBUM_VISIBILITY, P.PHOTO_ID, P.PHOTO_CAPTION,
P.PHOTO_CREATED_TIME, P.PHOTO_MODIFIED_TIME, P.PHOTO_LINK FROM
Album A, Photo P WHERE
P.ALBUM_ID = A.ALBUM_ID
;

CREATE VIEW VIEW_EVENT_INFORMATION
(
EVENT_ID VARCHAR2(100),
EVENT_CREATOR_ID VARCHAR2(100),
EVENT_NAME VARCHAR(100),
EVENT_TAGLINE VARCHAR2(1000),
EVENT_DESCRIPTION VARCHAR2(4000),
EVENT_HOST VARCHAR2(100),
EVENT_TYPE VARCHAR2(100),
EVENT_SUBTYPE VARCHAR2(100),
EVENT_LOCATION VARCHAR2(200),
EVENT_CITY VARCHAR2(100),
EVENT_STATE VARCHAR2(100),
EVENT_COUNTRY VARCHAR2(100),
EVENT_START_TIME TIMESTAMP(6),
EVENT_END_TIME TIMESTAMP(6)
#PRIMARY KEY (EVENT_ID),
#FOREIGN KEY (EVENT_CREATOR_ID) REFERENCES VIEW_USER_INFORMATION(USER_ID)
)
AS SELECT
E.EVENT_ID, E.EVENT_CREATOR_ID, E.EVENT_NAME, E.EVENT_TAGLINE, E.EVENT_DESCRIPTION, E.EVENT_HOST,
E.EVENT_TYPE, E.EVENT_SUBTYPE, E.EVENT_LOCATION, L.CITY, L.STATE, L.COUNTRY, E.EVENT_START_TIME, 
E.EVENT_END_TIME FROM
Event E, Location L WHERE
L.USER_ID = E.EVENT_ID;


CREATE VIEW VIEW_TAG_INFORMATION
(
PHOTO_ID VARCHAR2(100),
TAG_SUBJECT_ID VARCHAR2(100),
TAG_CREATED_TIME TIMESTAMP(6),
TAG_X_COORDINATE NUMBER,
TAG_Y_COORDINATE NUMBER,
#PRIMARY KEY (PHOTO_ID, TAG_SUBJECT_ID),
#PRIMARY KEY (PHOTO_ID) REFERENCES VIEW_PHOTO_INFORMATION(PHOTO_ID),
#FOREIGN KEY (TAG_SUBJECT_ID) REFERENCES VIEW_USER_INFORMATION(USER_ID)
)
AS SELECT
PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE FROM Event;



