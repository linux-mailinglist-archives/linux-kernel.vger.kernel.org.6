Return-Path: <linux-kernel+bounces-325059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A44975461
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCAD1C2110E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7919CC2D;
	Wed, 11 Sep 2024 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHKZHhmX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D819C55F;
	Wed, 11 Sep 2024 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062201; cv=none; b=FgSODtAXZT19iz+qM6j1Zd3nJltg5A5Bq0u+Tvbh3UR4qOA+60TNnZfgnZvXy72GryU/ijY7BRn5Op/WqoAsxXe+SwpSIK5FaMCb5mwQYuhmX7tKlwtCFsiQp8orvTS+oxGHtMfjruhlJjnlFWG52l7GCoCDd4qB4ZLdqN+Zids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062201; c=relaxed/simple;
	bh=OqWPGh95lrZt+H7bNu4+WatZYOsbgVu5vamzm2Y3fRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpqNsqtwV0OlT+CoWZmXYG4waTSzLpPR3epl+b8kbUQ4NjwUmdHcsR5Lz6CzwFjt0wE+Sy3pVnIAH24sSGt6/Fbgs+YmZe9IGGTXAsLG8LP/zgrCdexR9xAD337ucEm2Gw65Sfuz5+kLo5f4tSV8C/juvXtbHWgrHy2Gtl+3wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHKZHhmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D918CC4CEC7;
	Wed, 11 Sep 2024 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726062201;
	bh=OqWPGh95lrZt+H7bNu4+WatZYOsbgVu5vamzm2Y3fRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zHKZHhmXs+OkYEJALnjzjeo60P+p1EOMS1uAHtZHw20KyY8a1hCfJjmsZ4QHQy5zz
	 LnQ00Ym2ElBupanA0TQQa4xh/JubT5ihd23pOiRlEg65s4pGoKukTbT+kOYUFrp9QF
	 akZHLw8e0HcOntoXFoAb23FEgdjE7kFKsEM6+D04=
Date: Wed, 11 Sep 2024 15:43:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: abid-sayyad <sayyad.abid16@gmail.com>
Cc: linux-staging@lists.linux.dev, philipp.g.hortmann@gmail.com,
	guilherme@puida.xyz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs:  Fix indenation and coding style
 issues in rtw_securtiy.h
Message-ID: <2024091157-appointee-faceted-5ffe@gregkh>
References: <20240911133549.2664372-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911133549.2664372-1-sayyad.abid16@gmail.com>

On Wed, Sep 11, 2024 at 07:05:50PM +0530, abid-sayyad wrote:
> This patch improves the code readability and improves the presentation
> makes it look less scattered.
> 
> Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
> ---
>  .../staging/rtl8723bs/include/rtw_security.h  | 31 +++++++++----------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
> index c3e47d52687f..ae65d684a26d 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> @@ -171,27 +171,26 @@ struct security_priv {
>  #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)\
>  do {\
>  	switch (psecuritypriv->dot11AuthAlgrthm) {\
> -		case dot11AuthAlgrthm_Open:\
> -		case dot11AuthAlgrthm_Shared:\
> -		case dot11AuthAlgrthm_Auto:\
> -			encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
> -			break;\
> -		case dot11AuthAlgrthm_8021X:\
> -			if (bmcst)\
> -				encry_algo = (u8)psecuritypriv->dot118021XGrpPrivacy;\
> -			else\
> -				encry_algo = (u8)psta->dot118021XPrivacy;\
> -			break;\
> -	     case dot11AuthAlgrthm_WAPI:\
> -		     encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
> -		     break;\
> +	case dot11AuthAlgrthm_Open:\
> +	case dot11AuthAlgrthm_Shared:\
> +	case dot11AuthAlgrthm_Auto:\
> +		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
> +		break;\
> +	case dot11AuthAlgrthm_8021X:\
> +		if (bmcst)\
> +			encry_algo = (u8)psecuritypriv->dot118021XGrpPrivacy;\
> +		else\
> +			encry_algo = (u8)psta->dot118021XPrivacy;\
> +		break;\
> +	case dot11AuthAlgrthm_WAPI:\
> +	     encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
> +	     break;\
>  	} \
>  } while (0)
> 
>  #define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
>  do {\
> -	switch (encrypt)\
> -	{\
> +	switch (encrypt) {\
>  		case _WEP40_:\
>  		case _WEP104_:\
>  			iv_len = 4;\
> --
> 2.39.2
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

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

