Return-Path: <linux-kernel+bounces-358613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DFB998198
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39808B27ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802421BBBF1;
	Thu, 10 Oct 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WL+BoClG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4QOfUk01"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F812194C7A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551173; cv=none; b=IVdGWJ/enHmMD8dCha259AHqiHGRSVDDEWGLF7OK7ssRGm6JauSwiXVacxdKt+vDiAoild9mg+qloB7JngSW01qcoZZtLSdyIBrW87BMTjmDr3HHjYj6bwQK1b/WETVu5LuAcP6YJVWZNLBoLiUd1LYRZUNPmIR3z2oO0iZPYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551173; c=relaxed/simple;
	bh=cWVYFkyxgookqYEVW/YbwelYHauwq+AEknw1K3n3UTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4L5tw5pDldYMmI9mBxn1UncyZ3J8xW59oSfqojERLYTrModVNPJBIH88leGYL9IFvEd0kuU7huAcdhxy5PMInk1tSmt/T/xMq+ijFjl1UdgsY654zOhPRk9hVbfAATkqIscbRSJ9gwCybHTeDv9A5x1A1SBMEGCP5WpDcdtSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WL+BoClG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4QOfUk01; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728551169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8u+BrXdsCN8F9YI+DQrAGXJivZ1tgdxpt4JlHf7ZkNE=;
	b=WL+BoClGt5w8N0pqJ0mB3ErXwizHoeWiHWLbg4zyD7H5nabk6aiWHPRzcmynxzwltAnEBg
	iPqoBRc/H4gBp74kcZic3BEE3y3AaQvIYHACLrda5T2tTOsAwALh9WlhRmSn3jIFyeOz+z
	GmA9WEj++7xsvQJE6BU+NeManjAz441m/MsXRz+WsI1WTiQKCCduZQirH6PAtipvqQtawx
	yDbAMHDU1vxM4hi/pALmH2FAAG4EWbwtDXsHe8d4SdJOY4FPjS35PXK2aT0JBxmU2zzUvG
	GjudacTmCAUMA7+/Wdnxzyg1AHgswZZm0KtK0SjQEkYUWEX7aMOWtY0Qog+fbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728551169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8u+BrXdsCN8F9YI+DQrAGXJivZ1tgdxpt4JlHf7ZkNE=;
	b=4QOfUk01TGreh/KEV76ujGAo6ieCY1U6LTkbW5Lmj5ul/bLsYVjNWpcqAuzBmBMmCLgmNM
	UGIffmTkb9xbldAw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>, Joe
 Perches <joe@perches.com>
Subject: Re: [PATCH v2 09/15] timers: Add a warning to usleep_range_state()
 for wrong order of arguments
In-Reply-To: <ZwZ1ePAzuyJBlxNy@localhost.localdomain>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-9-b0d3f33ccfe0@linutronix.de>
 <ZwZ1ePAzuyJBlxNy@localhost.localdomain>
Date: Thu, 10 Oct 2024 11:06:09 +0200
Message-ID: <87plo89vjy.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Wed, Sep 11, 2024 at 07:13:35AM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>> There is a warning in checkpatch script that triggers, when min and max
>> arguments of usleep_range_state() are in reverse order. This check does
>> only cover callsites which uses constants. Move this check into the code=
 as
>> a WARN_ON_ONCE() to also cover callsites not using constants and get rid=
 of
>> it in checkpatch.
>>=20
>> Cc: Andy Whitcroft <apw@canonical.com>
>> Cc: Joe Perches <joe@perches.com>
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> ---
>>  kernel/time/sleep_timeout.c | 2 ++
>>  scripts/checkpatch.pl       | 4 ----
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
>> index 21f412350b15..4b805d7e1903 100644
>> --- a/kernel/time/sleep_timeout.c
>> +++ b/kernel/time/sleep_timeout.c
>> @@ -364,6 +364,8 @@ void __sched usleep_range_state(unsigned long min, u=
nsigned long max, unsigned i
>>  	ktime_t exp =3D ktime_add_us(ktime_get(), min);
>>  	u64 delta =3D (u64)(max - min) * NSEC_PER_USEC;
>>=20=20
>> +	WARN_ON_ONCE(max < min);
>> +
>
> Should it try to "fix" to avoid overflow?
>
> if WARN_ON_ONCE(max < min)
>     delta =3D 0

yes!

>>  	for (;;) {
>>  		__set_current_state(state);
>>  		/* Do not return before the requested sleep time has elapsed */
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 39032224d504..ba3359bdd1fa 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -7088,10 +7088,6 @@ sub process {
>>  			if ($min eq $max) {
>>  				WARN("USLEEP_RANGE",
>>  				     "usleep_range should not use min =3D=3D max args; see Document=
ation/timers/timers-howto.rst\n" . "$here\n$stat\n");
>> -			} elsif ($min =3D~ /^\d+$/ && $max =3D~ /^\d+$/ &&
>> -				 $min > $max) {
>> -				WARN("USLEEP_RANGE",
>> -				     "usleep_range args reversed, use min then max; see Documentati=
on/timers/timers-howto.rst\n" . "$here\n$stat\n");
>
> Perhaps it doesn't hurt to keep the static check?

I'll keep it but drop the link to the
Documentation/timers/timers-howto.rst which will be removed.

> Thanks.
>>  			}
>>  		}
>>=20=20
>>=20
>> --=20
>> 2.39.2
>>=20

