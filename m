Return-Path: <linux-kernel+bounces-269531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EBD9433E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB1D1C220E3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE31BBBE7;
	Wed, 31 Jul 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DCqv1JvG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0701B29A7;
	Wed, 31 Jul 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442241; cv=none; b=JjT8kEqTmQR2qYYY34wKQPlzorVmLr3+3vmWaWA2xoEGTdn37DUFh1jIsB2BU+LLEWf5wFhcDkXvum4tXc2NOYXzCl3uR3na3mXM9PvG7vKJxiQYHK65uUYj+3rj78+LZ5sFBXV9PLIpXSbAST6JjDlXWzbmE7etFfJDRkKOMJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442241; c=relaxed/simple;
	bh=VeBZHTZ9MWthhdznTxC81hf76FdhTqXK3UXAPLv2cyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXGE/wwg/KbUVVRKLQIW33LjigtUusDV2WJGw9SESroImoGfJYY5iwvUC1pQzjYPvyjkZpLHPgjR1M7jp4rKT8LfqWXPhFsLOK/yS3DPAdtkahIEL0zv+XliRn6JtjIQcVrGbdTDl2Lbkc69mkH+zf9uWUlnavAWkoAAjYESYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DCqv1JvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B283C116B1;
	Wed, 31 Jul 2024 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722442240;
	bh=VeBZHTZ9MWthhdznTxC81hf76FdhTqXK3UXAPLv2cyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCqv1JvGal0RNE82tOEkNwOb7cQBjQzbhORx8zYX1wTBiy3Q3bwZxXToxkwwKsyfz
	 N385rDmnYB/SfTd8gS8U3r18Sp/dI7TvSQ9sms7P8oosaqHYqE9yCqgbcCkAB6LdrM
	 vWuu91/7L++WoZTcUjbOQtDpT8iXT5CTLdfUW9oA=
Date: Wed, 31 Jul 2024 18:10:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: EiPiFun <me@eipi.fun>
Cc: linux-staging <linux-staging@lists.linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] code indent,
 drivers/staging/rtl8723bs/include/rtw_security.h
Message-ID: <2024073104-friction-conjoined-c34a@gregkh>
References: <tencent_55ECF7AA38FD93254C1B7BF2@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_55ECF7AA38FD93254C1B7BF2@qq.com>

On Thu, Aug 01, 2024 at 12:52:54AM +0900, EiPiFun wrote:
> From 816921cbfa76a1cfd0cb1ca93a9df0f2a429bc3a Mon Sep 17 00:00:00 2001
> From: EiPi Fun <me@eipi.fun&gt;
> Date: Tue, 30 Jul 2024 07:28:38 +0000
> Subject: [PATCH] code indent should use tabs where possible
> 
> ---
> &nbsp;drivers/staging/rtl8723bs/include/rtw_security.h | 4 ++--
> &nbsp;1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h
> b/drivers/staging/rtl8723bs/include/rtw_security.h
> index c3e47d526..89c1d5ae1 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> @@ -75,8 +75,8 @@ struct {
> &nbsp;};
> &nbsp;
> &nbsp;union Keytype {
> -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8&nbsp;&nbsp; skey[16];
> -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; lkey[4];
> +	u8&nbsp;&nbsp; skey[16];
> +	u32&nbsp;&nbsp;&nbsp; lkey[4];
> &nbsp;};
> &nbsp;
> &nbsp;
> -- 
> 2.20.1

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

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

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

- It looks like you did not use your name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

