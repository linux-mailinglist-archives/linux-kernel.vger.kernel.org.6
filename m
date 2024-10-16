Return-Path: <linux-kernel+bounces-367859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8833B9A07B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C731C2715F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E16206940;
	Wed, 16 Oct 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oO1aXe5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882318E054;
	Wed, 16 Oct 2024 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075576; cv=none; b=oWdL6mFhqGxE+9Cfla4GA53/KDTmMB1SZ4QGvtmIHT5gjUvV+4dNJSSfk4rW1Dqf2clxhxGH7M9JSL2xDlcwx/w475zfmfPS0Uae5pDITWoYlsP4xJb3JivNlaHw7PaJAs3zMEUeZNIl2QDe03M7J7CX/Gu7YJZD+D5IplJzV2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075576; c=relaxed/simple;
	bh=dYQ6TAiu5IBqMOGhNq+sPsALj2j33/pOt4MWJ2/onjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET336kdcodE5peHAPCic96mO2amp02AKRfhYLOojIn4eFaCjdaHABJ954LU4d7GUVFYkmpwr+wNgqzZEtrhmR6hnY6C5DquFCLrjl4ZQlyw6IFDFUSAS6F13uoVMxT9W9m0Ed1xHYfyM1zNAQb3BbW01yacxXqibaNdaDa1zOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oO1aXe5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA96C4CECD;
	Wed, 16 Oct 2024 10:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729075575;
	bh=dYQ6TAiu5IBqMOGhNq+sPsALj2j33/pOt4MWJ2/onjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oO1aXe5lnTLfvJnWHbY7ipuZ6d1p/R5wdrIB1qIq2Yr3fq1023uraFg6T94qWW89X
	 K8nzUmtKTN9ZzyoQSYtMSY87AuwMM0j7kZpqHWZkdipet6MKqbXXwSBMJ6istu99+j
	 8BLoHlJqdvlyN54vdzv3qH/QX2uY51+zMYLglOAk=
Date: Wed, 16 Oct 2024 12:46:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Dave Penkler <dpenkler@gmail.com>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gpib: Remove unneeded semicolon.
Message-ID: <2024101659-camcorder-stuffy-ca30@gregkh>
References: <20241016100914.1617475-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016100914.1617475-1-roheetchavan@gmail.com>

On Wed, Oct 16, 2024 at 03:39:14PM +0530, Rohit Chavan wrote:
> This patch cleans up the GPIB driver by removing unneeded semicolons.
> 
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
>  drivers/staging/gpib/tms9914/tms9914.c | 4 ++--
>  drivers/staging/gpib/tnt4882/mite.c    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
> index aa2308cf5477..6d75294412d8 100644
> --- a/drivers/staging/gpib/tms9914/tms9914.c
> +++ b/drivers/staging/gpib/tms9914/tms9914.c
> @@ -439,7 +439,7 @@ static int wait_for_read_byte(gpib_board_t *board, struct tms9914_priv *priv)
>  				     test_bit(TIMO_NUM, &board->status))) {
>  		pr_debug("gpib: pio read wait interrupted\n");
>  		return -ERESTARTSYS;
> -	};
> +	}
>  	if (test_bit(TIMO_NUM, &board->status))
>  		return -ETIMEDOUT;
>  
> @@ -473,7 +473,7 @@ static inline uint8_t tms9914_read_data_in(gpib_board_t *board, struct tms9914_p
>  	default:
>  		pr_err("%s: bug! bad holdoff mode %i\n", __func__, priv->holdoff_mode);
>  		break;
> -	};
> +	}
>  	spin_unlock_irqrestore(&board->spinlock, flags);
>  
>  	return data;
> diff --git a/drivers/staging/gpib/tnt4882/mite.c b/drivers/staging/gpib/tnt4882/mite.c
> index adb656a5eb2c..882cc4bc122e 100644
> --- a/drivers/staging/gpib/tnt4882/mite.c
> +++ b/drivers/staging/gpib/tnt4882/mite.c
> @@ -82,7 +82,7 @@ int mite_setup(struct mite_struct *mite)
>  	if (pci_request_regions(mite->pcidev, "mite")) {
>  		pr_err("mite: failed to request mite io regions.\n");
>  		return -EIO;
> -	};
> +	}
>  	addr = pci_resource_start(mite->pcidev, 0);
>  	mite->mite_phys_addr = addr;
>  	mite->mite_io_addr = ioremap(addr, pci_resource_len(mite->pcidev, 0));
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

