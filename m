Return-Path: <linux-kernel+bounces-295503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 197EC959BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78471F2164E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3375188CA4;
	Wed, 21 Aug 2024 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lqpVJvoY"
Received: from msa.smtpout.orange.fr (smtp-73.smtpout.orange.fr [80.12.242.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC129166F04;
	Wed, 21 Aug 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243743; cv=none; b=IJs/A++rS4jBei59kB9tSxqGNp+uORtAKV/+mGlG6MVGZun/l14QoTeod1E3MuF8rIlRX1VENM1z6kCTz+XoCOcCcORVpwU9nzD4DaH4UdizxiTjVfitTH/IU+1DCJbwtilPNXTnosWkGuSC0T1cxha+EpyBdgT9uApX3fOukjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243743; c=relaxed/simple;
	bh=25ObRqwlOtBj/pcd5FxF9unYnK53/tXqiPwFSw8dR4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALuc3m/xiBsmoQojgUXfGmvYVzvg0Y8ovVL5CBdk8El0zymDMFpf+F8sFaJxq70MN9IAX4eVWSZvagw9oseLC6gPgZGPlT/uCwjxWnHxrktwncy1miVaDKYzQv03elr0bshGs9RYb95jAwBIAv4fBU6hqM04sdbaSgzv+qONc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lqpVJvoY; arc=none smtp.client-ip=80.12.242.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gkYksIlFjNe0IgkYksKwrp; Wed, 21 Aug 2024 14:35:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724243732;
	bh=7mFzAZMR1DwQrG49Sp3pjJHS3JwHC2jICOmjdxEWYww=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lqpVJvoYso3fIEBrbv55noli99PPmHB/Rz3T9EtO/fx7AdDAsX9eA2xJtu+aDP7I7
	 F+P8bv5gE+nkky+pFHLlfUk8E4elTB1YPJKpdT+4AYijEojIb2mR51UcJSfcR+8YyI
	 KCdaoyt53XqzVOxzk1/tVJjysmMZFpUE1X/48iytde3oOJSI2dpw+4TUN8yIk6Yd0M
	 8wDOeCg46S2BN2altjNfcMDM9Zj801t5LY/O7v6TnDV5ESR4d6Ej3E5XeyY9w/IBxz
	 XZB90F6ydU9UOIOEyOiFHooetSgroJAdFEysbxt1bo5lsSyW1PB4GO707emu46Bc5e
	 H/BPlX0e9my5A==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 14:35:32 +0200
X-ME-IP: 90.11.132.44
Message-ID: <a096554e-fdfe-4deb-b19b-500c86beec98@wanadoo.fr>
Date: Wed, 21 Aug 2024 14:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] platform/x86: int3472: Simplify dev_err_probe()
 usage
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Scally <djrscally@gmail.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com>
 <20240821122233.3761645-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240821122233.3761645-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 14:20, Andy Shevchenko a écrit :
> Since dev_err_probe() ignores success,

Hi,

Does it really?
It does not seem to be the case (at least on linux-next). Or I miss 
something obvious?

CJ

> i.e. 0. we may call
> it unconditionally.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/platform/x86/intel/int3472/discrete.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
> index 07b302e09340..cd0743300d7f 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -289,10 +289,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>   	int3472->ngpios++;
>   	ACPI_FREE(obj);
>   
> -	if (ret < 0)
> -		return dev_err_probe(int3472->dev, ret, err_msg);
> -
> -	return ret;
> +	return dev_err_probe(int3472->dev, ret, err_msg);
>   }
>   
>   static int skl_int3472_parse_crs(struct int3472_discrete_device *int3472)


