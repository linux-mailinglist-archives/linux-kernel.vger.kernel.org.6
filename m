Return-Path: <linux-kernel+bounces-207962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B345901E92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7351C218CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA94757EF;
	Mon, 10 Jun 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4gvTaGs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cnvu1XqA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5942AA1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012865; cv=none; b=QxpiI3T6HazqSn5syY1NvVptHOmfIY3l1iesEJGPNWGAjaHV2IUolSO/gdXOEcDgKD8j4JMYfOXAW9vWy+1cxVph7+EC5V4oiE2nwMiFJT1IHyPrSh3pvy23oVa1Nl1ak6QmEySboRZV1ZLoopYP68vXZznkffy5IEftatV8ta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012865; c=relaxed/simple;
	bh=ARGhxvS/s5Dj2XsNG+1mlK6zCS2uhIKNCt8LkqeooFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pO1BdDP0eyptWTI2jr46s+KgM1tJm9ptTi2hNMtQlv7PcXXy0zou2+uCLgQc6l79PKlTB6m3sHAylFqLWYXPW73lV2LjHXStz5L1jbprIBRJb2DCMPZZlNwnABN4osFzMRKkF3zz5ndYuz/+Z2CxkW4e0jTbPn/BHNYjD7ZjL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4gvTaGs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cnvu1XqA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718012861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=niYe53zUpXvYd4fxzEQMt55McnLdwhYGnjG+n4GezzE=;
	b=M4gvTaGsbM16AqQsriJORCFrrntzmFgB8Is7s6pQ78LdU2HWRJRnFgJxndSudK0nAsmMMA
	eC3OH0V+NN2ciJDyT15zM0nQ0kG+03ziVyZQd/wORTSL78pHfA6TvqEkMNE+ES1Zi2OPWp
	6s2ntQmR6fODt9phl6r9h1dL3Mx00bzYuPI2UF6jal0h0/vUt+wDfVtqr0VwoMFXg6MvKF
	I9QmXH/kQFmD3TrrLJa7Uj80PV3D+MnrPUz9SoITH9cDOIBfgPu5GOXz7ugt6jH5Qn+nMj
	7vFP2a5m0ducqlIANeVRtoJARItHm1lyABCRE6tjX7uJzJg2nJxowA7nukiI6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718012861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=niYe53zUpXvYd4fxzEQMt55McnLdwhYGnjG+n4GezzE=;
	b=cnvu1XqAXICWboO3c93v5ayawLJHbfSxDolW8t5qb7iy4hCL0hPGYDFolliObaqLRClvQR
	xBnTmrTVpPL/VPBA==
To: Phil Chang <phil.chang@mediatek.com>
Cc: alix.wu@mediatek.com, angelogioacchino.delregno@collabora.com,
 frederic@kernel.org, jy.ho@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 matthias.bgg@gmail.com, phil.chang@mediatek.com, tglx@linutronix.de
Subject: Re: [PATCH v2] hrtimer: check hrtimer with a NULL function
In-Reply-To: <20240607022614.22902-1-phil.chang@mediatek.com>
References: <877cf2i56q.fsf@somnus>
 <20240607022614.22902-1-phil.chang@mediatek.com>
Date: Mon, 10 Jun 2024 11:47:40 +0200
Message-ID: <87bk496seb.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phil Chang <phil.chang@mediatek.com> writes:

> Since hrtimers do not allow a NULL function to be passed,
> to prevent a kernel crash, return before adding the timer to a queue.

You could point out in the commit message, where the kernel would crash
when using a hrtimer with a NULL pointer as function pointer. And it
shouldn't be a problem to use more than a single sentence for a commit
message :)

> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
>  kernel/time/hrtimer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 492c14aac642..d32c1afe59b3 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1285,6 +1285,9 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  	struct hrtimer_clock_base *base;
>  	unsigned long flags;
>  
> +	if (WARN_ON(!timer->function))
> +		return;
> +

Please use a WARN_ON_ONCE() (as documented in
Documentation/process/coding-style.rst)

>  	/*
>  	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
>  	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard

Thanks,

	Anna-Maria


