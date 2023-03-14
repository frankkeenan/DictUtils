
sub print_xsl_hdr
{
    my($code) = @_;
    print <<END_HDR
    <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:d="urn:$code" xmlns:e="urn:IDMEE"
	version="1.0">

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

END_HDR
}

sub print_xsl_footer
{
    my($e) = @_;
    my($res, $eid);	
    printf("</xsl:stylesheet>\n"); 
}
1;
