id
user_id
content
status
create_time


##display todo
select content from todo where user_id = $user_id;

##update status
update todo set status = 'done' where id = $id;

##update todo
update todo set content = '$content' where id = $id;

##create todo
insert into todo (id, user_id, content, status, create_time) values(1, $user_id, $content, 'yet', now());

create index `todo_idx` on todo(user_id);

##user search
select username from user where docomo_openid = $openid;
select user_id from user where username = $username;

CREATE TABLE `todo` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `status` enum('done','yet') NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `docomo_openid` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
);

create index `user_id_idx` on todo(`user_id`);
create index `time_idx(create_time(255))` on todo(`create_time`);
create index `status_idx` on todo(`status`);
create index `time_idx` on todo(`create_time`);

create index `username_idx` on user(`username`);
create index `user_idx` on user(docomo_openid);

DELIMITER //
CREATE PROCEDURE testInsert(IN max INT)
  BEGIN
  DECLARE cnt INT Default 1 ;
    simple_loop: LOOP
      INSERT INTO todo (user_id, content, status, create_time) VALUES (CONCAT('00',cnt), CONCAT('test',cnt,'is todo!!'),'yet',NOW());
      SET cnt = cnt+1;
      IF cnt=max THEN
        LEAVE simple_loop;
       END IF;
    END LOOP simple_loop;
END //


DELIMITER //
CREATE PROCEDURE testInsert(IN max INT)
  BEGIN
  DECLARE cnt INT Default 1 ;
    simple_loop: LOOP
      INSERT INTO user (username,docomo_openid) VALUES (CONCAT('test00',cnt), CONCAT('http://test0123/example.',cnt,'.com'));
      SET cnt = cnt+1;
      IF cnt=max THEN
        LEAVE simple_loop;
       END IF;
    END LOOP simple_loop;
END //

DELIMITER ;

CALL testInsert(1000000);

DROP PROCEDURE testInsert;
