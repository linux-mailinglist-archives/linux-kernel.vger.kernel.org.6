Return-Path: <linux-kernel+bounces-253013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D6931B38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8781C210A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D4139D00;
	Mon, 15 Jul 2024 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A5krj+rm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MeE8B3dh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6CF510
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072999; cv=none; b=lni/1nlwHljLp2NxZsLZL+pNiYW+VInTR7/SZFXjKHZ3fBZd2S9bo4y+BvOoN2wZ/WEPVX4D3n4JLX7Ej0YwLjoq2BlsYr+HpG9fZ6sD2dY0vIfK4qsy0fydL1iHxdmM3x6x6P+YJMnXeYTux1+j7ODDEOVibiWBgzIV3RxDbUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072999; c=relaxed/simple;
	bh=ZxPzQTirFx5bghd1d73xa5JwAYkRCFuoMY7vNbGTwn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7xOJKweu+jnWbjusep66B7N20yQMo2/2nqvbNZMxcpKc6mk4JRhcmzF8unBSfOLAC0Qp+Riqib2H+9eLiv3P2PI0vZjpoeJDPdJqsjo+jK9zMxykizwmH8l2gwPG/tQf9Xhy3zyCPgLEFLSIDt+QjVuQ67eIXSWD/jJpSLDi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A5krj+rm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MeE8B3dh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jul 2024 21:49:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721072989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylyQi+OilL3xNrb+dh/i/+npJwA0U02fGtboF/I9cxI=;
	b=A5krj+rmZe9wFQAn2aytsZJCbdTW1MPjuRyXuYAQtutkoRHuFUfivgDeiQNdUpVnDYNzFt
	ItGzDb7p7cqt8zD3eJGdh7xzLWJl+RrXwgZJz/r9OpCDyt9R9ACRvZwlKEL3nzQ9lgYeZv
	C0Am4y4kZxwLuR2pW9E+xLAbPCtQSGeniPJr1PVkPMPXM82J/ENRpTU77eRSRut4o+DSPQ
	nYYIZFNgu2kHjkDnKdS4/vZg70jm8oiNc9yEHkwWpNNeQQX1kmV3h9bnuErfHL1Cz/wxWM
	bTyQedm0IpCC3rB3R/Qe1ntZlPxch7V0VxpLyGA91rw6N1WLEGTdYoq3tB+qDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721072989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylyQi+OilL3xNrb+dh/i/+npJwA0U02fGtboF/I9cxI=;
	b=MeE8B3dhdhm2hhzik1urR+zWOIwg0BfhIeAGMLlBNtx6P68qsfZKN2S7OXV0mXzkm5DVBt
	w1g3jf/xQfU4YSCg==
From: Nam Cao <namcao@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	b.spranger@linutronix.de, Christoph Hellwig <hch@lst.de>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Fix plic_set_affinity() only
 enables 1 cpu
Message-ID: <20240715194943.J5bVJokv@linutronix.de>
References: <20240703072659.1427616-1-namcao@linutronix.de>
 <CAAhSdy0ZGD-p0iBVPqHF0RKTwvAAMWwYZ0ufioRrO75JzSh1qQ@mail.gmail.com>
 <20240703123327.CvOiP2Jb@linutronix.de>
 <CAAhSdy3gZHnSwovxypY5vP438TNPj8h+miqtyBKhEUAdWj=htQ@mail.gmail.com>
 <20240707143414.0ydME30F@linutronix.de>
 <87r0c1uhhx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0c1uhhx.ffs@tglx>

