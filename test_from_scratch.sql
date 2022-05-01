use test_from_scratch;

/***************************************  TABLES ************************************************/

-- users table
create table USERS(
       USER_ID INTEGER AUTO_INCREMENT ,
       USER_FIRST_NAME VARCHAR(30),
       USER_LAST_NAME VARCHAR(30),
       USER_EMAIL VARCHAR(30),
       USER_PASSWORD varchar(20),
       USER_COUNTRY VARCHAR(30),
       
       USER_BASE_LEVEL BOOLEAN ,
       USER_MEDIUM_LEVEL BOOLEAN,
       USER_EXPERT_LEVEL BOOLEAN ,
       
       primary key(USER_ID)
);

-- training table
create table TRAINING(
        TRAINING_ID INTEGER AUTO_INCREMENT,
		TRAINING_TITLE varchar(20),
        TRAINING_DESCRIPTION VARCHAR(255),
        
        primary key (TRAINING_ID)
);

-- module table
create table MODULE(
        MODULE_ID INTEGER AUTO_INCREMENT,
        MODULE_TRAINING INTEGER ,
		MODULE_TITLE varchar(20),
        MODULE_DESCRIPTION VARCHAR(255),
        MODULE_PRICE FLOAT,

		primary key (MODULE_ID),
        FOREIGN KEY (MODULE_TRAINING) REFERENCES  TRAINING(TRAINING_ID)
);

-- question table
create table QUESTION(
        QUESTION_ID INTEGER AUTO_INCREMENT,
        QUESTION_MODULE INTEGER ,
		QUESTION_TEXT varchar(255),
        QUESTION_FIRST_CHOICE varchar(255),
        QUESTION_SECOND_CHOICE varchar(255),
        QUESTION_THIRD_CHOICE varchar(255),
        QUESTION_CORRECT_CHOICE VARCHAR(255),
        QUESTION_HARDNESS_LEVEL ENUM('LOW','MEDIUM','HEIGH'),
        
        primary key (QUESTION_ID),
        foreign key (QUESTION_MODULE) REFERENCES MODULE(MODULE_ID)
        
);

-- subscription table
create table SUBSCRIPTION(
        SUBSCRIPTION_ID INTEGER AUTO_INCREMENT,
        SUBSCRIPTION_USER INTEGER,
        SUBSCRIPTION_TRAINING INTEGER,
        SUBSCRIPTION_DATETIME DATETIME,
        
        primary key (SUBSCRIPTION_ID),
        foreign key (SUBSCRIPTION_TRAINING) REFERENCES TRAINING(TRAINING_ID),
        foreign key (SUBSCRIPTION_USER) REFERENCES USERS(USER_ID)
        
);

-- capsule table
create table CAPSULE(
		
        CAPSULE_ID INTEGER AUTO_INCREMENT,
        CAPSULE_MODULE INTEGER,
        CAPSULE_URL varchar(255) ,
        CAPSULE_HAS_BEEN_SEEN BOOLEAN DEFAULT FALSE ,
        
        primary key (CAPSULE_ID),
        foreign key (CAPSULE_MODULE) REFERENCES MODULE(MODULE_ID)
        
        
);

-- answer table
create table ANSWER (
	
    ANSWER_ID integer auto_increment,
    ANSWER_QUESTION integer,
    QUESTION_TEXT varchar(255),
    CANDIDAT_CHOICE varchar(255),
    CHAMP_USER integer, 
    CHAMP_TRAINING integer,
    CHOICE_FILTER boolean,
    
    primary key (ANSWER_ID) ,
    foreign key (ANSWER_QUESTION) references QUESTION(QUESTION_ID)
	
);

ALTER TABLE CAPSULE ADD COLUMN CAPSULE_SUBSCRIPTION INTEGER ;

alter table CAPSULE add foreign key (CAPSULE_SUBSCRIPTION) references SUBSCRIPTION(SUBSCRIPTION_ID );


/***************************************  VIEWS ************************************************/

-- capsulemodule
create view capsuleModules as
select * from CAPSULE 
inner join MODULE on CAPSULE_MODULE = MODULE_ID ;

-- capsule Sabscription Seen 
create view capsuleSubscriptionSeen as
select * from CAPSULE 
inner join SUBSCRIPTION on CAPSULE_SUBSCRIPTION = SUBSCRIPTION_ID;

-- module list
create view moduleList as
select * from MODULE 
join TRAINING on module_training = training_id
join SUBSCRIPTION on training_id = SUBSCRIPTION_ID;

-- module training
create view moduleTraining as
SELECT * , count(*) as 'MODULE_NUMBER' FROM TRAINING
INNER JOIN MODULE ON TRAINING_ID = MODULE_TRAINING
group by TRAINING_ID ;

-- question module
create view questionModule as
select * from QUESTION 
inner join MODULE on module_id = QUESTION_MODULE;

-- user subscription training
create view userSubscriptionTraining as
select * from SUBSCRIPTION 
inner join TRAINING on TRAINING_ID = SUBSCRIPTION_TRAINING
inner join USERS on USER_ID = SUBSCRIPTION_USER ;

-- delete
-- delete from question where question_id between 1 and 78;


