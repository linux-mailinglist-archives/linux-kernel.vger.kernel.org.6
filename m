Return-Path: <linux-kernel+bounces-269293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AEB94311F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB97284D02
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D91B150E;
	Wed, 31 Jul 2024 13:40:33 +0000 (UTC)
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650541AD3FE;
	Wed, 31 Jul 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433232; cv=none; b=PeBnbEI/bZmZeTmZalW3WaVAepV7S1QFKpXUyKWxNr1EtSkaifYVt2fSGdygsXQNCmBaAxrHlXwixEa0+/22lAY1/Kzbof9eF8xr2SNk51olgyGevATOG1fNb4nB/IqXcKCy2uADpcOUL0ilSeIJ7zrvjAk9mtMEc/d+xWhZqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433232; c=relaxed/simple;
	bh=h0PF3yhyybjZDecyKpukDJch8WS+YmJcGqdqDbZnb0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrUQL7GlOwJNi/k/QONRQOpl0kY25XxInStsZxRHrxrmlUlR5mKybqPlBFgmn+AaQoEjYLOIbQgcefgZzGJepPuxcIVzxSO0ma7EmrRDigT2nueU2BPO6xWVRQcIBYgjZ7JMb722Nu6lgM0s6DX25GxouWe9x3nPsoOhqP2zGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.18.1/8.18.1) with ESMTPS id 46VDLPNr028891
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 31 Jul 2024 22:51:27 +0930
Date: Wed, 31 Jul 2024 22:51:25 +0930
From: Jonathan Woithe <jwoithe@just42.net>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] platform/x86: fujitsu-laptop: Use backlight power
 constants
Message-ID: <Zqo6VfQGyApMdTWN@marvin.atrad.com.au>
References: <20240731125220.1147348-1-tzimmermann@suse.de>
 <20240731125220.1147348-8-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731125220.1147348-8-tzimmermann@suse.de>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Wed, Jul 31, 2024 at 02:50:57PM +0200, Thomas Zimmermann wrote:
> Replace FB_BLANK_ constants with their counterparts from the
> backlight subsystem. The values are identical, so there's no
> change in functionality or semantics.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jonathan Woithe <jwoithe@just42.net>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>

I see no issues as far as fujitsu-laptop is concerned.

Acked-by: Jonathan Woithe <jwoithe@just42.net>

Regards
  jonathan

> ---
>  drivers/platform/x86/fujitsu-laptop.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 968fc91bd5e4..ae992ac1ab4a 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -43,7 +43,6 @@
>  #include <linux/bitops.h>
>  #include <linux/dmi.h>
>  #include <linux/backlight.h>
> -#include <linux/fb.h>
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/kfifo.h>
> @@ -356,7 +355,7 @@ static int bl_get_brightness(struct backlight_device *b)
>  {
>  	struct acpi_device *device = bl_get_data(b);
>  
> -	return b->props.power == FB_BLANK_POWERDOWN ? 0 : get_lcd_level(device);
> +	return b->props.power == BACKLIGHT_POWER_OFF ? 0 : get_lcd_level(device);
>  }
>  
>  static int bl_update_status(struct backlight_device *b)
> @@ -364,7 +363,7 @@ static int bl_update_status(struct backlight_device *b)
>  	struct acpi_device *device = bl_get_data(b);
>  
>  	if (fext) {
> -		if (b->props.power == FB_BLANK_POWERDOWN)
> +		if (b->props.power == BACKLIGHT_POWER_OFF)
>  			call_fext_func(fext, FUNC_BACKLIGHT, 0x1,
>  				       BACKLIGHT_PARAM_POWER, BACKLIGHT_OFF);
>  		else
> @@ -933,9 +932,9 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
>  	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
>  		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2,
>  				   BACKLIGHT_PARAM_POWER, 0x0) == BACKLIGHT_OFF)
> -			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
> +			fujitsu_bl->bl_device->props.power = BACKLIGHT_POWER_OFF;
>  		else
> -			fujitsu_bl->bl_device->props.power = FB_BLANK_UNBLANK;
> +			fujitsu_bl->bl_device->props.power = BACKLIGHT_POWER_ON;
>  	}
>  
>  	ret = acpi_fujitsu_laptop_input_setup(device);
> -- 
> 2.45.2

-- 

