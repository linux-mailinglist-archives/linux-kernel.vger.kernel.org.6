Return-Path: <linux-kernel+bounces-367744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D7B9A062A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913A82852D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E2206065;
	Wed, 16 Oct 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lt78s6ht";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RC4jeOYk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70E1B78F3;
	Wed, 16 Oct 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072516; cv=none; b=JsPNRRvJLcaQT3Rc0vxR6s5w/Fa/dAfr/O73OB57wtDAgIPkHP2qJjdeTuZVwOu0i+5oKKI4ZJmN8+QCYm6YEZwW17P92fkCmB186hEIFnRIX6l2RNQGd0hiFBKVmO6FeOgtOOAf0hT1bDCLA2q8vTwAplW3PDcE6iDyeXq46l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072516; c=relaxed/simple;
	bh=ZKIz2nwtQVcX7IrHAIw7TJ8vmQ30BHAIpL39n66xL2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l0AWUAHpZqAKXyneuh5fzu28NWQBX2ivqkTAYXMToOd6f/lQcTVPoJPFsYimhDOz4uJtz1gUJemyEUDrryheF3rVpBb1NUeZF4HinSrzJmmTIY07/NCtqe3Mbw5UtfnK2i3Emj8q/bVniWBpbqI6HTX1+UhMFGBSUrcH/AZTMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lt78s6ht; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RC4jeOYk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729072511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YWJkMNI+8Sb/EzEOMqVgOhTaGyPPyCS7yi0OpGrZ/s=;
	b=lt78s6ht20q70sOlCNV6MS1I3u/dPyEBo9zs/FT0Y3UVVwBODwRpdFJo7Gzc7icAbyrAPr
	eS39QKoxFe9koeTEzY1GUwTut1dD8+9ZrOAjZ4bc52PagZz0wr4FOIc4HirbE9Ka4bIDIL
	v5GwT8ldW7VmpV35zWiY+cCBbi1z2GGKs1b49KhbyGx3k25gjiIsCuMsZTA0ILs4lnvS+B
	pU6Akkr5QooCjVRom3YKeESQ95H7d/bQlVQuR8cxu9V7Kh0paaTyacCjhW+Ek37qIQXNQu
	9SQ5l6wLwrW2+orGw6TnPKS9Zmxkk9nR4XidQIDaUntbX8b9VZM5KsMMH+ajhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729072511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YWJkMNI+8Sb/EzEOMqVgOhTaGyPPyCS7yi0OpGrZ/s=;
	b=RC4jeOYkZKhiou3Q1jSrj2Bh8pnFJFBh+ZYGamf4kSR7oy0CArY/SoadkQoDzPHQYJGfOu
	uQnuynjqdba0utDg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, Alice Ryhl
 <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>, Andy
 Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan
 Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v3 16/16] checkpatch: Remove broken sleep/delay related
 checks
In-Reply-To: <Zw56n9P0Io1bMb0y@localhost.localdomain>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
 <20241014-devel-anna-maria-b4-timers-flseep-v3-16-dc8b907cb62f@linutronix.de>
 <Zw56n9P0Io1bMb0y@localhost.localdomain>
