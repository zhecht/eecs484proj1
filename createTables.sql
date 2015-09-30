

CREATE TABLE FB_User
(
USER_ID VARCHAR2(100),
FIRST_NAME VARCHAR2(100),
LAST_NAME VARCHAR2(100),
GENDER VARCHAR2(100),
DAY_OF_BIRTH VARCHAR2(100),
MONTH_OF_BIRTH VARCHAR2(100),
YEAR_OF_BIRTH VARCHAR2(100),
PRIMARY KEY (USER_ID)
);

CREATE TABLE Photo
(
PHOTO_ID VARCHAR2(100),
ALBUM_ID VARCHAR2(100),
PHOTO_CAPTION VARCHAR2(2000),
PHOTO_CREATED_TIME TIMESTAMP(6),
PHOTO_MODIFIED_TIME TIMESTAMP(6),
PHOTO_LINK VARCHAR2(2000),
PRIMARY KEY(PHOTO_ID)
);

CREATE TABLE Album
(
ALBUM_ID VARCHAR2(100),
COVER_PHOTO_ID VARCHAR2(100),
USER_ID VARCHAR2(100),
ALBUM_CREATED_TIME TIMESTAMP(6),
ALBUM_MODIFIED_TIME TIMESTAMP(6),
ALBUM_LINK VARCHAR2(2000),
ALBUM_VISIBILITY VARCHAR2(100),
ALBUM_NAME VARCHAR2(100),
PRIMARY KEY (ALBUM_ID),
FOREIGN KEY (COVER_PHOTO_ID) REFERENCES Photo(PHOTO_ID),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID)
);

CREATE TABLE Tag
(
TAG_ID VARCHAR2(100),
PHOTO_ID VARCHAR2(100),
TAG_SUBJECT_ID VARCHAR2(100),
TAG_CREATED_TIME TIMESTAMP(6),
TAG_X_COORDINATE NUMBER,
TAG_Y_COORDINATE NUMBER,
PRIMARY KEY (TAG_ID),
FOREIGN KEY (PHOTO_ID) REFERENCES Photo(PHOTO_ID),
FOREIGN KEY (TAG_SUBJECT_ID) REFERENCES FB_User(USER_ID)
);

CREATE TABLE Education
(
EDUCATION_ID VARCHAR2(100),
USER_ID VARCHAR2(100),
PROGRAM_YEAR NUMBER(38),
INSTITUTION_NAME VARCHAR2(100),
PROGRAM_DEGREE VARCHAR2(100),
PROGRAM_CONCENTRATION CHAR(100),
PRIMARY KEY (EDUCATION_ID),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID)
);

CREATE TABLE Event
(
EVENT_ID VARCHAR2(100),
EVENT_CREATOR_ID VARCHAR2(100),
EVENT_NAME VARCHAR2(100),
EVENT_TAGLINE VARCHAR2(1000),
EVENT_DESCRIPTION VARCHAR2(4000),
EVENT_HOST VARCHAR2(100),
EVENT_TYPE VARCHAR2(100),
EVENT_SUBTYPE VARCHAR2(100),
EVENT_LOCATION VARCHAR2(200),
EVENT_CREATED_TIME TIMESTAMP(6),
EVENT_MODIFIED_TIME TIMESTAMP(6),
PRIMARY KEY (EVENT_ID),
FOREIGN KEY (EVENT_CREATOR_ID) REFERENCES FB_User(USER_ID)
);

CREATE TABLE Location
(
LOCATION_ID VARCHAR2(100),
USER_ID VARCHAR2(100),
LOCATION_TYPE VARCHAR2(100),
STATE VARCHAR2(100),
CITY VARCHAR2(100),
COUNTRY VARCHAR2(100),
PRIMARY KEY (LOCATION_ID),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID)
);

