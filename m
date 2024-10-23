Return-Path: <linux-kernel+bounces-377488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003A9ABF87
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307121C2338B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC7715886D;
	Wed, 23 Oct 2024 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m92Iue2N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WsBqM3Wi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC6152787
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666694; cv=none; b=Ag/DycwJPyt5H8sZ7kDu9ubHHUE6uda02gmSBd4uBS7+cehWYir3ALVcz6oyEbZKMpr9cM1LFTlodjg8JGIL0SewGPmfIDKzBmv0PJmVTpVJd+Ui3gopFmV9YG4BfP5yw2CBJN9deln99joL+Sub+Md0pA5SbKpQPwlZHTfeJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666694; c=relaxed/simple;
	bh=wPIB8QSIupSPPZdkspNYel3pUj1/ekFjh30TOXpRp/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIOihC0wovPFVvf8RLAT4N4LZLuuPGsB4YTvdWMXQNilxDsnuleTBUpeqzP2E/fiX3SjnTbPwuBxrOSBf//HnQz7pfyvqTDnwXHbzl1iJEgpD6pj/IP9Wf9RQap3dNJB6zVFMnwZ8YBZ2Bn3P5oTsbC3i/q4Q0bSzQU3ElkdnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m92Iue2N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WsBqM3Wi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Oct 2024 08:58:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729666691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rTDGDImdVKlSypVICOR7k/jZ5sRO6qVnRG82GzSCZP4=;
	b=m92Iue2NPao7eS3c4a4/LX/0lhBQMwc1TlvDhMbCNIN13+NDJEdfQ9bKLGzDPsZl/R/zDT
	UQHl3ReRxG6cNy9skjWAt9cB1DRjAOVcllNcC3fO/b+6rY1v2606tnHFqohb+VOxAhShIW
	WzkufQoBndOo/XwV92Ng6ynYRDhyEMV+QOqj9mt/8FMS6i5dJpda/cWYcujL7/UrDwFXu2
	96i/imj37j/oYA6IfeQ0IzKTzhak40Dik1VYmuBZPpq+W02+Fry5ZloB5zsZslnXJporn1
	AK4zpt8jZMOfoavGrN6T/eeM4HKy9v1WWtpOparSQFz/sZazTLP1TB/NkYkMwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729666691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rTDGDImdVKlSypVICOR7k/jZ5sRO6qVnRG82GzSCZP4=;
	b=WsBqM3Wiu5MM4UsVIco0L1y7/lF66iqpKnmkgsGzCG6mEta2LYzjHV67MLBCG4svae40p2
	mmd/1xUaBlzz5zCA==
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
Message-ID: <20241023065808.ck-vPSbO@linutronix.de>
References: <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <2a2a3ae6-ed0b-4afe-b48a-489cf19667a3@paulmck-laptop>
 <20241017070710.U9bTJFMS@linutronix.de>
 <0313c8c5-a6a0-4d09-9f85-ac5afa379041@paulmck-laptop>
 <20241021112755.m7dWNbc0@linutronix.de>
 <a71a7154-7cd4-44da-be41-5f2831fbfbbe@paulmck-laptop>
 <20241022140933.XfxSIpDu@linutronix.de>
 <88b90ca8-9d73-4691-b391-43891a057c77@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88b90ca8-9d73-4691-b391-43891a057c77@paulmck-laptop>

On 2024-10-22 16:54:11 [-0700], Paul E. McKenney wrote:
> > Yes. I have no idea which of those two (PREEMPT_RCU vs !PREEMPT_RCU) is
> > to be preferred. Therefore I'm suggesting to make configurable here.
> 
> As Ankur noted, the original intent was to move people from both
> PREEMPT_NONE and PREEMPT_VOLUNTARY to lazy preemption.  This strongly
> suggests setting the value of PREEMPT_RCU to n.  Not just the default,
> but the value.  We need to have a definite non-speculative case for
> forcing people to once again worry about RCU preemptibility, and I know
> of no such case.

okay.

> > If you have a benchmark for memory consumption or anything else of
> > interest, I could throw it a box or two to get some numbers. I've been
> > looking at free memory at boot and this was almost the same (+- noise).
> 
> Unfortunately, the benchmark is the fleet and all of the various
> non-public applications that run on it.  :-(

I see.

> > > > Therefore I would suggest to make PREEMPT_RCU 
> > > > - selectable for LAZY && !PREEMPT_DYNAMIC, default yes
> > > > - selected for LAZY && PREEMPT_DYNAMIC
> > > > - the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
> > > >   !PREEMPT_DYNAMIC)
> > > > 
> > > > Does this make sense to you?
> > > 
> > > Not really.  At the very least, default no.
> > > 
> > > Unless LAZIEST makes the most sense for us (which will take time to
> > > figure out), in which case make PREMPT_RCU:
> > > 
> > > - hard-defined =n for LAZIEST.
> > > - selectable for LAZY && !PREEMPT_DYNAMIC, default yes
> > > - selected for LAZY && PREEMPT_DYNAMIC
> > > - the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
> > >   !PREEMPT_DYNAMIC)
> > > 
> > > Or am I still missing some aspect of this series?
> > 
> > no, that is perfect.
> 
> And assuming LAZIEST is not to be with us much longer, this becomes:
> 
> - hard-defined to "no" for LAZY && !PREEMPT_DYNAMIC, just like
>   NONE or VOLUNTARY with !PREEMPT_DYNAMIC.
> - selected for LAZY && PREEMPT_DYNAMIC
> - the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
>   !PREEMPT_DYNAMIC)
> 
> Fair enough?

Guess this hard no and worry later makes sense.

> 							Thanx, Paul

Sebastian

