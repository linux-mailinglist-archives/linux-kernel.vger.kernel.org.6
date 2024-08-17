Return-Path: <linux-kernel+bounces-290532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B4D955562
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF00F2855EF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6E77113;
	Sat, 17 Aug 2024 04:33:40 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45876FBF0;
	Sat, 17 Aug 2024 04:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723869219; cv=none; b=ru3HjXe2g+3DqoUKHg5XPu91ZIX6J3WjSoxtUry9eqZM+NS7bPpk2kPY8HDA3otPUP5AdYn/LefRYZSLQ5pdSrcliBFw5ZBaf9DDMAzPjTxb6tIz74s90MYyxkLxtgQ3sUg3JzgwAHpdboaTqXyhnnunPXS3EtupI8feZnFI35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723869219; c=relaxed/simple;
	bh=eDnp+2gx6QCRwhpBESBXCQMwVIUXqpzIau2n3A/Fvc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POc2J02Z85lqzZm89YCuTcJeyFg+U+HZWiCjd1kSW0hqdVtA45VnmsrkMH4fFThIZQ6gUYkSe741hBU8p+T7+wj8rW8hnt780ZEnr2q+UzVXi461huzzEc/tt30XuqTeMt8GSlszmz1357xql2J4KQ+f1wt+MfuiG/OAURAgUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2234A8044C;
	Sat, 17 Aug 2024 03:54:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id ED87820025;
	Sat, 17 Aug 2024 03:54:49 +0000 (UTC)
Message-ID: <3c0658cc4a5a174d149175bd9b8f6ce3dfe75574.camel@perches.com>
Subject: Re: [PATCH 1/2] get_maintainer: add --bug option to print bug
 reporting info
From: Joe Perches <joe@perches.com>
To: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 16 Aug 2024 20:54:48 -0700
In-Reply-To: <20240815113450.3397499-1-jani.nikula@intel.com>
References: <20240815113450.3397499-1-jani.nikula@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: ED87820025
X-Rspamd-Server: rspamout07
X-Stat-Signature: 4wogohdghyjmk1ozweorx98k615pnzfs
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18s59Ngl0OfNgXviDlVqMO6fWuIGsClT1A=
X-HE-Tag: 1723866889-878923
X-HE-Meta: U2FsdGVkX18uUGTaxNORMUF09RuX0kKw1FbjXkKTsxci0VBtexklqfAC439zULFKzYs7qMxcgL4KHM++3arxkP8OYwFFEpjAb+Lbq6WMLKberIjgGl1WtBBg14FwSMy5zjRo+Sr59hg/ZP2fUKH8FqS7pomceyFWgFCQLgjXRooanTCiz7nUkRbyOBXpdnrnvAVc9fhp8QJQ6e1UHmlXOD5B3SbFZkDN7Ix8oiyPXQ+XPEpo6Mt6NqtAvoOQZ1CNtCc+mrzxmMr/2aK/+HPPljod8LWXzORbxv1XCllUVuuEfrO6YwnhSbuLE4UqNF/i7IwFCgajJjeTkXkf+Wq7jfcBAyQGAKGsfwB376oqhlumStPIutRDrs4G5xvM9QaulAq5CSQPlGdPKB/jtMektj/OtANXxWpqXWoe0TsioZ0c2QeEcf65qLlZoWagSni+asT8PTXE6q2Q2Cq7M9DbRA==

On Thu, 2024-08-15 at 14:34 +0300, Jani Nikula wrote:
> For example Documentation/adming-guide/bug-hunting.rst suggest using
> get_maintainer.pl to get a list of maintainers and mailing lists to
> report bugs to, while a number of subsystems and drivers explicitly use
> the "B:" MAINTAINERS entry to direct bug reports at issue trackers
> instead of mailing lists and people.
>=20
> Add the --bug option to get_maintainer.pl to print the bug reporting
> URIs, if any.

Seems sensible, thanks.

Acked-by: Joe Perches <joe@perches.com>

>=20
> Cc: Joe Perches <joe@perches.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  scripts/get_maintainer.pl | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index ee1aed7e090c..5ac02e198737 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -54,6 +54,7 @@ my $output_section_maxlen =3D 50;
>  my $scm =3D 0;
>  my $tree =3D 1;
>  my $web =3D 0;
> +my $bug =3D 0;
>  my $subsystem =3D 0;
>  my $status =3D 0;
>  my $letters =3D "";
> @@ -271,6 +272,7 @@ if (!GetOptions(
>  		'scm!' =3D> \$scm,
>  		'tree!' =3D> \$tree,
>  		'web!' =3D> \$web,
> +		'bug!' =3D> \$bug,
>  		'letters=3Ds' =3D> \$letters,
>  		'pattern-depth=3Di' =3D> \$pattern_depth,
>  		'k|keywords!' =3D> \$keywords,
> @@ -320,13 +322,14 @@ if ($sections || $letters ne "") {
>      $status =3D 0;
>      $subsystem =3D 0;
>      $web =3D 0;
> +    $bug =3D 0;
>      $keywords =3D 0;
>      $keywords_in_file =3D 0;
>      $interactive =3D 0;
>  } else {
> -    my $selections =3D $email + $scm + $status + $subsystem + $web;
> +    my $selections =3D $email + $scm + $status + $subsystem + $web + $bu=
g;
>      if ($selections =3D=3D 0) {
> -	die "$P:  Missing required option: email, scm, status, subsystem or web=
\n";
> +	die "$P:  Missing required option: email, scm, status, subsystem, web o=
r bug\n";
>      }
>  }
> =20
> @@ -631,6 +634,7 @@ my %hash_list_to;
>  my @list_to =3D ();
>  my @scm =3D ();
>  my @web =3D ();
> +my @bug =3D ();
>  my @subsystem =3D ();
>  my @status =3D ();
>  my %deduplicate_name_hash =3D ();
> @@ -662,6 +666,11 @@ if ($web) {
>      output(@web);
>  }
> =20
> +if ($bug) {
> +    @bug =3D uniq(@bug);
> +    output(@bug);
> +}
> +
>  exit($exit);
> =20
>  sub self_test {
> @@ -847,6 +856,7 @@ sub get_maintainers {
>      @list_to =3D ();
>      @scm =3D ();
>      @web =3D ();
> +    @bug =3D ();
>      @subsystem =3D ();
>      @status =3D ();
>      %deduplicate_name_hash =3D ();
> @@ -1069,6 +1079,7 @@ MAINTAINER field selection options:
>    --status =3D> print status if any
>    --subsystem =3D> print subsystem name if any
>    --web =3D> print website(s) if any
> +  --bug =3D> print bug reporting info if any
> =20
>  Output type options:
>    --separator [, ] =3D> separator for multiple entries on 1 line
> @@ -1382,6 +1393,8 @@ sub add_categories {
>  		push(@scm, $pvalue . $suffix);
>  	    } elsif ($ptype eq "W") {
>  		push(@web, $pvalue . $suffix);
> +	    } elsif ($ptype eq "B") {
> +		push(@bug, $pvalue . $suffix);
>  	    } elsif ($ptype eq "S") {
>  		push(@status, $pvalue . $suffix);
>  	    }


