
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

-- admin table
create table ADMIN(
	ADMIN_ID integer auto_increment,
    ADMIN_USER integer ,
    
    primary key (ADMIN_ID),
    foreign key (ADMIN_USER) references USERS(USER_ID)
);

-- training table
create table TRAINING(
        TRAINING_ID INTEGER AUTO_INCREMENT,
		TRAINING_TITLE varchar(100),
        TRAINING_DESCRIPTION VARCHAR(255),
        
        primary key (TRAINING_ID)
);

-- module table
create table MODULE(
        MODULE_ID INTEGER AUTO_INCREMENT,
        MODULE_TRAINING INTEGER ,
		MODULE_TITLE varchar(100),
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
        CAPSULE_SUBSCRIPTION INTEGER,
        
        primary key (CAPSULE_ID),
        foreign key (CAPSULE_MODULE) REFERENCES MODULE(MODULE_ID),
        foreign key (CAPSULE_SUBSCRIPTION) REFERENCES SUBSCRIPTION(SUBSCRIPTION_ID)
        
        
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

/***************************************  VIEWS ************************************************/
-- view user admin
create view adminUser as 
select * from ADMIN 
inner join USERS on user_id = admin_user ;

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


/* 30 Exam Questions*/
CREATE VIEW EXAM_QUESTIONS AS
(SELECT * FROM QUESTION INNER JOIN MODULE ON MODULE_ID = QUESTION_MODULE WHERE QUESTION_HARDNESS_LEVEL = 'LOW' AND MODULE_TRAINING = 3 order by RAND()  LIMIT 10)
UNION
(SELECT * FROM QUESTION INNER JOIN MODULE ON MODULE_ID = QUESTION_MODULE WHERE QUESTION_HARDNESS_LEVEL = 'MEDIUM' AND MODULE_TRAINING = 3 order by RAND()  LIMIT 10)
UNION
(SELECT * FROM QUESTION INNER JOIN MODULE ON MODULE_ID = QUESTION_MODULE WHERE QUESTION_HARDNESS_LEVEL = 'HEIGH' AND MODULE_TRAINING = 3 order by RAND() LIMIT 10);



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



INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('31', '2', 'Which type of static route is configured with a greater administrative distance to provide a backup route to a route learned from a dynamic routing protocol?', 'floating static route', 'default static route', 'summary static route', 'floating static route', 'LOW');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('32', '2', 'What network prefix and prefix-length combination is used to create a default static route that will match any IPv6 destination?', 'FFFF:/128', '::1/64', '::/0', '::/0', 'LOW');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('33', '2', ' A router has used the OSPF protocol to learn a route to the 172.16.32.0/19 network. Which command will implement a backup floating static route to this network?', 'ip route 172.16.32.0 255.255.224.0 S0/0/0 200', 'ip route 172.16.0.0 255.255.224.0 S0/0/0 100', 'ip route 172.16.32.0 255.255.0.0 S0/0/0 100', 'ip route 172.16.32.0 255.255.224.0 S0/0/0 200', 'LOW');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('34', '2', 'Which statement describes a route that has been learned dynamically?', 'It is automatically updated and maintained by routing protocols', 'It is unaffected by changes in the topology of the network', 'It has an administrative distance of 1', 'It is automatically updated and maintained by routing protocols', 'LOW');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('35', '2', 'Which route will a router use to forward an IPv4 packet after examining its routing table for the best match with the destination address?', 'a level 1 child route', 'a level 1 parent route', 'a level 1 ultimate route', 'a level 1 ultimate route', 'LOW');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('36', '2', 'What is a basic function of the Cisco Borderless Architecture access layer?', 'aggregates Layer 2 broadcast domains', 'aggregates Layer 3 routing boundaries', 'provides access to the user', 'provides access to the user', 'LOW');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('37', '2', 'What is a characteristic of the distribution layer in the three layer hierarchical model?', 'provides access to the rest of the network through switching, routing, and network access policies', 'distributes access to end users', 'represents the network edge', 'provides access to the rest of the network through switching, routing, and network access policies', 'LOW');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('38', '2', 'Which information does a switch use to populate the MAC address table?', 'the destination MAC address and the incoming port', 'the destination MAC address and the outgoing port', 'the source MAC address and the incoming port', 'the source MAC address and the incoming port', 'LOW');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('39', '2', ' Which statement is correct about Ethernet switch frame forwarding decisions?', 'Unicast frames are always forwarded regardless of the destination MAC address', 'Frame forwarding decisions are based on MAC address and port mappings in the CAM table', 'Cut-through frame forwarding ensures that invalid frames are always dropped', 'Frame forwarding decisions are based on MAC address and port mappings in the CAM table', 'LOW');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('40', '2', 'What is the name of the layer in the Cisco borderless switched network design that would have more switches deployed than other layers?', 'access', 'core', 'data link', 'access', 'LOW');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('41', '2', 'Which switching method drops frames that fail the FCS check?', 'borderless switching', 'cut-through switching', 'store-and-forward switching', 'store-and-forward switching', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('42', '2', 'In what situation would a Layer 2 switch have an IP address configured?', 'when the Layer 2 switch needs to be remotely managed', 'when the Layer 2 switch is the default gateway of user traffic', 'when the Layer 2 switch needs to forward user traffic to another device', 'when the Layer 2 switch needs to be remotely managed', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('43', '2', ' A network administrator is configuring port security on a Cisco switch. When a violation occurs, which violation mode that is configured on an interface will cause  sent?', 'protect', 'restrict', 'shutdown', 'protect', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('44', '2', 'What will a Cisco LAN switch do if it receives an incoming frame and the destination MAC address is not listed in the MAC address table?', 'Use ARP to resolve the port that is related to the frame', 'Forward the frame out all ports except the port where the frame is received', 'Use ARP to resolve the port that is related to the frame', 'Forward the frame out all ports except the port where the frame is received', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('45', '2', 'What VLANs are allowed across a trunk when the range of allowed VLANs is set to the default value?', 'Only the native VLAN will be allowed across the trunk', 'Only VLAN 1 will be allowed across the trunk', 'All VLANs will be allowed across the trunk', 'All VLANs will be allowed across the trunk', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('46', '2', 'Which type of traffic would most likely have problems when passing through a NAT device?', 'IPsec', 'HTTP', 'ICMP', 'IPsec', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('47', '2', 'A network engineer is interested in obtaining specific information relevant to the operation of both distribution and access layer Cisco devices. Wt to both types of devices?', 'show port-security', 'show cdp neighbors', 'show mac-address-table', 'show cdp neighbors', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('48', '2', ' Refer to the exhibit. An administrator is examining the message in a syslog server. What can be determined from the message?', 'This is a notification message for a normal but significant condition', 'This is an error message for which warning conditions exist', 'This is an alert message for which immediate action is needed', 'This is a notification message for a normal but significant condition', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('49', '2', 'When a customer purchases a Cisco IOS 15.0 software package, what serves as the receipt for that customer and is used to obtain the license as well?', 'Product Activation Key', 'End User License Agreement', 'Unique Device Identifier', 'Product Activation Key', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('50', '2', ' What benefit does NAT64 provide?', 'It allows sites to connect IPv6 hosts to an IPv4 network by translating the IPv6 addresses to IPv4 addresses', 'It allows sites to use private IPv6 addresses and translates them to global IPv6 addresses', 'It allows sites to use private IPv4 addresses, and thus hides the internal addressing structure from hosts on rks', 'It allows sites to connect IPv6 hosts to an IPv4 network by translating the IPv6 addresses to IPv4 addresses', 'MEDIUM');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('51', '2', 'What is the effect of configuring the ipv6 unicast-routing command on a router?', 'to assign the router to the all-nodes multicast group', 'to enable the router as an IPv6 router', 'to permit only unicast packets on the router', 'to enable the router as an IPv6 router', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('52', '2', 'What is a characteristic of a static route that creates a gateway of last resort?', 'It identifies the gateway IP address to which the router sends all IP packets for which it does not have a learned or static route', 'It backs up a route already discovered by a dynamic routing protocol', 'It is configured with a higher administrative distance than the original dynamic routing protocol has', 'It identifies the gateway IP address to which the router sends all IP packets for which it does not have a learned or static route', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('53', '2', 'Which network design may be recommended for a small campus site that consists of a single building with a few users?', 'a three-tier campus network design where the access, distribution, and core are all separate layers, each one with very specific functions', 'a collapsed core network design', 'a network design where the access and distribution layers are collapsed into a single layer', 'a collapsed core network design', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('54', '2', 'Which information does a switch use to keep the MAC address table information current?', 'the source MAC address and the incoming port', 'the destination MAC address and the incoming port', 'the source and destination MAC addresses and the incoming port', 'the source MAC address and the incoming port', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('55', '2', ' Which advantage does the store-and-forward switching method have compared with the cut-through switching method?', 'frame error checking', 'faster frame forwarding', 'collision detecting', 'frame error checking', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('56', '2', 'Which characteristic describes cut-through switching?', 'Error-free fragments are forwarded, so switching accurs with lower latency', 'Only outgoing frames are checked for errors', 'Frames are forwarded without any error checking', 'Frames are forwarded without any error checking', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('57', '2', ' What is a result of connecting two or more switches together?', 'The number of broadcast domains is increased', 'The size of the broadcast domain is increased', 'The number of collision domains is reduced', 'The size of the broadcast domain is increased', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('58', '2', ' Which commands are used to re-enable a port that has been disabled as a result of a port security violation?', 'shutdown', 'no switchport port-security', 'no switchport port-security violation shutdown', 'no switchport port-security violation shutdown', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('59', '2', 'Which type of traffic is designed for a native VLAN?', 'management', 'user-generated', 'user-generated', 'user-generated', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_ID`, `QUESTION_MODULE`, `QUESTION_TEXT`, `QUESTION_FIRST_CHOICE`, `QUESTION_SECOND_CHOICE`, `QUESTION_THIRD_CHOICE`, `QUESTION_CORRECT_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('60', '2', ' A network administrator is verifying a configuration that involves network monitoring. What is the purpose of the global configuration command logging trap 4?', 'System messages that match logging levels 0-4 will be forwarded to a specified logging device', 'System messages that exist in levels 4-7 must be forwarded to a specific logging server', 'System messages will be forwarded using a SNMP version that matches the argument that follows the logging trap command', 'System messages that match logging levels 0-4 will be forwarded to a specified logging device', 'HEIGH');
INSERT INTO `test_from_scratch`.`QUESTION` (`QUESTION_FIRST_CHOICE`, `QUESTION_HARDNESS_LEVEL`) VALUES ('', '');
