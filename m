Return-Path: <linux-kernel+bounces-200526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD8C8FB145
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE481C22180
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD861459E2;
	Tue,  4 Jun 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PKE7NdH8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF3738B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501265; cv=none; b=A99ns2CMvPqhbtdkmzVV0uVJDTrkQ41B/BDRReJOV8ul5QijVO2midnmAuRaQbg/eEHh73seguTnzU7hCR3+w+LgWHI/aRaz9ODnR0SLN/Xwy0jXmJl8be1yUrou83K7yjZOuB3Rc89aN5NtcP/pg9pPR1dOi4tVPqlyce4Snw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501265; c=relaxed/simple;
	bh=WN2C4UW3o4LE/TxurRuwC+WV2zLD7L9yVvWJwyrwmcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMU/A8siSAF8y3p9Tsd80Qmq/Kp4MWSGnn1DnHbW9c3JpYOedCi7M6X7XXj+1tVyrEk/xrQ7kSIHhA8ONBP9d8HD+sz/R5nAJPWzfPEmxD+G6gwcx59W0TbazMpIGoQc2J1jPKYSnppRQg0oNOPEqlDkwXO0Tk2qSpg6iG1Hxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PKE7NdH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BC2C2BBFC;
	Tue,  4 Jun 2024 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717501265;
	bh=WN2C4UW3o4LE/TxurRuwC+WV2zLD7L9yVvWJwyrwmcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKE7NdH8/33CImJI9qBCoq1xAn4v4f8cytlYtTrfzysfQskPIC+6EOJmgjgckI0IX
	 EAbXYcrQDtxM0CKfbwF3vZRnwxh9BeDPilQt2lpZRDR5EyxYVcOCX89/9cF1Bk52vk
	 tIBbvdHT2gmWARZb7smAOL7W/Eql8vkyxsZOUGwM=
Date: Tue, 4 Jun 2024 13:34:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mohamed Karaoui <moharaka@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fixes a coding style error
Message-ID: <2024060411-flanking-surfacing-63c9@gregkh>
References: <20240517110140.81732-1-moharaka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517110140.81732-1-moharaka@gmail.com>

On Fri, May 17, 2024 at 12:01:40PM +0100, Mohamed Karaoui wrote:
> Adds a space before if statement's condition
> 
> Signed-off-by: Mohamed Karaoui <moharaka@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> index 0cbf4a1a326b..b2af802b9451 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> @@ -278,7 +278,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>  		int aad_len, ret;
>  
>  		req = aead_request_alloc(key->tfm, GFP_ATOMIC);
> -		if(!req)
> +		if (!req)
>  			return -ENOMEM;
>  
>  		aad_len = ccmp_init_iv_and_aad(hdr, pn, iv, aad);

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

- Your patch did not apply to any known trees that Greg is in control
  of.  Possibly this is because you made it against Linus's tree, not
  the linux-next tree, which is where all of the development for the
  next version of the kernel is at.  Please refresh your patch against
  the linux-next tree, or even better yet, the development tree
  specified in the MAINTAINERS file for the subsystem you are submitting
  a patch for, and resend it.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

