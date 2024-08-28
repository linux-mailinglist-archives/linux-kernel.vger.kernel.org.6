Return-Path: <linux-kernel+bounces-304694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1269623A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122511F21829
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA761649CC;
	Wed, 28 Aug 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BTPBFuYP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MBd1q8bU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2987715B107
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837844; cv=none; b=esmYPDAU2e7GjI9rO0yi5sxzi0PLHiWohGB++tx2/ix1Sd05a8TQTNOYUdFnCpi6HCzfAZx7/0FXc/62gAIrNYO45OrafMpAUHExac/M3nYrYf3dKo61VmORhSWtIgOrMlMV69j6gipTpnJoj7P08HVgZLlBPXesF8MKzluOPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837844; c=relaxed/simple;
	bh=RWcJG9KWtsrnGelXB+CNLCRGmAJUeXx/ehAHF8cFizo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhJ7Z2o4GDGQTC248JuTDFFA38ZZHAalS6l8QPYGyXyq+8gsfZoMK5dNRjFUJsa1sBqwrJp9qq7ZLXq5BMkrz0xuskymidrmH/CohRvI4emM2D2mjHL1UYZ3E0emhmyypYkNOQVVY4kD3D7qWIWZE0IL9A3suQjpcNormRxlMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BTPBFuYP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MBd1q8bU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Aug 2024 11:37:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724837840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KEVoNAWW/hw2gNeOsyzbzeJso1qtUj48K2FtF3cwIDY=;
	b=BTPBFuYPjQvV5oKFlme9S85eALERldB1nLnXZ17MLCT9P8a7yVcOo5vuTX2nnM21/GySac
	4UoQ6rO5tEzQMJ+h2zGrx7CkIMtxKXD2wg5LlWGXQQP6p7njflaEpYAgNCMdOP15O/yZOd
	nt8gg+wOVL8pviqDcygctCWzQOM00/ome8cZOHR0glmwDiP2vvG/GfkjFU3DETki5Je7A+
	Ns55jhL2SDl4ONtY5JNPwhM413oCUjE0vyKGv5efNYoYmi3X2NbJPsDbeXX5lNdToVdABh
	1V8Kr6lsLeLw8PlZh5BXxUxeir0RIhVfignx5RsGofdYoJtlB6s2XW+J9tCLuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724837840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KEVoNAWW/hw2gNeOsyzbzeJso1qtUj48K2FtF3cwIDY=;
	b=MBd1q8bU/FimjaeNe/gu169ErszEdYQBgxHdUe7xy0eJqM4nHQEHltMGy51dS9PrGBDutP
	8E5yDIiuIJrvPSAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq_work: Avoid unnecessary "IRQ work" interrupts
Message-ID: <20240828093719.3KJWbR6Y@linutronix.de>
References: <25833c44051f02ea2fd95309652628e2b1607a1e.camel@lenze.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25833c44051f02ea2fd95309652628e2b1607a1e.camel@lenze.com>

On 2024-08-27 15:45:42 [+0000], Brandt, Oliver - Lenze wrote:
> It was noticed that newer kernels (>= 6.1) raises a lot of "IRQ work"
> interrupts where older ones (<= 5.10) haven't used this at all on our
> system.
> 
> Root cause seems to be commit b4c6f86ec2f6 ('irq_work: Handle some
> irq_work in a per-CPU thread on PREEMPT_RT'). This commit tries to avoid
> calling irq_work callbacks from hardirq context as much as possible.
> Therefore interrupts marked as IRQ_WORK_LAZY and (on PREEMT_RT) interrupts
> not marked as IRQ_WORK_HARD_IRQ should be handled from an per-CPU thread.
> 
> Running the remaining interrupts from hardirq context is triggered using
> irq_work_raise(). But on PREEMPT_RT irq_work_raise() will be called for
> all interrupts not marked as IRQ_WORK_LAZY which results in unnecessary
> "IRQ work" interrupts.

Good catch I think.

> Fixes: b4c6f86ec2f6 ('irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT')
> Signed-off-by: Oliver Brandt <oliver.brandt@lenze.com>
> ---
>  kernel/irq_work.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 2f4fb336dda1..df08b7dde7d5 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -108,7 +108,7 @@ static void __irq_work_queue_local(struct irq_work *work)
>                 return;
>  
>         /* If the work is "lazy", handle it from next tick if any */
> -       if (!lazy_work || tick_nohz_tick_stopped())
> +       if (!(lazy_work || rt_lazy_work) || tick_nohz_tick_stopped())
>                 irq_work_raise(work);

Looking at this I *think* rt_lazy_work was needed earlier due to
different code but not anymore. Couldn't you just remove rt_lazy_work
and set lazy_work in the RT path? That should work.

>  }
>  

Sebastian

