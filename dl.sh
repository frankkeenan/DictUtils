curl -s --user frank.keenan:$DPSPASS "https://dws-dps.idm.fr/api/v1/projects/B-DE-EN-00001/entries/export/allInternalAttributesAndAdditionalMetadata"  | perl ./oneline.pl  > /data/data_c/Projects/OL/B-DE-EN-00001/dps.xml

