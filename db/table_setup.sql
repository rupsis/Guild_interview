-- Ups
create table "user"(
  userId SERIAL primary key  not null,
  firstName char(255) null,
  lastName char(255) null
);


create table messages(
  messageId SERIAL primary key not null,
  senderId int not null,
  receiverId int not null,
  message TEXT,
  "timestamp" TIMESTAMP,
  CONSTRAINT fk_senderId
      FOREIGN KEY(senderId)
	      REFERENCES "user"(userId),
 CONSTRAINT fk_receiverId
      FOREIGN KEY(receiverId)
	      REFERENCES "user"(userId)
);

-- Downs
/*
drop table messages;
drop table "user";
 */