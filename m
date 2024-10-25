Return-Path: <linux-kernel+bounces-382184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4496B9B0A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D677C1F23E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EA218BC2F;
	Fri, 25 Oct 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eoEX/CDR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k6TSgzxG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504915ADAB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875812; cv=none; b=Vk9vXodDMQYgBlKMS7ddkBitQML47cJvpKJbGe9iUEkfHthqtDUO9mocBzoKDRjj8zvIOvg5JrL2cJGXyvWP0N6tK0gNaq/stBnvpTHoO2O8FTY92WiOoXD6e32fmY3GukGhGWxuJ/2FMqcCOfKv0DdFXXSuMUHp8JDYlbK/+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875812; c=relaxed/simple;
	bh=ye1QxF8RXLNj7RIwW0erOYtttPzz+4JsEAYsTt1kJk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf2e2hrsatIp/iipg3WwD4H5DZKr3mhA9jT3bXjIfZloai4lN/e4VipvppUcWlk2LI17DBJuAL839kshJl1McMobOEiMAfRqy0kz1erd7h6DUejXklnlPodJVUkTN7QXpF3E9/iGfFhxAwqFStV8A++gSOgDVLqJIllIEHNmju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eoEX/CDR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k6TSgzxG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 19:03:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729875808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWfY3zD1gqTEZBaqOtdFVpCMRGY+pidPmrFeeIvmsU0=;
	b=eoEX/CDRvdqBLDDKUJ56I7KhFEBcapYb759anmI9bpBtDll7F2gOIAjwtSVKPTKF1l2qoH
	QO+qeGgbGJJAQX1nIGZ4gkWgQgGfic128pZuCy37N5RfdKPTI3iATa/rMKxeradIwMFXZx
	kAbGQTofMImEIGh/kCyOOBRC856EIC+s7z/UulWvB46SuxnIUOlibUxxRCzVL5Isb/1n+4
	G2A69REgDxP9C+vgYBp8QxRsDBEYbjw4na1PleMEVCJDocnva7Brk3R9JxlIuhQCleHkFe
	2Kvr7iZYBSn2KH+qqcy8WlsnwhDnC4XLpsSw6W7rp101IZrIKnrE2mHv/s7EKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729875808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWfY3zD1gqTEZBaqOtdFVpCMRGY+pidPmrFeeIvmsU0=;
	b=k6TSgzxGJDkXGVg5b7RFltWEdyonmfNMCsyCgfzZgpK8kwfQbPTEjnTybOhjpklBQ4Dc6M
	ROWuRw8mVOfCVABg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Tejun Heo <tj@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v3 5/5] softirq: Avoid unnecessary wakeup of ksoftirqd
 when a call to do_sofirq() is pending
Message-ID: <20241025170326.ChR4tfjG@linutronix.de>
References: <20241014090339.2478-1-kprateek.nayak@amd.com>
 <20241014090339.2478-6-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014090339.2478-6-kprateek.nayak@amd.com>

On 2024-10-14 09:03:39 [+0000], K Prateek Nayak wrote:
> Since commit b2a02fc43a1f4 ("smp: Optimize
> send_call_function_single_ipi()"), sending an actual interrupt to an
> idle CPU in TIF_POLLING_NRFLAG mode can be avoided by queuing the SMP
> call function on the call function queue of the CPU and setting the
> TIF_NEED_RESCHED bit in idle task's thread info. The call function is
> handled in the idle exit path when do_idle() calls
> flush_smp_call_function_queue().
> 
> However, since flush_smp_call_function_queue() is executed in idle
> thread's context, in_interrupt() check within a call function will
> return false. raise_softirq() uses this check to decide whether to wake
> ksoftirqd, since, a softirq raised from an interrupt context will be
> handled at irq exit. In all other cases, raise_softirq() wakes up
> ksoftirqd to handle the softirq on !PREEMPT_RT kernel.

Stupid question. You talk about the invocation from nohz_csd_func(),
right?.
Given that this is an IPI and always invoked from an IRQ then the
softirq is invoked on IRQ-exit. If it is flushed from
flush_smp_call_function_queue() then the softirq is handled via
do_softirq_post_smp_call_flush(). In that case couldn't you just tell
nohz_csd_func() to use __raise_softirq_irqoff(SCHED_SOFTIRQ) ? This
should solve this, right?

> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 0730c2b43ae4..3a6b3e67ea24 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -99,6 +99,10 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
>   *
>   * The per CPU counter prevents pointless wakeups of ksoftirqd in case that
>   * the task which is in a softirq disabled section is preempted or blocks.
> + *
> + * The bottom bits of softirq_ctrl::cnt is used to indicate an impending call
> + * to do_softirq() to prevent pointless wakeups of ksoftirqd since the CPU
> + * promises to handle softirqs soon.
>   */

The comment that you are extending and the comment regarding
SOFTIRQ_OFFSET were nearby. I don't like that those two are now far
apart.

>  struct softirq_ctrl {
>  	local_lock_t	lock;
> @@ -109,6 +113,16 @@ static DEFINE_PER_CPU_ALIGNED(struct softirq_ctrl, softirq_ctrl) = {
>  	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
>  };
>  
> +inline void set_do_softirq_pending(void)
> +{
> +	__this_cpu_inc(softirq_ctrl.cnt);
> +}
> +
> +inline void clr_do_softirq_pending(void)

there should be no inline here.

> +{
> +	__this_cpu_dec(softirq_ctrl.cnt);
> +}
> +
>  static inline bool should_wake_ksoftirqd(void)
>  {
>  	return !this_cpu_read(softirq_ctrl.cnt);

Sebastian