/* 30 Exam Questions*/
CREATE VIEW EXAM_QUESTIONS AS
(SELECT * FROM QUESTION INNER JOIN MODULE ON MODULE_ID = QUESTION_MODULE WHERE QUESTION_HARDNESS_LEVEL = 'LOW' AND MODULE_TRAINING = 3 order by RAND()  LIMIT 10)
UNION
(SELECT * FROM QUESTION INNER JOIN MODULE ON MODULE_ID = QUESTION_MODULE WHERE QUESTION_HARDNESS_LEVEL = 'MEDIUM' AND MODULE_TRAINING = 3 order by RAND()  LIMIT 10)
UNION
(SELECT * FROM QUESTION INNER JOIN MODULE ON MODULE_ID = QUESTION_MODULE WHERE QUESTION_HARDNESS_LEVEL = 'HEIGH' AND MODULE_TRAINING = 3 order by RAND() LIMIT 10);

SELECT * FROM EXAM_QUESTIONS;


/******************************************insertion query ********************************************************/

INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('11', '1', 'What addresses are mapped by ARP', 'destination MAC address to a destination IPv4 address', 'destination IPv4 address to the source MAC address', 'destination IPv4 address to the destination host name', 'destination MAC address to a destination IPv4 address', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('12', '1', 'What information is added during encapsulation at OSI Layer 3', 'source and destination MAC', 'source and destination application protocol', 'source and destination IP address', 'source and destination IP address', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('13', '1', 'Why does a Layer 3 device perform the ANDing process on a destination IP address and subnet mask?', 'to identify the broadcast address of the destination network', 'to identify the host address of the destination host', 'to identify the network address of the destination network', 'to identify the network address of the destination network', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('14', '1', ' What are two functions of NVRAM?', 'to store the routing table', 'to retain contents when power is removed', 'to contain the running configuration file', 'to retain contents when power is removed', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('15', '1', 'What is the dotted decimal representation of the IPv4 address 11001011.00000000.01110001.11010011?', '192.0.2.199', '198.51.100.201', '203.0.113.211', '203.0.113.211', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('16', '1', 'What purpose does NAT64 serve in IPv6?', 'It converts IPv6 packets into IPv4 packets', 'It enables companies to use IPv6 unique local addresses in the network', 'It translates private IPv6 addresses into public IPv6 addresses', 'It converts IPv6 packets into IPv4 packets', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('17', '1', 'What is the most compressed representation of the IPv6 address 2001:0000:0000:abcd:0000:0000:0000:0001?', '2001:0:abcd::1', '2001:0:0:abcd::1', '2001::abcd::1', '2001:0:0:abcd::1', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('18', '1', 'Which range of link-local addresses can be assigned to an IPv6-enabled interface?', 'FDEE::/7', 'FE80::/10', 'FF00::/8', 'FE80::/10', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('19', '1', 'What type of IPv6 address is FE80::1?', 'loopback', 'link-local', 'multicast', 'link-local', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('20', '1', 'How many valid host addresses are available on an IPv4 subnet that is configured with a /26 mask?', '254', '190', '62', '62', 'MEDIUM');

INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('21', '1', 'A wireless host needs to request an IP address. What protocol would be used to process the request?', 'HTTP', 'DHCP', 'ICMP', 'DHCP', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('22', '1', 'Which example of malicious code would be classified as a Trojan horse?', 'malware that was written to look like a video game', 'malware that can automatically spread from one system to another by exploiting a vulnerability in the target', 'malware that requires manual user intervention to spread between systems', 'malware that was written to look like a video game', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('23', '1', 'When applied to a router, which command would help mitigate brute-force password attacks against the router?', 'exec-timeout 30', 'service password-encryption', 'login block-for 60 attempts 5 within 60', 'login block-for 60 attempts 5 within 60', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('24', '1', ' Where are Cisco IOS debug output messages sent by default?', 'Syslog server', 'console line', 'memory buffers', 'console line', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('25', '1', 'A home user is looking for an ISP connection that provides high speed digital transmission over regular phone lines. What ISP connection type should be used?', 'DSL', 'cell modem', 'cable modem', 'DSL', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('26', '1', 'How does quality of service help a network support a wide range of applications and services?', 'by limiting the impact of a network failure', 'by providing mechanisms to manage congested network traffic', 'by providing the ability for the network to grow to accommodate new users', 'by providing mechanisms to manage congested network traffic', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('27', '1', 'What source IP address does a router use by default when the traceroute command is issued?', 'the lowest configured IP address on the router', 'the IP address of the outbound interface', 'the lowest configured IP address on the router', 'the IP address of the outbound interface', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('28', '1', 'What layer is responsible for routing messages through an internetwork in the TCP/IP model?', 'internet', 'transport', 'network access', 'internet', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('29', '1', 'Which statement accurately describes a TCP/IP encapsulation process when a PC is sending data to the network?', 'Data is sent from the internet layer to the network access layer', 'Segments are sent from the transport layer to the internet layer', 'Packets are sent from the network access layer to the transport layer', 'Segments are sent from the transport layer to the internet layer', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('30', '1', 'What unique address is embedded in an Ethernet NIC and used for communication on an Ethernet network?', 'host address', 'IP address', 'MAC address', 'MAC address', 'HEIGH');

