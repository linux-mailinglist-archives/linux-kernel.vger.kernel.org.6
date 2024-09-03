Return-Path: <linux-kernel+bounces-312616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C639698DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8DE1F23359
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE661B985A;
	Tue,  3 Sep 2024 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PQy87fZj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uf+et/c+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50081AD262
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355589; cv=none; b=WPUWHYlVmY81cWggUVLPEE9R1iiJCh6QugGhz7XUhB3N3BaXK7oUWlLFarS1p82+EkypmMXxXdcdg4MD+t8NN3jkJwCmhn8ODJqRGHxnOohhQ3bXRykuQ0hx+rjUEGIEDml6VU/fQZKSj1ek57Rxkc1/5VBy/YjehO0RF6WTN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355589; c=relaxed/simple;
	bh=qBM0qMzMHJ26PiMVzRrGCiHERAZKkXObNeBOdeT3xwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIRrv9f5n+yHjqT9qMfz/pJdxqZAjQqm2RPrqKIvfoj5ZbUABg2/GYBsqbVDQpUj7xr0jWEkn7ggJqniceWGWmo+gqcaBi/sHui4TLV8+ijfUIh56Yor/gYeKlx3/sMkdOvF7xcwpVgKDWn76isD7qYsFWq4CBoiHqekD9eEfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PQy87fZj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uf+et/c+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Sep 2024 11:26:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725355583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32pnX+8iKASsJE5a++zViMDL/zgeEfLuyhfdPbGJ/gg=;
	b=PQy87fZjVXxq8NRTATvOliSAyZrM542/54okF4rJswi+PQBM1iaFCp0tVjf8/SYcoNWTe4
	fY0whTmi4+OKo0hMc/DOd5YRJuSjHOztPY3CxPvnCWTyl1ATOB5pviYTVFAOKm4JyePw3a
	dGNKQdzZkt6UFLN6ikUrphjnoABh3W2q06zTTFz7RemN4ZJ3XFJXfMbwAod36d+6000Tf2
	UyRP4sV7MyH+UZHhio5RbI7N+fztqzUJ/Ky88FBKDPL1TPOuPQlCRb2dk4BjyfPcf0feDr
	NQ6I41lUwLJf/0Kv8mC0wnkU1Gn32UHugkB2dIiSYtB8j3/4WnJThI5lv5bhtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725355583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32pnX+8iKASsJE5a++zViMDL/zgeEfLuyhfdPbGJ/gg=;
	b=uf+et/c+keELxwAV/wXo08rvJzoLfnYYJTqoPO9Ohm0Q851PnHJwOMQHU4s8erv9321J+P
	nbfvBSpLgFZIreBg==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq_work: Avoid unnecessary "IRQ work" interrupts
Message-ID: <20240903092622.1Vxa89yN@linutronix.de>
References: <25833c44051f02ea2fd95309652628e2b1607a1e.camel@lenze.com>
 <20240828093719.3KJWbR6Y@linutronix.de>
 <20240828095415.43iwHYdM@linutronix.de>
 <1dc4fa0a48b05e14a1ae2a751441ba021ecee286.camel@lenze.com>
 <20240828140223.P5vGN54Q@linutronix.de>
 <2f59d15b63bfe1911261af86991820aadaf54b38.camel@lenze.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f59d15b63bfe1911261af86991820aadaf54b38.camel@lenze.com>

On 2024-08-28 14:52:17 [+0000], Brandt, Oliver - Lenze wrote:
> On Wed, 2024-08-28 at 16:02 +0200, bigeasy@linutronix.de wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On 2024-08-28 13:26:42 [+0000], Brandt, Oliver - Lenze wrote:
> > > Hmm.... I see. What about calling wake_irq_workd() directly; something
> > > like
> > > 
> > >         if (rt_lazy_work)
> > >                 wake_irq_workd();
> > >         else if (!lazy_work || tick_nohz_tick_stopped())
> > >                 irq_work_raise(work);
> > 
> > this might work but I'm not too sure about it. This will become a
> > problem if irq_work_queue() is invoked from a path where scheduling is
> > not possible due to recursion or acquired locks.
> > 
> > How much of a problem is it and how much you gain by doing so?
> > 
> 
> To be honest I haven't made any measurements. But we have a system with
> *very* tight timing constrains: One thing is a 16kHz irq; the other a
> 4kHz RT-task; both running on an isolated core. So if we assume ~2us
> "overhead" for an irq (this should be more or less the time on our
> system; Cortex-A9 with 800MHz) we would spend ~1% of our 250us grid for
> the additionally irq. Not really something we would like.
> 
> Additionally we may get an (additionally) latency of ~2us before our 16-
> kHz irq could go to work. Also something we wouldn't like.

This is a local-IRQ. It will be slightly more expensive than doing the
wakeup directly.

> What I didn't understand: The "IRQ work" irqs are needed in order to
> start the execution of something. Ok. But how was this done before? It
> seems that "softirqs" were used for this purpose on kernel v4.14 (don't
> ask why we are using such an old version). But I didn't get the idea of
> these "softirqs". Are they triggered via "real" irqs (e.g. IPIs)? In
> this case we would most likely have the same count of irqs on a kernel
> 4.14 and a kernel 6.1 (our goal for now; I don't lose hope that even a
> v6.6 may be used the next year).

You schedule a "work item" via irq_work. This can be compared with
tasklet or workqueue for instance. In the past a softirq was raised and
it was handled as part it. Raising a softirq is simply ORing a bit and
the softirq will be handled on IRQ-exit path or ksoftirqd will be
scheduled (= task wakeup). This is all CPU-local in general. Cross-CPU
requires sending an interrupt (IPI) and within that IPI you need to
raise (OR) the bit for softirq. 

It is likely I had some hacks to get it work. However. Some of the
things require hard-irq context and IRQs-off and it might be triggered
from an NMI and the former infrastructure was not really fit for it. So
we went closer to what mainline is doing and this is what we have now.

You could look at what is triggering the irq_work requests and maybe
based on understanding you could disable it (say this is issued by
driver X and you can disable it because you don't use it).

You could, without breaking much (I think), avoid triggering irq-work
locally for the "only-lazy-work" case and then ensuring the timer-tick
will do the wake-up of the irq-work thread. This is done in case there
is no HW support for signaling irq-work. So would have less irqs but the
work will be delayed to the next jiffy which will it make take a little
bit longer.

Ideally would be avoiding having to deal with irq-work in the first
place.

> Any ideas about this assumption?
> 
> Oliver

Sebastian

