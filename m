Return-Path: <linux-kernel+bounces-559656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 743A5A5F73C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F54168520
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB088267AE9;
	Thu, 13 Mar 2025 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="O3so/JpO"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95F35944
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874788; cv=none; b=FiQl3+FysxQ26D8W5Fp4Oq4FGPK7ogVT6BnDHOliJ36mX7vrLs+iQGZljsX/qnQXpW2vPV7SRfgyfqrU93Y+UwksqOeC/ei3e0fJnp1DO9AXF5dU9Y8CQtlGrtPFqTFuCGv6HB9EHmT5YlJ5i0zx9vlCh278f8dRbuX4W0NFz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874788; c=relaxed/simple;
	bh=U6YYA0pQzHVT5ZNcufy8EzIeHHrGIlivviDFVBaBLG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeHfncZfmW8ZqcbtKfzPFLqRTgTt5W5BRV+hz7EBodpzwVeX6F+/GlxxAXGSxZCQTG5flPp9D6DFieqNLh3Q1RW/Lp2XmzbBu8+ccPm8uaN13VjZDUFGL2EAZF4PG7vp116mjVGN2wjfRR4kVyUJB9THsZHJvkN1MJTMmOE5IBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=O3so/JpO; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Sw1Im7IY6HGSZTwSlodOKGVFEVW29j0gB60U8GGwFts=; b=O3so/JpO78km8bs/
	Osb8IsrmwlrA9Eglf6zr6+kjsDEUi78JEEaPj7CtPWMM7RnJgxFS0yhF65mT5A/Ez+V5eSSQTFpV0
	WwdZWuYmMiH27XZNb+UfqdR/lV2o0C5fcoJ0U9M3g60JOTOHmAHrMLEWIKBMJQOAqs87ziFnpH6nV
	U9j9i54dosBCZ6nPuCfFMcmDMT9ExU7PiCLS6kIUN50mMEqj9cT51jDgVXMnFJx5QZgcYPZAhdpp5
	1dbS5VX10pqVt2dxbYRuOaZumKXzbDMTx5nsrg70G2Rcu19hSVE8S0pIg4kzGOr/69s++1BIlRD3f
	wllQOK8Lw4GiSVrLjQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tsjCZ-004eIB-0X;
	Thu, 13 Mar 2025 14:06:23 +0000
Date: Thu, 13 Mar 2025 14:06:23 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] comedi: comedi_8254: Remove unused
 comedi_8254_ns_to_timer
Message-ID: <Z9LmXxvc6tA-SPrn@gallifrey>
References: <20241010204127.271377-1-linux@treblig.org>
 <ZzPKWeqPhY0miHSC@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZzPKWeqPhY0miHSC@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:05:57 up 309 days,  1:19,  1 user,  load average: 0.00, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > comedi_8254_ns_to_timer() has been unused since it was added
> > in commit
> > d42b5211d861 ("staging: comedi: comedi_8254: introduce module for 8254 timer support")
> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Ping.

Hi,
  I'd appreciate if someone could pick up and review this old cleanup patch.

Thanks,

Dave

> Thanks,
> 
> Dave
> 
> > ---
> >  drivers/comedi/drivers/comedi_8254.c | 37 ----------------------------
> >  include/linux/comedi/comedi_8254.h   |  2 --
> >  2 files changed, 39 deletions(-)
> > 
> > diff --git a/drivers/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
> > index 6beca2a6d66e..9b7747dab747 100644
> > --- a/drivers/comedi/drivers/comedi_8254.c
> > +++ b/drivers/comedi/drivers/comedi_8254.c
> > @@ -77,10 +77,6 @@
> >   * to create a 32-bit rate generator (I8254_MODE2). These functions are
> >   * provided to handle the cascaded counters:
> >   *
> > - * comedi_8254_ns_to_timer()
> > - *	Calculates the divisor value needed for a single counter to generate
> > - *	ns timing.
> > - *
> >   * comedi_8254_cascade_ns_to_timer()
> >   *	Calculates the two divisor values needed to the generate the pacer
> >   *	clock (in ns).
> > @@ -472,39 +468,6 @@ void comedi_8254_cascade_ns_to_timer(struct comedi_8254 *i8254,
> >  }
> >  EXPORT_SYMBOL_GPL(comedi_8254_cascade_ns_to_timer);
> >  
> > -/**
> > - * comedi_8254_ns_to_timer - calculate the divisor value for nanosec timing
> > - * @i8254:	comedi_8254 struct for the timer
> > - * @nanosec:	the desired ns time
> > - * @flags:	comedi_cmd flags
> > - */
> > -void comedi_8254_ns_to_timer(struct comedi_8254 *i8254,
> > -			     unsigned int *nanosec, unsigned int flags)
> > -{
> > -	unsigned int divisor;
> > -
> > -	switch (flags & CMDF_ROUND_MASK) {
> > -	default:
> > -	case CMDF_ROUND_NEAREST:
> > -		divisor = DIV_ROUND_CLOSEST(*nanosec, i8254->osc_base);
> > -		break;
> > -	case CMDF_ROUND_UP:
> > -		divisor = DIV_ROUND_UP(*nanosec, i8254->osc_base);
> > -		break;
> > -	case CMDF_ROUND_DOWN:
> > -		divisor = *nanosec / i8254->osc_base;
> > -		break;
> > -	}
> > -	if (divisor < 2)
> > -		divisor = 2;
> > -	if (divisor > I8254_MAX_COUNT)
> > -		divisor = I8254_MAX_COUNT;
> > -
> > -	*nanosec = divisor * i8254->osc_base;
> > -	i8254->next_div = divisor;
> > -}
> > -EXPORT_SYMBOL_GPL(comedi_8254_ns_to_timer);
> > -
> >  /**
> >   * comedi_8254_set_busy - set/clear the "busy" flag for a given counter
> >   * @i8254:	comedi_8254 struct for the timer
> > diff --git a/include/linux/comedi/comedi_8254.h b/include/linux/comedi/comedi_8254.h
> > index d527f04400df..21be0b7250b4 100644
> > --- a/include/linux/comedi/comedi_8254.h
> > +++ b/include/linux/comedi/comedi_8254.h
> > @@ -129,8 +129,6 @@ void comedi_8254_pacer_enable(struct comedi_8254 *i8254,
> >  void comedi_8254_update_divisors(struct comedi_8254 *i8254);
> >  void comedi_8254_cascade_ns_to_timer(struct comedi_8254 *i8254,
> >  				     unsigned int *nanosec, unsigned int flags);
> > -void comedi_8254_ns_to_timer(struct comedi_8254 *i8254,
> > -			     unsigned int *nanosec, unsigned int flags);
> >  
> >  void comedi_8254_set_busy(struct comedi_8254 *i8254,
> >  			  unsigned int counter, bool busy);
> > -- 
> > 2.47.0
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

