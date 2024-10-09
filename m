Return-Path: <linux-kernel+bounces-356583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269FA9963A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577841C24C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760D01917FD;
	Wed,  9 Oct 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IpiC0LYy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LWY4RvE1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D009188A06
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463518; cv=none; b=M1CSMF5gBin1SlNwDs867hRQmz9lLsg7703UwotRnUuNX8qyYZ1RKDeL1t55Ly9edu6wOX7ZGXP4UEtVYM9/aHK8HPDDX2YH1LDWxW8PiwCYGrkPd1oeFRRWu5OWbOKYQdsapP/Z7n+k5y1yARWTUCIvdYRSChzdq6so5v6b1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463518; c=relaxed/simple;
	bh=RIUQ4igpLjqKOrSDByTI79XlO5vW0EmD2OMsR1jbWK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPEUnxO7vkbdBbu6eoF7YZvHZzqK0bZDGvbj644xQwCZAQyUMp/h8V53qU5oF7JtGSyGm3xsWlN7Kv5Q8k5x8ivlzhSA3ZXuk4dxiq7C0A4XacJ41PxAaxO+T67DzneWV51JHhFyUzUyIrg9lyH3s1PDjm7f8V7Nli7bSncTKco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IpiC0LYy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LWY4RvE1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Oct 2024 10:45:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728463516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JmhjvLATDcVVzJtEiv37Kro4PN4ZZdVDXolxULUg7pw=;
	b=IpiC0LYypRVcQn8J3NYzhXzdBzFeyELGhN+o8SL9KGpnvvSSqL+RWywiDuATmmY3ymTIbu
	fX7qlbd/VyFJ07IYZcMGxUIoLUsfFU/GedxrRVk4mliR+AXsAu1/oDfHyETzhfPURPK/cU
	bF6M/6ji3Zmt4fv0ApeAYI1eCOT6gOVMzj6A/ytSCIKKVKwMCtkzBVshuA43BCfuxApKfG
	0KSUU5pjzhVmMe5K/lkLslP3eSJVvrcPxInnCZfkMKN+2OTN+SUJQQWB01HsjUKGPWkOUZ
	JZb6P5PXOZm/QO9M7jcLWkBLxlwbiAyjAnN5Sj6bWHtqD36HL/vZW9plTTH15Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728463516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JmhjvLATDcVVzJtEiv37Kro4PN4ZZdVDXolxULUg7pw=;
	b=LWY4RvE1ht9Y8Mrq3Ak6UpQ2riBAA0Zk83JZ/VapRJX1cDSRUJqmxTXA+ETaXG9KnxPlvU
	SUuVRvn4QHlrZgBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, tglx@linutronix.de,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241009084514.V-RzKZRm@linutronix.de>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de>
 <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
 <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009080202.GJ17263@noisy.programming.kicks-ass.net>

On 2024-10-09 10:02:02 [+0200], Peter Zijlstra wrote:
> > There are places such as __clear_extent_bit() or select_collect() where
> > need_resched() is checked and if 0 they loop again. For these kind of
> > users it would probably make sense to allow them to preempt themself.
> > We could also add a new function which checks both and audit all users
> > and check what would make sense base on $criteria.
> 
> Do we really need this -- wasn't the idea to have thing 'delay' until
> the actual NEED_RESCHED bit gets set?

Not sure. They asked for it and have a lock acquired. But I guess it
could make sense to do as much work as possible until they have finally
to go.
This what we used to have in the RT tree, I don't complain just compare
notes.

Is there any punishment from the scheduler if they get preempted vs
leave early? It is just the time slice they used up and become less
eligible next time?

Let me do some more testing, this looks good so far.

Sebastian

