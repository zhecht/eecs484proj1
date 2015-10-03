DROP SEQUENCE seq_education;
DROP SEQUENCE seq_location;
DROP SEQUENCE seq_message;
DROP SEQUENCE seq_tag;

DROP TRIGGER tag_increment;
DROP TRIGGER education_increment;
DROP TRIGGER message_increment;
DROP TRIGGER location_increment;
DROP TRIGGER photo_tag_relation;
DROP TRIGGER user_event_relation;
DROP TRIGGER insert_location_trigger;

DROP TABLE UserParticipatesInEvent;
DROP TABLE UserHasFriend;
DROP TABLE UserLivesInLocation;

DROP TABLE Tag;
DROP TABLE Photo;
DROP TABLE Message;
DROP TABLE Education;
DROP TABLE Event CASCADE CONSTRAINTS;
DROP TABLE Location;
DROP TABLE FB_User CASCADE CONSTRAINTS;
