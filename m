Return-Path: <linux-kernel+bounces-374188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C2B9A6691
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BBA1C213AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8051E6325;
	Mon, 21 Oct 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Daj1qTzY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qKz1f9ra"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4D198E6F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510081; cv=none; b=sLLWjEx7Cc46Ux4Yb8HS/KHveH/NaDhMP0HwwcBVxjN+Sm4GdWfYbfAYGujKQfdPqOYVqBRP9tCa9WiCYK5T9LtNYi2y7lonlgyl4slWQqOo43mtI9SMb9Q6lhgEBjF2su1jPrVE5Jmdgghg/r1I5r1zkDuBf29LgF3OoksdMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510081; c=relaxed/simple;
	bh=b5IndUBUWnrLbJ2qcQHXhc7GovdBsR/Aedi4iqQ8ptA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPZr2a6290yc/PRynr5yzITYz9VDFzF9OehOGIwKNpSUz4deRuKEl0w3iuJW/622SEIwv+/7BiuyiXTh45eweVEzeaJ88xXiOKCClmgtoU6nwaxYgyQqEgYjXroSn2rfAArdqEUzB1OlgRfXveuLITvKtVjRYeDViWsfHTJVmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Daj1qTzY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qKz1f9ra; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 21 Oct 2024 13:27:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729510077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SZptfpkmtnph5FccEpfCWxm3lInZ8j0ni8t+QEKi8z0=;
	b=Daj1qTzYmDkxbCL+WqupLvJU1jBSAGWoNq68lt4+hX7ykKg2IRA9R+oFETbFZ4p2ZOF/Do
	mKUnQHT/ceo/OJuray/+WG4Wvn9HLR/CQtn2x2BMyxa242kGr9Bn8nAFyQxk+n3f0UGhXx
	BSpQHK0h12xKeyvswIOV+sLUX+IoVZWCEgHkX3vqS9cT6BNcvzcAgvBmt5y/DH7q42oPd5
	j7xACdV+RY1mC7dJQLci1sHb7SbxSvZ2D8+LH4vA6MGc1ajbu+xSMyqv1KGWVbMhv4/5ST
	T1rBxM2Lm32+C4xKcKB/0+QQEE8P3O33eaKG4lfyHJC/OWtzA/j+llBfESmiMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729510077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SZptfpkmtnph5FccEpfCWxm3lInZ8j0ni8t+QEKi8z0=;
	b=qKz1f9ra5gnVNxtK2oB4rYoTKH90+wXfSlYfJw0hhRo7EFUn9GdpclewrtryLOrCOcMu/r
	ugtaovL12WJWg6BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241021112755.m7dWNbc0@linutronix.de>
References: <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <2a2a3ae6-ed0b-4afe-b48a-489cf19667a3@paulmck-laptop>
 <20241017070710.U9bTJFMS@linutronix.de>
 <0313c8c5-a6a0-4d09-9f85-ac5afa379041@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0313c8c5-a6a0-4d09-9f85-ac5afa379041@paulmck-laptop>

On 2024-10-18 10:38:15 [-0700], Paul E. McKenney wrote:
> > > > I don't think this is always the case because the "preemptible" users
> > > > would also get this and this is an unexpected change for them.
> > > 
> > > Is this series now removing PREEMPT_NONE and PREEMPT_VOLUNTARY?
> > no, not yet. It is only adding PREEMPT_LAZY as new model, next to
> > PREEMPT_NONE and PREEMPT_VOLUNTARY. But is is likely to be on schedule.
> > 
> > > As conceived last time around, the change would affect only kernels
> > > built with one of the other of those two Kconfig options, which will
> > > not be users expecting preemption.
> > 
> > If you continue to use PREEMPT_NONE/ PREEMPT_VOLUNTARY nothing changes
> > right now.
> 
> Good, thank you!
> 
> Presumably PREEMPT_NONE=y && PREEMPT_LAZY=y enables lazy preemption,
> but retains non-preemptible RCU.

PREEMPT_NONE=y && PREEMPT_LAZY=y is exclusive. Either NONE or LAZY.

> > > If PREEMPT_NONE and PREEMPT_VOLUNTARY are still around, it would be
> > > far better to make PREEMPT_RCU depend on neither of those being set.
> > > That would leave the RCU Kconfig settings fully automatic, and this
> > > automation is not to be abandoned lightly.
> > 
> > Yes, that was my intention - only to make is selectable with
> > LAZY-preemption enabled but without dynamic.
> > So you are not complete against it.
> 
> Help me out here.  In what situation is it beneficial to make PREEMPT_RCU
> visible, given that PREEMPT_NONE, PREEMPT_VOLUNTARY, PREEMPT, and
> PREEMPT_FULL already take care of this automatically?

We have now NONE, VOLUNTARY, PREEMPT, PREEMPT_RT (as in choose one).

This series changes it to NONE, VOLUNTARY, PREEMPT, LAZY, LAZIEST.
Ignore LAZIEST. PREEMPT_RT is a on/ off bool.

Based on my understanding so far, you have nothing to worry about.

With NONE + VOLUNTARY removed in favor of LAZY or without the removal
(yet)  you ask yourself what happens to those using NONE, go to LAZY and
want to stay with !PREEMPT_RCU, right?
With LAZY and !PREEMPT_DYNAMIC there is still PREEMPT_RCU as of now.
And you say people using !PREEMPT_DYNAMIC + LAZY are the old NONE/
VOLUNTARY users and want !PREEMPT_RCU.

This could be true but it could also attract people from PREEMPT which
expect additional performance gain due to LAZY and the same "preemption"
level. Additionally if PREEMPT gets removed because LAZY turns out to be
superior then PREEMPT_DYNAMIC makes probably no sense since there is
nothing to switch from/ to.

Therefore I would suggest to make PREEMPT_RCU 
- selectable for LAZY && !PREEMPT_DYNAMIC, default yes
- selected for LAZY && PREEMPT_DYNAMIC
- the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
  !PREEMPT_DYNAMIC)

Does this make sense to you?

> 							Thanx, Paul

Sebastian

