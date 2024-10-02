Return-Path: <linux-kernel+bounces-347772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D698DEA8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D00B7B2BE81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA021D0B86;
	Wed,  2 Oct 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iglS9thO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z7YGf0am"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79141D049A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881548; cv=none; b=nZFo8PH+Jx3Wf2mnyowt5H7XVBrHJJDbpsjmFZQBlDvqTx1N2vvveUWk0C6dXXM2YZU+/m4upL468VPmo+EilFC6a6rVjdgyhRWWHmbFff/KxFLskePgXXFBMzIWSdWrEk/RGFC1mhToXJ2PDwdDG0twf/ps8b1SQyR7yC4T+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881548; c=relaxed/simple;
	bh=N8pPgpOsm1aBCg3tm6WnIhv201HWqWp6LCAQwi10Yq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZGwtxd9kOlc6u2DjuxJFV6KRSCS38ezVt9Qwuvm1QClhB0gfPumlcVKpDU53t/M3EoXLn3xfePNNLkpIj+iyGoDfN5NbrBnnbK2RGl40o+puiLJSYhk5pRt5RwlnzHsk2Qv/8wyshbsRF5YiM9HN144iAISBGkp+02nAYZKuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iglS9thO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z7YGf0am; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Oct 2024 17:05:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727881545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8RXnyShGfruTHfN3PlronqHXBj7dBxJTe/3sIBh6y0k=;
	b=iglS9thOtUS5bCOXWZXnGM1WlpR0oUXTMJxn809XefgeP6Yl5DZDDHouvrGxL3Xi4rmANt
	MnKnwYeLBwFG4NFiODIt9VDifRMGu8XmSKjFy/OdrF0SdoPRdxcOHOQZ2ukx36QmrV72g2
	JNg7vxuoWdSoLCHG/GJooX5B6Pk+80Nh2IZWcUw0KgmbWNMGhpxOqTk6gkFylxWPj+h2fc
	k+kJLHR2UoovJktAMka7eVEIPgXIzTELl+xzwDbmWAMb+XLxbdbK+0lYsJTEjADnh4l5A/
	0eTyrdUCtCI3+L3B5LF62IaPqRXy8UAK2FI8S6GboQnL4RlOLolPIXd7z2ha/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727881545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8RXnyShGfruTHfN3PlronqHXBj7dBxJTe/3sIBh6y0k=;
	b=Z7YGf0amBp6qqVxWYMEU+r554zj36+pJLZ44IUDGr/B96scjkHUM3gw07jtsVQ3/gTECUN
	eFZCrk5Ormyb3VCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Repeated rto_push_irq_work_func() invocation.
Message-ID: <20241002150543.IhYy2Q9k@linutronix.de>
References: <20241002112105.LCvHpHN1@linutronix.de>
 <20241002103749.14d713c1@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002103749.14d713c1@gandalf.local.home>

On 2024-10-02 10:37:49 [-0400], Steven Rostedt wrote:
> On Wed, 2 Oct 2024 13:21:05 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Would it make sense to avoid scheduling rto_push_work if rq->curr has
> > NEED_RESCHED set and make the scheduler do push_rt_task()?
> 
> Can we safely check rq->curr without taking any locks on that CPU?
> 
> I guess tasks do not get freed while a CPU has preemption disabled, so it
> may be safe to do:
> 
> 	task = READ_ONCE(rq->curr);
> 	if (test_task_need_resched(task))
> 		/* skip */
> 
> ??

+rcu_read_lock() but yes. This would be one part. You need to check if
the task on pull-list has lower priority than the current task on rq.
This would be need to be moved to somewhere in schedule() probably after
pick_next_task().

> -- Steve

Sebastian

