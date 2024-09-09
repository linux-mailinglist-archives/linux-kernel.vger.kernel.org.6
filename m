Return-Path: <linux-kernel+bounces-320850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC7E97114E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AD91C220C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4564C1B2515;
	Mon,  9 Sep 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jshb9RzZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UjPLvVAn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE431B2516
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869420; cv=none; b=OW3IYIxxPfgxQsTQ7oM//SiGjw9HeBpziANyXWhNQY2gOUDI3z0U2QJncbSdafsdAYIAuG3IY4wU1ZClinHvboBf4V/ZVkXwN0Qkw1Iw2LVAI/lR88njG2XjgNNOln/vfdDNXm6EQk2fOYYyNfoZm9MIHcyfRSnbfRWXWbFZV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869420; c=relaxed/simple;
	bh=uq0/0JRRaZ6FZtFMOgvBsY/yB3bmWF5/uHpHFYA7dPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HcZP7iTlubHolfg+pD5gGrVujeYLoo9c5RlxQOpvlYs2qvbxbhHoI+VAJh1H7Bwdet7MmxMsrDy+DqBmNRjpJ7Ywh6u47q3bZqTVtkYjh+UGIuAEejRaGwhUhHVo1GJkHgD4L/HWevnnnyY9IMxXDR/U/0EyMm7X4+p+EfEIbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jshb9RzZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UjPLvVAn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725869416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZXpqhNkaq+a8JzgmflyIK0UpiO8+d38lC1ao20MOLo=;
	b=Jshb9RzZewW5tR0xvVB1HIW02Dsxcb+uXpWJmS80V5PNAlwpFQTItm0Nqxk3nqTIhWGTsk
	3lm85ZL3pwUXTsPZ9dRxnTOCZY+e9TNuQsBMYx/OYyNL93L8hrjb1mvdmvCPpzJNYDlra0
	u5cIuBaywZnE0tsh8wfxF3zW19rQaRmPNxYp9RXvqCVj3+olJl2oBNqjXQguxvz1U2HFZI
	zKzdgDdpD84wUj97zCLUIeSXV6bc/QMcOV8ZneNpNvBMV8VLJmG4YzMQVmS2fKlRT7tzHO
	ziwqxWX/l2PJ/GzI8nc0XsdPYCZWXhnQSq0vluoFQG79mfsPD+3YndywlVqxDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725869416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZXpqhNkaq+a8JzgmflyIK0UpiO8+d38lC1ao20MOLo=;
	b=UjPLvVAnkGQ9jklkNpEalty1+MZSIpVNrGhHht2Goe4lBPYQ/BJcwgSgQZiv4ufioAnpcO
	bXIxGrbj8CDhQ9Ag==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 04/15] timers: Move *sleep*() and timeout functions into
 a separate file
In-Reply-To: <ZtsGwgatGpFRQerw@pavilion.home>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-4-e98760256370@linutronix.de>
 <ZtsGwgatGpFRQerw@pavilion.home>
Date: Mon, 09 Sep 2024 10:10:16 +0200
Message-ID: <87h6ap1c47.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Wed, Sep 04, 2024 at 03:04:54PM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>> All schedule_timeout() and *sleep*() related functions are interfaces on
>> top of timer list timers and hrtimers to add a sleep to the code. As they
>> are built on top of the timer list timers and hrtimers, the [hr]timer
>> interfaces are already used except when queuing the timer in
>> schedule_timeout(). But there exists the appropriate interface add_timer=
()
>> which does the same job with an extra check for an already pending timer.
>>=20
>> Split all those functions as they are into a separate file and use
>> add_timer() instead of __mod_timer() in schedule_timeout().
>>=20
>> While at it fix minor formatting issues and a multi line printk function
>> call in schedule_timeout(). While at it also add not listed
>> include/linux/delay.h to the MAINTAINTERS file.
>
> I don't mind sometimes having several logical changes within a same
> patch if that makes sense but the delay is MAINTAINERS is pretty off-topic
> and should move to its own patch.

Ack. But, I was too slow to provide a v2. It's already applied in
tip. Should we change tip, or is ok for you?

Thanks,

        Anna-Maria


