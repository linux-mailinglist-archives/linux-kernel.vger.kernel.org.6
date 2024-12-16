Return-Path: <linux-kernel+bounces-448152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8AE9F3C34
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A0D16451B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC401DB356;
	Mon, 16 Dec 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="dCBsJe4B"
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ADD1D54FE;
	Mon, 16 Dec 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.142.107.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382590; cv=none; b=Tm5B4b1ZeCySYS9qbdxxAlYC717NTXiTgE47cNjdQRBgAw83Vvg2BDi/PS2tmT3+Bal6bS/8+WdchsfNGnfbtZjlJgyu/bNNQbFbyzkPzOvzpqypw9LFZwTChZSfYOx4lUpYzZqMGN4j1q0XRktnthu7wCoFU0pWD2fkRAGlQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382590; c=relaxed/simple;
	bh=f33spiVBZWwMRJ3qOGnfEAtYYVvmfxcG+mtlDjn47SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbDFJy1iJFCiNyBhNnOKVf6dKU5vKrTVP952qTstGznRv3NFlrzt6EYEcHKGbAEbL5RLbjJcO/8c53fcujOdcgYFHA6ZLnbmEwU7k9CMcBkb6jW2VjajCaMVHKIWRkdPiwU02Qap67yCizFinTZNJYcuMHC3bAbHuys/rLVvCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com; spf=pass smtp.mailfrom=lechnology.com; dkim=pass (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b=dCBsJe4B; arc=none smtp.client-ip=98.142.107.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lechnology.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u0i/nqNynhxorDvBqYi7rvVswVl5vc8AALs0sk1McnI=; b=dCBsJe4Bk88bliVyeBzNr1Uwdr
	ukVRX8GFzABGPSrQM5nnA4tfZnTgC3ILRuRZgfYheRcoRJ7Y5T4O2/2s1NyoBLdYhdCtPP8al6Q0a
	E23JGHAt8UUC4Fly10pF3suh8ol89JOXgJxeLchkQFyEOIsK/1Cc8iEmbBAMKk6bFrvpx1BmSoxOS
	zgqyHtVKCWAcC9VmZS9Lpy5aFROJxn+zjLDXL+GUMBW6hQ1xi7C/XgVRSsG3wAXy2ruruZhJ3rwoS
	2do2NfqCPpBb+AXu8fdiy8ZhE8/dU/CnyEYYkydpQzgf4uYhEGK4w1Rxs7dFSew4lRIl03ApLa2wW
	gTysbyIg==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:47916 helo=[192.168.0.142])
	by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <david@lechnology.com>)
	id 1tNHjj-0003xF-2u;
	Mon, 16 Dec 2024 15:29:40 -0500
Message-ID: <24fb0bdb-6d59-424e-bb8f-a9d54d835f4b@lechnology.com>
Date: Mon, 16 Dec 2024 14:29:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: davinci: remove platform data struct
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20241210175723.127594-1-brgl@bgdev.pl>
Content-Language: en-US
From: David Lechner <david@lechnology.com>
Autocrypt: addr=david@lechnology.com; keydata=
 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
In-Reply-To: <20241210175723.127594-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 12/10/24 11:57 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There are no board files using struct davinci_pll_platform_data anymore.
> The structure itself is currently used to store a single pointer. Let's
> remove the struct definition, the header and rework the driver to not
> require the syscon regmap to be stored in probe().
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/clk/davinci/pll.c                     | 33 +++----------------
>  include/linux/platform_data/clk-davinci-pll.h | 21 ------------
>  2 files changed, 4 insertions(+), 50 deletions(-)
>  delete mode 100644 include/linux/platform_data/clk-davinci-pll.h
> 
> diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
> index 5bbbb3a66477..b284da602f8d 100644
> --- a/drivers/clk/davinci/pll.c
> +++ b/drivers/clk/davinci/pll.c
> @@ -19,7 +19,6 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/notifier.h>
>  #include <linux/of.h>
> -#include <linux/platform_data/clk-davinci-pll.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> @@ -840,27 +839,6 @@ int of_davinci_pll_init(struct device *dev, struct device_node *node,
>  	return 0;
>  }
>  
> -static struct davinci_pll_platform_data *davinci_pll_get_pdata(struct device *dev)
> -{
> -	struct davinci_pll_platform_data *pdata = dev_get_platdata(dev);
> -
> -	/*
> -	 * Platform data is optional, so allocate a new struct if one was not
> -	 * provided. For device tree, this will always be the case.
> -	 */
> -	if (!pdata)
> -		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata)
> -		return NULL;
> -
> -	/* for device tree, we need to fill in the struct */
> -	if (dev->of_node)
> -		pdata->cfgchip =
> -			syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
> -
> -	return pdata;
> -}
> -
>  /* needed in early boot for clocksource/clockevent */
>  #ifdef CONFIG_ARCH_DAVINCI_DA850
>  CLK_OF_DECLARE(da850_pll0, "ti,da850-pll0", of_da850_pll0_init);
> @@ -890,8 +868,8 @@ typedef int (*davinci_pll_init)(struct device *dev, void __iomem *base,
>  static int davinci_pll_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct davinci_pll_platform_data *pdata;
>  	davinci_pll_init pll_init = NULL;
> +	struct regmap *cfgchip;

I think we need to initialize this to NULL since it is only set
conditionally later.

>  	void __iomem *base;
>  
>  	pll_init = device_get_match_data(dev);
> @@ -903,17 +881,14 @@ static int davinci_pll_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	pdata = davinci_pll_get_pdata(dev);
> -	if (!pdata) {
> -		dev_err(dev, "missing platform data\n");
> -		return -EINVAL;
> -	}
> +	if (dev->of_node)

Or just leave out the if here.

> +		cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
>  
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -	return pll_init(dev, base, pdata->cfgchip);
> +	return pll_init(dev, base, cfgchip);
>  }
>  

