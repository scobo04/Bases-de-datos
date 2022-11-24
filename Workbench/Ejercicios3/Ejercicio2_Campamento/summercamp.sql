create database summer_camp;
use summer_camp;
create table region (
id int auto_increment,
name varchar(50) not null unique,
population int not null check (population>=0),
area decimal(8,1) not null check (area>=0),
primary key (id)
);
create table activity (
id int not null auto_increment,
name varchar(50) not null unique,
primary key (id)
);
create table child (
id int not null,
name varchar(50) not null,
sur1 varchar(50) not null,
sur2 varchar (50),
phone varchar(20) not null,
id_region int not null,
primary key (id),
foreign key (id_region) references region(id)
);
create table summer_camp (
id int not null,
name varchar(50) not null unique,
capacity int not null check (capacity>=0),
id_region int not null,
primary key (id),
foreign key (id_region) references region(id)
);
create table offer (
rate int not null check (rate>=0),
id_summer_camp int,
id_activity int,
foreign key (id_summer_camp) references summer_camp(id),
foreign key (id_activity) references activity(id)
);
create table signup (
init_date date not null,
final_date date,
id_child int not null,
id_summer_camp int not null,
primary key (id_child, init_date),
foreign key (id_child) references child(id),
foreign key (id_summer_camp) references summer_camp(id),
check(final_date is null or init_date<=final_date)
);