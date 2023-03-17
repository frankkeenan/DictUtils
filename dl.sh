curl -s --user frank.keenan:wltncrs40 "https://dws-dps.idm.fr/api/v1/projects/B-DE-EN-00001/entries/export/allInternalAttributesAndAdditionalMetadata"  | perl  /data/dicts/generic/progs/add_missing_end_tags.pl | perl /NEWdata/dicts/generic/progs/lose_suppressed.pl  > /data/data_c/Projects/OL/B-DE-EN-00001/dps.xml

