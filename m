Return-Path: <linux-kernel+bounces-217917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4CD90B622
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B8C1C22A63
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B706814D71F;
	Mon, 17 Jun 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9yjD5c0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OCHSGj4f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786381474C6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641186; cv=none; b=Q14ClZG0puB/Z7zUGVuyCZXmYq0ILIygn9UzAnvldGGjb1yqhxSn+wVVRQXCJbykC4tyTgCqKIr7OzPOfzyYPPvXE0p0Bk31yJolK3F1Jz8/eY/DPas3NbSE4L0cMSATORSq7a6GEdoEPz0v807Hg1xc4Y1vwFmPW3SLAIdf0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641186; c=relaxed/simple;
	bh=/IIwLAg71h7Ka9mSLiQwdsaFgE8fR2kdhUA9bF+cA6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KYcuvCKzBPT2SYz+jZcpjccSBzPpWs5rlnoq88DtQK40g1rKrWypoz76wTpioCXC2ejZW+afTxY3X0Hi6DGdAX8aqacXU1UpcPEbrZ2XuSS8KwHPEYpuuPE4Mv7w4XucGlKXyeXbzivcIqsEr5Hwd6j1RfLWD5fppdg6FhCctJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9yjD5c0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OCHSGj4f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718641182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uiuI0ne78SCn0dRqC/AA7OSeq1K0b9qMP7aQO3GiU3A=;
	b=c9yjD5c0rmBkkXgK+g/+45a92f5RYx1M1zhQAj0cZoAsc2vCaoKRCI2GSvXLrxDcLapxi8
	CeuExVn+rbtI/5a88s6XKv7v2M62uR/oKa/EzQyHcrdv5TW5iaGz7GMYCcrCfdB+XPDpJn
	yuDp3taCI+Wthli5R230f93MkNkMMFpLA43giMkkbUQUjxrabaNuI9bn3yoeWBY6k3SzMb
	C2X2ueeaxRHND0Qbgtl7ubt0jUl/IlXCYfjbRuWjLhfRTat61w3HZg/+Wbsd/ApM0D6stN
	DkkiWqpw/EN/LBv48PZRWd+xlcAFMeI286caZdN8isotddO8+78u/5D1/oy9ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718641182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uiuI0ne78SCn0dRqC/AA7OSeq1K0b9qMP7aQO3GiU3A=;
	b=OCHSGj4fl0S5vb/+GHyOFycN5xud/B011qQqB4AEftopyb79TSmKd18Ea/IyMmqF0Mr685
	1wRKWs368hv5l/Bg==
To: Phil Chang <phil.chang@mediatek.com>
Cc: alix.wu@mediatek.com, angelogioacchino.delregno@collabora.com,
 frederic@kernel.org, jy.ho@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 matthias.bgg@gmail.com, phil.chang@mediatek.com, tglx@linutronix.de
Subject: Re: [PATCH v3] hrtimer: check hrtimer with a NULL function
In-Reply-To: <20240610133136.327-1-phil.chang@mediatek.com>
References: <87bk496seb.fsf@somnus>
 <20240610133136.327-1-phil.chang@mediatek.com>
Date: Mon, 17 Jun 2024 18:19:42 +0200
Message-ID: <87tthr4k4h.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phil Chang <phil.chang@mediatek.com> writes:

> To prevent improper usage of hrtimers and avoid potential kernel crashes,
> this commit introduces a validation check for hrtimers with a valid function callback,
> discard the hrtimers that have a NULL callback.
>
> The `run_hrtimer` executes callbacks for every hrtimer,
> and these callbacks must not be NULL. A NULL callback can lead to a kernel crash.
> This update ensures that all hrtimers have properly initialized callbacks
> before execution.

Definitely better! You could sort it, first problem description and then
solution:

The hrtimer function callback must not be NULL. It has to be specified
by the callsite but it is not validated by hrtimer code. When a hrtimer
is queued with a NULL pointer instead of a valid function, the kernel
crashes with a null pointer dereference when trying to execute the
callback in __run_hrtimer().

Introduce a validation before queueing the hrtimer in
hrtimer_start_range_ns().

>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

> ---
>  kernel/time/hrtimer.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 492c14aac642..b8ee320208d4 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1285,6 +1285,8 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  	struct hrtimer_clock_base *base;
>  	unsigned long flags;
>  
> +	if (WARN_ON_ONCE(!timer->function))
> +		return;
>  	/*
>  	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
>  	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard

