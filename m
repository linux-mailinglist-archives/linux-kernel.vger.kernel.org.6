Return-Path: <linux-kernel+bounces-358346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 343A8997D73
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6291F21A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85D21B1D61;
	Thu, 10 Oct 2024 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ywv0oWr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jxZ/Wjv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6C18BB8E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542252; cv=none; b=DbQFrH5XWrDLy3oJIN3Bw9GYKNDs1CByW+NFw983nBPAU/NCrHoixzvIC+Wz2YF8JAzscrE5FUcFJ/xBfhdVDq3t6FZmf4oPmIb6ayWMS3VAd9NOErBxWb8t3P2gXQPb4xCbb9hXdRvEW50NaMuKDkamWXzfFz7FtYekGd9k0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542252; c=relaxed/simple;
	bh=F3iWNb4xrA7GT3rXIDJKAHxzmk046MAI0udIeKOQo28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRrYtu64uZY+/CAtJl4QShp2i5ELSL7QNqRuwJUMXxd8rIroPuroYUxEc6wtUottxn3VoyczrKOOOdIL++VzJQ+DkXNvxMFSpfh87AQMMpeOh1GCULkteboSm5SvsNpyWea22A6Ux8m5A5QVR59+OtGz0D8C8XzBdpA8e9n4TdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ywv0oWr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jxZ/Wjv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 08:37:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728542248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/a5w1MUIhNMqfy+XXpxP7hhNwqwCTgPstHeRfhntFGE=;
	b=0ywv0oWrsrHQvMUS75CmAoULKdtWGeFnsYUxtopOByX0O57efz97sKnq/Elu/Ct9/Ba17j
	ZtWXJMiXV3ma/LQhf4kvu0v9IpWsi9k8TRdVMUtXX1b1eU6/E/WmBzjoExsLiHYXe5eGzh
	hFZRMQBgnrPinUF/3knZGOjIqOQ231eQ+kGVKzewxo1ob5t9uRcy+LiVfqUGKwfXwYxSFS
	H1Kd6xs+kOUeowVWGdezN0U6fxupCchFiP/Mk/Wi0S2Dw+6RzJ3IQp0H9j/CwVBwI4et66
	gm2CmoMy+crVY+O+4TIoxK4BpU4b3U2ZVB3xrAlWBcYEh3w9zcWVdyH/VFz+aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728542248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/a5w1MUIhNMqfy+XXpxP7hhNwqwCTgPstHeRfhntFGE=;
	b=0jxZ/Wjvybysocsu8J+TM+oWSZDcedUlPEtiUZLOB9eHHvZyMvVia0r8rRCqeGFCOhpTOJ
	4qpM9QRE7Ia2rFBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 1/7] sched: warn for high latency with
 TIF_NEED_RESCHED_LAZY
Message-ID: <20241010063727.Ckx0eeMC@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241009165411.3426937-2-ankur.a.arora@oracle.com>

On 2024-10-09 09:54:05 [-0700], Ankur Arora wrote:
> resched_latency_warn() now also warns if TIF_NEED_RESCHED_LAZY is set
> without rescheduling for more than the latency_warn_ms period.

The description is odd. I think you want to say that
resched_latency_warn() does not warn if a task has TIF_NEED_RESCHED_LAZY
has set for longer periods and you want to add this functionality.

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Ziljstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
=E2=80=A6
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 694bfcf153cb..1229766b704e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5571,7 +5571,7 @@ static u64 cpu_resched_latency(struct rq *rq)
>  	if (sysctl_resched_latency_warn_once && warned_once)
>  		return 0;
> =20
> -	if (!need_resched() || !latency_warn_ms)
> +	if ((!need_resched() && !tif_need_resched_lazy()) || !latency_warn_ms)

tif_need_resched_lazy() is not doing what you think it is doing.

Either PeterZ makes a helper for this or you need
tif_test_bit(TIF_NEED_RESCHED_LAZY).

>  		return 0;
> =20
>  	if (system_state =3D=3D SYSTEM_BOOTING)

Sebastian

