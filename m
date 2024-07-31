Return-Path: <linux-kernel+bounces-269094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CE942D86
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12570281195
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F041AE846;
	Wed, 31 Jul 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IDNmUoa5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9E1AD9EB;
	Wed, 31 Jul 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426853; cv=none; b=Z53AuFY6VGJO7sCOzy/NJcO96ncdnM0mM6uuGRX01gC9syRCWH2oqKycsrW4h6aYfeoSPK5voYWHv/vGbPLa2wWOLorageVkz1xz5bmOPF/f6o1WmgUiRs1+A8RCxZ5/DGpUuOkJs/bPsAWqEp9yM95g6DdYYcjzUNE2CQpdiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426853; c=relaxed/simple;
	bh=j7eXb7UEnptMikwrJPvI1xlYWjJ7Q+HKQUJZNaXCAEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYiKoAR93409LP2+DruA+1TM50+FAmxtpyWuaYHf/Xk4epbtffUVKH7J8RuMxCd1atgNS6wralWdTzePEdOYJ7bowebgOumc8sm9W3dGYN6YEDyDj+eHXAbwsSICIPPwo6iwmFrZP1I3Gmobqecu8kgEQ4L+buCxvamK+8ssoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IDNmUoa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62B7C116B1;
	Wed, 31 Jul 2024 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722426853;
	bh=j7eXb7UEnptMikwrJPvI1xlYWjJ7Q+HKQUJZNaXCAEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDNmUoa5yjxwfOGEJ+m9HXcDZQsmEaW8yrD3lCds3cWpgWarRZsc06lqj2htafQys
	 UdEUAzcq/Me4woWcMQDX+3MY2P7g93g+uJ9gRonftHSm1nUceqixKb8l3z4gjWI6Y0
	 ZL0ZkJLYmkVp8o+kaMLcl0HV7E/+KAzk627qUT8Q=
Date: Wed, 31 Jul 2024 13:54:10 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIHVz?=
 =?utf-8?Q?b=3A_gadget=3A_uvc=3A_Fixes_th?= =?utf-8?Q?e?= abnormal
 enumeration problem of mobile phone as UVC camera.
Message-ID: <2024073150-pointless-makeshift-3745@gregkh>
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

There  is no fixes tag here :(

Also you have a lot of trailing whitespace on the commit changelog, is
that intentional?

thanks,

greg k-h

