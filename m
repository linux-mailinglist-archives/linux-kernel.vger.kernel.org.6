Return-Path: <linux-kernel+bounces-259206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC0939296
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567CD1F232C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F15916EB6D;
	Mon, 22 Jul 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Webi8DPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6E26ACD;
	Mon, 22 Jul 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665978; cv=none; b=dMIf6cqAZW3ySEAGiVJawDm6t7rJMohUl88Bm8VEDU1UPcSgKzt2KouSElZgGvGVusrJ/6DREPLuDQOVDHypI4H4mZmB1d4l9Y9PplpuhitldmB32nCOgGUq2JHXa0E2ZJppWN6rJwzS687XioBSuHB3Z+gvzepubjag6sB6GJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665978; c=relaxed/simple;
	bh=1M0mxD+ofI58h7xIrBA0625MaIsQLwX633kvF94BbAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asx/yIihE8LvKpTWvPm6Ujj8PQ5/JA1u6Ybta1CMSZo63oAWgqhMlZflmO6EWrO3ZkbXAcyGcKwwq6ql2ZUC7ALf4GesYLzA053bY/lUzy7DI9UYDLBBq8fSg4xCkvO4+oAw/8obPVVxWNLFFt//psQYWgjXiVsDjj8eMIrc1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Webi8DPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8461C116B1;
	Mon, 22 Jul 2024 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721665978;
	bh=1M0mxD+ofI58h7xIrBA0625MaIsQLwX633kvF94BbAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Webi8DPCmkZgw1wCJHxOwfIBke6hMiuFL+GejK9m6v9M21aYb0GLxAxSFZYOBVS2b
	 HAtFHnDhLGouECdKRv8B2MM8XhWkWeFgqJ79xErEOCVXoqhpJZAqIo0NZADBUAELIb
	 wX8LXiYxNxDRqFa37vWdTGgDmHXSVhPW4J8FuSn8=
Date: Mon, 22 Jul 2024 18:32:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aurelio Mannara <aurelio.mannara@gmail.com>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Added support for Silicon Labs Phoenix Contact UPS
 Device Silicon Labs Phoenix Contact UPS Device VID/PID pair has been added
 to CP210x driver in order for the OS to properly detect it
Message-ID: <2024072228-cosmos-portion-f842@gregkh>
References: <CAM-gfB_v9m3j2v0u+8M8fr54z_ka-3XFQep31uTRtdUre2a8_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM-gfB_v9m3j2v0u+8M8fr54z_ka-3XFQep31uTRtdUre2a8_g@mail.gmail.com>

On Mon, Jul 22, 2024 at 05:19:51PM +0200, Aurelio Mannara wrote:
> ---
>  drivers/usb/serial/cp210x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 21fd26609252..a3b931441557 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -254,6 +254,7 @@ static const struct usb_device_id id_table[] = {
>   { USB_DEVICE(0x3195, 0xF281) }, /* Link Instruments MSO-28 */
>   { USB_DEVICE(0x3923, 0x7A0B) }, /* National Instruments USB Serial
> Console */
>   { USB_DEVICE(0x413C, 0x9500) }, /* DW700 GPS USB interface */
> + { USB_DEVICE(0x1b93, 0x1013) }, /* Silicon Labs Phoenix Contact UPS
> Device */
>   { } /* Terminating Entry */
>  };
> 
> --

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

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

