Return-Path: <linux-kernel+bounces-449625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 915809F51B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6577A5557
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F1F1F75A6;
	Tue, 17 Dec 2024 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O0ezHjUm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ort1tAvg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406C1F7582
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455264; cv=none; b=OKtX5KTCb32rlUzOvDDbCGr9Mys/y81hm2tpObqyckQJtWXGlL+ejA4uJ0a0Rk0CQW5dAmDfu/HJFPYslgXnTNaL30aGZA04UTY76bksjcYN/1oo4SdZyC5TmnjIh8HSPLqZ3UYOgQNym8rP1NEb6fiYWc5iZEOK9PH+SGVKHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455264; c=relaxed/simple;
	bh=gt3f/gfRCzOtH7hrqqTm/zgypstgYDYbdc9mL2EvOms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBBS5+jeUlcYRZKhTTIFRMSD54XXNpbQ2+KNk4eQMWKSvmkK4hYVaso0VyBP1d6wWmhL0L+IejhZOw8G/C/CsjErXdGJpCsasBLs3lR5pKGszyCyUbYnZmYfl95WuJjrP4HfLD1q+whl10ZVr4h3LkemlEdBbea/VV/aMCsQ6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O0ezHjUm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ort1tAvg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Dec 2024 18:07:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734455260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3t0aJLNzwRL+IOd3hZ1cDVZRaVpCmBTf44od5vrjvo=;
	b=O0ezHjUmMSdQpmMxrYfhokI2OLPLRDCrjU8IStOKfQzwma5oaimGSVXG7gQQsY8Lo5QRLs
	c57qmPS5BTVQIENvuOmL/dqQDJVQ8TOaDnBzyVT8/wKhp7mkbAWqYfzhvEPvjt9tVwBNfM
	r2xVukWL/tCadGcKpNbXuxPFd6Ijjiv3+YbWdBLoCTEvip/EGSRXzkv9FBK8USvcpSP0CZ
	9BI3VfuCuEGswmMMeGoH6pr3iU7JUA5Gw/grQ30/GA2cVhD2WQxDF+S5rBcGRpdwt02V1P
	jWXMS5bfMokI8ZXAevZJVWpkrnazXfA5/B76/uYBp319AmBRoUojjxsfN1tk6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734455260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3t0aJLNzwRL+IOd3hZ1cDVZRaVpCmBTf44od5vrjvo=;
	b=Ort1tAvgmthHhMXlrllKy4SEXMYSK0ez0iWrQaQ3tC2JlZD85qA059F7QQ0YFFJSd+27KD
	OSuCxOsniBvhTtBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 06/14] futex: Add helper which include the put of a hb
 after end of operation.
Message-ID: <20241217170739.AbsgKxuZ@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
 <20241215230642.104118-7-bigeasy@linutronix.de>
 <87wmfz79co.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmfz79co.ffs@tglx>

On 2024-12-16 19:48:07 [+0100], Thomas Gleixner wrote:
> So something like this might be more to the point:
> 
>    futex: Prepare for reference counting of the process private hash
> 
>    To support runtime resizing of the process private hash, it's
>    required to add a reference count to the hash structure. The
>    reference count ensures that the hash cannot be resized or freed
>    while a task is operating on it.
> 
>    The reference count will be obtained within futex_hash() and dropped
>    once the hash bucket is unlocked and not longer required for the
>    particular operation (queue, unqueue, wakeup etc.).
> 
>    This is achieved by:
> 
>     - appending _put() to existing functions so it's clear that they
>       also put the hash reference and fixing up the usage sites
> 
>     - providing new helpers, which combine common operations (unlock,
>       put), and using them at the appropriate places
> 
>     - providing new helper for standalone reference counting
>       functionality and using them at places, where the unlock operation
>       needs to be separate.
>    
> Hmm?

much better.

> > -void futex_q_unlock(struct futex_hash_bucket *hb)
> > +void futex_q_unlock_put(struct futex_hash_bucket *hb)
> >  	__releases(&hb->lock)
> >  {
> >  	spin_unlock(&hb->lock);
> >  	futex_hb_waiters_dec(hb);
> > +	futex_hash_put(hb);
> 
> You missed a place to move the waiter_dec() before the unlock. Actually

This is fine because futex_hb_waiters_dec() happens before the reference
drop. However it is better to keep it symmetrical so I going to move it.

> this move should be in a separate preparatory patch, which does only
> that. It also needs a proper change log which explains why this done,
> why it is equivalent and not introducing a change in terms of ordering
> rules. This:
>
> > Move futex_hb_waiters_dec() before the reference drop, if needed
> > before the unlock.
> 
> does not really give any clue at all.
> 
> >  		if (unlikely(ret)) {
> > -			double_unlock_hb(hb1, hb2);
> >  			futex_hb_waiters_dec(hb2);
> > +			double_unlock_hb_put(hb1, hb2);
> 
> And having this move before the _put() change makes the latter a purely
> mechanical change which let's the reader/reviewer focus on the reference
> count rules and not be distracted by the waiter count changes.

Okay, moving this into its own patch.

> > -	/* futex_queue and wait for wakeup, timeout, or a signal. */
> > +	/* futex_queue_put and wait for wakeup, timeout, or a signal. */
> 
> When you fix up these comments, can you please use the fn() notation?

sure

> Thanks,
> 
>         tglx

Sebastian

