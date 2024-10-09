Return-Path: <linux-kernel+bounces-356367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF08D996010
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13321C22E46
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52DB17B4E5;
	Wed,  9 Oct 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ilzOV1A3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245A178CC5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456458; cv=none; b=Xt5BeOqwz+9YOXiHQPSmZgopp6td1IntxwaRfr7joH1siZBoJV44PB5fw59nWpxS4/PL7g6iGKT36Wfv4Cr6ZTE2QUSPVabBEe0Y3P6LXoBo1/Swd39mzbgM0Ysg1cbkcohjO1WJjYxr0kWcjbkcG3PbV/oOMddjeL2li6JVHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456458; c=relaxed/simple;
	bh=vKDvpdjeCI0iEpxVJEPZ5e9WGAWNIxrFapWo1uGrq4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtu/EgCSr5BgDOJ8Dj35uIPW6LL9KWBoya2kIFncRVkLuEgjH60ZaKw5uaoBL1eKO36zrx9lHeYp5wsvI3mpo44jODDYYG/VibTk9oOrInsOb3LIAtIsQ/Fb99xk0A86W+QYx4D/V5Yp+CyUr9T4qzYEUuiMLUjxF7rQNkW/ZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ilzOV1A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ABDC4CECF;
	Wed,  9 Oct 2024 06:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728456457;
	bh=vKDvpdjeCI0iEpxVJEPZ5e9WGAWNIxrFapWo1uGrq4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilzOV1A3F2QRmbN1OU3BXUycQ0Dzy57tCTawvc06FYuFgetzj8qVPWLpq2SBfRsPl
	 oeZ6TdS0vtUHGNbLAV6CsDwd/q2A4rumoEeQJn3YOOUG7jpBEFzc26+PRokaiZjiKX
	 Dq+XHE1u9RtcmLYnSny3WCvCmZSIDj1u/7rRRsT4=
Date: Wed, 9 Oct 2024 08:47:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: applicom: Remove redundant ret variable in ac_read
 function
Message-ID: <2024100923-scorecard-anemic-34fa@gregkh>
References: <20241009063219.6212-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009063219.6212-1-zhujun2@cmss.chinamobile.com>

On Tue, Oct 08, 2024 at 11:32:19PM -0700, Zhu Jun wrote:
> Removed the unused variable 'ret' from the ac_read function
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  drivers/char/applicom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
> index 9fed9706d9cd..17ff89b15f56 100644
> --- a/drivers/char/applicom.c
> +++ b/drivers/char/applicom.c
> @@ -539,7 +539,6 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
>  	unsigned long flags;
>  	unsigned int i;
>  	unsigned char tmp;
> -	int ret = 0;
>  	DECLARE_WAITQUEUE(wait, current);
>  #ifdef DEBUG
>  	int loopcount=0;
> @@ -570,7 +569,7 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
>  
>  				/* Got a packet for us */
>  				memset(&st_loc, 0, sizeof(st_loc));
> -				ret = do_ac_read(i, buf, &st_loc, &mailbox);
> +				do_ac_read(i, buf, &st_loc, &mailbox);
>  				spin_unlock_irqrestore(&apbs[i].mutex, flags);
>  				set_current_state(TASK_RUNNING);
>  				remove_wait_queue(&FlagSleepRec, &wait);
> -- 
> 2.17.1
> 

Is there some reason you are ignoring our emails?  I already responded
to this patch when you sent it yesterday, why did you send it again
today with only the subject line changed a tiny bit?

I think you need to work with someone else first to get some more
experience with kernel development before sending out any more changes,
as this is not an acceptable way to work with our community, sorry.

greg k-h

