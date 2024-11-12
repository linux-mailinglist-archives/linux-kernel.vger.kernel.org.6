Return-Path: <linux-kernel+bounces-406769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ADB9C639D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF0D1F219DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3D221A4DF;
	Tue, 12 Nov 2024 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="q0izeBXF"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DDB204930
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447653; cv=none; b=gGc8kYkkzWyqCnmQVR0e6ugbKDwdvYa8RDHcxqWMJcNDiArHb8+buNBtZ+ZO2zzxZpMErjaP/bLl7dHHJQ63YsK6XQu9Y19S74B7FbcYW0ClcNtfe5i8a9KtoHJqg5Co2Oi/6TBYxA9YFqb8Sgo++jhN7bPo+sTAEw8qYA8bxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447653; c=relaxed/simple;
	bh=OwN4XgTU/F7qQnbkvXDrYKew1VWQvrWT9N+LFxLW1UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kteQ5ZFD92rWSzIq6szNFnPAMyLch7b+USHdfThZeHipfyss5fAQ02Ve6keqDa9kyChsFsLvS5GDhkiwGUICgZ32ZiGPy546UO42oSEM3L15n5VRqEwQVkTIBwMEMRKUDDn9upfFjd5/+VFQvbNu34nXQ2yrvvklHgrLJKxFvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=q0izeBXF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=kBJsD0iEA6btQOR5yHhO1Hhm5kswTi+CVHncyRBSHIY=; b=q0izeBXF93QDYBrf
	uoBooQXq5IHjyyOK/LscuP81ghPYJFd9kGw3D2/0WFwO4FDGpUmqENlW767M3qKQKvY/bSePCWHJ5
	gnzvchB7i+mIsaRQMSynM+c5TaMv9G3JHbBMDeTMDvN5DTDIf1oNiuEa008VVv62up4SZYwxixpw7
	7d034rN6WvFLBafS7zAhrzPOqhiKLHZckoxIA9pbNpqAbrDHxK6acA1kNxwtdwOIBcNIBsvrEa3oP
	OjaM9FQpICPuaNpdikDMx+z2Sl0bIXtH9PH20Tl+ixo8OGk/PODeQvfEd5vPAnsbydSksBKVs9oI0
	ouDlpejaEr+K0EK+ag==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tAyYj-00H8oA-1T;
	Tue, 12 Nov 2024 21:36:25 +0000
Date: Tue, 12 Nov 2024 21:36:25 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] comedi: comedi_8254: Remove unused
 comedi_8254_ns_to_timer
Message-ID: <ZzPKWeqPhY0miHSC@gallifrey>
References: <20241010204127.271377-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241010204127.271377-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:36:08 up 188 days,  8:50,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> comedi_8254_ns_to_timer() has been unused since it was added
> in commit
> d42b5211d861 ("staging: comedi: comedi_8254: introduce module for 8254 timer support")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping.

Thanks,

Dave

> ---
>  drivers/comedi/drivers/comedi_8254.c | 37 ----------------------------
>  include/linux/comedi/comedi_8254.h   |  2 --
>  2 files changed, 39 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
> index 6beca2a6d66e..9b7747dab747 100644
> --- a/drivers/comedi/drivers/comedi_8254.c
> +++ b/drivers/comedi/drivers/comedi_8254.c
> @@ -77,10 +77,6 @@
>   * to create a 32-bit rate generator (I8254_MODE2). These functions are
>   * provided to handle the cascaded counters:
>   *
> - * comedi_8254_ns_to_timer()
> - *	Calculates the divisor value needed for a single counter to generate
> - *	ns timing.
> - *
>   * comedi_8254_cascade_ns_to_timer()
>   *	Calculates the two divisor values needed to the generate the pacer
>   *	clock (in ns).
> @@ -472,39 +468,6 @@ void comedi_8254_cascade_ns_to_timer(struct comedi_8254 *i8254,
>  }
>  EXPORT_SYMBOL_GPL(comedi_8254_cascade_ns_to_timer);
>  
> -/**
> - * comedi_8254_ns_to_timer - calculate the divisor value for nanosec timing
> - * @i8254:	comedi_8254 struct for the timer
> - * @nanosec:	the desired ns time
> - * @flags:	comedi_cmd flags
> - */
> -void comedi_8254_ns_to_timer(struct comedi_8254 *i8254,
> -			     unsigned int *nanosec, unsigned int flags)
> -{
> -	unsigned int divisor;
> -
> -	switch (flags & CMDF_ROUND_MASK) {
> -	default:
> -	case CMDF_ROUND_NEAREST:
> -		divisor = DIV_ROUND_CLOSEST(*nanosec, i8254->osc_base);
> -		break;
> -	case CMDF_ROUND_UP:
> -		divisor = DIV_ROUND_UP(*nanosec, i8254->osc_base);
> -		break;
> -	case CMDF_ROUND_DOWN:
> -		divisor = *nanosec / i8254->osc_base;
> -		break;
> -	}
> -	if (divisor < 2)
> -		divisor = 2;
> -	if (divisor > I8254_MAX_COUNT)
> -		divisor = I8254_MAX_COUNT;
> -
> -	*nanosec = divisor * i8254->osc_base;
> -	i8254->next_div = divisor;
> -}
> -EXPORT_SYMBOL_GPL(comedi_8254_ns_to_timer);
> -
>  /**
>   * comedi_8254_set_busy - set/clear the "busy" flag for a given counter
>   * @i8254:	comedi_8254 struct for the timer
> diff --git a/include/linux/comedi/comedi_8254.h b/include/linux/comedi/comedi_8254.h
> index d527f04400df..21be0b7250b4 100644
> --- a/include/linux/comedi/comedi_8254.h
> +++ b/include/linux/comedi/comedi_8254.h
> @@ -129,8 +129,6 @@ void comedi_8254_pacer_enable(struct comedi_8254 *i8254,
>  void comedi_8254_update_divisors(struct comedi_8254 *i8254);
>  void comedi_8254_cascade_ns_to_timer(struct comedi_8254 *i8254,
>  				     unsigned int *nanosec, unsigned int flags);
> -void comedi_8254_ns_to_timer(struct comedi_8254 *i8254,
> -			     unsigned int *nanosec, unsigned int flags);
>  
>  void comedi_8254_set_busy(struct comedi_8254 *i8254,
>  			  unsigned int counter, bool busy);
> -- 
> 2.47.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

