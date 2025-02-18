Return-Path: <linux-kernel+bounces-518767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE08A39424
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F3C1884BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE21F6664;
	Tue, 18 Feb 2025 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yekH2BkT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E51F63D5;
	Tue, 18 Feb 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865131; cv=none; b=XrqNta4N4QFqI5tkAT2jdsYcbcDJ6lKGyOgUG4BFafVXGGHKNCrw9jrUps5WbWooHjEHzOndL12EweqGu8l5PQd5pHHCwQzh4Xo/aV3ORZ5gujzqEyACJUp7MZoVOTyWdnLpTl7ZQqIJKfZ4UwncZEh9U06HqnaTVCecNcf/xs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865131; c=relaxed/simple;
	bh=xr47Rx2Y5giue5IqVLZC1ffWnY4G5fT1fAlGY+EUzVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMQ7qA/m7uf2rU8K5UE8tXO5e1GkYQ3goaumj/a3GyjsSBay7wZGyMC0plgEA4XI4z4XaX5Gr3gOWRjtCypyIF245UoADRkt+rbHcfvfx2KduIzEYl6FohGY8ez0IWw033NwvDPmafxww9lszG1fBa++JzAR2H8tR20VUR7pj8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yekH2BkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1D0C4CEE2;
	Tue, 18 Feb 2025 07:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739865129;
	bh=xr47Rx2Y5giue5IqVLZC1ffWnY4G5fT1fAlGY+EUzVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yekH2BkTkDAEkkkDfS6kVxnU/1xAI9IK8a9iPxLXHgOaUoFl+WBg9Pj2lXNv+yhss
	 x7Bz7iQysvj3eZZNG9LUaxw1hU7VefYFsojKZdyW1zBqUHvCvqpaMdcb0YLJqgtnJz
	 2jgRTFVo2aTYMJXZV67Z37ULNWXIVLtsAijR83UA=
Date: Tue, 18 Feb 2025 08:52:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, kuba@kernel.org, dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] staging:gpib:agilent_82350b.c: removed braces
 from a single if statement
Message-ID: <2025021803-fled-handwoven-0efd@gregkh>
References: <20250217195050.117167-1-kumarkairiravi@gmail.com>
 <20250217195050.117167-4-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217195050.117167-4-kumarkairiravi@gmail.com>

On Tue, Feb 18, 2025 at 01:20:50AM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> removed brances from a single line od 'if' block
> 
> Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> ---
>  drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> index af1bf6e893..0c07745649 100644
> --- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> +++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> @@ -205,9 +205,8 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  		}
>  		writeb(ENABLE_TI_TO_SRAM, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
>  
> -		if (agilent_82350b_fifo_is_halted(a_priv)) {
> +		if (agilent_82350b_fifo_is_halted(a_priv))
>  			writeb(RESTART_STREAM_BIT, a_priv->gpib_base + STREAM_STATUS_REG);
> -		}
>  
>  		retval = wait_event_interruptible(board->wait,
>  						  ((event_status =
> -- 
> 2.48.1
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

