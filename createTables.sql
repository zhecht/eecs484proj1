

CREATE TABLE FB_User
(
USER_ID VARCHAR2(100),
FIRST_NAME VARCHAR2(100) NOT NULL,
LAST_NAME VARCHAR2(100) NOT NULL,
GENDER VARCHAR2(100),
DAY_OF_BIRTH NUMBER(38),
MONTH_OF_BIRTH NUMBER(38),
YEAR_OF_BIRTH NUMBER(38),
PRIMARY KEY (USER_ID)
);

CREATE TABLE Photo
(
PHOTO_ID VARCHAR2(100),
COVER_PHOTO_ID VARCHAR2(100),
OWNER_ID VARCHAR2(100),
ALBUM_ID VARCHAR2(100),
PHOTO_CAPTION VARCHAR2(2000),
PHOTO_CREATED_TIME TIMESTAMP(6),
PHOTO_MODIFIED_TIME TIMESTAMP(6),
PHOTO_LINK VARCHAR2(2000),
ALBUM_CREATED_TIME TIMESTAMP(6),
ALBUM_MODIFIED_TIME TIMESTAMP(6),
ALBUM_LINK VARCHAR2(2000),
ALBUM_VISIBILITY VARCHAR2(100),
ALBUM_NAME VARCHAR2(100),
PRIMARY KEY(PHOTO_ID),
FOREIGN KEY (OWNER_ID) REFERENCES FB_User(USER_ID)
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
EVENT_START_TIME TIMESTAMP(6),
EVENT_END_TIME TIMESTAMP(6),
PRIMARY KEY (EVENT_ID),
FOREIGN KEY (EVENT_CREATOR_ID) REFERENCES FB_User(USER_ID)
);

CREATE TABLE Location
(
LOCATION_ID VARCHAR2(100),
USER_ID VARCHAR2(100),
EVENT_ID VARCHAR2(100),
STATE VARCHAR2(100),
CITY VARCHAR2(100),
COUNTRY VARCHAR2(100),
IS_HOMETOWN VARCHAR2(100),
PRIMARY KEY (LOCATION_ID),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (EVENT_ID) REFERENCES Event(EVENT_ID)
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

CREATE TABLE UserLivesInLocation
(
USER_ID VARCHAR2(100),
CURRENT_LOCATION_ID VARCHAR2(100),
HOMETOWN_LOCATION_ID VARCHAR2(100),
PRIMARY KEY (USER_ID, CURRENT_LOCATION_ID, HOMETOWN_LOCATION_ID),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (CURRENT_LOCATION_ID) REFERENCES Location(LOCATION_ID),
FOREIGN KEY (HOMETOWN_LOCATION_ID) REFERENCES Location(LOCATION_ID)
);

CREATE TABLE UserParticipatesInEvent
(
USER_ID VARCHAR2(100),
EVENT_ID VARCHAR2(100),
STATUS VARCHAR2(100),
PRIMARY KEY (USER_ID, EVENT_ID),
FOREIGN KEY (USER_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (EVENT_ID) REFERENCES Event(EVENT_ID)
);

CREATE TABLE UserHasFriend
(
USER1_ID VARCHAR2(100),
USER2_ID VARCHAR2(100),
PRIMARY KEY (USER1_ID, USER2_ID),
FOREIGN KEY (USER1_ID) REFERENCES FB_User(USER_ID),
FOREIGN KEY (USER2_ID) REFERENCES FB_User(USER_ID)
);

CREATE SEQUENCE seq_education
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

CREATE SEQUENCE seq_tag
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE TRIGGER tag_increment
BEFORE INSERT
    ON Tag
    FOR EACH ROW
BEGIN
    :NEW.TAG_ID := seq_tag.nextval;
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

CREATE TRIGGER photo_tag_relation
AFTER INSERT
    ON Tag
    FOR EACH ROW
BEGIN
    INSERT INTO PhotoHasTag (PHOTO_ID, TAG_ID) VALUES (:NEW.PHOTO_ID, :NEW.TAG_ID);
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

CREATE TRIGGER insert_location_trigger
AFTER INSERT
    ON Location
        FOR EACH ROW
DECLARE
    rows_found NUMBER;
BEGIN
    IF :NEW.USER_ID IS NOT NULL THEN
        SELECT COUNT(*) INTO rows_found FROM UserLivesInLocation WHERE ROWNUM <= 1 AND USER_ID = :NEW.USER_ID;
        IF :NEW.IS_HOMETOWN IS NOT NULL THEN
            IF rows_found THEN
                UPDATE UserLivesInLocation SET HOMETOWN_LOCATION_ID = :NEW.LOCATION_ID WHERE USER_ID = :NEW.USER_ID;
            ELSE
                INSERT INTO UserLivesInLocation (USER_ID, HOMETOWN_LOCATION_ID) VALUES (:NEW.USER_ID, :NEW.LOCATION_ID);
            END IF;
        ELSE
            IF rows_found THEN
                UPDATE UserLivesInLocation SET CURRENT_LOCATION_ID = :NEW.LOCATION_ID WHERE USER_ID = :NEW.USER_ID;
            ELSE
                INSERT INTO UserLivesInLocation (USER_ID, CURRENT_LOCATION_ID) VALUES (:NEW.USER_ID, :NEW.LOCATION_ID);
            END IF;
        END IF;
    ELSE
        --don't need table for event-->location 
    END IF;
END;
/
