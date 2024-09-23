Return-Path: <linux-kernel+bounces-335465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8997E625
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DA21C20BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B55A28689;
	Mon, 23 Sep 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQeeQClr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26279E1;
	Mon, 23 Sep 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074041; cv=none; b=Onoh9i3N/W2M35nStKqBXKP6HyGKwzATNKaNvU+fKCTFcBFAiRJJrHYJgN3w2N02t+AOhTaUzOytKjHonYTlVJNQQHjbWgfomXiGHz2xCwR58g/105deWxN/8Ho9+83x0eftKJnkx5u+u7XxFD7vH7LhTKr6hyvtv6I+/AHPPqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074041; c=relaxed/simple;
	bh=53iniC7jI02cR162zTnFckidMsqxose3NiwOriwcVZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAlU2NiO4eQN/SExb0cndaEJkuYDbJbbUJlt8EsrY8Y5jy55q/I2p6oBnSh5wE9vcyi1iXIILzt0eRs+ZcH2LvN361QM6rSnO3rX9/Ey6TAND2nLGVs8AcWHo4Qcb/5EN6fGs/B1yxROqgewWzpGMXhIXDRKZ0hYK9sU98dNs/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQeeQClr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35F2C4CEC4;
	Mon, 23 Sep 2024 06:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727074041;
	bh=53iniC7jI02cR162zTnFckidMsqxose3NiwOriwcVZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQeeQClr/BBgvyo/Ji0tn0tW0hsufiBP4EhUCT9VIAOMFDNAhf4McgGarIULwJI7O
	 Y0As20YJ+BiUV/735ESUgMLMti8hl+6Wx3IC1BHgdZzs09+YeGDRCo9tRF/h7f50LP
	 /hRD/Hn4xbDvcG0J6nuoOpEDE91xwrC86stpgwnE=
Date: Mon, 23 Sep 2024 08:47:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: amin-amani <didi1364@gmail.com>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: digi_acceleport: Enhance error handling by
 checkpatch.pl
Message-ID: <2024092347-expansive-thrower-b40a@gregkh>
References: <20240922211512.49273-1-didi1364@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922211512.49273-1-didi1364@gmail.com>

On Mon, Sep 23, 2024 at 12:45:12AM +0330, amin-amani wrote:
> - Separated null checks for port, serial and private data.
> 
> Signed-off-by: amin-amani <didi1364@gmail.com>
> ---
>  drivers/usb/serial/digi_acceleport.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

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

