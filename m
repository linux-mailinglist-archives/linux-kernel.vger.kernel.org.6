Return-Path: <linux-kernel+bounces-247147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011A92CBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04F9B22313
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7988249A;
	Wed, 10 Jul 2024 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qu5nYKVG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894129AB;
	Wed, 10 Jul 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596283; cv=none; b=owYOECjNwaJWuRbwACogpUKMIkL9c8qHNPvkAloLTlQ6EnpqUEwkH1rc71AmLJKSzpXZrHarbJwv9Soju+VbFG1rDCbF7f1tsAelteDVIF6D9mxYvShtkYsohpJnzUmx5Y6WjmgPJdwreMMW2fsMHu/lpJRHQK+wStG3xLNQEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596283; c=relaxed/simple;
	bh=TUKbp393zKXDg0C9xynQbJ5WMtNpOy7+0fBYrg7+uwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdxXn5w71nx1atW0sh/ZQgdEG0J0zpDhQKPgzYylOrP5ojJwcqgk/KYXyWIovgdMnS26Oog3xnWsiYYAuW/dc/XxA447zO6XLWXvanyo2MkiwCjbiI0sx7o34W4OWfjwutLCjeKCkgGZOrEdlOZcihyCZqAupLGxWkT27IvwJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qu5nYKVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2F4C32781;
	Wed, 10 Jul 2024 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720596282;
	bh=TUKbp393zKXDg0C9xynQbJ5WMtNpOy7+0fBYrg7+uwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qu5nYKVGGWqNZD4N0nidCbFeLW1UQHYBInc61br9mthg+FOrd8xpQxdsCmhwMQJOn
	 OaEvoH4UmNX98X/sRWLM2HKnW30Q7KIG0l4IevpR1Yxw+2lWhTClnGnb4gV8391SDx
	 D3wdNPwqGLum06rlC4r5eRfLBpYPlF8uWts4IKzI=
Date: Wed, 10 Jul 2024 09:24:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tyler Taormina <taormina.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Remove redundant parentheses
Message-ID: <2024071015-sash-flyaway-321c@gregkh>
References: <Zo2MTjKCM_UaLIGx@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo2MTjKCM_UaLIGx@localhost.localdomain>

On Tue, Jul 09, 2024 at 12:15:26PM -0700, Tyler Taormina wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: Unnecessary parentheses around (...)
> 
> Signed-off-by: Tyler Taormina <taormina.dev@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 0cd370ab1008..5c1d1c9b7b70 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -274,7 +274,7 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
>  		mutex_lock(&slave_image->mtx);
>  		if (((slave_image->address_attr & address) == address) &&
>  		    ((slave_image->cycle_attr & cycle) == cycle) &&
> -		    (slave_image->locked == 0)) {
> +		    slave_image->locked == 0) {
>  			slave_image->locked = 1;
>  			mutex_unlock(&slave_image->mtx);
>  			allocated_image = slave_image;
> @@ -473,7 +473,7 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
>  		if (((master_image->address_attr & address) == address) &&
>  		    ((master_image->cycle_attr & cycle) == cycle) &&
>  		    ((master_image->width_attr & dwidth) == dwidth) &&
> -		    (master_image->locked == 0)) {
> +		    master_image->locked == 0) {
>  			master_image->locked = 1;
>  			spin_unlock(&master_image->lock);
>  			allocated_image = master_image;
> @@ -849,7 +849,7 @@ struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route)
>  		/* Find an unlocked and compatible controller */
>  		mutex_lock(&dma_ctrlr->mtx);
>  		if (((dma_ctrlr->route_attr & route) == route) &&
> -		    (dma_ctrlr->locked == 0)) {
> +		    dma_ctrlr->locked == 0) {
>  			dma_ctrlr->locked = 1;
>  			mutex_unlock(&dma_ctrlr->mtx);
>  			allocated_ctrlr = dma_ctrlr;
> @@ -1218,9 +1218,9 @@ void vme_bus_error_handler(struct vme_bridge *bridge,
>  	u32 aspace = vme_get_aspace(am);
>  
>  	list_for_each_entry(handler, &bridge->vme_error_handlers, list) {
> -		if ((aspace == handler->aspace) &&
> -		    (address >= handler->start) &&
> -		    (address < handler->end)) {
> +		if (aspace == handler->aspace &&
> +		    address >= handler->start &&
> +		    address < handler->end) {
>  			if (!handler->num_errors)
>  				handler->first_error = address;
>  			if (handler->num_errors != UINT_MAX)
> @@ -1307,7 +1307,7 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
>  		return -EINVAL;
>  	}
>  
> -	if ((level < 1) || (level > 7)) {
> +	if (level < 1 || level > 7) {
>  		dev_err(bridge->parent, "Invalid interrupt level\n");
>  		return -EINVAL;
>  	}
> @@ -1357,7 +1357,7 @@ void vme_irq_free(struct vme_dev *vdev, int level, int statid)
>  		return;
>  	}
>  
> -	if ((level < 1) || (level > 7)) {
> +	if (level < 1 || level > 7) {
>  		dev_err(bridge->parent, "Invalid interrupt level\n");
>  		return;
>  	}
> @@ -1405,7 +1405,7 @@ int vme_irq_generate(struct vme_dev *vdev, int level, int statid)
>  		return -EINVAL;
>  	}
>  
> -	if ((level < 1) || (level > 7)) {
> +	if (level < 1 || level > 7) {
>  		dev_warn(bridge->parent, "Invalid interrupt level\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.39.2
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

- You sent a patch that has been sent multiple times in the past, and is
  identical to ones that has been rejected.  Please always look at the
  mailing list traffic to determine if you are duplicating other
  people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

