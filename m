Return-Path: <linux-kernel+bounces-355000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5B9945CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA651C230F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27731C3034;
	Tue,  8 Oct 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tv323OgP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BvtRMYHK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBF02CA8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384607; cv=none; b=J54glMILj3xIwDgciJzG07VfFlqVaOOJj+NW7eFqXAmuJjCRuK6YGyfy7nnnUPcipVjJwjbtYHv+/i0yn4C5BqAXEKdkNvNPXZ8wLN6nZ3cwz1NFZ17w8gUZIKliLrtF3HKNKDQDrFLL3LWnJBBnSTR6Wt5zVrwqSH9Dt4+rvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384607; c=relaxed/simple;
	bh=TfM774MHmRWW1WkA4FTSxO7iwI/+QGDcQV5EDeZt8Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv/JWXenKcV19CwEnercu9rBxeeja/OIQ6SxjVYy9+j/1+pb62Z9X+tQes45ZSGAooCSDRQXkgtZUxPiniupmodT3UrAsuG5t3qXrbW2gcEPkHFAJt2TDHqxO3hYbniVkoh5EPOqTucHtA916rGO7719lPwN+h1ZVxCt1qVcs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tv323OgP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BvtRMYHK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Oct 2024 12:50:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728384601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diNXZmybCRiWfqVgM1i6L2c7B7zQ+GVayYDu2nod9Wg=;
	b=tv323OgPpnnSj8XazdSEPJm/zPlI3kcDjxuIw230S0SNLxaPUG3IoT4YZ4gv4De2SuEBBB
	HA1LxPF6SHJjiPv1DUvKo0/iEwTPi08rGg/HB1hguPdMxo8eO5s1sh/MSVyuuuVPEQRp+s
	iOo7DpS0w1XO94DjsS5rtpcqKMtXwds1Gl27WpFZE0oEmD5ZwhzVhMoUInGT4o7P8bLdTA
	DfQP3GfGwiSNvgi+zv6oy08DIqUEEf6BjkU+KjTzAKFliyV5/k9CG34FYDHEyKlBJuG151
	bBu3CMB+JbxB4ipeqIEosnJJj3JEHDvyhMxlJqV1lKCUZxjlmp65guYphKanRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728384601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diNXZmybCRiWfqVgM1i6L2c7B7zQ+GVayYDu2nod9Wg=;
	b=BvtRMYHKLOV6InqhZqOqtnBQB2N+eqIsxFtUTYHSCTj7d5ZVBqT/61pt4rsJvTYrRX+ob7
	p96qRxxa9KdstBDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com
Subject: Re: [PATCH] locking/rtmutex: Fix misleading comment
Message-ID: <20241008105000._zQhLQk4@linutronix.de>
References: <20241008092606.GJ33184@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008092606.GJ33184@noisy.programming.kicks-ass.net>

On 2024-10-08 11:26:06 [+0200], Peter Zijlstra wrote:
> 
> Going through the RCU-boost and rtmutex code, I ran into this utterly
> confusing comment. Fix it to avoid confusing future readers.

Correct.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
> index a6974d044593..587ede8073c0 100644
> --- a/kernel/locking/rtmutex_api.c
> +++ b/kernel/locking/rtmutex_api.c
> @@ -175,7 +175,7 @@ bool __sched __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
>  	}
>  
>  	/*
> -	 * We've already deboosted, mark_wakeup_next_waiter() will
> +	 * This will deboost, mark_wakeup_next_waiter() will
  +	 * mark_wakeup_next_waiter() will deboost and
>  	 * retain preempt_disabled when we drop the wait_lock, to
>  	 * avoid inversion prior to the wakeup.  preempt_disable()
>  	 * therein pairs with rt_mutex_postunlock().

This could make it obvious that mark_wakeup_next_waiter() does all the
things.

Sebastian

