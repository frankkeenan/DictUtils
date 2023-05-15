Move the OALD e:id attribs to sourceid
Remove existing dpsref attributes and for any OALD targets move
e:targeteltid to dpsref attribute


perl move_database1.pl dps.xml > dps_to_move.xml

zip dps_to_move.xml.zip dps_to_move.xml 

# Now upload dps_to_move.zip to DPS

# Once uploaded export the database to dps2.xml

# Use this to find out what the new values of e:targetid and e:targeteltid need to be 
perl get_mapping.pl dps2.xml > get_mapping.pl.res

# Apply these values to the exported dps file and upload the result
perl update_xrefs.pl -f get_mapping.pl.res dps2.xml > dps_xrefs.xml

