Return-Path: <linux-kernel+bounces-239506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5217992610E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AB21F23C53
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37C117B43C;
	Wed,  3 Jul 2024 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AZVK1BI1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5117083F;
	Wed,  3 Jul 2024 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011743; cv=none; b=NRvFpY1oI+G8GHIn/y9jODLuP9/WYVreqT1lS5Hba1Xs+bm4TNA7YmuPZ437q841oSxSQdFipYZNY9FF+mhPBp6AuylJAvR1iSEFZa380EHjy6EgNHkc3vhyPm24BCxOy4NP5+L1bl4JtX+2wzTk6da3F+xSudw+ygaZkRZx22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011743; c=relaxed/simple;
	bh=+M9F+vfRgYjR1PTmjDTzGuhYqKbDAqfPRpyWcUy5ijE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lh7CPI9JI39KmljQpguJPyvVXZKI+tgA3pA6HRV5PW0qemFW8zLbUV5iLfVR7Am0kGp254R14rP2JuLiNWGmiBvcTQqAkdn/F0Ks6IjFtYqhLnHf3B65C0KifdI2xC7nqdHd4RFjc/CLAPK3pOrDQ0fltbDOiNo/9nQ8x/89lQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AZVK1BI1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720011739;
	bh=+M9F+vfRgYjR1PTmjDTzGuhYqKbDAqfPRpyWcUy5ijE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AZVK1BI1q5Tlke9vsKCXWn1a/Q8FYm05+J+Ctu2qKMtSf5R4mF8cw6zM4+0TwTNpP
	 GFhKc+E+2IXyP9gCCCGPzxJTIhHEkKn1vf1lduVyPYFj/nU0cT5vyNZEZ88IFE7g4b
	 +JqJKNu7ibsbruibslyRHUZtIt+8XEGqSg6Zx4tZGxML4flykmcCbQlXug2g6kpDzz
	 xiuNZ6JFATtrfN7tTLmwxKe/NKN8pOkqjSJeoTxoibGaznwXBIKVgPAUuTpuPtC9Od
	 6tuXTwdFFYYdgbQhB6q/aVpgnp8I/XohqpzqzXur0zAaXnI+rPfugaWQjtyzTzzLI6
	 TG88tDjFpPgdg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0AC0037821CD;
	Wed,  3 Jul 2024 13:02:18 +0000 (UTC)
Message-ID: <65b422fe-ecc1-4f57-bb72-f2fef3a5af28@collabora.com>
Date: Wed, 3 Jul 2024 15:02:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] soc: mediatek: pwrap: Use
 devm_clk_get_[optional_]enabled()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 matthias.bgg@gmail.com, fparent@baylibre.com, fchiby@baylibre.com,
 s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1719652155.git.christophe.jaillet@wanadoo.fr>
 <07b3745819c8ba818d4508ed12e93f14f29b80a2.1719652155.git.christophe.jaillet@wanadoo.fr>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <07b3745819c8ba818d4508ed12e93f14f29b80a2.1719652155.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/06/24 11:19, Christophe JAILLET ha scritto:
