CREATE VIEW VIEW_USER_INFORMATION
(
USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH,
GENDER, CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY, HOMETOWN_CITY, HOMETOWN_STATE,
HOMETOWN_COUNTRY, INSTITUTION_NAME, PROGRAM_YEAR, PROGRAM_CONCENTRATION, PROGRAM_DEGREE
)
AS SELECT
U.USER_ID, U.FIRST_NAME, U.LAST_NAME, U.YEAR_OF_BIRTH, U.MONTH_OF_BIRTH, U.DAY_OF_BIRTH,
U.GENDER, LC.CITY, LC.STATE, LC.COUNTRY, LH.CITY, LH.STATE, LH.COUNTRY, E.INSTITUTION_NAME,
E.PROGRAM_YEAR, E.PROGRAM_CONCENTRATION, E.PROGRAM_DEGREE FROM
FB_User U
RIGHT JOIN Education E ON U.USER_ID = E.USER_ID
LEFT JOIN Location LH ON U.USER_ID = (SELECT HOMETOWN_LOCATION_ID FROM UserLivesInLocation WHERE USER_ID = U.USER_ID)
LEFT JOIN Location LC ON U.USER_ID = (SELECT CURRENT_LOCATION_ID FROM UserLivesInLocation WHERE USER_ID = U.USER_ID)
;

CREATE VIEW VIEW_ARE_FRIENDS
(
USER1_ID, USER2_ID
)
AS SELECT
USER1_ID, USER2_ID FROM UserHasFriend;

CREATE VIEW VIEW_PHOTO_INFORMATION
(
ALBUM_ID, OWNER_ID, COVER_PHOTO_ID, ALBUM_NAME, ALBUM_CREATED_TIME, 
ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, PHOTO_ID, PHOTO_CAPTION,
PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK
)
AS SELECT
ALBUM_ID, OWNER_ID, COVER_PHOTO_ID, ALBUM_NAME, ALBUM_CREATED_TIME, 
ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, PHOTO_ID, PHOTO_CAPTION,
PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK FROM Photo;

CREATE VIEW VIEW_EVENT_INFORMATION
(
EVENT_ID, EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, 
EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_LOCATION, EVENT_CITY,
EVENT_STATE, EVENT_COUNTRY, EVENT_START_TIME, EVENT_END_TIME
)
AS SELECT
E.EVENT_ID, E.EVENT_CREATOR_ID, E.EVENT_NAME, E.EVENT_TAGLINE, E.EVENT_DESCRIPTION, E.EVENT_HOST,
E.EVENT_TYPE, E.EVENT_SUBTYPE, E.EVENT_LOCATION, L.CITY, L.STATE, L.COUNTRY, E.EVENT_START_TIME, 
E.EVENT_END_TIME FROM
Event E LEFT JOIN Location L ON E.EVENT_ID = L.EVENT_ID;


CREATE VIEW VIEW_TAG_INFORMATION
(
PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE
)
AS SELECT
PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE FROM Tag;