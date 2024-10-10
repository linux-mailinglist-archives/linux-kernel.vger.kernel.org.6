Return-Path: <linux-kernel+bounces-358662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16640998220
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB11B281B78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85B61A08BC;
	Thu, 10 Oct 2024 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N+BkNhHC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+34NaGs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6361A00F0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552458; cv=none; b=Qzi2vi3lClsV0emp+u6q54E+EeU+zPnWn14A8E3gq6+JD5QchkOQ3UWjJmMZv0+RWh83Zo2QjbWKdl2+gklJhJT6vJvmlsMJ3nux2oN0xyLGVgOJeFq9x8wGao0NeMPwGJ/hFWm5zclfGGtKvNjHYoXjxcgpebwvviNZkhA+GDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552458; c=relaxed/simple;
	bh=EC6uVc1pRBXn7XTs+16IgJy2nYthZT5ol6aI7idN9eA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pmz0vwOLMt/uj1xpbj++yZZD4UG5EIJ455QCL17iREK5XpRCozKBuPx1n3rxpl2CfixqCnmGuCwy6AAquk80d62CbL/LkWWOqdIvBAN2K0HKX61KJouwtqIA+ifGVugF5xgey2Rf3bZ6OoZIfw41KZntyuqKGUZ7YjAw/sdRHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N+BkNhHC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+34NaGs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728552454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EC6uVc1pRBXn7XTs+16IgJy2nYthZT5ol6aI7idN9eA=;
	b=N+BkNhHCW97yOqTChI+9nX7KOHJ2MNyJP4Z7VS8z55Q0lu0TkNCcIHBROivA/WwIHqOrNO
	JVEp9JHMiIaX58U3ffhiySfjLKGftMl7k4K2POtygO+Pk7q8TE23L/NcWN2x+qBmQ69td8
	8pzdJTPiuQ+bdYwWZD+XDk6GIA4ukTGqcOGDT9WZN0dcrqNvCI6F9VeMWZ4aFa+bzLepDF
	UY8lFg9hZor4y6YIS7iTuBWysfWkctq8NvMlXhlczCmLFTscsG5OGEUUhtJYYR+VyvKarR
	kzR8HulrI6y3pvk9M43GVA1L1T/+wj6RUhJaW+wbHNeUaZ4dgrVcH3Kbyq7J3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728552454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EC6uVc1pRBXn7XTs+16IgJy2nYthZT5ol6aI7idN9eA=;
	b=g+34NaGstkjfHtkUiZ66r6z6Hm9oYWibG1iGT7Q6bsKblJpkMnBJWBQAd2VqLz4iKQIrpN
	T8qirBVC6FnoWsAg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 13/15] powerpc/rtas: Use fsleep() to minimize
 additional sleep duration
In-Reply-To: <ZwatTfHxojsZwqHw@localhost.localdomain>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-13-b0d3f33ccfe0@linutronix.de>
 <ZwatTfHxojsZwqHw@localhost.localdomain>
Date: Thu, 10 Oct 2024 11:27:34 +0200
Message-ID: <87msjc9uk9.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Wed, Sep 11, 2024 at 07:13:39AM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>> When commit 38f7b7067dae ("powerpc/rtas: rtas_busy_delay() improvements")
>> was introduced, documentation about proper usage of sleep realted functi=
ons
>
> related*
>
>> was outdated.
>>=20
>> The commit message references the usage of a HZ=3D100 system. When using=
 a
>> 20ms sleep duration on such a system and therefore using msleep(), the
>> possible additional slack will be +10ms.
>>=20
>> When the system is configured with HZ=3D100 the granularity of a jiffy a=
nd of
>> a bucket of the lowest timer wheel level is 10ms. To make sure a timer w=
ill
>> not expire early (when queueing of the timer races with an concurrent
>> update of jiffies), timers are always queued into the next bucket. This =
is
>> the reason for the maximal possible slack of 10ms.
>>=20
>> fsleep() limits the maximal possible slack to 25% by making threshold
>> between usleep_range() and msleep() HZ dependent. As soon as the accuracy
>> of msleep() is sufficient, the less expensive timer list timer based
>> sleeping function is used instead of the more expensive hrtimer based
>> usleep_range() function. The udelay() will not be used in this specific
>> usecase as the lowest sleep length is larger than 1 microsecond.
>
> Isn't udelay() for everything below 10us ?

It's larger than 1 millisecond...

>
>>=20
>> Use fsleep() directly instead of using an own heuristic for the best
>> sleeping mechanism to use..
>>=20
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nathan Lynch <nathanl@linux.ibm.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

