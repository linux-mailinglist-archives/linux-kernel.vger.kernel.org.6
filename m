Return-Path: <linux-kernel+bounces-335466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B797E627
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2022281180
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19332940B;
	Mon, 23 Sep 2024 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ctX0uiFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4D79E1;
	Mon, 23 Sep 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074165; cv=none; b=t22KkTzz/qtAFegopdlYER7Ucu9QfdA93zjLnpp/3FApdUoHfiqu5/PtGCDfZ6VMUZ2e9AqtsxDB8cffLk7FTL9JaD5+m1fdoyjm+USUAMXmtcM/+BVmusKhllvftYovs74vMqlVnSI8AeJb9oKovuRpal82XvvW7zsi81IXICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074165; c=relaxed/simple;
	bh=phhhARRHEfctbxxHfbZ7OwsAOfhRcR2f/57D0hK4Ktk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYv7ANNN/FHVGlzcW39tVsJUBK5jA4YoFaH4zAUImMJqjaC2K+k96HcHDaFEP020ex+ueBNum5yeoVAKbEc47waAE0FfAYYlhNFFB2GiA/nLJBJqz0lCOa2FIXij6w4yNUi37AqCNM/pmBKysYnuxwNauW0GVILaZFkmLIfB5G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ctX0uiFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EAFC4CEC5;
	Mon, 23 Sep 2024 06:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727074164;
	bh=phhhARRHEfctbxxHfbZ7OwsAOfhRcR2f/57D0hK4Ktk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctX0uiFUmrayWT0fCODzNI2q/5xYcy0MMSzVOkA1HrX45j8R8FVKS1EeQB3EwWMRX
	 suZkUTtGGQw8PeWACm/XAuLZBGsnfOsdse/N0UJ2BVhqenBV7CSDTofAiS60Pjsizd
	 s33h5OzqI8461BJQG/HJdvyuqxKoQPclDYAxXTmg=
Date: Mon, 23 Sep 2024 08:49:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: amin-amani <didi1364@gmail.com>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: digi_acceleport: Enhance error handling by
 checkpatch.pl
Message-ID: <2024092321-explore-student-c2a1@gregkh>
References: <20240922211512.49273-1-didi1364@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922211512.49273-1-didi1364@gmail.com>

On Mon, Sep 23, 2024 at 12:45:12AM +0330, amin-amani wrote:
> - Separated null checks for port, serial and private data.
> 
> Signed-off-by: amin-amani <didi1364@gmail.com>
> ---
>  drivers/usb/serial/digi_acceleport.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Hint, when working on a "first patch" for cleanups like this, please
work in the drivers/staging/ portion of the kernel, as that is where
stuff like this is encouraged.  Only after getting experience in the
development process should you venture out into other areas.

Also, for drivers like this, if you do not have the hardware, and can
test your changes, it can be hard to justify taking the commit.

> diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
> index d1dea3850576..d858358f94d8 100644
> --- a/drivers/usb/serial/digi_acceleport.c
> +++ b/drivers/usb/serial/digi_acceleport.c
> @@ -1309,9 +1309,14 @@ static void digi_read_bulk_callback(struct urb *urb)
>  			__func__, status);
>  		return;
>  	}
> -	if (port->serial == NULL ||
> -		(serial_priv = usb_get_serial_data(port->serial)) == NULL) {
> -		dev_err(&port->dev, "%s: serial is bad or serial->private "
> +	if (port->serial == NULL) {
> +		dev_err(&port->dev, "%s: serial is bad,"
> +			" status=%d\n", __func__, status);
> +		return;
> +	}
> +	serial_priv = usb_get_serial_data(port->serial);
> +	if (serial_priv == NULL) {
> +		dev_err(&port->dev, "%s:serial->private "

Also, what does this really provide?  Is it more helpful to you to see 2
different strings for this error?  Have you hit this before, and if so,
we should fix the root problem here instead, right?

thanks,

greg k-h

