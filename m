Return-Path: <linux-kernel+bounces-204336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2E8FE75E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D12FB257A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC6A195FDD;
	Thu,  6 Jun 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3hXU3vc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PCjwzUTv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA107195B24
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679681; cv=none; b=JtbzKwbo/ifPb/SwCq0bslaIgFXPriRx4tQXiHl267UeNmbD1ks1tUA9ohz5tA1qAaTmA4bSyAMe0vUYXH0mNSmB/q4Rh+nCjHmLDZDJPowtt1v+V2khoHMvVqArUtKF5ojgQoBhr6opYspY0O7CbRjiFcDKQo+iWnD5Uz6kU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679681; c=relaxed/simple;
	bh=DSAnsYiVzVWKlnHu2xNJGJ3BVbSsFa3BBE2oC217PiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JY4vcHhxGyXg/MFas7ifqnagXxgVBJUkJ4VpqshbtH2G9b939jgkF0AEaGvGbnSr/2jjDjYC8BWwk/5AqXOo0I1YA9/rrG428JI/wt0+2zV3CqxCkDFijW6UVH1/OPrZXyInrOi4K6lhA2ju3ihB3RNV206axVkQXqkC98gPBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3hXU3vc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PCjwzUTv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717679677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yAsZ/41lOcaQ90q2I6nOsLXJ1jn8OTLuONqlVOl/Qwg=;
	b=F3hXU3vclt3wgaEdMhe8f2JPD/jGLGgpsWebOgeBHHa+8kjuavv10RP98lWXdLB9khxweb
	bx0iAHU9PkIMvFi5XyqKXa8cwEBFbvzPm+AMrc6hAP/5XGlvfaE8Pj6zulkl9mW6N1h9gj
	4aQhu3iBzJjpDr7TUcAvfMzCwfDHej3zV2rBsKISWob/PgQL2BsMdL7vx4wCFeSkEa/r32
	c2Z/ptEBHyb3oOafTpZhmW+wCKarLgVkYP9wLNM8QHSldv1iK0+xiVwmh//mM5IYJA15uw
	RVe/NREYcdiCrtORtLX9OOfXbaCkiubx2lFztT5rBTJObbNd//3VHg4uX6lKqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717679677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yAsZ/41lOcaQ90q2I6nOsLXJ1jn8OTLuONqlVOl/Qwg=;
	b=PCjwzUTvkzTIUnlN4ZroszFujEBS7bTxk+AsI0SO3II+nx1H9Iud162t4hji4zxpl2163r
	/L2LAj8lnnwsHdAg==
To: Phil Chang <phil.chang@mediatek.com>
Cc: alix.wu@mediatek.com, angelogioacchino.delregno@collabora.com,
 frederic@kernel.org, jy.ho@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 matthias.bgg@gmail.com, phil.chang@mediatek.com, tglx@linutronix.de
Subject: Re: [PATCH] hrtimer: check hrtimer with a NULL function
In-Reply-To: <20240605135106.16065-1-phil.chang@mediatek.com>
References: <87plsvvgpn.fsf@somnus>
 <20240605135106.16065-1-phil.chang@mediatek.com>
Date: Thu, 06 Jun 2024 15:14:37 +0200
Message-ID: <877cf2i56q.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phil Chang <phil.chang@mediatek.com> writes:

>>> simillar with timers, check for timer->function == NULL.
>>> If the pointer is NULL, discard the request silently.
>
>> Can you please explain, why this change is required?
>
>> The statement "similar to timers" is not a valid explaination as timer
>> list timers and hrtimers are two different things. The function pointer
>> for timer list timers is explicitly set to NULL in shutdown path to
>> prevent unwanted rearming of the timer. For hrtimers there is no
>> shutdown function implemented and function is never set to NULL by
>> hrtimer code.
>>
> The timer->function is provided  by caller, which is invaild if fuction is NULL, 
> and currently, the hrtime code does not perform any checks to validate this. 
> Passing a NULL function can lead to a system panic, with a backtrace likes:
> ```
>    __hrtimer_run_queues+0x1d8/0x3b8
>    hrtimer_interrupt+0xdc/0x3a0
>    arch_timer_handler_phys+0x54/0x94
>    handle_percpu_devid_irq+0xb8/0x308
>    handle_domain_irq+0x78/0xec
>    gic_handle_irq+0x50/0x10c
>    call_on_irq_stack+0x38/0x54
>    do_interrupt_handler+0x40/0x98
> ```
> This backtrace does not clearly indicate the source of the invalid usage of hrtimer.

To make it more clear to the inexperienced hrtimer user that it is
mandatory to initialize timer->function to be able to use hrtimers, but
to prevent the kernel to crash, please add a warning in
hrtimer_start_range_ns(). The check can be done without locking the
hrtimer base. When the function pointer is not set, return directly
without doing anything. So this above mentioned backtrace will no longer
appear, as the timer is not added to a queue.

Thanks,

	Anna-Maria

