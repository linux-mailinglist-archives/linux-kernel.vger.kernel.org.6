Return-Path: <linux-kernel+bounces-316558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C47096D136
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5F6B2205C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D4619409A;
	Thu,  5 Sep 2024 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ibxKql2K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qr+rUBnD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78A2AE96
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523500; cv=none; b=WuIZcL0EJYt2+ZcugKlBBLoOSaYn+LrnuBY1nOjgtWALYy8o9ibBauNUhwUtfB721o7spzTH6tnqdAgQeFGDeAee2bT9HmVgYB+AY4Lca6gZyt8eREFmbQC+vhRHhdoVCPchmgM2INYLXBL17qHngShRpGivezDtUmAqA5esyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523500; c=relaxed/simple;
	bh=VrWxo7qkrFSO90eH7a66evWxm1t9IJ/LFwsUbGCOh2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FcpSTvv4CEQMD7nRWeHAXMXVRnwyjuDBJ8Rt47htL88sspM9BoOSAiymVCtMUXtzIKVIqnEz+jjqMGqHyZyTKmMFFeNE9D3yLW5F4QZJ3IY2FDNU/VEQ3X+rWAziZUwrjJixri2j/J01GcdrKljnBjgJxUxoXdKbyi3gKo55r7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ibxKql2K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qr+rUBnD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725523497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZWGdr4yiMk9jICqplmPA9Y6JHWxtXIWmpn3ABfKfI0=;
	b=ibxKql2KpZf56UrdwlrQDKNLsM2cEmcv7QmbquL3UAzxJFGDY9Wq/MOsJxJkYSYp/NEXRv
	QrJDFSJSyAMr4G5BcAt183NXoSy8kDE9jJDz7OQyyggmsuldsy1jl2oVv8JPkt52fLdPiF
	YKVuhS7zqeUxNVqt4/bGMHdyhS2rMDi/u31iSy8L+H7to8uD737hol2AF5Hva5AuUfmrJ0
	VbBmj4XyiGKp3YUxNLvUf943/w5SHJBwL1D3KXdGibkYmggOlDLzXR18/69moFXRi72xvx
	Yqp4ctovlSlHFl/4XstWXwZQL/twEocUNn/58SCgMBLMpY/r5ZCFcOK2JDeZIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725523497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZWGdr4yiMk9jICqplmPA9Y6JHWxtXIWmpn3ABfKfI0=;
	b=qr+rUBnDAuYWFXYj7YXs+Dr6VQi8y9IKaRU5jFB8jrInCPfrKdEUOFeo73qxwX3tRMWlXS
	LCTqmix8eofbxGBA==
To: Joe Perches <joe@perches.com>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonathan
 Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH 10/15] checkpatch: Remove broken sleep/delay related checks
In-Reply-To: <61936c29ad056ac72c142600f6414c6dba0b6136.camel@perches.com>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-10-e98760256370@linutronix.de>
 <61936c29ad056ac72c142600f6414c6dba0b6136.camel@perches.com>
Date: Thu, 05 Sep 2024 10:04:56 +0200
Message-ID: <877cbq5xw7.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joe Perches <joe@perches.com> writes:

> On Wed, 2024-09-04 at 15:05 +0200, Anna-Maria Behnsen wrote:
>> checkpatch.pl checks for several things related to sleep and delay
>> functions. In all warnings the outdated documentation is referenced. All
>> broken parts are listed one by one in the following with an explanation why
>> this check is broken. For a basic background of those functions please also
>> refere to the updated function descriptions of udelay(), nsleep_range() and
>> msleep().
> []
>> - Check: ($1 < 20)
>>   Message: "msleep < 20ms can sleep for up to 20ms;
>>             see Documentation/timers/timers-howto.rst\n"
>>   Why is the check broken: The message is simply wrong. msleep() will not
>>                            sleep (and never did it before)
>
> While it might have changed, the "never did it before" is
> not correct.
>
> https://lore.kernel.org/all/15327.1186166232@lwn.net/

Thanks for the fast reply!

Yes you are right. I wasn't able to read properly and had in my mind
that it says that msleep will sleep at least 20ms when I was writing
this "never did it before" - my fault.

The point I want to make here is that those 20ms cannot be hard coded,
as this is HZ dependent (same thing as it was before). I will rephrase
it to:

      Why is the check broken: msleep(1) might sleep up to 20ms but only
                               on a HZ=100 system. On a HZ=1000 system
                               this will be 2ms. This means, the
                               threshold cannot be hard coded as it
                               depends on HZ (jiffy granularity and
                               timer wheel bucket/level granularity) and
                               also on the required accuracy of the
                               callsite. See msleep() and also the
                               USLEEP_RANGE_UPPER_BOUND value.

>> Remove all broken checks. Remove also no longer required checkpatch
>> documentation section about USLEEP_RANGE.
>
> It'd be useful to remove the appropriate now unnecessary
> verbose sections from Documentation/dev-tools/checkpatch.rst

Maybe my coffee does not do it's job yet - which part should I remove? I
already remove the USLEEP_RANGE part. For MSLEEP and LONG_UDELAY there
wasn't anything documented.

Or should I rephrase the commit message somehow?

Thanks,

	Anna-Maria


