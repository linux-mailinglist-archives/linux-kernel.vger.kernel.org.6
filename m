Return-Path: <linux-kernel+bounces-349913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0098FD3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6495B223E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F6D84A2C;
	Fri,  4 Oct 2024 06:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mAbQL6VG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27152F76;
	Fri,  4 Oct 2024 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728022808; cv=none; b=IZXe8hxlVSQfKNF8C2shkbYzkpdPZqhw8MH7hxk0/qgD9z6MPE8+LPIdGs/d2MAl2r9MiPefn0YPJlM6bTzDw7CbdFP4fjyEqPStoRodReGPWZTHI/T/IhWhlHb4+ZWyYcFW/ad99OuZyj4cR8Clf82lk8Di87hTpPPreFo02cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728022808; c=relaxed/simple;
	bh=xvs7Byxkt/+mjYKAblL+8K44lPFq+HdKaS1cAe+vdTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrtehbr+18hACDe4/Qtz6m7M94GplogOg1byEE2pLXuEa4MQmJUV1/w33AanBrqolXtGODHKX4/SkmOrBTktc+8Wmfc7FL1HzHh4zja8l+iasb07q1oS7Iell9hVcLV2mqGCahG2+W+WfO+aJaVFQyPFZcJjTRXMt/PV/zaJSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mAbQL6VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E81C4CEC6;
	Fri,  4 Oct 2024 06:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728022807;
	bh=xvs7Byxkt/+mjYKAblL+8K44lPFq+HdKaS1cAe+vdTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAbQL6VGiOUxy39OfUeFH1cZ69jKowGPXsCs5LrAvCM5thTdwzDKIabOJtux8zeLL
	 sIe+HZzxfIJTV0BTmFXuSWjJcdBj+YtpGexT0QUI6oZb0uUZi33AgkRlxMDH0/LP7C
	 nY316QXfPGQAbIg6vIEyZgWG1/4sfqqVgkjXTRZY=
Date: Fri, 4 Oct 2024 08:20:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Manuel Quintero F <sakunix@yahoo.com>
Cc: duncan.sands@free.fr, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: atm: speedtch: do not use assignment in if condition
Message-ID: <2024100400-whiff-unspoiled-0e1a@gregkh>
References: <20241004030512.2036-1-sakunix.ref@yahoo.com>
 <20241004030512.2036-1-sakunix@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004030512.2036-1-sakunix@yahoo.com>

On Thu, Oct 03, 2024 at 08:05:12PM -0700, Manuel Quintero F wrote:
> Fix checkpatch error "do not use assignment in if condition"
> 
> Signed-off-by: Manuel Quintero F <sakunix@yahoo.com>
> Signed-off-by: Manuel Quintero F <sakunix@yahoo.com>

Why twice?

> ---
>  drivers/usb/atm/speedtch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/atm/speedtch.c b/drivers/usb/atm/speedtch.c
> index 973548b5c15c..dfd362abf602 100644
> --- a/drivers/usb/atm/speedtch.c
> +++ b/drivers/usb/atm/speedtch.c
> @@ -324,7 +324,9 @@ static int speedtch_upload_firmware(struct speedtch_instance_data *instance,
>  	   because we're in our own kernel thread anyway. */
>  	msleep_interruptible(1000);
>  
> -	if ((ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->params.altsetting)) < 0) {
> +	ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->params.altsetting
> +
> +	if (ret < 0) {

Why the extra blank line?

When learning to do kernel changes, I recommend doing so in
drivers/staging/ first, as that is what it is there for.  Only after
getting experience would I recommend doing this in other areas of the
kernel, and even then, only do checkpatch cleanups for code that you can
test, or that the subsystem maintainer has explicitly asked for.

good luck!

greg k-h

