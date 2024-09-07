Return-Path: <linux-kernel+bounces-319653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B95970029
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E0BB21AE7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289815336B;
	Sat,  7 Sep 2024 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="nZyf2W9B"
Received: from msa.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F8EED8;
	Sat,  7 Sep 2024 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725686285; cv=none; b=bXK86g1JhUhOtAzbXZ0bNKRPsdIXx7xe56qRe98/r9ZMIDrqbQJroJEBz3P17S+kj5RNTw8FrKycueg7KZvuD4pFyzPkkJRNTiKzgRsadKus+qFWfOteFVACspqQWESpww/P8no4thp0Rh7iAW1AcJTW3iUvXdwkQKpnDRFoklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725686285; c=relaxed/simple;
	bh=UJGS4hukZhi/1f0Pm1k4J6IKHrTjLf2L3z9Wr0Ljbyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=sqbzQE9mPR1tDMG1k3K03iWx6j/zHubjdmk17Tz9B3GQFNiBvte+g5YDZhnvaZhwd1hDL/uvoq5ee5WwN6H07Vhf/pTzw/7AftAyljaUnkr/ThUN6ZAh2zeG2Qc0pdFvmQh0qv0ZzJIIejisF78We0y7cE2XbpBV+mMfkmiFxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=nZyf2W9B; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id mnpcsV4ES6mdlmnpcsxKPo; Sat, 07 Sep 2024 07:17:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725686280;
	bh=T74dM4a9o8MJXWRHczPa96Jl3U3aNHiJ5FfMrEntuXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=nZyf2W9BL+Z7qKkq6EfyWzzFYQnVGrbk2aHdRjUhYHOzdrIH8GmCJ2kIJgfXhQBHK
	 /TJKtcTwfNMIH+3U5FbyxHiYkkvC6/w/90Hy0dBWJctnBcyyHoTEhFgoCaFTxjy3lH
	 YjgPJ/OizHpz3UFqodNokuEDNbMZc50/N3j1eGLm8aX44PtCqMrqL57pC/zpN+ALUP
	 krQ3wpZL7ISYTf/wTEGwA22zyl7fzxXrym+nKY8w3qA1Rkk/duaeVN+saGkchjegFE
	 UjFrS52vCXBlI7ltlH1FxlIFBaJz3eULYk3ljwFdE4zpNv76p3IYLTjQLzMsohpIyc
	 K7SdCzPZooYCg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 07 Sep 2024 07:18:00 +0200
X-ME-IP: 90.11.132.44
Message-ID: <1cda7882-56e2-445f-b3cf-0366236250e6@wanadoo.fr>
Date: Sat, 7 Sep 2024 07:17:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] usb: musb: mediatek: Simplify code with
 dev_err_probe()
To: linruifeng4@huawei.com
References: <20240907034226.120159-1-linruifeng4@huawei.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: angelogioacchino.delregno@collabora.com, b-liu@ti.com,
 gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-usb@vger.kernel.org, matthias.bgg@gmail.com
In-Reply-To: <20240907034226.120159-1-linruifeng4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/09/2024 à 05:42, Lin Ruifeng a écrit :
> The combination of dev_err() and the returned error code could be
> replaced by dev_err_probe() in driver's probe function. Let's,
> converting to dev_err_probe() to make code more simple.
> 
> Signed-off-by: Lin Ruifeng <linruifeng4-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/usb/musb/mediatek.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
> index 0a35aab3ab81..393b909de238 100644
> --- a/drivers/usb/musb/mediatek.c
> +++ b/drivers/usb/musb/mediatek.c
> @@ -416,10 +416,9 @@ static int mtk_musb_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	ret = of_platform_populate(np, NULL, NULL, dev);
> -	if (ret) {
> -		dev_err(dev, "failed to create child devices at %p\n", np);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				"failed to create child devices at %p\n", np);
>   
>   	ret = mtk_musb_clks_get(glue);
>   	if (ret)
> @@ -448,23 +447,19 @@ static int mtk_musb_probe(struct platform_device *pdev)
>   		glue->role = USB_ROLE_NONE;
>   		break;
>   	default:
> -		dev_err(&pdev->dev, "Error 'dr_mode' property\n");
> -		return -EINVAL;
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				"failed to create child devices at %p\n", np);

This message is wrong.
You made a cut'n'paste of the previous one.

>   	}
>   
>   	glue->phy = devm_of_phy_get_by_index(dev, np, 0);
> -	if (IS_ERR(glue->phy)) {
> -		dev_err(dev, "fail to getting phy %ld\n",
> -			PTR_ERR(glue->phy));
> -		return PTR_ERR(glue->phy);
> -	}
> +	if (IS_ERR(glue->phy))
> +		return dev_err_probe(dev, PTR_ERR(glue->phy),
> +				"fail to getting phy\n");

While a it, change it to "failed to get phy"?

>   
>   	glue->usb_phy = usb_phy_generic_register();
> -	if (IS_ERR(glue->usb_phy)) {
> -		dev_err(dev, "fail to registering usb-phy %ld\n",
> -			PTR_ERR(glue->usb_phy));
> -		return PTR_ERR(glue->usb_phy);
> -	}
> +	if (IS_ERR(glue->usb_phy))
> +		return dev_err_probe(dev, PTR_ERR(glue->usb_phy),
> +				"fail to registering usb-phy\n");

While a it, change it to "failed to register usb-phy"?

CJ

>   
>   	glue->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
>   	if (IS_ERR(glue->xceiv)) {


