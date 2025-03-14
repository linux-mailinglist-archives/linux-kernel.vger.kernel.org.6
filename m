Return-Path: <linux-kernel+bounces-560925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4ABA60B19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7507919C1AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B726E1A254E;
	Fri, 14 Mar 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UcvFpkS0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B19EAD7;
	Fri, 14 Mar 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940390; cv=none; b=YsvLvSnBXM3PY17ODbJt+bjwQabF2v97FxUS4QTz1H/zzCPqV5t3T6oLMVEXjRsPmPCbeK23/rqTPM63zlTYPJyXbtSNnpGfBEAf8VbAjHbK52SKj6ajQabgh48ZOplVycoT070s21uLW1ncuADgstExVkM2pxZf+cpayv+rkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940390; c=relaxed/simple;
	bh=kdFwwWX7uw9irI3XUeb7K1Tm67CdTCvgOj59eYAoB+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDPs7b5XYvfZQFzefDaEKYE2X77UVD3/KbmTrDqqRxeM4F2oTFJOwdNtHvIpZf0ut3NBy/+/2suV8DzIJ8DgmGMenUc/kc8TsPtf5m11O7kvp/ty8dYgpbsZ0hqXqdGppxxfjOBbV3R+wKP6Jnu15Cp+bGqdO1XjdTkHKsNCu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UcvFpkS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFCAC4CEE3;
	Fri, 14 Mar 2025 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741940389;
	bh=kdFwwWX7uw9irI3XUeb7K1Tm67CdTCvgOj59eYAoB+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcvFpkS0poDhkXhpSzSyE7nwPlSeWDphVaJCLDBBr/DPFKJ0ZRKLDVyCvkijUzcaz
	 aaDAc9hg7htE0YsnUhQ+0tXs3C/3LCQflA6IMamcPnkmQjE5JfcXagwSQe9KSa4h7J
	 CLjzfsM3JgdzoGurVUvaaqdX13++ymgVUq1vHNvA=
Date: Fri, 14 Mar 2025 09:19:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Li Qiong <liqiong@nfschina.com>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: cdns3: Remove the invalid comment
Message-ID: <2025031435-candy-tacking-1c7a@gregkh>
References: <20250314070921.355986-1-liqiong@nfschina.com>
 <20250314080249.469307-1-liqiong@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314080249.469307-1-liqiong@nfschina.com>

On Fri, Mar 14, 2025 at 04:02:48PM +0800, Li Qiong wrote:
> The function don't return value, remove the invalid comment.
> 
> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> ---
>  drivers/usb/cdns3/cdns3-plat.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> index 59ec505e198a..735df88774e4 100644
> --- a/drivers/usb/cdns3/cdns3-plat.c
> +++ b/drivers/usb/cdns3/cdns3-plat.c
> @@ -179,8 +179,6 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>  /**
>   * cdns3_plat_remove() - unbind drd driver and clean up
>   * @pdev: Pointer to Linux platform device
> - *
> - * Returns 0 on success otherwise negative errno
>   */
>  static void cdns3_plat_remove(struct platform_device *pdev)
>  {
> -- 
> 2.30.2
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

