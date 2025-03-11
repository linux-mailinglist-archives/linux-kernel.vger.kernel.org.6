Return-Path: <linux-kernel+bounces-556613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABD7A5CC57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F63B5129
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A42620E5;
	Tue, 11 Mar 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ojTrRDoo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D702E1EB5E7;
	Tue, 11 Mar 2025 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714600; cv=none; b=sLE+01JouHhYtv4aqniBTq6/RwuyHgnJmmHl7Kf9SHvQ8hy2l50k2uEcF2/hh4lpw9czZbnSvwzC6YJiv8sv3ExacK858M6IYy9w2jc2awpUCkoM9EogIV0wZVZ/SOLkGG+zrSHpVouY4ASUyUB6BsY6IQGk+OKWc6ngVMAHhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714600; c=relaxed/simple;
	bh=Upf2eyD1OvYuj+z2ZLiUjkVaA3b7XtDSb9cBpeAfsMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiWMNPm3BQ66+DAK2nLBK0WCB1YHVPnBuyrifKWXW8LJAfm3dDHATTg5SziNdN+w+0kyUw54+iKahLMPHXzd7pX9hoey4WTfHh22H8ps9o8XVr5wUVcsHTeDOPVJeClQmanB3Vg+BVqzYH3BLJXLXRZFxKA22EFoi4N0/YfRZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ojTrRDoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47ABC4CEE9;
	Tue, 11 Mar 2025 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741714600;
	bh=Upf2eyD1OvYuj+z2ZLiUjkVaA3b7XtDSb9cBpeAfsMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojTrRDoo+i5XTjAm8Cn8HbC6VoulsrS/f9bUgv9VE/Ms3lM/65udTntwgSnbXINyZ
	 uK4U+zEXQRM2WQf4mqIfb5uD7cIcwBNg+jfR8CbSqhJH+oYdohOMwTKe4STDVShRI/
	 kdZAOm932ORORn2oBO6p1IrbxgP6mhnomCFA+UTE=
Date: Tue, 11 Mar 2025 18:36:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suraj Patil <surajpatil522@gmail.com>
Cc: oneukum@suse.com, stern@rowland.harvard.edu, viro@zeniv.linux.org.uk,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdc-wdm: Fix typo in comment
Message-ID: <2025031124-unroll-wife-8844@gregkh>
References: <20250311171633.469024-1-surajpatil522@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311171633.469024-1-surajpatil522@gmail.com>

On Tue, Mar 11, 2025 at 05:16:33PM +0000, Suraj Patil wrote:
> cdc-wdm: Fix typo in comment
> 
> Corrected 'interferring' to 'interfering' in a comment
> to improve readability and maintain code quality.
> No functional changes.
> 
> Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
> ---
>  drivers/usb/class/cdc-wdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
> index 86ee39db013f..c5123db416fa 100644
> --- a/drivers/usb/class/cdc-wdm.c
> +++ b/drivers/usb/class/cdc-wdm.c
> @@ -1181,7 +1181,7 @@ static int wdm_probe(struct usb_interface *intf, const struct usb_device_id *id)
>   *
>   * The subdriver will manage the given interrupt endpoint exclusively
>   * and will issue control requests referring to the given intf. It
> - * will otherwise avoid interferring, and in particular not do
> + * will otherwise avoid interfering, and in particular not do
>   * usb_set_intfdata/usb_get_intfdata on intf.
>   *
>   * The return value is a pointer to the subdriver's struct usb_driver.
> -- 
> 2.43.0
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

