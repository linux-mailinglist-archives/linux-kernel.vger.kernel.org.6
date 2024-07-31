Return-Path: <linux-kernel+bounces-269148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2704942E55
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586251F24FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2381B0120;
	Wed, 31 Jul 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="b0Y4pwYp"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DB31AE853;
	Wed, 31 Jul 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428663; cv=none; b=nkblA4mqhI6dRiMNsGsIbCSGOj9LZ1If3V6nhwc468c4/mxxapWDlBkPXa8FrUl/xpEgYF6I+8Z2/Xsj0PGVcI4Pz9RQZaMIYgAUKf2Db23ycmgxfQixUDEIequQJ0Xu16iQ780xjHY7b76+yCEAFivuh4zyQZ6n7lyUlaIzM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428663; c=relaxed/simple;
	bh=uKl7CURAfx3NUTWUtQi77qTzryxy/ndvuS6LS6Y1E/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDkX/rcX1YzJlYl5GUQp7G46m9XykFtABdCHn2y645lwDVIogPqvmCtBDgZtSNikASW2gQK0LjSayF/yQEA7va+FcOaAd8r4CPm8/i+ZEbk8zigV3PJ0+O9OR6jI2WEwOqFtfxfBsy2nW0OY+4i2t1ft/0Z5X/P4JPiPQluObA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=b0Y4pwYp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CEB4A18D;
	Wed, 31 Jul 2024 14:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722428605;
	bh=uKl7CURAfx3NUTWUtQi77qTzryxy/ndvuS6LS6Y1E/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0Y4pwYprppv64aUM233vTkChbzcyXmhUNuYLPx6hhFxBBdmt6V/2/ncLs8fiVlRm
	 +MNBO3PxZRnIv2tvLz3h2NirJvCN1y4AsnXZMQqaTv2ugetyyKXNK6pTURblQG3VFz
	 dkng6yz1NHcprSZ6q3yRUx/SfsmGPWG0gLeX9UPQ=
Date: Wed, 31 Jul 2024 15:23:51 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIHVz?=
 =?utf-8?Q?b=3A_gadget=3A_uvc=3A_Fixes_th?= =?utf-8?Q?e?= abnormal
 enumeration problem of mobile phone as UVC camera.
Message-ID: <20240731122351.GU8146@pendragon.ideasonboard.com>
References: <TYUPR06MB62175899DECC7A9B0DA0DF01D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB62175899DECC7A9B0DA0DF01D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Wed, Jul 31, 2024 at 11:49:11AM +0000, 胡连勤 wrote:
> When the phone is connected to the computer to use the webcam function, 
> the phone needs to be enumerated as a uvc camera function.
> 
> Because uvc->func.bind_deactivated is configured as true in the f_uvc 
> driver uvc_alloc function, the usb_gadget_deactivate function is called 
> during the execution of the configfs_composite_bind function to 
> set gadget->deactivated to true, which in turn causes the 
> usb_gadget_connect_locked function to fail to call the corresponding 
> controller pullup operation (such as: dwc3_gadget_pullup, 
> mtu3_gadget_pullup), and the USB cannot be enumerated 
> normally under the uvc function combination.
> 
> After applying this patch, we measured that under the uvc function, 
> the dwc3 controller and the mtu3 controller can be enumerated normally, 
> and the webcam function is normal.
> 
> Fixes this by removing the setting of uvc->func.bind_deactivated to true.
> 
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
> v2:
>   - Add "Fixes:" tag on the commit
>   - Modify description information.
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

This is done on purpose. The UVC function requires a userspace control
application, so the function is deactivated by default at bind time, and
gets activated when the application is ready.

This patch isn't right.

>  
>  	return &uvc->func;
>  
> -- 
> 2.39.0
> 
> 
> -----邮件原件-----
> 发件人: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> 
> 发送时间: 2024年7月31日 19:13
> 收件人: 胡连勤 <hulianqin@vivo.com>
> 抄送: akpm@linux-foundation.org; linux-kernel@vger.kernel.org; opensource.kernel <opensource.kernel@vivo.com>
> 主题: Re: [PATCH v1] usb: gadget: uvc: Fixed the abnormal enumeration problem of mobile phone as UVC camera.
> 
> On Wed, Jul 31, 2024 at 08:45:31AM +0000, 胡连勤 wrote:
> > When the phone is connected to the computer to use the webcam 
> > function, the phone needs to be enumerated as a uvc camera function.
> 
> <snip>
> 
> Note, why aren't you using scripts/get_maintainer.pl to find the proper mailing list and developers for this change?  Please do so.
> 
> thanks,
> 
> greg k-h

-- 
Regards,

Laurent Pinchart

