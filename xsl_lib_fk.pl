#!/usr/local/bin/perl
#
# Input = 
# Result = 
# $Id: xsl_lib_fk.pl,v 1.1 2016/03/10 15:14:34 keenanf Exp keenanf $
# $Log: xsl_lib_fk.pl,v $
# Revision 1.1  2016/03/10 15:14:34  keenanf
# Initial revision
#
# Revision 1.2  2014/12/05 14:24:22  keenanf
# *** empty log message ***
#
# Revision 1.1  2014/11/30 10:05:52  keenanf
# Initial revision
#
#
package xsl_lib_fk;
#require "/disk1/home/keenanf/perl/utils.pl";
#
#
# Load this with
# require "/NEWdata/dicts/generic/progs/xsl_lib_fk.pl";
#
#Calls
# $hdr = xsl_lib_fk::get_xsl_header(PROJ);
# $footer = xsl_lib_fk::get_xsl_footer;
#
# SETTING ATTVALUES
# xsl_lib_fk::print_set_att_value_header("PROJ", "TAGNAME");
# xsl_lib_fk::set_attval_for_eid("e:id", "attname", "attval");
# xsl_lib_fk::print_set_att_value_footer();
# INSERTING TAGGING
# xsl_lib_fk::print_insert_content_after_final_child_header("PROJ", "TAGNAME");
# xsl_lib_fk::print_insert_content_after_final_child("e:id", "CONTENT");
# xsl_lib_fk::print_insert_content_after_final_child_footer();
##
our ($call_count);

sub print_set_att_value_header
{
    my($projectname, $tagname) = @_;
    my($res, $eid, $hdr);	
    $hdr = xsl_lib_fk::get_xsl_header($projectname);    
    print $hdr;
    printf("<xsl:template match=\"d:%s\">\n<xsl:copy>\n\t<xsl:apply-templates select=\"\@*\"/>\n<xsl:choose>\n", $tagname); 		
}

sub print_insert_content_after_final_child_header
{
    my($projectname, $tagname) = @_;
    my($res, $eid, $hdr);	
    $hdr = xsl_lib_fk::get_xsl_header($projectname);    
    print $hdr;
    printf("<xsl:template match=\"d:%s\">\n<xsl:copy>\n\t<xsl:apply-templates select=\"\@*\"/>\n<xsl:apply-templates/>\n<xsl:choose>\n", $tagname); 		
}

sub print_set_att_value_footer
{
    printf("</xsl:choose>\n\t<xsl:apply-templates select=\"node()\"/>\n"); 
    $ftr = &get_xsl_footer;
    print $ftr;
}


sub print_insert_content_after_final_child_footer
{
    printf("</xsl:choose>\n"); 
    $ftr = &get_xsl_footer;
    print $ftr;
}

sub get_xsl_header
{
    my($projectname) = @_;
    my($res, $eid);	
    $res = <<FK1;
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:d="urn:$projectname" xmlns:e="urn:IDMEE" version="1.0">
	<xsl:output method="xml" version="1.0" encoding="utf-8" omit-xml-declaration="yes"/>
	<xsl:template match="*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*|text()">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="comment() | processing-instruction()">
		<xsl:copy/>
	</xsl:template>
FK1
return($res);
}


sub set_attval_for_eid
{
    my($eid, @ATTPAIRS) = @_;
    printf("\t<xsl:when test=\"\@e:id=\'%s\'\">\n", $eid);
    while (@ATTPAIRS)
    {
	$attname = shift @ATTPAIRS;
	$attval = shift @ATTPAIRS;    
	printf("\t\t<xsl:attribute name=\"%s\">%s</xsl:attribute>\n", $attname, $attval);
    }
    printf("\t</xsl:when>\n"); 
    return;
}


sub print_insert_content_after_final_child
{
    my($eid, $content) = @_;
    printf("\t<xsl:if test=\"\@e:id=\'%s\'\">\n\t%s\n\t</xsl:if>\n", $eid, $content);
    return;
}

sub get_xsl_footer
{
    my($res, $eid);	
    $res = <<FK2;    
    </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
FK2
return($res);
}


1;
