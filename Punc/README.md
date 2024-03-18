#Punctionation rules

## Solving the parse problem
There is an issue with the parser if the rule file is too large.
This is avoided by creating a wrapper rules file.
perl create_pnc_wrapper.pl RULES_FILE.xml

This creates RULES_FILE_wrapper.xml which is the punctuation program that should be called - it also updates the RULES_FILE.xml to have an xml:id atttribute set on the rules being called. Original rules file is in RULES_FILE.xml.BAK file