> Use devm_clk_get_enabled() and devm_clk_get_optional_enabled() to simplify
> the code and to make sure that clk_disable_unprepare() is called if the
> driver is unloaded.
> 
> Fixes: 55924157da8c ("soc: mediatek: pwrap: add support for sys & tmr clocks")
> Fixes: 1f022d84bd19 ("soc: mediatek: Add PMIC wrapper for MT8135 and MT8173 SoCs")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 85 ++++++++--------------------
>   1 file changed, 25 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index d57553486383..6981d6a1ab93 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1366,10 +1366,6 @@ struct pmic_wrapper {
>   	struct regmap *regmap;
>   	const struct pmic_wrapper_type *master;
>   	const struct pwrap_slv_type *slave;
> -	struct clk *clk_spi;
> -	struct clk *clk_wrap;
> -	struct clk *clk_sys;
> -	struct clk *clk_tmr;
>   	struct reset_control *rstc;
>   
>   	struct reset_control *rstc_bridge;
> @@ -2471,6 +2467,7 @@ static int pwrap_probe(struct platform_device *pdev)
>   {
>   	int ret, irq;
>   	u32 mask_done;
> +	struct clk *clk;
>   	struct pmic_wrapper *wrp;
>   	struct device_node *np = pdev->dev.of_node;
>   	const struct of_device_id *of_slave_id = NULL;
> @@ -2521,50 +2518,34 @@ static int pwrap_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	wrp->clk_spi = devm_clk_get(wrp->dev, "spi");
> -	if (IS_ERR(wrp->clk_spi)) {
> +	clk = devm_clk_get_enabled(wrp->dev, "spi");

Uhm... in this case, it might be worth using devm_clk_bulk_get_all_enable()
instead... as anyway we're never turning off those clocks during operation.

I checked the devicetrees and the clocks are ordered the right way, but then
we can also consider the fact that the bindings are enforcing the clock order
so that's.. golden.

Practically, by using devm_clk_bulk_get_all_enable(), you're removing even
more lines from this driver, as those four clocks (and four times error checking)
will be reduced to just one call.....!

Thanks for cleaning up this driver, btw!

Cheers,
Angelo


> +	if (IS_ERR(clk)) {
>   		dev_dbg(wrp->dev, "failed to get clock: %ld\n",
> -			PTR_ERR(wrp->clk_spi));
> -		return PTR_ERR(wrp->clk_spi);
> +			PTR_ERR(clk));
> +		return PTR_ERR(clk);
>   	}
>   
> -	wrp->clk_wrap = devm_clk_get(wrp->dev, "wrap");
> -	if (IS_ERR(wrp->clk_wrap)) {
> +	clk = devm_clk_get_enabled(wrp->dev, "wrap");
> +	if (IS_ERR(clk)) {
>   		dev_dbg(wrp->dev, "failed to get clock: %ld\n",
> -			PTR_ERR(wrp->clk_wrap));
> -		return PTR_ERR(wrp->clk_wrap);
> +			PTR_ERR(clk));
> +		return PTR_ERR(clk);
>   	}
>   
> -	wrp->clk_sys = devm_clk_get_optional(wrp->dev, "sys");
> -	if (IS_ERR(wrp->clk_sys)) {
> -		return dev_err_probe(wrp->dev, PTR_ERR(wrp->clk_sys),
> +	clk = devm_clk_get_optional_enabled(wrp->dev, "sys");
> +	if (IS_ERR(clk)) {
> +		return dev_err_probe(wrp->dev, PTR_ERR(clk),
>   				     "failed to get clock: %pe\n",
> -				     wrp->clk_sys);
> +				     clk);
>   	}
>   
> -	wrp->clk_tmr = devm_clk_get_optional(wrp->dev, "tmr");
> -	if (IS_ERR(wrp->clk_tmr)) {
> -		return dev_err_probe(wrp->dev, PTR_ERR(wrp->clk_tmr),
> +	clk = devm_clk_get_optional_enabled(wrp->dev, "tmr");
> +	if (IS_ERR(clk)) {
> +		return dev_err_probe(wrp->dev, PTR_ERR(clk),
>   				     "failed to get clock: %pe\n",
> -				     wrp->clk_tmr);
> +				     clk);
>   	}
>   
> -	ret = clk_prepare_enable(wrp->clk_spi);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare_enable(wrp->clk_wrap);
> -	if (ret)
> -		goto err_out1;
> -
> -	ret = clk_prepare_enable(wrp->clk_sys);
> -	if (ret)
> -		goto err_out2;
> -
> -	ret = clk_prepare_enable(wrp->clk_tmr);
> -	if (ret)
> -		goto err_out3;
> -
>   	/* Enable internal dynamic clock */
>   	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {
>   		pwrap_writel(wrp, 1, PWRAP_DCM_EN);
> @@ -2579,7 +2560,7 @@ static int pwrap_probe(struct platform_device *pdev)
>   		ret = pwrap_init(wrp);
>   		if (ret) {
>   			dev_dbg(wrp->dev, "init failed with %d\n", ret);
> -			goto err_out4;
> +			return ret;
>   		}
>   	}
>   
> @@ -2592,8 +2573,7 @@ static int pwrap_probe(struct platform_device *pdev)
>   
>   	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & mask_done)) {
>   		dev_dbg(wrp->dev, "initialization isn't finished\n");
> -		ret = -ENODEV;
> -		goto err_out4;
> +		return -ENODEV;
>   	}
>   
>   	/* Initialize watchdog, may not be done by the bootloader */
> @@ -2622,42 +2602,27 @@ static int pwrap_probe(struct platform_device *pdev)
>   		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
>   
>   	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		ret = irq;
> -		goto err_out2;
> -	}
> +	if (irq < 0)
> +		return irq;
>   
>   	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
>   			       IRQF_TRIGGER_HIGH,
>   			       "mt-pmic-pwrap", wrp);
>   	if (ret)
> -		goto err_out4;
> +		return ret;
>   
>   	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, wrp->slave->regops->regmap);
> -	if (IS_ERR(wrp->regmap)) {
> -		ret = PTR_ERR(wrp->regmap);
> -		goto err_out2;
> -	}
> +	if (IS_ERR(wrp->regmap))
> +		return PTR_ERR(wrp->regmap);
>   
>   	ret = of_platform_populate(np, NULL, NULL, wrp->dev);
>   	if (ret) {
>   		dev_dbg(wrp->dev, "failed to create child devices at %pOF\n",
>   				np);
> -		goto err_out4;
> +		return ret;
>   	}
>   
>   	return 0;
> -
> -err_out4:
> -	clk_disable_unprepare(wrp->clk_tmr);
> -err_out3:
> -	clk_disable_unprepare(wrp->clk_sys);
> -err_out2:
> -	clk_disable_unprepare(wrp->clk_wrap);
> -err_out1:
> -	clk_disable_unprepare(wrp->clk_spi);
> -
> -	return ret;
>   }
>   
>   static struct platform_driver pwrap_drv = {




