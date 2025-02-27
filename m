Return-Path: <linux-kernel+bounces-536374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE63A47EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77161890B63
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A202422F3BC;
	Thu, 27 Feb 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RWwypsh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="63ZblLAF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9AC22171A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662386; cv=none; b=EBC6C388eL//dG8GCrREfviZb0fqVXxgm/v0zAkNcgwc/Xz06dFKjxJ004RQsBvKYmpGtfTdLbqszGzOj+84arT0qzKim0J6ybjimvRhv3GkaPYyV/3dmiMJhJxBGsvaBRZkWz4sUWIpT4nlNVm0UvGcSmI4aEpM7lQQro36gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662386; c=relaxed/simple;
	bh=6FHmEO5ROtitiqwvaGMNwbr+tjLVFIR2Yo8O643eJFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjF73ej2/rXzEVOAUmwl54M5mank3ZK7s+3/PJP3HoZxZI9pWzaBaxZlHSLJk0SzakoJHeMt1hQ1qth7p+zbAAfuHC7yF9cVjd8Q9U6cU8awAtUa7MSUvuYuJaWvC4SThyxnrfv2tiy5St6SbHy9WDf5g/naP2CKyiYGenFoNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RWwypsh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=63ZblLAF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 14:19:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740662381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=632v7CpS3QPt9HhoeHrpEHCN5Oo6OBT/aBsHaC13wJY=;
	b=4RWwypsh/b1DxIEgQSwJa7inry57ujp0PresSVkMyspBaFU1HX4PromBZGoY9YKqR7TVwD
	H37uGAU5gQMHgDv3T9gb132AhFZ5dEW+I+r9Tm9zQ5WUhCK6qn7zGiA0Ba94xqyOIaMLB0
	0od4tH93Zi6Agm7bGSoscoq2yx4A5KMdc2O7nNuNHkVK62RERbDb8jbatYYn6I5v0E6UjJ
	l8fgMsKn0PP0fSSzUj6rApDjBqkAlNvmG2sQmZ16MnwIliklQyl8DJPRfMj6qR9zPNiK+J
	7vQWH/jPkxGKQlY7dluCf3BocQcXJhKNmTBq9ROA+69L7nUISTrtM3I67geuAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740662381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=632v7CpS3QPt9HhoeHrpEHCN5Oo6OBT/aBsHaC13wJY=;
	b=63ZblLAFx8Q9BJMFP8YmpzPUbtp3qT/fznqsvToR8Xgeiv5Ra2TQxxIHHfuAaNuNSqCwuf
	AIblV8hsvxwf44Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/17] zram: permit reclaim in zstd custom allocator
Message-ID: <20250227131940.6yzjRQmL@linutronix.de>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-15-senozhatsky@chromium.org>
 <20250224091036.Y9fHrKr-@linutronix.de>
 <vh3uzody42dfcfduwrhnha3wrjm6wi7awwferzed35zuodn4zu@txo4zpftf2uq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vh3uzody42dfcfduwrhnha3wrjm6wi7awwferzed35zuodn4zu@txo4zpftf2uq>

On 2025-02-25 13:42:55 [+0900], Sergey Senozhatsky wrote:
> On (25/02/24 10:10), Sebastian Andrzej Siewior wrote:
> > On 2025-02-22 07:25:45 [+0900], Sergey Senozhatsky wrote:
> > >  static void *zstd_custom_alloc(void *opaque, size_t size)
> > >  {
> > > -	if (!preemptible())
> > > +	/* Technically this should not happen */
> > > +	if (WARN_ON_ONCE(!preemptible()))
> > >  		return kvzalloc(size, GFP_ATOMIC);
> > 
> > This check works only on preemptible kernels.
> 
> I'm not sure this is true.
> 
> > If you run this on !PREEMPTIBLE kernels, preemptible() reports always 0
> > so that WARNING will always trigger there.
> 
> I thought that preemptible() depends on PREEMPT_COUNT, not on
> PREEMPTIBLE, because even on !PREEMPTIBLE preempt-count still
> holds hard/soft irq counts, etc.

Yes. The preempt count is always there to hold NMI/ HARDIRQ/ SOFTIRQ.
However only on a preemptible (that is with PREEMPT_COUNT) kernel
preempt_disable() does something. So on !PREEMPTIBLE kernel you don't
see spin_lock() or preempt_disable() reflect in preempt_count. Unless
you enable debugging which force this option into a non-preemptible
kernel.

> I ran CONFIG_PREEMPT_NONE=y zram-zstd tests and didn't see any
> warnings.

Sebastian

