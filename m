Return-Path: <linux-kernel+bounces-331822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4E497B199
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8DFB248D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343D0178397;
	Tue, 17 Sep 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TKWlaU9P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R9YjvQfn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F3535DC;
	Tue, 17 Sep 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726584621; cv=none; b=S4+p2AQsU+q620Q4BZewoAIIIxRQ6/YN9vhg7UGGh+ENuGD8p7WDqV7OQldOocywYkp1KpFKm73GlTKYQ2oO4A1/8dRXn+yQVmKLPnkCtcC9wcunuKDcs/O1Y0/nuMXxDEN0fEe2FBnuqpZJfBhyi9UQz4oK7dRB27Uuu6M3cDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726584621; c=relaxed/simple;
	bh=vsbLyYUXsDioKkrnt/JOxoELHNh5QqS1ACqYJPcHIRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co4BIoZtirjGYFwnLhVZ0VE6bN4IVS22VR0SgYVZ1w+lDh4ZboRBXfJBr7A4KdtuswWWw05KtLwoBUBVMvmE2WmAWJtwSY7dqxmIj3TwEVDYV2BlPdarv2UX++oyTEzunz92UVvhoZQ5+b5gvqAljHZIWe4vYpNRSdxWLEXXaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TKWlaU9P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R9YjvQfn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Sep 2024 16:50:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726584618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rxJRzbktYiDJXT+Ub/Ybk8aF3V3Yo1DxmmO7BxSocTo=;
	b=TKWlaU9PXHY6Q/j8IGbl/hcg7jrpk52Vr2plBkxPMLfnJsB8zUhVE3PaaRNA+2PATRXFve
	Hx0jQLMrahlLRoVaDG4QELVl3EfExUAikQy2PYcBAm8jWi/Zar5DoddHw9iL6aiodhYnUa
	cpMoYuieMsTCnj1lCRrOZX7lpXjW4VEau05Od4s5M/sAKF96XQjsD88erckHYDtqPogUfV
	GZAEUbAO5BuyjGX50QwQCY/znEqSgeZS+CY10H2/yOQ0VbDo62ITlY6kLuyXhFzVjeBu4x
	HxOtqXC4NtTIuNXT385ev7ooJZADG3WTPF1kbiMHT+iGR4LEho1DObWndG3dUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726584618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rxJRzbktYiDJXT+Ub/Ybk8aF3V3Yo1DxmmO7BxSocTo=;
	b=R9YjvQfn5CWH9BLCY1TXG4V2cC+vDqaUqBBfZSENZJ1uCErdXnHcQ7ZyCTZ2NTtCcdmZUs
	DTeyub0MuvmPJmCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mikhail Arkhipov <m.arhipov@rosa.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Felipe Balbi <balbi@ti.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: gadget: r8a66597-udc: Fix double free in
 r8a66597_probe
Message-ID: <20240917145017.dCZwT_uL@linutronix.de>
References: <20240916222937.12878-1-m.arhipov@rosa.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916222937.12878-1-m.arhipov@rosa.ru>

On 2024-09-17 01:29:37 [+0300], Mikhail Arkhipov wrote:
> The function r8a66597_free_request is called to free r8a66597->ep0_req,
> but the pointer is not set to NULL afterward, which may lead to a double
> free if the function is called again.
> 
> If the probe process fails and the r8a66597_probe function subsequently
> goes through its error handling path. Since r8a66597_free_request is called
> multiple times in different error handling sections, it leads to an attempt
> to free the same memory twice.
> 
> Set r8a66597->ep0_req to NULL after calling r8a66597_free_request
> to prevent any further attempts to free this pointer.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0f91349b89f3 ("usb: gadget: convert all users to the new udc infrastructure")
> Signed-off-by: Mikhail Arkhipov <m.arhipov@rosa.ru>

Looking at how the code looks now and how it looks back then, I simply
haven't seen it. I would suggest to instead assigning NULL simply remove
the second block. The request gets allocated shortly before
usb_add_gadget_udc() is invoked. It does not make sense to have this
conditional check all the way from clean_up2 where it is not allocated.

>  drivers/usb/gadget/udc/r8a66597-udc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
> index db4a10a979f9..43b81cae7d17 100644
> --- a/drivers/usb/gadget/udc/r8a66597-udc.c
> +++ b/drivers/usb/gadget/udc/r8a66597-udc.c
> @@ -1952,12 +1952,14 @@ static int r8a66597_probe(struct platform_device *pdev)
>  
>  err_add_udc:
>  	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
> +	r8a66597->ep0_req = NULL;
>  clean_up2:
>  	if (r8a66597->pdata->on_chip)
>  		clk_disable_unprepare(r8a66597->clk);
>  
>  	if (r8a66597->ep0_req)
>  		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
> +		r8a66597->ep0_req = NULL;
>  
>  	return ret;
>  }

Sebastian

