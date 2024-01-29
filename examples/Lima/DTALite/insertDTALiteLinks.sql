delete from DTALite_links;

insert into DTALite_links(name, link_id, from_node_id, to_node_id, facility_type, dir_flag, length, lanes, capacity, free_speed, link_type, cost) 
SELECT
name,
link_id,
from_node_id,
to_node_id,
facility_type,
dir_flag,
length,
lanes,
capacity*lanes,
free_speed,
1,
toll

FROM
GMNS_link where
GMNS_link.capacity > 0;

update DTALite_links
set VDF_fftt1 = 60 * length / free_speed,
VDF_cap1 = capacity,
VDF_PHF1 = 1,
VDF_gamma1 = 1,
VDF_mu1 = 100;

update DTALite_links 
set VDF_alpha1 = (select alpha from link_types where link_type = DTALite_links.facility_type);

update DTALite_links 
set VDF_alpha1 = (select alpha from link_types where link_type = 'default') where VDF_alpha1 is NULL;

update DTALite_links
set VDF_beta1 = (select beta from link_types where link_type = DTALite_links.facility_type);

update DTALite_links
set VDF_beta1 = (select beta from link_types where link_type = 'default') where VDF_beta1 is NULL;