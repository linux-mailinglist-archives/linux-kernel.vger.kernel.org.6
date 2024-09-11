Return-Path: <linux-kernel+bounces-324324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA66974B20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B39B20E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7034136341;
	Wed, 11 Sep 2024 07:20:33 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F756742
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039233; cv=none; b=pGJr6skMXsHViyWCvwEQKTmNI2TxNXVRmEd34ivFUxZzuPbxymafKZMDCzcHSvHTnqHiw8WPH6t6XsMoxpShXXkATEnsBpwZNQeTmMgSniSDshQPgUb+rjE1IPWY7VIpv0SmOapM2vXVZXUvQgM+FZ2I7X6yXRrTjXhJ1iUnG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039233; c=relaxed/simple;
	bh=JspO6/jSEEYfqh/bh9JZfnlJBoC1NsmXyP/j0gMOlQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iUGn4ke9w/TyraHlyroqwrt4L7DVqdlJPmjtJM7lgAL3LqDUKeCRANl2/tD2woDvJ2i2VhE378+JFTemNGC04DM+2aLvkXJaNa2+/wMvjzJx22yjEOKOYM3uM8MNfbNPXYknvBuPjJIreIAAY1T1hbniYBvZ9Wn/B2zYBZQyn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 1A5EEA13ED;
	Wed, 11 Sep 2024 06:44:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id A103720023;
	Wed, 11 Sep 2024 06:44:12 +0000 (UTC)
Message-ID: <ba245a06048af9eee61cea8c8fb79a331900cc73.camel@perches.com>
Subject: Re: [PATCH v2 10/15] checkpatch: Remove broken sleep/delay related
 checks
From: Joe Perches <joe@perches.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonathan
 Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>
Date: Tue, 10 Sep 2024 23:44:11 -0700
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-10-b0d3f33ccfe0@linutronix.de>
References: 
	<20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
	 <20240911-devel-anna-maria-b4-timers-flseep-v2-10-b0d3f33ccfe0@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A103720023
X-Rspamd-Server: rspamout03
X-Stat-Signature: 9rsi9yqmc3da51cjgb43ecr369br8thb
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18z0g6H2mqJH6XSheGkgCK8oJ/9O7nhJhg=
X-HE-Tag: 1726037052-310822
X-HE-Meta: U2FsdGVkX19Mpi5qFPtYacXkcHMQF0UQup160biEztXoYF5/xgH49zJlzDi89ghHw9JNJnnaP1SS1WWlmIinLutWuMuiFC+YwbdwoCzDLVI2ZcbYHDFu2MUrg+gk1EcWDG26PEiRu6qq4Si6fyri16lkXp3Pe8mzQfyPRyx6VGOJKxlt+vuK8ebYyBNh12FFHSBtMXRwSv4EkfktNRl6hTT85T8Wq0Q8WkgNUz53hKUubfa4BNKEqPu2gtGaJlugt7lGIwAJNcOlGHBlBGrES+GCGcL31b09EgsrsW+AYPjEd26FqI2UQqCLNWQUnDfemsbBXBOUj4cvJeLzt6sauC8lYn52Tr+X78YXXiz0NVbW8sEO70KqI6kdXrQwLAGT1ZAunqyXeLpqh1+Ib0T0ITAKqNxsR246UJ0sKoPLxR5DxDjoBZstp9rHCuLTRpwVxlqQ1/Qww6RE7JyEDDrUxwyG9odpR4KgPN4vmJCGVRylf8Laefvw+uLnQ/E9+pJjXUp6WZ60E+ivJwy8/6KuL/kYaWHopEnA

On Wed, 2024-09-11 at 07:13 +0200, Anna-Maria Behnsen wrote:
> checkpatch.pl checks for several things related to sleep and delay
> functions. In all warnings the outdated documentation is referenced. All
> broken parts are listed one by one in the following with an explanation w=
hy
> this check is broken. For a basic background of those functions please al=
so
> refere to the updated function descriptions of udelay(), nsleep_range() a=
nd
> msleep().
>=20
> Be aware: The change is done with a perl knowledge of the level "I'm able
> to spell perl".
>=20
> The following checks are broken:
>=20
> - Check: (! ($delay < 10) )
>   Message: "usleep_range is preferred over udelay;
>             see Documentation/timers/timers-howto.rst\n"
>   Why is the check broken: When it is an atomic context, udelay() is
>                            mandatory.
>=20
> - Check: ($min eq $max)
>   Message:  "usleep_range should not use min =3D=3D max args;
>              see Documentation/timers/timers-howto.rst\n"
>   Why is the check broken: When the requested accuracy for the sleep
>                            duration requires it, it is also valid to use
>                            min =3D=3D max.

