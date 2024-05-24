Return-Path: <linux-kernel+bounces-188292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA408CE025
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131D6B21677
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E8364CD;
	Fri, 24 May 2024 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rQQKHt16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB628184F;
	Fri, 24 May 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523344; cv=none; b=fj0G5e1mNpv81CEGvmuJ7sZqGfheBp2W8F8JESJPhLs38DVJlW6Ei3hIyiOoVjo8dOFJnDeJd9Eo5qBTF8dXpwPILfQ9LUr9+29ngLQj1fYxjA+/B0fQtxykygMt/9VVV0u0zaZH0SQa8qYTP4I+OutT0EiZdFF7bjVfqdgy5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523344; c=relaxed/simple;
	bh=PuRdybGRW+yx7VLuctPEMVFa+vpcdBbxb3YeVtVOrs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lloBNmp8uvBNWp6yiQwELyaKYfXUSD+I9kH4GyKrZ67c62l8fKY1q2XBxW3lnmuKhNaHWaOwkLllxIuP653eIBkkfmc/g/QH2PgE19KDx4sQVQvfhpTEcgH5/6vs7gXLNda5e11zmUl+/zKHwjE6EEqRPBs1n3KQ2O0gf7fzWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rQQKHt16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E06C2BBFC;
	Fri, 24 May 2024 04:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716523343;
	bh=PuRdybGRW+yx7VLuctPEMVFa+vpcdBbxb3YeVtVOrs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQQKHt16pZUDbp0kwqbnR+DG+8feMo84fneb2ltP17ZRlLTY9/9C+OxQaPDI38Rpo
	 uQOEFO5sizjPxS/Zd8+s+Hlhd4eCBey8TzUnU1N2ZQHT2Db+zLFzl9ADCyt64BEKcy
	 L4I/F9MaRO+E7e/4ZmGtbfVKgFhZHQOMSRCW6NLQ=
Date: Fri, 24 May 2024 06:02:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Roshan Khatri <topofeverest8848@gmail.com>
Cc: tdavies@darkphysics.net, philipp.g.hortmann@gmail.com,
	garyrookard@fastmail.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: Fix spelling mistakes in
 rtllib_softmac.c
Message-ID: <2024052404-decipher-backlight-8498@gregkh>
References: <20240524035525.61072-1-topofeverest8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524035525.61072-1-topofeverest8848@gmail.com>

On Fri, May 24, 2024 at 09:40:24AM +0545, Roshan Khatri wrote:
> This patch corrects some misspellings to increase code readability and
> searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
> index 97fdca828da7..0fc97c868f81 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac.c
> @@ -421,7 +421,7 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee)
>  		 *    So we switch to MAC80211_LINKED_SCANNING to remember
>  		 *    that we are still logically linked (not interested in
>  		 *    new network events, despite for updating the net list,
> -		 *    but we are temporarly 'unlinked' as the driver shall
> +		 *    but we are temporarily 'unlinked' as the driver shall
>  		 *    not filter RX frames and the channel is changing.
>  		 * So the only situation in which are interested is to check
>  		 * if the state become LINKED because of the #1 situation
> @@ -934,7 +934,7 @@ static void rtllib_associate_abort(struct rtllib_device *ieee)
>  
>  	ieee->associate_seq++;
>  
> -	/* don't scan, and avoid to have the RX path possibily
> +	/* don't scan, and avoid to have the RX path possibly
>  	 * try again to associate. Even do not react to AUTH or
>  	 * ASSOC response. Just wait for the retry wq to be scheduled.
>  	 * Here we will check if there are good nets to associate
> @@ -1359,7 +1359,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
>  		return 0;
>  	timeout = ieee->current_network.beacon_interval;
>  	ieee->current_network.dtim_data = RTLLIB_DTIM_INVALID;
> -	/* there's no need to nofity AP that I find you buffered
> +	/* there's no need to notify AP that I find you buffered
>  	 * with broadcast packet
>  	 */
>  	if (dtim & (RTLLIB_DTIM_UCAST & ieee->ps))
> @@ -1806,7 +1806,7 @@ void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee)
>  
>  	spin_lock_irqsave(&ieee->lock, flags);
>  
> -	/* called with 2nd parm 0, no tx mgmt lock required */
> +	/* called with 2nd param 0, no tx mgmt lock required */
>  	rtllib_sta_wakeup(ieee, 0);
>  
>  	/* update the tx status */
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