CREATE TABLE Message
(
MESSAGE_ID VARCHAR2(100),
RECEIVER_ID VARCHAR2(100),
SENDER_ID VARCHAR2(100),
SENT_TIME TIMESTAMP(6),
MESSAGE_CONTENT VARCHAR2(100),
PRIMARY KEY (MESSAGE_ID),
FOREIGN KEY (RECEIVER_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (SENDER_ID) REFERENCES FB_User(USER_ID)
);

CREATE TABLE PhotoHasTag
(
TAG_ID VARCHAR2(100),
PHOTO_ID VARCHAR2(100),
FOREIGN KEY (TAG_ID) REFERENCES Tag(TAG_ID),
FOREIGN KEY (PHOTO_ID) REFERENCES Photo(PHOTO_ID)
);

CREATE TABLE AlbumHasPhoto
(
PHOTO_ID VARCHAR2(100),
ALBUM_ID VARCHAR2(100),
FOREIGN KEY (PHOTO_ID) REFERENCES Photo(PHOTO_ID),
FOREIGN KEY (ALBUM_ID) REFERENCES Album(ALBUM_ID)
);

CREATE TABLE UserHasAlbum
(
ALBUM_ID VARCHAR2(100),
USER_ID VARCHAR2(100),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (ALBUM_ID) REFERENCES Album(ALBUM_ID)
);

CREATE TABLE UserHasEducation
(
EDUCATION_ID VARCHAR2(100),
USER_ID VARCHAR2(100),
FOREIGN KEY (EDUCATION_ID) REFERENCES Education(EDUCATION_ID),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID)
);

CREATE TABLE UserPlansEvent
(
USER_ID VARCHAR2(100),
EVENT_ID VARCHAR2(100),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (EVENT_ID) REFERENCES Event(EVENT_ID)
);

CREATE TABLE UserParticipatesInEvent
(
USER_ID VARCHAR2(100),
EVENT_ID VARCHAR2(100),
STATUS VARCHAR2(100),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (EVENT_ID) REFERENCES Event(EVENT_ID)
);

