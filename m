Return-Path: <linux-kernel+bounces-356979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5BF9969D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6455B21EDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D118E75F;
	Wed,  9 Oct 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iBj9CYnf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AA1TyFIv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD21922DD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476346; cv=none; b=XydSD3KnrR33qFLIN4kzEQhjuO8wSok8Rm2ATGpLUXeXIqvXbfr8RW77zJKzb5aVqo8aGZtQohOR6QDKgHBN8p2LOL5hPy7jM8TzAk0+fV3aP4C7ZVba8oG49+HjyXqCVRDshXcRbPsbFnKlQbEzxO8+2eLqN4IRWCjIs5rLU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476346; c=relaxed/simple;
	bh=vcxrRGus4BZVQIUKiLKYlD4Xpqg9QRvip7kCtIFK3wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9ZwX5tiA1EskUSNcW3anHHI5sEK+6JmEoJZ3hIIcKNK5lxpEKv1MEsMyGkKZlwZULFlsugKLBHaHUg9T+3P8U+HqB0/ARozBSmyYqidWDqvBs1d8NQnO4IfWKwVOq9GkRbwjvYRdJr/LjMWxIJ8ej1x9sm34zPv0Jc05Aj+zHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iBj9CYnf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AA1TyFIv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Oct 2024 14:18:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728476340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTBa28+lEUqbsbY3G1CvCa7Rswxn0Qf5kD7J19D3RKk=;
	b=iBj9CYnfQb+OQo5fPx197zb++m/fWXnhTj2ohQ3BNSrwWTcXfFXWfvEguhj9S/YOPhxQnU
	bvRqJYzgCQvPBrddpWSEs5N+xGNqunX5g/kWAy1Ev01G2u5ec7u1TDbasLqZy12pFKPy25
	QlsTnDSlWrX9E6TxgYlGsxk+nFp0XFb7rpp/CRHWNkVlGgRtNmf+W1nxslsdDhbX6sjCic
	ubQ6U13Q7gVdPw3rX0XN7lr2YVS9MIhps7PAeknv5llMbiSrxxdOIRUyaHRKxPJQe99AOO
	XiTyOBya9crc/scas8rqy/dcJkHZkuL7T5NX8JPZmDNmDy12iHh96wUZjxtHLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728476340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTBa28+lEUqbsbY3G1CvCa7Rswxn0Qf5kD7J19D3RKk=;
	b=AA1TyFIvy9nitbHp0SIjPpMkN0URAdOHBsOT/V5O+EUbArD/WA3Q0FR1bHolnVOENvSJUe
	jRiLQemfVjmFcKDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 1/5] sched: Add TIF_NEED_RESCHED_LAZY infrastructure
Message-ID: <20241009121859.C2-B8P4L@linutronix.de>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.219540785@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007075055.219540785@infradead.org>

On 2024-10-07 09:46:10 [+0200], Peter Zijlstra wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -964,9 +963,9 @@ static bool set_nr_if_polling(struct tas
>  }
>  
>  #else
> -static inline bool set_nr_and_not_polling(struct task_struct *p)
> +static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
>  {
> -	set_tsk_need_resched(p);
> +	atomic_long_or(1 << tif, (atomic_long_t *)&ti->flags);

	set_ti_thread_flag(ti, tif);
?
Not sure if there is a benefit over atomic_long_or() but you could avoid
the left shift. I know. Performance critical.

>  	return true;
>  }
>  

Sebastian

