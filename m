Return-Path: <linux-kernel+bounces-204958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71288FF57D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129AF1F235CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A66F06B;
	Thu,  6 Jun 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="s0UdELLC"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101961FC7;
	Thu,  6 Jun 2024 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703615; cv=none; b=d6R3/EgvKVwXYg+1P5pR4OhrwXvjW8mxA2WyZ9di6dcpSQcglYEWKm9AYEfnFOfkq1xNCBIACvND4pE3EoQFrIqNzOk3oxF+hFU789jMDcLYQqAaYKn+miESODmJ3MGBiXM/SzplHrz2oJlSBwzFXXzjFTZJ3V65jR551L6yLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703615; c=relaxed/simple;
	bh=a0X7bunm2bESyng2Upz/G7g4w2hy7WxYwZKNz6xfue8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAikCEdN4TzjOAEdYtfaGK1eno+Saa23BMaSWY3Zx3QhVe6w3BBpdYAWIDxCQjj0DGCbOny0TRiTSWUv7X4Er1yJNGGN6vNbdIBYwDWS+AI2JaGuCtqZpSc3+5yhjANt0SBLkZamxSKe7Vr5b05MveDZR8LIvB75kifStd43Xn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=s0UdELLC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717703609;
	bh=a0X7bunm2bESyng2Upz/G7g4w2hy7WxYwZKNz6xfue8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0UdELLCatnDct20eC2cqDtMDk6vUgS1IbCVqRiTEoCsOOBVdegjxcYhUU5xPbFdN
	 qWrZW6FVaOp2MjimpD4KEGQAF+kCkHXvR9EGlCri81dQ/1/Ifbit3lTPY+x5btVmCl
	 nyoj4MWjZzYdzpAu0JFWaf6iMdmN70Q+ZSEdDfBs=
Date: Thu, 6 Jun 2024 21:53:29 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] hwmon: (cros-ec_hwmon) Fix access to restricted __le16
Message-ID: <571aaac0-a397-4aa8-b9d5-2315f6a637d4@t-8ch.de>
References: <20240606180507.3332237-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606180507.3332237-1-linux@roeck-us.net>

Thanks!

On 2024-06-06 11:05:07+0000, Guenter Roeck wrote:
> 0-day complains:
> 
> drivers-hwmon-cros_ec_hwmon.c:sparse:sparse:cast-to-restricted-__le16
> 
> Fix by using a __le16 typed variable as parameter to le16_to_cpu().
> 
> Fixes: bc3e45258096 ("hwmon: add ChromeOS EC driver")
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

Guenter, does sparse work locally for you?

When I run it via "make C=1 drivers/hwmon/cros_ec_hwmon.o" I only get
some random warnings from included headers but nothing of value.

Tzung-Bi, could you pick up this patch through chrome-platform?
(And also "hwmon: (cros_ec) Prevent read overflow in probe()" [0])

[0] https://lore.kernel.org/lkml/42331b70-bd3c-496c-8c79-3ec4faad40b8@moroto.mountain/

> ---
>  drivers/hwmon/cros_ec_hwmon.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> index 41f268fa8260..f586987c3502 100644
> --- a/drivers/hwmon/cros_ec_hwmon.c
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -26,12 +26,13 @@ struct cros_ec_hwmon_priv {
>  static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
>  {
>  	int ret;
> +	__le16 __speed;
>  
> -	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, speed);
> +	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &__speed);
>  	if (ret < 0)
>  		return ret;
>  
> -	*speed = le16_to_cpu(*speed);
> +	*speed = le16_to_cpu(__speed);
>  	return 0;
>  }
>  
> -- 
> 2.39.2
> 

