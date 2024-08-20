Return-Path: <linux-kernel+bounces-294014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0A29587C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA420B21EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE809190462;
	Tue, 20 Aug 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sMOw9i9v"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130D18E35F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160175; cv=none; b=hFyAAhxGVmb21jCreR46y44K0GRBmaBnk12ey6tsL3KyEx2Jo5aXQQKSfeZokkLi/kKdwq+g+CzqWn45ctutFv1K078y6WMUFoJBw6a8PImH+nYz5rcUfKUzxKo6yiqUw0tYIDjkz7j0k4y+QWP4bH6vKLYBkdL+ubfLz1cL0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160175; c=relaxed/simple;
	bh=6SsWzGhQg6mX4Dz+eNdrAP21roHMdCf36hZ17CmA96U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruce/7RO1f1lpUP3eYtmT2Cv2M/4wtqNfiDpGHoZuMlfyCkCMAH/PuQpWnfMCcPz17dNeSPZ0NPRRcLjxnNYRlyh30eldQUu+lg5h7BiTXoqfG2BxQV+Sromjg7G4Skc4TkQhbB9rqj8Ohho8ofNpr96eT0s+JvouIiaYAxUyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sMOw9i9v; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gOnssXi27kjrSgOntsuabK; Tue, 20 Aug 2024 15:21:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724160102;
	bh=SeWGNhxdzGRrfnsYXDgtDRYV+3+oxeaoACzrlFrl3Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=sMOw9i9v0tU9ZWbnudGNgjqMsAcxZWb/JiuQ7jIDdxCyRyqdTcc4kUZNMHnnlFR4J
	 B2XYP1/dH4x9Je74CK1jrLORQWBA4ZJtFPE78Z8yELBG1pa4iVgtCoafnxO1l7XIy7
	 0P9bUkvqLnqAdKEgbzHtRGuyi40fidNTg0jgWc9Sv6ejvtGG85dDLPdOW/WgyDYZg2
	 4NYPCEWGST7fL7bU2fWpuOGWWWUwACc3SFzeJbw7nrP5cbUzI7mtIduqtEQorcfNgX
	 +Hjf6I7TWlLxDAdDCqgURteRWxEUf5c1JiEV5puraNqOTC7J98yvW9agFS0WZor2j9
	 D2JoYnOZXdwog==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 20 Aug 2024 15:21:42 +0200
X-ME-IP: 90.11.132.44
Message-ID: <7b31732e-00ca-4792-a16b-156689862c5b@wanadoo.fr>
Date: Tue, 20 Aug 2024 15:21:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: jz4780-efuse: Use devm_clk_get_enabled() helpers
To: Huan Yang <link@vivo.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240820102333.133503-1-link@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240820102333.133503-1-link@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/08/2024 à 12:23, Huan Yang a écrit :
> The devm_clk_get_enabled() helpers:
>      - call devm_clk_get()
>      - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> Signed-off-by: Huan Yang <link@vivo.com>
> ---

Hi,

if you want to go 1 step further, I think that 'clk' can now also be 
removed from struct jz4780_efuse.

Just my 2c.

CJ

>   drivers/nvmem/jz4780-efuse.c | 18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
> index 0b01b840edd9..2b5badfbf22f 100644
> --- a/drivers/nvmem/jz4780-efuse.c
> +++ b/drivers/nvmem/jz4780-efuse.c
> @@ -131,11 +131,6 @@ static const struct regmap_config jz4780_efuse_regmap_config = {
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
> @@ -146,7 +141,6 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
>   	unsigned long rd_strobe;
>   	struct device *dev = &pdev->dev;
>   	void __iomem *regs;
> -	int ret;
>   
>   	efuse = devm_kzalloc(dev, sizeof(*efuse), GFP_KERNEL);
>   	if (!efuse)
> @@ -161,20 +155,10 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
>   	if (IS_ERR(efuse->map))
>   		return PTR_ERR(efuse->map);
>   
> -	efuse->clk = devm_clk_get(&pdev->dev, NULL);
> +	efuse->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   	if (IS_ERR(efuse->clk))
>   		return PTR_ERR(efuse->clk);
>   
> -	ret = clk_prepare_enable(efuse->clk);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       clk_disable_unprepare_helper,
> -				       efuse->clk);
> -	if (ret < 0)
> -		return ret;
> -
>   	clk_rate = clk_get_rate(efuse->clk);
>   
>   	efuse->dev = dev;


