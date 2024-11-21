Return-Path: <linux-kernel+bounces-417592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAA89D5666
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5092FB24BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF541DED55;
	Thu, 21 Nov 2024 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1TeXAbXc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A131DED4B;
	Thu, 21 Nov 2024 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732232685; cv=none; b=eeQsojStD46C3dcrDV5Jj6CYiMa3j2RYOBOWQ4guq4PoI9SjD6tnU5SE+pzfddvQfdpRUtrAwUU9G6fwkZin74NKWGzjmfMgZ3iYvcXyqME5OXmme8XRMOxXwNkBU9xDBws3OZFUc7JPk9EZgBy2YtRFSbrtBBW0zk7leWn0cQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732232685; c=relaxed/simple;
	bh=jFzdPwj/6oVwYBRtFO5oaQqM6+nbohwp4izwYQoiQVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1jHsgU2Dse267Kd45UfPjU1ZxVjuu7H84iEMTVL2MPHPJklLq6ORpr7LH2ljEYNTLCrWYCU3inmzUaMg0t4Q/Bq3EBRiNvqiqcyCK1O1iCbZjOGDUHm1SZmUfBmdKnCO69tciHqeaHfx8MUas9eYPHEpdcUzVPAhVDa+n1m4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1TeXAbXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B1BC4CECC;
	Thu, 21 Nov 2024 23:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732232685;
	bh=jFzdPwj/6oVwYBRtFO5oaQqM6+nbohwp4izwYQoiQVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1TeXAbXcu9nriKPMZsQyAmMuTBrAeOHxq4gl6dJ0gQ3xp1Bs8LWsO59aSB+eI0lhz
	 qKuUVVqGNrwu5xpqJSRdAt0nGBU4jxpVOfh57kE/Z3TkBRr6BSO7FXA0IWFV8cnUuT
	 Cb3bzUdI4TMrz4Iw73jUtqw3M6Jgke7tomaQeaJs=
Date: Fri, 22 Nov 2024 00:44:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vyshnav Ajith <puthen1977@gmail.com>
Cc: corbet@lwn.net, linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Fixing Grammatical Error
Message-ID: <2024112255-grueling-glancing-2764@gregkh>
References: <20241121233829.14779-1-puthen1977@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121233829.14779-1-puthen1977@gmail.com>

On Fri, Nov 22, 2024 at 05:08:29AM +0530, Vyshnav Ajith wrote:
> 'Worst case' being singular needs 'is' instead of 'are'.
> 
> Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
> ---
>  Documentation/usb/dwc3.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/usb/dwc3.rst b/Documentation/usb/dwc3.rst
> index f94a7ba16573..12989d126a8a 100644
> --- a/Documentation/usb/dwc3.rst
> +++ b/Documentation/usb/dwc3.rst
> @@ -20,7 +20,7 @@ Please pick something while reading :)
>      to the device. If MSI provides per-endpoint interrupt this dummy
>      interrupt chip can be replaced with "real" interrupts.
>    - interrupts are requested / allocated on usb_ep_enable() and removed on
> -    usb_ep_disable(). Worst case are 32 interrupts, the lower limit is two
> +    usb_ep_disable(). The worst case is 32 interrupts, the lower limit is two
>      for ep0/1.
>    - dwc3_send_gadget_ep_cmd() will sleep in wait_for_completion_timeout()
>      until the command completes.
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

