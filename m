Return-Path: <linux-kernel+bounces-268928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F057942B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12D41C240FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE571B1419;
	Wed, 31 Jul 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XynXCVkh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2731B1409
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419315; cv=none; b=pSIahY3TwWJwHT6SNBnrDy1XE1oHlYkd2OK24Ep6yQoU9URASadNe7wI99w3HHqHqUb9kp0GMX9BY6isl4JMlvNMsSqH7eeMsOKZZyoOL7pUADaFkibxaHLxFLds5pVI8fWvGS6Pt1SPn8umijfoh6S0YPJ7r97uNAt+4JlYGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419315; c=relaxed/simple;
	bh=hD8lIRhXLx1NKeE9SHEx3vaCYzZmsY2ws5/kT1O4sq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPrcAC0HgP9G/q2x1IiwRjynAnxlZ/dUpFGQwg4RRjWCwx6xZW29PKXLXlGqxENTcskP4R/qwLu946GhmUDAt45BlvxAr4J+LVFsYr2znkBOzYcOzQppvh+BV6RmI1Pz8RYSqTdbRoxM994XcUFhnoc7YJG0sL4rQe7WW/ZIFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XynXCVkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6023CC4AF0F;
	Wed, 31 Jul 2024 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722419314;
	bh=hD8lIRhXLx1NKeE9SHEx3vaCYzZmsY2ws5/kT1O4sq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XynXCVkhcTtt5zN1C6F0F1EWtj2mIunLDdFJyaJ4VxziUHmWnNlwyuQlLIVU5pf5e
	 72ikVKNQJpTcBwu/MbMYAqlvw/l9gjli69hCctJJFooCq64VwFrRFyzOo+NQBsjDEM
	 tmeQ6p2KdE4sS1wtERinIlBC91eXL8cMxHYj41O8=
Date: Wed, 31 Jul 2024 11:48:31 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRD?=
 =?utf-8?Q?H_v2=5D_usb=3A_gadget=3A_uvc=3A_Fixed_th?= =?utf-8?Q?e?= abnormal
 enumeration problem of mobile phone as UVC camera.
Message-ID: <2024073117-velocity-buckle-ab6b@gregkh>
References: <TYUPR06MB62176C90FAD82DB165866B19D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB62176C90FAD82DB165866B19D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Wed, Jul 31, 2024 at 09:39:16AM +0000, 胡连勤 wrote:
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
> Therefore, modify the f_uvc driver to remove the operation of setting
> uvc->func.bind_deactivated to true.
> 
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
> v2:
>   - Modify "Fixes:" tag on the commit
>   - Modify description information.

I see no "Fixes:" tag here :(