Date: Wed, 16 Oct 2024 11:55:11 +0200
Message-ID: <87y12ocqyo.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Oct 14, 2024 at 10:22:33AM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>> checkpatch.pl checks for several things related to sleep and delay
>> functions. In all warnings the outdated documentation is referenced. All
>> broken parts are listed one by one in the following with an explanation =
why
>> this check is broken. For a basic background of those functions please a=
lso
>> refere to the updated function descriptions of udelay(), nsleep_range() =
and
>> msleep().
>>=20
>> Be aware: The change is done with a perl knowledge of the level "I'm able
>> to spell perl".
>>=20
>> The following checks are broken:
>>=20
>> - Check: (! ($delay < 10) )
>>   Message: "usleep_range is preferred over udelay;
>>             see Documentation/timers/timers-howto.rst\n"
>>   Why is the check broken: When it is an atomic context, udelay() is
>>                            mandatory.
>>=20
>> - Check: ($min eq $max)
>>   Message:  "usleep_range should not use min =3D=3D max args;
>>              see Documentation/timers/timers-howto.rst\n"
>>   Why is the check broken: When the requested accuracy for the sleep
>>                            duration requires it, it is also valid to use
>>                            min =3D=3D max.
>>=20
>> - Check: ($delay > 2000)
>>   Message: "long udelay - prefer mdelay;
>>             see arch/arm/include/asm/delay.h\n"
>>   Why is the check broken: The threshold when to start using mdelay() to
>>                            prevent an overflow depends on
>>                            MAX_UDELAY_MS. This value is architecture
>>                            dependent. The used value for the check and
>>                            reference is arm specific. Generic would be 5=
ms,
>>                            but this would "break" arm, loongarch and mips
>>                            and also the arm value might "break" mips and
>>                            loongarch in some configurations.
>>=20
>> - Check: ($1 < 20)
>>   Message: "msleep < 20ms can sleep for up to 20ms;
>>             see Documentation/timers/timers-howto.rst\n"
>>   Why is the check broken: msleep(1) might sleep up to 20ms but only on a
>>                            HZ=3D100 system. On a HZ=3D1000 system this w=
ill be
>>                            2ms. This means, the threshold cannot be hard
>>                            coded as it depends on HZ (jiffy granularity =
and
>>                            timer wheel bucket/level granularity) and also
>>                            on the required accuracy of the callsite. See
>>                            msleep() and also the USLEEP_RANGE_UPPER_BOUND
>>                            value.
>>=20
>> Remove all broken checks. Update checkpatch documentation accordingly.
>>=20
>> Cc: Andy Whitcroft <apw@canonical.com>
>> Cc: Joe Perches <joe@perches.com>
>> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> ---
>> v3: Move it to the end of the queue and adapt it to the new patch which
>>     removes the link to the outdated documentation before.
>> v2: Rephrase commit message
>> ---
>>  Documentation/dev-tools/checkpatch.rst |  4 ----
>>  scripts/checkpatch.pl                  | 38 ---------------------------=
-------
>>  2 files changed, 42 deletions(-)
>>=20
>> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-=
tools/checkpatch.rst
>> index abb3ff682076..f5c27be9e673 100644
>> --- a/Documentation/dev-tools/checkpatch.rst
>> +++ b/Documentation/dev-tools/checkpatch.rst
>> @@ -466,10 +466,6 @@ API usage
>>    **UAPI_INCLUDE**
>>      No #include statements in include/uapi should use a uapi/ path.
>>=20=20
>> -  **USLEEP_RANGE**
>> -    usleep_range() should be preferred over udelay(). The proper way of
>> -    using usleep_range() is mentioned in the kernel docs.
>> -
>>=20=20
>>  Comments
>>  --------
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 98790fe5115d..34d4b5beda29 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -6591,28 +6591,6 @@ sub process {
>>  			}
>>  		}
>>=20=20
>> -# prefer usleep_range over udelay
>> -		if ($line =3D~ /\budelay\s*\(\s*(\d+)\s*\)/) {
>> -			my $delay =3D $1;
>> -			# ignore udelay's < 10, however
>> -			if (! ($delay < 10) ) {
>> -				CHK("USLEEP_RANGE",
>> -				    "usleep_range is preferred over udelay; see function descriptio=
n of usleep_range() and udelay().\n" . $herecurr);
>> -			}
>> -			if ($delay > 2000) {
>> -				WARN("LONG_UDELAY",
>> -				     "long udelay - prefer mdelay; see function description of mdel=
ay().\n" . $herecurr);
>> -			}
>> -		}
>> -
>> -# warn about unexpectedly long msleep's
>> -		if ($line =3D~ /\bmsleep\s*\((\d+)\);/) {
>> -			if ($1 < 20) {
>> -				WARN("MSLEEP",
>> -				     "msleep < 20ms can sleep for up to 20ms; see function descript=
ion of msleep().\n" . $herecurr);
>> -			}
>> -		}
>> -
>>  # check for comparisons of jiffies
>>  		if ($line =3D~ /\bjiffies\s*$Compare|$Compare\s*jiffies\b/) {
>>  			WARN("JIFFIES_COMPARISON",
>> @@ -7069,22 +7047,6 @@ sub process {
>>  			}
>>  		}
>>=20=20
>> -# check usleep_range arguments
>> -		if ($perl_version_ok &&
>> -		    defined $stat &&
>> -		    $stat =3D~ /^\+(?:.*?)\busleep_range\s*\(\s*($FuncArg)\s*,\s*($Fu=
ncArg)\s*\)/) {
>> -			my $min =3D $1;
>> -			my $max =3D $7;
>> -			if ($min eq $max) {
>> -				WARN("USLEEP_RANGE",
>> -				     "usleep_range should not use min =3D=3D max args;  see functio=
n description of usleep_range().\n" . "$here\n$stat\n");
>> -			} elsif ($min =3D~ /^\d+$/ && $max =3D~ /^\d+$/ &&
>> -				 $min > $max) {
>> -				WARN("USLEEP_RANGE",
>> -				     "usleep_range args reversed, use min then max;  see function d=
escription of usleep_range().\n" . "$here\n$stat\n");
>
> Why not keep the min > max static check?

I removed it accidentially... It was my plan to keep the min > max
static check.

I'll send a v4 for this patch.

Thanks,

	Anna-Maria


