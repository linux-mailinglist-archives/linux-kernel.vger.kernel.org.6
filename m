Return-Path: <linux-kernel+bounces-518765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B485A39421
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6962E1884E82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C21F6694;
	Tue, 18 Feb 2025 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r2FSChpU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D701F4E49;
	Tue, 18 Feb 2025 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865117; cv=none; b=jFkFQrn4G+GsgWVLHvTqo32/55YBUs7O+bjuMz1/aqq34L+qYqrLAKPFrCIVKitTNBooB5PPAHxKqvCt2dCixIxoNqm+z80RjzXqCWTLhA6sqSUGAFGBu50EVeJeKfRy+JJ3Y0dD+oP9VHwW6u/q011GPn2dZMnfVXGFNenG/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865117; c=relaxed/simple;
	bh=3o/gOUY/mIC3JcMktRnuy5fqJ0GT0HkmV+X+QyyKyuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvFEspKFHcWFkr9jieOZkLA1T/qLsn3EVrGJmL1Mp5emL+ua1D+ACXeMRsG6LccUwKrRU29aGFfpHJIYDRhTMF2nj0GxNePVyVrbcJPtJrM1v5ONH11xquFOGnLqJ3+r0phnAmXsgXz0Mf9Xz1VK84sJWhhDx0UnIeKb4D1zvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r2FSChpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07BAC4CEE2;
	Tue, 18 Feb 2025 07:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739865117;
	bh=3o/gOUY/mIC3JcMktRnuy5fqJ0GT0HkmV+X+QyyKyuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2FSChpUH3rGo2XG2/JFnoxn0xuSZZ7goC2aFfrpqvY4XmAUQZ+ewWa9dgxtFKJkK
	 6owKivq2BdqvwuuojqFcBJrqMyxfhapDk03/3XZEoSYH/bvWQp+HjGLh9d+4ITX0Cg
	 mwZMHSV5d9YyBkOp84+baFXWJOje3LE3wCSzvVHc=
Date: Tue, 18 Feb 2025 08:51:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, kuba@kernel.org, dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] staging:gpib:agilent_82350b.c: fixed a typo
Message-ID: <2025021838-pronto-good-d050@gregkh>
References: <20250217195050.117167-1-kumarkairiravi@gmail.com>
 <20250217195050.117167-2-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217195050.117167-2-kumarkairiravi@gmail.com>

On Tue, Feb 18, 2025 at 01:20:48AM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> from havn't -> haven't
> 
> Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> ---
>  drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> index 5c62ec24fc..5a74a22015 100644
> --- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> +++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> @@ -121,7 +121,7 @@ static int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_
>  	writeb(DIRECTION_GPIB_TO_HOST, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
>  	if (retval < 0)
>  		return retval;
> -	// read last bytes if we havn't received an END yet
> +	// read last bytes if we haven't received an END yet
>  	if (*end == 0) {
>  		size_t num_bytes;
>  		// try to make sure we holdoff after last byte read
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

