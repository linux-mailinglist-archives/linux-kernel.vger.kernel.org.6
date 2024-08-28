Return-Path: <linux-kernel+bounces-304731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8396240A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255C01C23C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7DE166310;
	Wed, 28 Aug 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pZGlZEHC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iA3W2/kH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99015B10E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838860; cv=none; b=RGeh2wUStL1KGRkrpXSNqm7rI28vTev3/p+cyFEblKDHo/5/hcqMdfAZNV/9ZOTDrO1uquZNLiP8DPJXvegb1N+od7/QCs6t/xSEXRi4/5YQlSIID15JcgUOyXMJYgHUmMykueJli/lnN1PdXF/VYf0cfExW7kxnYYlc+pwyh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838860; c=relaxed/simple;
	bh=pQeYVI1EGSBM9Uus7UJokK9k/e9FsryM1nDmcOMUDX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI8/AF2asRHVWDu2DB8n8Z0aQjX6uAOOVrAVEZCx0rvjPpts9ZSfvD+Hz2C4ZqJ2i594F7e7pVcsSBTB7ZuT6Oy8gTidJpWCU8ALKIaOPeWtMyrZw2XnODC84NIe7LDbyWb2ZT7fvFofby31sTj779uB2ocgBADZgp4/R6cUqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pZGlZEHC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iA3W2/kH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Aug 2024 11:54:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724838856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88R1XAvcXieMHiFBJ6Bk5WuIrt1LhMy9qPSxVcp/sog=;
	b=pZGlZEHCfNcw6FwZPWesLYNIfadPQsBffLOuf5RDBR6Q9kY36wDgtk3xfxZKD8mRGRVBDT
	eKkHDWG5MNsUY89vTveycdoZpWm42BTl0eGNNOi4UMfvk6VJQC9CR8phhlp1WGfH05LMF+
	52G8d2x9j1PqHIU8aAJcPsZuMwM2mFbMHX/k5eUjG6BrTucOkbfkaEeH2vE37a4QjAUd5W
	hirGEFJHL+2++/g0o9oISnWCa41N36nLVBQjPudMtJjQqn4K0htrHhQf0PvzbdaSHt6hDq
	wIJePRpf+F3RY+4UVDWFEu/dCnifdAe+aC4ruJWy6G/1tgL9f7lWegL/OGHv0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724838856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88R1XAvcXieMHiFBJ6Bk5WuIrt1LhMy9qPSxVcp/sog=;
	b=iA3W2/kH7MOsvtAc9o/YmDFAtk6q0PozW1VBdyw4CaBV4+zgiven/HqAWHZRzqSgr1uXQI
	rFiF58Q/rssHx9BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq_work: Avoid unnecessary "IRQ work" interrupts
Message-ID: <20240828095415.43iwHYdM@linutronix.de>
References: <25833c44051f02ea2fd95309652628e2b1607a1e.camel@lenze.com>
 <20240828093719.3KJWbR6Y@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828093719.3KJWbR6Y@linutronix.de>

On 2024-08-28 11:37:20 [+0200], To Brandt, Oliver - Lenze wrote:
> > Fixes: b4c6f86ec2f6 ('irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT')
> > Signed-off-by: Oliver Brandt <oliver.brandt@lenze.com>
> > ---
> >  kernel/irq_work.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> > index 2f4fb336dda1..df08b7dde7d5 100644
> > --- a/kernel/irq_work.c
> > +++ b/kernel/irq_work.c
> > @@ -108,7 +108,7 @@ static void __irq_work_queue_local(struct irq_work *work)
> >                 return;
> >  
> >         /* If the work is "lazy", handle it from next tick if any */
> > -       if (!lazy_work || tick_nohz_tick_stopped())
> > +       if (!(lazy_work || rt_lazy_work) || tick_nohz_tick_stopped())
> >                 irq_work_raise(work);
> 
> Looking at this I *think* rt_lazy_work was needed earlier due to
> different code but not anymore. Couldn't you just remove rt_lazy_work
> and set lazy_work in the RT path? That should work.

Actually no. If we merge rt_lazy_work into lazy_work then we would have
the behaviour you have here. But we need irq_work_raise() in order to
	irq_work_run();
	-> wake_irq_workd();
	  -> wake_up_process(irq_workd);

If we don't irq_work_raise() here then it will be delayed until the next
tick and we didn't want that if my memory serves me.

> >  }
> >  

Sebastian

