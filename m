Return-Path: <linux-kernel+bounces-261842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898A93BCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258D81F21F10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA3916E895;
	Thu, 25 Jul 2024 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SDkodD/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907616B74C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891129; cv=none; b=Vljl5RdrJys8TQOQ/o37KSeX+XG2Lnpryz8yi8IefPthkLywqDm1DLfvNmijsTNl6g3MDKcl4KQncj5WYepfGOzWv7dhpvp8ZtIaNrUG9/Rh/a2VIb/GZoe4D+tA+t3syEDDDMmYR88akmil8kRB/WvTEoGCG8L0hCMOZEHA2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891129; c=relaxed/simple;
	bh=dQYPmHfwIOVQrujw+39ohNcM2Z4bWRmWI8iQTlZa8vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8/7lRD7vS660tHHAub6p1HUC9j5vuAVvfsUmIj+r1hXCdQ51+kO0Blwt3GW/l+ir0BEMOVXD5WQtPypewKBiNKjVi036KmBwgwmFQIqNAVGY+kqGcGisnp/RauIyE2m9V6MokxsszKTCp23gJK+g+gXjuZwm8ect6pFVqLce4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SDkodD/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D892C116B1;
	Thu, 25 Jul 2024 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721891128;
	bh=dQYPmHfwIOVQrujw+39ohNcM2Z4bWRmWI8iQTlZa8vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDkodD/3EcS4u8SSMnCWub3r6cy+QSyuRi9D4JbBilvoA/nmEKK25sEZzvddf1+Or
	 77D9vs8YtDP8ZLdoE1H1cGIp/Bw5g7d+aPF547ZpKbk+AswCTG1+x2o/r+UC9fdf4z
	 dNCYsan5e35qjfCfG2EDK0qf5zWS1pNASi1RA+V4=
Date: Thu, 25 Jul 2024 09:05:25 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: Subject: [PATCH] usb: gadget:Fixed the problem of abnormal
 function of mobile  phone as UVC camera.
Message-ID: <2024072537-landowner-diaphragm-1d22@gregkh>
References: <TYUPR06MB621753631B9F7836583E7BEED2AB2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB621753631B9F7836583E7BEED2AB2@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Thu, Jul 25, 2024 at 06:40:14AM +0000, 胡连勤 wrote:
> From b0058484e3fe7830c2092d5d19b46bf1bab73d83 Mon Sep 17 00:00:00 2001
> From: Lianqin Hu <hulianqin@vivo.com>
> Date: Wed, 24 Jul 2024 18:52:27 +0800
> Subject: [PATCH] usb: gadget:Fixed the problem of abnormal function of mobile
>  phone as UVC camera.

For some reason this showed up in the body of the email, and your
subject line has "subject" in it :(

> Android 15 USB function option interface adds camera function.
> after switching to camera function, USB enumeration is abnormal.

What do you mean by "abnormal"?

> the reason is that bind_deactivated is set to true in f_uvc driver,
> which causes gadget->deactivated to be set to true during
> usb_add_function,and dwc3 controller cannot perform pullup operation.

Why does the dwc3 controller matter here?  What about other controllers?

> 
> Therefore, modify f_uvc driver and remove the setting operation
> of func.bind_deactivated.
> 
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
>  drivers/usb/gadget/function/f_uvc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 40187b7112e7..6d63bea14211 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -1107,7 +1107,6 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
>  	uvc->func.disable = uvc_function_disable;
>  	uvc->func.setup = uvc_function_setup;
>  	uvc->func.free_func = uvc_free;
> -	uvc->func.bind_deactivated = true;

Why was this set to be true to start with?  What commit id does this
fix?  Should it be backported to older kernels, and if so, how far back?

What user-visable changes does this patch cause?  What used to work that
now will not as that was added for a reason, right?

thanks,

greg k-h

