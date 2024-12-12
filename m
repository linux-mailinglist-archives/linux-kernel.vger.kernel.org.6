Return-Path: <linux-kernel+bounces-443508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA359EF449
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A5B17EAA2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13C231A43;
	Thu, 12 Dec 2024 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LU5s7nIn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4/z3xmrm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F2226520
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021706; cv=none; b=TprQ/hZUoXCRyUX/8t3ppCKnhoMfrJO2DSLxnwVhbCtPPs/AWtQnWbfN0ts1/PCrjPlG++sM0w8/p+MMRkPApticjQW/hjbkH0+Y745n7tU8iqbLdri32VhRy8+ie7geI+7QphdNkiNYGT/AjVv1vfJwrtcxd1NRr/ALDbMp8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021706; c=relaxed/simple;
	bh=vCVFSJ66Kjgi2LNxKT5NRtHkebS7PIVdYpJMSEypjuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKZdMmkHrLXbwlJ7t9iVpsqMRYANHG7SYT8YOZjqCTwhlBXOZDDCo8sfLiJqCYaoP9kRIEjpcZV4WN27G2nx4YNrZBejv81v5u04CJu0E2Rtm59S6Ob8ZeihcbxzHH0eEyllXdtCUJAtl/DerxmFfRvfpQcmXrdXB0mfg1FoxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LU5s7nIn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4/z3xmrm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Dec 2024 17:41:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734021702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHHtUGU7DpOgU5PnduMLdKbW7NRwADcKVs8uErMNDqc=;
	b=LU5s7nInVicH/WCV4gq9vSmUI/aE301rRV/a5vWAKt40r2OP4EwLqCcizbs1eRtimb7fhc
	9dhlnQvNdb1b1DHGzJALuuq7JqKXcaTjcE59a6Xd85IgfCI0ynWSSzEaI7nK5YnCf5PQtJ
	I9LnWxVVuAd289VN1hbHOTLGiyFlmMZe47yQWVWgstYeqy6yjYPx3QlloHgsUL//7yGluk
	e8KRDC5ZEZQwMDdfcop8i84LxsfqUmQvKHfHT5zf8jWlBwfRFXUoL3PGtQ5VMeGxdnD5MY
	FTc28Nb/o8g0CiPWjL2VxEDWZwn9hrxL4Id9VzEZg6ql+3pI9JJYW5fABgYJDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734021702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHHtUGU7DpOgU5PnduMLdKbW7NRwADcKVs8uErMNDqc=;
	b=4/z3xmrmDp8zynjFr0hQwCE1rm18M6gBqma6ny9LAizZFimnbSz6Fy+iGjvwEH+UOi/d5B
	gG64u1V02GADoGAw==
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
Subject: Re: [PATCH v4 05/11] futex: Track the futex hash bucket.
Message-ID: <20241212164140.esFLafG0@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-6-bigeasy@linutronix.de>
 <87a5d3cr6j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5d3cr6j.ffs@tglx>

On 2024-12-10 19:45:56 [+0100], Thomas Gleixner wrote:
> > +void futex_hash_put(struct futex_hash_bucket *hb)
> > +{
> > +	struct futex_hash_bucket_private *hb_p;
> > +
> > +	if (hb->hb_slot == 0)
> > +		return;
> > +	hb_p = container_of(hb, struct futex_hash_bucket_private,
> > +			    queues[hb->hb_slot - 1]);
> 
> Duh. This off by one abuse of hb_slot is really counter intuitive. It
> took me a while to wrap my head around it.

The really cute part is that this -1 gets optimized away and this
container_of becomes just hb_p = hb - "hb_slot << 6" :)

> The structure has a 4 byte hole, so adding a private flag or such is
> feasible without going over a cache line, unless lockdep or rt is
> enabled, but in that case it expands into a second cache line anyway.

I have a whole cacheline to stash things because of futex_hash_bucket
alignment:
| struct futex_hash_bucket_private {
|         rcuref_t                   users;                /*     0     4 */
|         unsigned int               hash_mask;            /*     4     4 */
|         struct callback_head       rcu __attribute__((__aligned__(8))); /*     8    16 */
|         bool                       slots_invariant;      /*    24     1 */
| 
|         /* XXX 39 bytes hole, try to pack */
| 
|         /* --- cacheline 1 boundary (64 bytes) --- */
|         struct futex_hash_bucket   queues[] __attribute__((__aligned__(64))); /*    64     0 */
| 
|         /* size: 64, cachelines: 1, members: 5 */
|         /* sum members: 25, holes: 1, sum holes: 39 */
|         /* forced alignments: 2, forced holes: 1, sum forced holes: 39 */
| } __attribute__((__aligned__(64)));

The hash bucket itself on RT is:
| struct futex_hash_bucket {
|         atomic_t                   waiters;              /*     0     4 */
|         unsigned int               hb_slot;              /*     4     4 */
|         spinlock_t                 lock;                 /*     8    32 */
|         struct plist_head          chain;                /*    40    16 */
| 
|         /* size: 64, cachelines: 1, members: 4 */
|         /* padding: 8 */
| } __attribute__((__aligned__(64)));

so it still fits. However with lockdep enabled it acquires two
cache lines and these additional 4 bytes don't make a change.
On RT it doesn't make a difference because the spinlock_t is so huge.
But for !RT struct futex_hash_bucket becomes 32 bytes so we could fit 2
buckets into one cache line _if_ memory becomes a concern and cache
bouncing is not an issue because it is only process wide.

> > +	futex_hash_priv_put(hb_p);
> > +}

Sebastian

