Return-Path: <linux-kernel+bounces-418588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528319D6347
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180AD282D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821518452E;
	Fri, 22 Nov 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AjLurxzS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RfAqEEXC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F622339
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297104; cv=none; b=XfPG2cuI2bxPptLub9cbu+SuZ1E0C4ehyAFeo4W6/hVhDM6QeyckbSuoWKberPhwxKZrtDqeM+dwne9V4jwgMC5XKDY+u7x8Z08eeTsNtVvYq+FufqzvbU774q82+3Z/J4EdKV2jyfr/trYTWOqOA7kjiWb4XHqGV4gElOBGcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297104; c=relaxed/simple;
	bh=B2bECGjOfrz7jBpN+kQQrKWP2MFoGJQdTiQay7HTgZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOGcWWlA2UkjeTIFlSjJIQEJiS0FLUnSk372QQaalLorPaCoPl0b5lUwN1CO7AJcg0yAnH5Coi8KF8SlVVNXEiLxmaZw9oGBBhyjr5bWFrk3X4t+WDW5JGhC72DAWcCjHag/Rl9dnxKu9/cyFR0Xldc+lHm/tcRLT/bUJJjDpmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AjLurxzS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RfAqEEXC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Nov 2024 18:38:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732297101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tLt5o6MBRb5p5Zx9PRWdPnBX09AvSg/52XC6io9nfeg=;
	b=AjLurxzSqewyU52XkDyc12yCoSkROJ5otr05QCsncDyJbbhR1Ecz63nJ4/p0849LMBfPmM
	FISa/Sh6img2v0W1StowXiCHKjH30swFCfv9IegIGEKndl2/t3RHTv+Rxggiy8KTbo9y6Z
	Fm+ijqspSn1EndSbjysNir136n34LeioDVcAt0HBSFujHRYtJgY9RnKPA0NCPF+3t38XNO
	DlLtBYgjFE+0GgoIcHkKdRRUKdZNVQJvOVzQjOoD/C6FLAiAY4a1yBp4atuHRL8+AxwcYY
	YrzWGe/2tcl6vahrHWB2MkQ5h4GQ2iQOMfAmWgJ3/YyMrAtLaxWQ8tW2/taB5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732297101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tLt5o6MBRb5p5Zx9PRWdPnBX09AvSg/52XC6io9nfeg=;
	b=RfAqEEXCuqe/LiU76VLZMwgUaFSoQQnrz/QE7V7Amq/0cv7e52VeXT/rVESTswM1vPUQLW
	QfalXEh6sVhLyeAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH] stackdepot: fix stack_depot_save_flags() in NMI context
Message-ID: <20241122173820.-gmDeqUQ@linutronix.de>
References: <20241122154051.3914732-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122154051.3914732-1-elver@google.com>

On 2024-11-22 16:39:47 [+0100], Marco Elver wrote:
> Per documentation, stack_depot_save_flags() was meant to be usable from
> NMI context if STACK_DEPOT_FLAG_CAN_ALLOC is unset. However, it still
> would try to take the pool_lock in an attempt to save a stack trace in
> the current pool (if space is available).
> 
> This could result in deadlock if an NMI is handled while pool_lock is
> already held. To avoid deadlock, only try to take the lock in NMI
> context and give up if unsuccessful.
> 
> The documentation is fixed to clearly convey this.
> 
> Link: https://lkml.kernel.org/r/Z0CcyfbPqmxJ9uJH@elver.google.com
> Fixes: 4434a56ec209 ("stackdepot: make fast paths lock-less again")
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

