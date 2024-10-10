Return-Path: <linux-kernel+bounces-358359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C00997D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827221C230F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9631A304A;
	Thu, 10 Oct 2024 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ISjVvHyq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nQKIgkz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3F18BBB0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543049; cv=none; b=p6sq05+YEZuHSde29cJVHNraKNzuAyO8R52xMq7JXT6D+HUb4fUDxlM2EkiCkVNvNrNiybLDQkkcSUnnt8V4aSPXUOrzSV33BufMqSXpybJ+uaQLpSYewGqBP2200poXlJ6AcPfk8wNH478rkdUCGOdnJiHVxTjBvAv1JIgE9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543049; c=relaxed/simple;
	bh=J8RQR39fHbCsdaeHfLJ31PiuGA4SKHEV/VS2Bj0SIc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otmUKzqsqOzzLvPcjiDd94lJ1KMvMEDH4wJ411d+aaJ5uX+wS3axYd2h0XJAgI+yUD8/ib/Aq9Py2RZflKSdnkLut2xwrPnOKQ3eoPYdzbUNDcAKqkZxR7LS/TvlNLfU4L7yekVT9rBuEktuxb55JckdTNmM4XVMc9l5McVgYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ISjVvHyq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nQKIgkz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 08:50:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728543046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5lgjKalZku1tjojN5N/JOsW9PdBHE4/AUcV8v4z090=;
	b=ISjVvHyqlEzzTih1MFXVcSnT+z2ycWkANU5UOEl7srG9tlWNMHJV2vqru0WqDFSc/9uMiI
	4KHN1kfUS98UZva/xgxBTUzUh3E6ohzitBWygPPcDUuZBInm3veAmBIWKSJKcR7+IRyp6S
	kzAc+AGxXApLcmc1VGBrYdTfmO1JLPgN/yZaYp2UI8kftjGME/wbAjCSacD/6xPC5hyaWX
	IQkoVKfpxshznmneCS85W4M+lvcxzfPQjJ4Fl0oM/GSEjU20OzV23kHrYKqmKEJ8txXTAB
	z/tdskA2ty7jlp6QCMiRtlucWZHIs8IEwhRcrZzz6rcSjeEy2TwTiLCV0MyzNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728543046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5lgjKalZku1tjojN5N/JOsW9PdBHE4/AUcV8v4z090=;
	b=1nQKIgkzkP0/yvLJGvEDfuLmLS4pddwY75yxpdx7F08/KSHqNMST82Ypp2Y501yd9i5hVu
	R6f34MCKGzCFcjAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 4/7] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Message-ID: <20241010065044.kszYbjKa@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009165411.3426937-5-ankur.a.arora@oracle.com>

On 2024-10-09 09:54:08 [-0700], Ankur Arora wrote:
> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
> states for read-side critical sections via rcu_all_qs().
> One reason why this was needed, was lacking preempt-count, the tick
> handler has no way of knowing whether it is executing in a read-side
> critical section or not.
> 
> With PREEMPT_LAZY=y, there can be configurations with PREEMPT_COUNT=y,
> PREEMPT_RCU=n, where cond_resched() is a stub that does not provide
> quiescent states via rcu_all_qs().

PREEMPT_LAZY selects PREEMPT_BUILD which selects PREEMPTION which in
turn selects PREEMPT_RCU. So this is not a valid combination. Do you
have a different tree than I do? Because maybe I am missing something.

> So, use the availability of preempt_count() to report quiescent states
> in rcu_flavor_sched_clock_irq().
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/rcu/tree_plugin.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 1c7cbd145d5e..da324d66034b 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -974,13 +974,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>   */
>  static void rcu_flavor_sched_clock_irq(int user)
>  {
> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
> +	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
> +	      !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {

couldn't you use a helper preemptible()?

>  		/*
>  		 * Get here if this CPU took its interrupt from user
> -		 * mode or from the idle loop, and if this is not a
> -		 * nested interrupt.  In this case, the CPU is in
> -		 * a quiescent state, so note it.
> +		 * mode, from the idle loop without this being a nested
> +		 * interrupt, or while not holding a preempt count (but
> +		 * with PREEMPT_COUNT=y. In this case, the CPU is in a
> +		 * quiescent state, so note it.
>  		 *
>  		 * No memory barrier is required here because rcu_qs()
>  		 * references only CPU-local variables that other CPUs

Sebastian

