Return-Path: <linux-kernel+bounces-408894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAAC9C84CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B744B24CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9811F708D;
	Thu, 14 Nov 2024 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ir7/QJz8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RDxbeAQK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A0163
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572739; cv=none; b=ioFwaDo+7y55et9Ibm38sJ1aNmODD660WQosJ0WadWqTAmSDLOYO/PoD/b9pKv5a3efPolDWoxRTo23Bjw/ag6GBy/izi/4XcC9RMYNRB+yCUnlopcFwMszpa4O5zW5J7+mwQj+2FqRcP9ErzLahDclnMWS5QRSgWZxxgsu220U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572739; c=relaxed/simple;
	bh=hf39oRC75qiRp/7+cSu5pmosxB6BZnKeBGvzEe1DrtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxFntfJF9UoXxLBn6HmclYktB6HgkJuWnluGXtDSZ96U9g7SupJ3K6Gh4BHFno/VhnmED/6x78K6zZXMDj7hWyIrzXUM9GFj5KLZ8oL/d4y5bTh/Tnuf93ouFib0NSwZyPlh1BRcIEaSpKkUECvbjd4dq6dKJzFuNI6kuQeHOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ir7/QJz8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RDxbeAQK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 09:25:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731572735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fvdk2d2yuMXRXZ/nUCL2skdHtpcCTm6R4sBa6WxUfN0=;
	b=ir7/QJz83+74rmijL731cvjSdnud/X5fcQQmxOqtOmBgs6OfIKmq0Rm8OIYpwuMwHRwu7g
	5Q0AEpqC1kfdqsU0dPr2/z1XH4HR8sUsdYwQDWP0Y8V/5cQZO1td5c37rNE0nHlrk+cW5y
	9s9avsisr+JLOXEC4xHFIIWeol6UI9S6ICIaUuSdqNq7pvsUBR6azVB0IuUoABqd0YqWIu
	I4NSqWThFDARUuM/SCqLK+5p/i0cshGnX9BMBofWzK1bjRdO/GRqgSxAbIjkzvuE98XnnY
	Su8lB5KtDs189cbOS0V2/Pmnt/gFol505oicmF2SV93oJa11ulwSou0Tf/f1+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731572735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fvdk2d2yuMXRXZ/nUCL2skdHtpcCTm6R4sBa6WxUfN0=;
	b=RDxbeAQKfqoBdKRZUtRbuhNBl6k62rVyQUFCnkkwlxeLpbZ3mwuCFdwNXXs1pvdycnwAUT
	G85ZLeSiRvTcf9Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241114082534.8Go_kdjY@linutronix.de>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
 <ZzTGQ_zTS8NrxjW9@localhost.localdomain>
 <87bjyir7dk.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bjyir7dk.fsf@oracle.com>

On 2024-11-13 16:23:03 [-0800], Ankur Arora wrote:
> > But looking at !CONFIG_PREEMPT_RCU code on tree_plugin.h, I see
> > some issues now that the code can be preemptible. Well I think
> > it has always been preemptible but PREEMPTION && !PREEMPT_RCU
> > has seldom been exerciced (or was it even possible?).
> >
> > For example rcu_read_unlock_strict() can be called with preemption
> > enabled so we need the following otherwise the rdp is unstable, the
> > norm value becomes racy
> 
> I think I see your point about rdp being racy, but given that
> rcu_read_unlock_strict() would always be called with a non-zero
> preemption count (with CONFIG_PREEMPTION), wouldn't the preempt_count()
> check defeat any calls to rcu_read_unlock_strict()?
> 
>     void rcu_read_unlock_strict(void)
>     {
>             struct rcu_data *rdp;
> 
>             if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
>                     return;
> 
> Or am I missing something?

This is indeed broken. By moving preempt_disable() as Frederic suggested
then rcu_read_unlock_strict() becomes a NOP. Keeping this as-is results
in spats due to this_cpu_ptr() in preemptible regions. Looking further
we have "rdp->cpu != smp_processor_id()" as the next candidate.

That preempt_disable() should go to rcu_read_unlock_strict() after the
check.

> Ankur

Sebastian

