Return-Path: <linux-kernel+bounces-386898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6129B494B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42B9B23FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AB6205ADF;
	Tue, 29 Oct 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJRMkc+h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E71DF960;
	Tue, 29 Oct 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203918; cv=none; b=pTAthhL7Yyq/ywuWfCUSa6oneNnVflUxLBYHhCYnL4K+VKQJ88PHdoj8SpKwVk/WEXQ4cwcMfYED8Ck2pmLCZyW12LAbQzSStRJn8IG0/pKEkWsxG/c7omB4gneP+ETyq29SoevGmWM4PYYd1hZ6rPg8Rc/tn4Sf4zJMnSF/hOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203918; c=relaxed/simple;
	bh=DvOA428vZdpj4FY6SOQjmd/eWCaW9YAhTenfjs/0W+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vna8Jdgil0pa2Li8AETqAsT6uO/ntgdqdzFn1zZHHBByn4YtfjFecNd+W7k3e6AO1IbFtgJ8M+KWp+I9Gy8mA+oseM3lZLuohgW1ke0Dfr7+3jtd1MDhmu5pS984FwIoZJDI8JRpQuuK0y39oix0py9q8hD1oY1qjHz0GXohBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJRMkc+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EBBC4CEE6;
	Tue, 29 Oct 2024 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730203918;
	bh=DvOA428vZdpj4FY6SOQjmd/eWCaW9YAhTenfjs/0W+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJRMkc+heMepmtDI/F6bUP1EfECyQ6mwg6/UR1N2Msy1FZ/fLS/dFeoohHbkkDc8d
	 EiNeyJUGhQx+zfj5bZUnlsvwLROnSt9zhK21sHtjrCP7GiQBKlN7U3ktsqWLdeasef
	 0lYs2cNmKmZH/BN308f+yWVmZGavtavo0LNDrVuNqIdi069ZDBVie2A6Oj82oYNwpw
	 4EpdNGT5fQDKQG0z2i1yafONGQxLeZVvFgmJF8ULQUgBWaidsqyCWQmEnZa7vcUyRV
	 7KyVRmTPVXHS7mboG2a2bU5yCE11lNtTLtB/NJrdHU/DKtFaPkkAl8XWFNtcXOOuFR
	 6Y0lzy4g3Mc8g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t5l57-000000002zu-29c3;
	Tue, 29 Oct 2024 13:12:17 +0100
Date: Tue, 29 Oct 2024 13:12:17 +0100
From: Johan Hovold <johan@kernel.org>
To: wojackbb@gmail.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add MediaTek T7XX compositions
Message-ID: <ZyDRIW0DIGn_FIsD@hovoldconsulting.com>
References: <20241028080415.697793-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028080415.697793-1-wojackbb@gmail.com>

On Mon, Oct 28, 2024 at 04:04:15PM +0800, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> Add the MediaTek T7XX compositions:

Can you say something about what the various interfaces are used for
here?

> T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=01 Dev#= 74 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0e8d ProdID=7129 Rev= 0.01
> S:  Manufacturer=MediaTek Inc.
> S:  Product=USB DATA CARD
> S:  SerialNumber=004402459035402
> C:* #Ifs=10 Cfg#= 1 Atr=a0 MxPwr=500mA

> Signed-off-by: Jack Wu <wojackbb@gmail.com>
> ---
>  drivers/usb/serial/option.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 4f18f189f309..b6118f545386 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2244,6 +2244,7 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = NCTRL(2) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7127, 0xff, 0x00, 0x00),
>  	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7129, 0xff, 0x00, 0x00) },	/* MediaTek T7XX */

Should you mark some of the interfaces are not accepting modem control
requests similar to 0x7126 and 0x7127?

>  	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MEN200) },
>  	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MPL200),
>  	  .driver_info = RSVD(1) | RSVD(4) },

Johan

