Return-Path: <linux-kernel+bounces-522971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05978A3D0AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E94E18980E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678C19007D;
	Thu, 20 Feb 2025 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kJyI91oN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D662AD16
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740028577; cv=none; b=hdlCnOjFB16/mQ8byEZssEQKJkAMqDsJsXZHzU5Opcv5k1gDYmB7FzrZjP2Av/2a6FHt+P4syxTfBJAOiGG1cxn1qfB2Gyqb68mqdZJTc4S+1Jmx+RdMsJbrKLR8gv2m1jPNPA10dOxyld9/E+0TB4GQn0MEOEOM/n3JoqstWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740028577; c=relaxed/simple;
	bh=sQSfM4UIvI/WWiNjXD7va01EmRTY8o98hV7ZKJoRxNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjBKKzA7V2n4OF+IuIfXpbFbYihkeqhoQY3/fmty/EmA3+vEURIyxSUFuNLwJggAG1wTAhWMSchbQ4C4NjR4/SbjJug/pGE+vdJADwGv1wKdLLSKddz0YT+N4qOlLJjm/x5ZeaHfjcDoyo93VGmYiG+IGq3Aquls0rg2DvbEyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kJyI91oN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC85C4CED1;
	Thu, 20 Feb 2025 05:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740028573;
	bh=sQSfM4UIvI/WWiNjXD7va01EmRTY8o98hV7ZKJoRxNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJyI91oNPkTzQPIYBcob1PsqP7cQlOBtseIASALYw9S1yFJaAaisUafPMxt8JtJCc
	 7+L8S5vCGoGkyrgHyfWF9LE9NxXzMokxQNqq6mNcI6iimxztsTvYLAsFwoZPddFf50
	 WiHDXf54DMljm9qHKOXrfhwDz8+HLgky4amZrzT4=
Date: Thu, 20 Feb 2025 06:16:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suraj Patil <surajpatil522@gmail.com>
Cc: linux-kernel@vger.kernel.org, jirislaby@kernel.org
Subject: Re: [PATCH] gpio: max732x: Remove deprecated irq_base assignment
Message-ID: <2025022049-pout-garter-23d2@gregkh>
References: <20250219192426.164654-1-surajpatil522@gmail.com>
 <20250219192426.164654-2-surajpatil522@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219192426.164654-2-surajpatil522@gmail.com>

On Wed, Feb 19, 2025 at 07:24:25PM +0000, Suraj Patil wrote:
> Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
> ---
>  drivers/gpio/gpio-max732x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
> index 49d362907bc7..bc30cb57e222 100644
> --- a/drivers/gpio/gpio-max732x.c
> +++ b/drivers/gpio/gpio-max732x.c
> @@ -525,7 +525,7 @@ static int max732x_irq_setup(struct max732x_chip *chip,
>  		girq->default_type = IRQ_TYPE_NONE;
>  		girq->handler = handle_simple_irq;
>  		girq->threaded = true;
> -		girq->first = irq_base; /* FIXME: get rid of this */
> +		/* FIXME: get rid of this */
>  	}
>  
>  	return 0;
> -- 
> 2.43.0
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

