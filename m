Return-Path: <linux-kernel+bounces-338335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AFC985693
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3F32868A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE79A13C810;
	Wed, 25 Sep 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itH3lMow";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QKPuL6uO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0166F8120C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257520; cv=none; b=VWi8TsA4UpDqSgrzQGvMmOu1bFaq8nKQ6kmI0h416RxdDPGpRyTmrC3ncxHurNwJ7lWjZV7doGxcs4ETbCbmVaigLc6bRe4IQnmnBBX2B+iyWiTNB9LXH9HAF9zKIOoMFx+icQ6dPXShqPXoYNPE+T2207Rpt9QWgXIPDjrebLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257520; c=relaxed/simple;
	bh=xkesKK+LCqZ4R+CZtT3Hz0l6d7Sdbdvi2ksNk10O+Ds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CnwKSvauoQt7EJxVMOjs5oQT2s+hoUqg7Uj1jZ7d2kGKro3VPuYZEhIwMvgyqpPPsZMdfT8VBbGCCHzkHofJMy8J2AbHzTjhilCxMdlMkMepc1Orrz2H3eINADF8s9tZNYhvgofmuUiDi7o4ATCef2gnBIEz2hJA8ukrfCLwDp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itH3lMow; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QKPuL6uO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727257515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzmwNkKBnhu6OS2+f/CNoDisEFHf/Z5jvGw1rDdvpdY=;
	b=itH3lMowxS4rvElVNNrex1bTrgvKlehOCIMUk5tDtLBu7Zthp8NjX0eF/f7GymHGk6K6Uy
	s3zk6SU/Qo84Y7Zsx5tutxyXg7C21RBxZxdOBu+jVSPsEcz/jsF59TVwlR8gRJiNkzKsRK
	svtoBmfjnlYiKQqaGGyN0FCNREL4McdAC0MA3Hk80SmIdix6jzP0aghhnBpjlduchi33ri
	OkE/cLbuvbst1LuNhIXZslWV5HNyE2GGMyoSLzk11k8azjsJXGbO6Reo4eFPszPDVaQ8RR
	4uCep0kmUCDQtNYGbr+HeQA3uQt/7HK0Xh1rzlJEGPH2gJsQZzF/BI+Zja22wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727257515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzmwNkKBnhu6OS2+f/CNoDisEFHf/Z5jvGw1rDdvpdY=;
	b=QKPuL6uO2jp5ivZKL8d7xDNoKd023zBeNpLTqSodmV+J6XCTqo+AVZqWFNnDYD+xsKvlur
	QC+BSs9HL8Fdz3Dg==
To: Thomas Gleixner <tglx@linutronix.de>, =?utf-8?B?5pyx5oG65Lm+?=
 <zhukaiqian@xiaomi.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, =?utf-8?B?5byg5ZiJ5Lyf?=
 <zhangjiawei8@xiaomi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?utf-8?B?546L6Z+s?=
 <lingyue@xiaomi.com>, =?utf-8?B?54aK5Lqu?= <xiongliang@xiaomi.com>,
 "isaacmanjarres@google.com" <isaacmanjarres@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, =?utf-8?B?5qKB5Lyf6bmP?=
 <weipengliang@xiaomi.com>, =?utf-8?B?57+B6YeR6aOe?=
 <wengjinfei@xiaomi.com>
Subject: Re: [PATCH] tick/broadcast: Plug clockevents replacement race
In-Reply-To: <87cymdsu0r.ffs@tglx>
References: <042520850d394f0bb0004a226db63d0d@xiaomi.com>
 <87o77m1v9r.ffs@tglx> <b07f9746a58d46919b1600b22f5dff05@xiaomi.com>
 <835d5847-1aa0-4852-89c7-6a6996b3eb65@linaro.org>
 <bc1a086b932f454f9379c49221983675@xiaomi.com> <87o775uh0y.ffs@tglx>
 <87frrs8lsg.ffs@tglx> <87cymdsu0r.ffs@tglx>
Date: Wed, 25 Sep 2024 11:45:15 +0200
Message-ID: <87v7ykf4no.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> writes:

> =E6=9C=B1=E6=81=BA=E4=B9=BE reported and decoded the following race condi=
tion when a broadcast
> device is replaced:
>
> CPUA					CPUB
>  __tick_broadcast_oneshot_control()
>    bc =3D tick_broadcast_device.evtdev;
> 					tick_install_broadcast_device(dev)
>         				clockevents_exchange_device(cur, dev)
> 					   shutdown(cur);
> 					   detach(cur);
> 					   cur->handler =3D noop;
> 					   tick_broadcast_device.evtdev =3D dev;
>
>   tick_broadcast_set_event(bc, next_event); <- FAIL: arms a detached devi=
ce.
>
> If the original broadcast device has a restricted interrupt affinity mask
> and the last CPU in that mask goes offline then the BUG() in
> tick_cleanup_dead_cpu() triggers because the clockevent device is not in
> detached state.
>
> The reason for this is that tick_install_broadcast_device() is not
> serialized vs. tick broadcast operations.
>
> The obvious cure is to serialize tick_install_broadcast_device() with
> tick_broadcast_lock against a concurrent tick broadcast operation.
>
> That requires to split clockevents_exchange_device() into two parts, one
> which does the exchange, shutdown and detach operation and the other which
> drops the module reference count. This is required because the module
> reference cannot be dropped while holding tick_broadcast_lock.
>
> Let clockevents_exchange_device() do both operations as before, but let t=
he
> broadcast device code take the two step approach and do the device
> exchange under tick_broadcast_lock and drop the module reference count
> after releasing it.
>
> Fixes: f8381cba04ba ("[PATCH] tick-management: broadcast functionality")
> Reported-by: =E6=9C=B1=E6=81=BA=E4=B9=BE <zhukaiqian@xiaomi.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/clockevents.c    |   33 ++++++++++++++++++++-------------
>  kernel/time/tick-broadcast.c |   36 ++++++++++++++++++++++--------------
>  kernel/time/tick-internal.h  |    2 ++
>  3 files changed, 44 insertions(+), 27 deletions(-)
>
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -557,34 +557,41 @@ void clockevents_handle_noop(struct cloc

[...]

>=20=20
>  /**
> + * clockevents_exchange_device - release and request clock devices
> + * @old:	device to release (can be NULL)
> + * @new:	device to request (can be NULL)
> + *
> + * Called from various tick functions with clockevents_lock held and
> + * interrupts disabled.

can you please transform the comment into a lockdep annotation?

Thanks

