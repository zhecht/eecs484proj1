DROP SEQUENCE seq_photo;
DROP SEQUENCE seq_user;
DROP SEQUENCE seq_tag;
DROP SEQUENCE seq_education;
DROP SEQUENCE seq_event;
DROP SEQUENCE seq_location;
DROP SEQUENCE seq_message;
DROP SEQUENCE seq_album;

DROP TRIGGER photo_increment;
DROP TRIGGER photo_modified;
DROP TRIGGER album_increment;
DROP TRIGGER album_modified;
DROP TRIGGER tag_increment;
DROP TRIGGER user_increment;
DROP TRIGGER education_increment;
DROP TRIGGER event_increment;
DROP TRIGGER message_increment;
DROP TRIGGER location_increment;
DROP TRIGGER user_album_relation;
DROP TRIGGER album_photo_relation;
DROP TRIGGER photo_tag_relation;
DROP TRIGGER user_message_relation;
DROP TRIGGER user_education_relation;
DROP TRIGGER user_event_relation;
DROP TRIGGER user_location_relation;
DROP TRIGGER after_insert_location;

DROP TABLE PhotoHasTag;
DROP TABLE AlbumHasPhoto;
DROP TABLE UserHasAlbum;
DROP TABLE UserHasEducation;
DROP TABLE UserPlansEvent;
DROP TABLE UserParticipatesInEvent;
DROP TABLE UserLivesInLocation;
DROP TABLE UserSendsReceivesMessage;
DROP TABLE UserHasFriend;
DROP TABLE EventIsInLocation;

DROP TABLE Tag;
DROP TABLE Photo;
DROP TABLE Album;
DROP TABLE Location;
DROP TABLE Message;
DROP TABLE Education;
DROP TABLE Event;
DROP TABLE FB_User;