On Wed, Jul 10, 2024 at 10:19:54PM +0200, Thomas Gleixner wrote:
> On Sun, Jul 07 2024 at 16:34, Nam Cao wrote:
> > On Wed, Jul 03, 2024 at 08:31:31PM +0530, Anup Patel wrote:
> >> On Wed, Jul 3, 2024 at 6:03 PM Nam Cao <namcao@linutronix.de> wrote:
> >> > Then we should leave the job of distributing interrupts to those tools,
> >> > right? Not all use cases want minimally wasted CPU cycles. For example, if
> >> > a particular interrupt does not arrive very often, but when it does, it
> >> > needs to be handled fast; in this example, clearly enabling this interrupt
> >> > for all CPUs is superior.
> 
> It's not really superior at all.
> 
> The problem is that a single interrupt is delivered to multiple CPUs at
> once and there is no mechanism in the hardware to select one CPU from
> the given set which can handle it quickly because it does not have
> interrupts disabled. The spec is clear about this:
> 
> "The PLIC hardware only supports multicasting of interrupts, such that
>  all enabled targets will receive interrupt notifications for a given
>  active interrupt. Multicasting provides rapid response since the
>  fastest responder claims the interrupt, but can be wasteful in
>  high-interrupt-rate scenarios if multiple harts take a trap for an
>  interrupt that only one can successfully claim."
> 
> It's even worse. $N CPUs will in the worst case congest on the interrupt
> descriptor lock and for edge type interrupts it will cause the interrupt
> to be masked, marked pending and the handling CPU is forced to unmask
> and run another handler invocation. That's just wrong.

Hmm I'm not sure if this case can happen. CPUs do not touch the interrupt,
including taking the description lock, unless it has claimed the interrupt
successfully; and only 1 CPU can claim successfully.

But it doesn't matter, your other points are enough for me to drop this
patch.

> Aside of that this can cause the loss of cache and memory locality in
> high speed scenarios when the interrupt handler bounces around between
> CPUs.
> 
> >> This is a very specific case which you are trying to optimize and in the
> >> process hurting performance in many other cases. There are many high
> >> speed IOs (network, storage, etc) where rate of interrupt is high so for
> >> such IO your patch will degrade performance on multiple CPUs.
> >
> > No, it wouldn't "hurting performance in many other cases". It would give
> > users the ability to do what they want, including hurting performance as
> > you said, or improving performance as I pointed out earlier.
> 
> Kinda, but you make the bad case the default for very dubious benefits.
> 
> I grant you that the current implementation which defaults everything to
> CPU0 is suboptimal, but that's an orthogonal problem. E.g. X86 selects
> the single target CPU from the mask by spreading the interrupts out
> halfways evenly.
> 
> But if you really care about low latency, then you want to selectively
> associate interrupts to particular CPUs and ensure that the associated
> processing is bound to the same CPU.
> 
> > I am willing to bet that most users don't ever touch this. But if they do,
> > they better know what they are doing. If they want to waste their CPU
> > cycles, so be it.
> 
> That's not what your patch does. It defaults to bad behaviour.
> 
> > My point essentially is that kernel shouldn't force any policy on users.
> > The only case this makes sense is when the policy is _strictly_ better than
> > anything else, which is not true here. What the driver should do is
> > providing a "good enough for most" default, but still let users decide
> > what's best for them.
> 
> See what I explained you above. Changing this to multi-CPU delivery is
> not really good enough and there is a valid technical reason not to do
> that.
> 
> > Side note: if I am not mistaken, the effective affinity mask thing is for
> > hardware limitation of the chips who cannot enable interrupt for all CPUs
> > in the mask. RISC-V PLIC, on the other hand, can enable interrupts for any
> > CPU, and therefore should do so.
> 
> It's not only hardware limitations which cause architectures to limit
> the CPU mask to a single target. On X86 systems which support logical
> destination or cluster mode this was disabled even though the 'multiple
> CPUs try to handle it' problem is mitigated in hardware. The benefit is
> marginal for the common case and is not sufficient for the low latency
> requirements case.
> 
> Using a spreading algorithm for the default case will help for the
> common case, but won't be sufficient for special latency sensitive
> scenarios. Those are the scenarios where the user needs to take care and
> set the affinities correctly.

Thanks for the explanation, I didn't see all the angles on this. Let's drop
it then.

Best regards,
Nam