CREATE TABLE UserHasFriend
(
USER1_ID VARCHAR2(100),
USER2_ID VARCHAR2(100),
FOREIGN KEY (USER1_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (USER2_ID) REFERENCES FB_User(USER_ID)
);

CREATE TABLE EventIsInLocation
(
EVENT_ID VARCHAR2(100),
LOCATION_ID VARCHAR2(100),
FOREIGN KEY (EVENT_ID) REFERENCES Event(EVENT_ID),
FOREIGN KEY (LOCATION_ID) REFERENCES Location(LOCATION_ID)
);

CREATE TABLE UserLivesInLocation
(
USER_ID VARCHAR2(100),
CURRENT_LOCATION_ID VARCHAR2(100),
HOMETOWN_LOCATION_ID VARCHAR2(100),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (CURRENT_LOCATION_ID) REFERENCES Location(LOCATION_ID),
FOREIGN KEY (HOMETOWN_LOCATION_ID) REFERENCES Location(LOCATION_ID)
);

CREATE TABLE UserSendsReceivesMessage
(
USER_ID VARCHAR2(100),
MESSAGE_ID VARCHAR2(100),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (MESSAGE_ID) REFERENCES Message(MESSAGE_ID)
);

CREATE SEQUENCE seq_photo
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_user
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_tag
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_education
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_event
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_location
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_message
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_album
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE TRIGGER photo_increment
BEFORE INSERT
	ON Photo
	FOR EACH ROW
BEGIN
	:NEW.PHOTO_ID := seq_photo.nextval;
	:NEW.PHOTO_CREATED_TIME := CURRENT_TIMESTAMP;
	:NEW.PHOTO_MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/

CREATE TRIGGER photo_modified
BEFORE UPDATE
	ON Photo
	FOR EACH ROW
BEGIN
	:NEW.PHOTO_MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/

CREATE TRIGGER album_increment
BEFORE INSERT
	ON Album
	FOR EACH ROW
BEGIN
	:NEW.ALBUM_ID := seq_album.nextval;
	:NEW.ALBUM_CREATED_TIME := CURRENT_TIMESTAMP;
	:NEW.ALBUM_MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/

CREATE TRIGGER album_modified
BEFORE UPDATE
	ON Album
	FOR EACH ROW
BEGIN
	:NEW.ALBUM_MODIFIED_TIME := CURRENT_TIMESTAMP;
END;
/

CREATE TRIGGER tag_increment
BEFORE INSERT
	ON Tag
	FOR EACH ROW
BEGIN
	:NEW.TAG_ID := seq_tag.nextval;
	:NEW.TAG_CREATED_TIME := CURRENT_TIMESTAMP;
END;
/

CREATE TRIGGER user_increment
BEFORE INSERT
	ON FB_User
	FOR EACH ROW
BEGIN
	:NEW.USER_ID := seq_user.nextval;
END;
/

CREATE TRIGGER education_increment
BEFORE INSERT
	ON Education
	FOR EACH ROW
BEGIN
	:NEW.EDUCATION_ID := seq_education.nextval;
END;
/

CREATE TRIGGER event_increment
BEFORE INSERT
	ON Event
	FOR EACH ROW
BEGIN
	:NEW.EVENT_ID := seq_event.nextval;
END;
/

CREATE TRIGGER message_increment
BEFORE INSERT
	ON Message
	FOR EACH ROW
BEGIN
	:NEW.MESSAGE_ID := seq_message.nextval;
END;
/

CREATE TRIGGER location_increment
BEFORE INSERT
	ON Location
	FOR EACH ROW
BEGIN
	:NEW.LOCATION_ID := seq_location.nextval;
END;
/

CREATE TRIGGER user_album_relation
AFTER INSERT
	ON Album
	FOR EACH ROW
BEGIN
	INSERT INTO UserHasAlbum (USER_ID, ALBUM_ID) VALUES (:NEW.USER_ID, :NEW.ALBUM_ID);
END;
/

CREATE TRIGGER album_photo_relation
AFTER INSERT
	ON Photo
	FOR EACH ROW
BEGIN
	INSERT INTO AlbumHasPhoto (PHOTO_ID, ALBUM_ID) VALUES (:NEW.PHOTO_ID, :NEW.ALBUM_ID);
END;
/

CREATE TRIGGER photo_tag_relation
AFTER INSERT
	ON Tag
	FOR EACH ROW
BEGIN
	INSERT INTO PhotoHasTag (PHOTO_ID, TAG_ID) VALUES (:NEW.PHOTO_ID, :NEW.TAG_ID);
END;
/

CREATE TRIGGER user_message_relation
AFTER INSERT
	ON Message
	FOR EACH ROW
BEGIN
	INSERT INTO UserSendsReceivesMessage (USER_ID, MESSAGE_ID) VALUES (:NEW.SENDER_ID, :NEW.MESSAGE_ID);
END;
/

CREATE TRIGGER user_education_relation
AFTER INSERT
	ON Education
	FOR EACH ROW
BEGIN
	INSERT INTO UserHasEducation (EDUCATION_ID, USER_ID) VALUES (:NEW.EDUCATION_ID, :NEW.USER_ID);
END;
/

CREATE TRIGGER user_event_relation
AFTER INSERT
	ON Event
	FOR EACH ROW
BEGIN
	INSERT INTO UserPlansEvent (EVENT_ID, USER_ID) VALUES (:NEW.EVENT_ID, :NEW.EVENT_CREATOR_ID);
END;
/

CREATE TRIGGER user_location_relation
AFTER INSERT
	ON FB_User
	FOR EACH ROW
BEGIN
	
END;
/

CREATE TRIGGER after_insert_location
AFTER INSERT
	ON Location
	FOR EACH ROW
BEGIN
	IF MOD(:NEW.LOCATION_ID, 3) = 1 THEN
		INSERT INTO UserLivesInLocation (USER_ID, HOMETOWN_LOCATION_ID) VALUES (:NEW.USER_ID, :NEW.LOCATION_ID)
	ELSIF MOD(:NEW.LOCATION_ID, 3) = 2 THEN
		INSERT INTO UserLivesInLocation (USER_ID, CURRENT_LOCATION_ID) VALUES (:NEW.USER_ID, :NEW.LOCATION_ID)
	ELSE
		INSERT INTO EventIsInLocation (EVENT_ID, LOCATION_ID) VALUES (:NEW.USER_ID, :NEW.LOCATION_ID)
	END IF;
END;
/


