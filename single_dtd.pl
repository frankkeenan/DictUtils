#!/usr/local/bin/perl
#
# Input = 
# Result = 
# $Id$
# $Log$
#
package restructure;
require "/NEWdata/dicts/generic/progs/utils.pl";
#
#
# Load this with
# require "/NEWdata/dicts/generic/progs/restructure.pl";
#
#Calls
# $e = restructure::add_xgs($e, $dict);
# $e = restructure::add_idsgs($e);
# $e = restructure::add_pvsgs($e);
# $e = restructure::add_posg($e, $dict);
# $e = restructure::do_ndvs($e);
# $e = restructure::expand_tildes($e);
# $e = restructure::mark_empty_phon_groups($e);
# $e = restructure::add_xrgs($e);
# $e = restructure::eb_in_if($e);
# $e = restructure::eb_in_d($e);
# $e = restructure::eb_in_x($e);
# $e = restructure::do_prac_pron($e);
# $e = restructure::put_audio_on_ig_tags($e);
# $e = restructure::get_spoken_examples($e);
# $e = restructure::add_levels_info($e);
##

sub relabel_empty_tags
{
    my($e) = @_;
    $e =~ s|(<pos [^/>]*)> *</pos>|\1 />|gi;
    $e =~ s|(<r [^/>]*)> *</r>|\1 />|gi;
    $e =~ s|(<s [^/>]*)> *</s>|\1 />|gi;
    $e =~ s|(<g [^/>]*)> *</g>|\1 />|gi;
#    $e =~ s|<(([a-z]+) [^>/]*)> *</\2>|<\1 />|gi;
    return $e;
}


sub convert_phons
{
    my($e) = @_;
    my($bit, $res, $lang);
    my(@BITS);
    $e =~ s|<i([ >])|<phon-gb$1|gio;
    $e =~ s|<y([ >])|<phon-us$1|gio;
    $e =~ s|</i>|</phon-gb>|gio;
    $e =~ s|</y>|</phon-us>|gio;
    $e =~ s|(<phon-gb[ >].*?</phon-gb>)|&split;&fk;$1&split;|gio;
    $e =~ s|(<phon-us[ >].*?</phon-us>)|&split;&fk;$1&split;|gio;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gio){
	    $phon = &get_phon($bit);
	    $audio = &get_audio($bit);
	    $lang = &get_lang($bit);
	    $eid = &get_eid1($bit);
	    $bit = sprintf("<pron-g %s %s>%s%s</pron-g>", $eid, $lang, $phon, $audio);
	}
	$res .= $bit;
    }
    return $res;
}

sub get_eid1
{
    my($e) = @_;
    if ($e =~ m|^.*? (eid=\"[^\"]*\")|i)
    {
	return $1;
    }
}

sub get_wd
{
    my($e) = @_;
    if ($e =~ m|^.*? (wd=\"[^\"]*\")|i)
    {
	return $1;
    }
}

sub get_pub
{
    my($e) = @_;
    if ($e =~ m|^.*? (pub=\"[^\"]*\")|i)
    {
	return $1;
    }
}

sub get_phon
{
    my($e) = @_;
    my($bit, $phon, $eid);
    if ($e =~ m|<phon[^>]*>(.*)</phon[^>]*>|i)
    {
	$phon = $1;
	$phon =~ s|<part[^>]*>|<ptl>|gi;
	$phon =~ s|</part[^>]*>|</ptl>|gi;
	$attribs = &get_phon_attribs($e);
	$phon = sprintf("<phon %s>%s</phon>", $attribs, $phon);
	$phon =~ s|<phon [^>]*> *</phon>||gio;
    }
    return $phon;
}

sub get_phon_attribs
{
    my($e) = @_;
    my($bit, $res, $wd, $pub, $eid);
    $eid = &get_eid1($e);
    $pub = &get_pub($e);
#    $wd = &get_wd($e);
    $res = sprintf("%s %s %s", $eid, $pub);
    $res =~ s|  +| |g;
    $res =~ s|^ *||;
    $res =~ s| *$||;
    return $res;
}

sub get_prongs_attribs
{
    my($e) = @_;
    my($bit, $res, $wd, $pub, $eid);
    $eid = &get_eid1($e);
    $pub = &get_pub($e);
    $wd = &get_wd($e);
    $res = sprintf("%s %s %s", $eid, $pub, $wd);
    $res =~ s|  +| |g;
    $res =~ s|^ *||;
    $res =~ s| *$||;
    return $res;
}

sub get_audio
{
    my($e) = @_;
    my($res, $file, $wd);
    if ($e =~ m|<phon[^>]* file=\"(.*?)\"|i)
    {
	$file = $1;
	$file =~ s|^.*/||;
    }
    $res = sprintf("<audio name=\"%s\"/>", $file);
    return $res;
}

sub get_lang
{
    my($e) = @_;
    my($res);
    if ($e =~ m|<phon-gb|)
    {
	$res = "g=\"br\"";
    }
    elsif ($e =~ m|<phon-us|)
    {
	$res = "g=\"usa\"";
    }
    return $res;
}


1;