There is a runtime setup cost to use usleep_range.

I believe udelay should generally be used when there
is a specific microsecond time delay required.

>=20
> - Check: ($delay > 2000)
>   Message: "long udelay - prefer mdelay;
>             see arch/arm/include/asm/delay.h\n"
>   Why is the check broken: The threshold when to start using mdelay() to
>                            prevent an overflow depends on
>                            MAX_UDELAY_MS. This value is architecture
>                            dependent. The used value for the check and
>                            reference is arm specific. Generic would be 5m=
s,
>                            but this would "break" arm, loongarch and mips
>                            and also the arm value might "break" mips and
>                            loongarch in some configurations.

It likely won't "break", just perhaps be inefficient.

> - Check: ($1 < 20)
>   Message: "msleep < 20ms can sleep for up to 20ms;
>             see Documentation/timers/timers-howto.rst\n"
>   Why is the check broken: msleep(1) might sleep up to 20ms but only on a
>                            HZ=3D100 system. On a HZ=3D1000 system this wi=
ll be
>                            2ms. This means, the threshold cannot be hard
>                            coded as it depends on HZ (jiffy granularity a=
nd
>                            timer wheel bucket/level granularity) and also
>                            on the required accuracy of the callsite. See
>                            msleep() and also the USLEEP_RANGE_UPPER_BOUND
>                            value.
>=20
> Remove all broken checks. Update checkpatch documentation accordingly.
>=20
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> v2: Rephrase commit message
> ---
>  Documentation/dev-tools/checkpatch.rst |  6 ------
>  scripts/checkpatch.pl                  | 34 ----------------------------=
------
>  2 files changed, 40 deletions(-)
>=20
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-t=
ools/checkpatch.rst
> index a9fac978a525..f5c27be9e673 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -466,12 +466,6 @@ API usage
>    **UAPI_INCLUDE**
>      No #include statements in include/uapi should use a uapi/ path.
> =20
> -  **USLEEP_RANGE**
> -    usleep_range() should be preferred over udelay(). The proper way of
> -    using usleep_range() is mentioned in the kernel docs.
> -
> -    See: https://www.kernel.org/doc/html/latest/timers/timers-howto.html=
#delays-information-on-the-various-kernel-delay-sleep-mechanisms
> -
> =20
>  Comments
>  --------
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index ba3359bdd1fa..80497da4aaac 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6601,28 +6601,6 @@ sub process {
>  			}
>  		}
> =20
> -# prefer usleep_range over udelay
> -		if ($line =3D~ /\budelay\s*\(\s*(\d+)\s*\)/) {
> -			my $delay =3D $1;
> -			# ignore udelay's < 10, however
> -			if (! ($delay < 10) ) {
> -				CHK("USLEEP_RANGE",
> -				    "usleep_range is preferred over udelay; see Documentation/timers=
/timers-howto.rst\n" . $herecurr);
> -			}
> -			if ($delay > 2000) {
> -				WARN("LONG_UDELAY",
> -				     "long udelay - prefer mdelay; see arch/arm/include/asm/delay.h\=
n" . $herecurr);
> -			}
> -		}
> -
> -# warn about unexpectedly long msleep's
> -		if ($line =3D~ /\bmsleep\s*\((\d+)\);/) {
> -			if ($1 < 20) {
> -				WARN("MSLEEP",
> -				     "msleep < 20ms can sleep for up to 20ms; see Documentation/time=
rs/timers-howto.rst\n" . $herecurr);
> -			}
> -		}
> -
>  # check for comparisons of jiffies
>  		if ($line =3D~ /\bjiffies\s*$Compare|$Compare\s*jiffies\b/) {
>  			WARN("JIFFIES_COMPARISON",
> @@ -7079,18 +7057,6 @@ sub process {
>  			}
>  		}
> =20
> -# check usleep_range arguments
> -		if ($perl_version_ok &&
> -		    defined $stat &&
> -		    $stat =3D~ /^\+(?:.*?)\busleep_range\s*\(\s*($FuncArg)\s*,\s*($Fun=
cArg)\s*\)/) {
> -			my $min =3D $1;
> -			my $max =3D $7;
> -			if ($min eq $max) {
> -				WARN("USLEEP_RANGE",
> -				     "usleep_range should not use min =3D=3D max args; see Documenta=
tion/timers/timers-howto.rst\n" . "$here\n$stat\n");
> -			}
> -		}
> -
>  # check for naked sscanf
>  		if ($perl_version_ok &&
>  		    defined $stat &&
>=20


