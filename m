Return-Path: <linux-kernel+bounces-294988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5B959520
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07591F22594
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03D19258B;
	Wed, 21 Aug 2024 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XzM/gxMA"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5E192580
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223196; cv=none; b=dyd1ZUdu63O3JzvuES/wzPxuoQ3IJ7Hwco+7EID8bJ9V08hYqp4TrebrvSIGHyZQ6xklx2YxBJVL4O4aGBH0fdLszXVOqM5Yc04qeUtymoLmA7gXtfzDm96wVgQ859x/tBxMtONeuUPfpAZTg/vPOAxFMeQwWEE8zbrPcSR4Log=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223196; c=relaxed/simple;
	bh=8zsTj2kFmANqQRunXFC+IxA30EoRsV6r0wTj00GQXCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K68+V/hP9EGLAlFi/2YNcmG4tWrxmKcZdFQZU+r5aXfZi5I6Cluu8jJ/4tskwDKpJFExAQDBfwG0MWixa2LoRQO6pUhpKoiz7BHCrb3LsMGY8fs+tvqbW6nO+Vyz5B8r5Inuz13EHJuGrAAF+cDeCmw03UbfHtIhArWpH5UOC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XzM/gxMA; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gfDLs67VmoIRNgfDLsa0Um; Wed, 21 Aug 2024 08:53:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724223185;
	bh=Y6PE42jxZgX9ZhRl24qtZNSOFVBjNngY7GQle21v0Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XzM/gxMAjcNRC/EZmrI4lnF8X1aidNQHk76GWjzR3ZKiunIP+zObNw5on1HQQahqx
	 PziD3061P/XwuAX3qObOTfmuzQVUepbHZIlhVyqE71a4wJQdm/aFZstG/zEeC8eKZj
	 ZjICV0mx1aZktAA5i1+Cs8q88YnGjNoCAkptSQHi5BVZBWF2ZpoXQ7DG3Wqa+eDicf
	 dBfEETUnCsQ7N/4pWhJMmHyZxbv63SaqWHqVUsiqhsjA37a29npnoMkl+G+hHTtv0d
	 y60RfdyYMlycqp+pxxvxwOwafRz2y28i5lqB0HWyLXxX4beHscTnCHOdAG35GKVIzV
	 7VKmPINVuGGyA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 08:53:05 +0200
X-ME-IP: 90.11.132.44
Message-ID: <183e6ca4-f1b4-4b41-bad1-9999df205277@wanadoo.fr>
Date: Wed, 21 Aug 2024 08:53:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmem: jz4780-efuse: Use devm_clk_get_enabled()
 helpers
To: Huan Yang <link@vivo.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240821014001.788676-1-link@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240821014001.788676-1-link@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 03:40, Huan Yang a écrit :
> The devm_clk_get_enabled() helpers:
>       - call devm_clk_get()
>       - call clk_prepare_enable() and register what is needed in order to
>        call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> Due to clk only used when probe, no need to save it into jz4780_efuse.
> 
> Signed-off-by: Huan Yang <link@vivo.com>
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Nitpick: no need to add this S-b. I just made a comment when looking at 
your patch in order to improve it. I'm not the one that suggested the 
initial change. All merit is yours.


Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

> ---
> v1 -> v2: remove clk pointer from jz4780_efuse
> 
>   drivers/nvmem/jz4780-efuse.c | 26 +++++---------------------
>   1 file changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
> index 0b01b840edd9..99c43c93f4a5 100644
> --- a/drivers/nvmem/jz4780-efuse.c
> +++ b/drivers/nvmem/jz4780-efuse.c
> @@ -62,7 +62,6 @@
>   struct jz4780_efuse {
>   	struct device *dev;
>   	struct regmap *map;
> -	struct clk *clk;
>   };
>   
>   /* main entry point */
> @@ -131,11 +130,6 @@ static const struct regmap_config jz4780_efuse_regmap_config = {
>   	.max_register = JZ_EFUDATA(7),
>   };
>   
> -static void clk_disable_unprepare_helper(void *clock)
> -{
> -	clk_disable_unprepare(clock);
> -}
> -
>   static int jz4780_efuse_probe(struct platform_device *pdev)
>   {
>   	struct nvmem_device *nvmem;
> @@ -146,7 +140,7 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
>   	unsigned long rd_strobe;
>   	struct device *dev = &pdev->dev;
>   	void __iomem *regs;
> -	int ret;
> +	struct clk *clk;
>   
>   	efuse = devm_kzalloc(dev, sizeof(*efuse), GFP_KERNEL);
>   	if (!efuse)
> @@ -161,21 +155,11 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
>   	if (IS_ERR(efuse->map))
>   		return PTR_ERR(efuse->map);
>   
> -	efuse->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(efuse->clk))
> -		return PTR_ERR(efuse->clk);
> -
> -	ret = clk_prepare_enable(efuse->clk);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       clk_disable_unprepare_helper,
> -				       efuse->clk);
> -	if (ret < 0)
> -		return ret;
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
>   
> -	clk_rate = clk_get_rate(efuse->clk);
> +	clk_rate = clk_get_rate(clk);
>   
>   	efuse->dev = dev;
>   


