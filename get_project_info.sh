curl -s --user frank.keenan:wltncrs40 "https://dws-dps.idm.fr/api/v1/projects?full_content=true" | perl get_project_names_from_dump.pl > project_names.dat 
