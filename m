Return-Path: <linux-kernel+bounces-539827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9764DA4A97C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9ACD1899E00
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87801C4A24;
	Sat,  1 Mar 2025 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nqKc36wq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF771BE238
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740814381; cv=none; b=KsXpVPkunjDETLO6c6ihxpAdYq8OnG1fuE00pBOx1LVaxfoQ0nthIYn0IbfhF5mKv5CgcsggzIzRC5Ym644VFDL452EMqYa1exkCRdCNiBFZItxqdR1oQuMw4Vmum+Dh47seBElKgr+pQXlx3+HZgsxhHV60QEqH5+A17JiyA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740814381; c=relaxed/simple;
	bh=p6Ht7LrDu3zIAKnUUfDDAnpyS+p8bhA2hF1WLWWNJS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5cWl/h2u6/RBCE3XUQm/wU2LSxSkcaVEBfknLYSULLNDahP3pbaLgTH3yUb3s+JVNQKr3Ug09FJh9bBnvLwlH2BW34n0wur1nDtR9hpEHVg56/CNRz0fRU9QvPbH20Q0JQJ4p1PRO/Jebq8YL64IkGsXo89byeWab9U77K2VYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nqKc36wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A2BC4CEDD;
	Sat,  1 Mar 2025 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740814379;
	bh=p6Ht7LrDu3zIAKnUUfDDAnpyS+p8bhA2hF1WLWWNJS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqKc36wq6998V0P3tcNXmyU6s/lDiht/pduK2Izl79WMTNgFMtG1kIWq2hew9SDC2
	 xWPUVHUPSO4N77pIChLmTZl8bNBIo7a/X92sHHe1+pn5vUnkxWc16M3gNZX8MXDQ/z
	 bhBF161ibrjZoHEQknluiHf+dtjWZga0Y7aiMWlk=
Date: Fri, 28 Feb 2025 23:31:46 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: ayaanmirza85@gmail.com, dakr@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers/base: fix checkpatch.pl warnings in
 attribute_container.c (v2)
Message-ID: <2025022827-gesture-matted-d400@gregkh>
References: <2025022606-carrousel-unstable-f2f3@gregkh>
 <20250227124417.132020-3-ayaanmirzabaig85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227124417.132020-3-ayaanmirzabaig85@gmail.com>

On Thu, Feb 27, 2025 at 06:11:28PM +0530, Ayaan Mirza Baig wrote:
> This patch applies only cosmetic changes such as
> whitespace fixes, formatting and typos. These
> changes are flagged by checkpatch.pl
> 
> Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> ---
>  drivers/base/attribute_container.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
> index b6f941a6ab69..69637b2ec3bc 100644
> --- a/drivers/base/attribute_container.c
> +++ b/drivers/base/attribute_container.c
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
>   *
>   * The basic idea here is to enable a device to be attached to an
> - * aritrary numer of classes without having to allocate storage for them.
> + * aritrary number of classes without having to allocate storage for them.
>   * Instead, the contained classes select the devices they need to attach
>   * to via a matching function.
>   */
> @@ -21,7 +21,8 @@
>  #include "base.h"
>  
>  /* This is a private structure used to tie the classdev and the
> - * container .. it should never be visible outside this file */
> + * container .. it should never be visible outside this file
> + */
>  struct internal_container {
>  	struct klist_node node;
>  	struct attribute_container *cont;
> @@ -449,7 +450,7 @@ attribute_container_remove_attrs(struct device *classdev)
>  
>  	if (cont->grp) {
>  		sysfs_remove_group(&classdev->kobj, cont->grp);
> -		return ;
> +		return;
>  	}
>  
>  	for (i = 0; attrs[i]; i++)
> -- 
> 2.47.1
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

