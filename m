Return-Path: <linux-kernel+bounces-309398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199659669DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D01B1C256B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07D01BDAA8;
	Fri, 30 Aug 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EVFmW8zm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C939633CD1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046384; cv=none; b=trGOVXT1NFNHelI6d3v/+1Ch9eGRqKRSQ196s71NAQezY/vwvEXP/G7qw/6W2b9xEYdUY8Iq8wbDqVleCNM4ISzawZMeCBlC6DOeDgeGHngpkz78qrqkeOV1OLWGL9eV1PCNBcfikMG1dnotA63Bw8JHnjVENJSu9sMv7hbZ69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046384; c=relaxed/simple;
	bh=EGQHQ9fk8ZiqDNL6+X+CQQWMMmNTIja/SNDq7dE//XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzB01es6JYefzQYuQNmFbeV0YXS/bIUZFnk5DLF5S48EumhQmv9/0MmyStyMqOL+ttYgA0iX6aznKwWwkINGuslB0ms0UvQBGbzRTgP53nh0Ds8xowTdOeet0Rvbhf4gKc7gCvYJ2I5UTIfF0FRD0XhiqTcLdyOuJdJTv2GoQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EVFmW8zm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725046379;
	bh=EGQHQ9fk8ZiqDNL6+X+CQQWMMmNTIja/SNDq7dE//XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVFmW8zm6BHJo4kzQuf1Ng1cIjCUEEe08QXEAtUdXsssM/A105UrkQdJEMDQECxWE
	 DHIr8fVYHbhGxUtopqOj0q5rhUp0kfQtf/yjp8xRxmRMH2lSimy5tN/OyK5H743Tm8
	 4d+9tqLjSE7YXJ7Y68c8NOoX00M+WTBarAwkVVkM/SV1Z1JQIhQy8O3cpVEV8haA24
	 ZY2UXS8KGYs+opY/035pG4aoDHkoi51ImMzy1eCdlghZ8fqsak6V/ewfxXm2hV8VMM
	 BaO0B6HpVFcQwwq8KrWahZYQ+V4fY4EkMHfZNpQEah1kGPn22KK12KJTO9fEt/4bPk
	 t8wGKP+MMkeQA==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F2CED17E114A;
	Fri, 30 Aug 2024 21:32:58 +0200 (CEST)
Date: Fri, 30 Aug 2024 15:32:56 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] soc: mediatek: Simplify with dev_err_probe()
Message-ID: <d269df37-3bf9-45fd-8e3f-fb4f36ff9d8f@notapiano>
References: <20240830080538.376200-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830080538.376200-1-yanzhen@vivo.com>

Hi,

thank you for the patch. See comments below.

On Fri, Aug 30, 2024 at 04:05:38PM +0800, Yan Zhen wrote:
> Using dev_err_probe() to simplify the error path and unify a 
> message template.
> 

From [1]:

  Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead of
  “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as if
  you are giving orders to the codebase to change its behaviour.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

So should be "Use dev_err_probe()...".

Also, the commit summary seems a bit too broad, please add "mtk-mmsys:" in the
subsystem:

  soc: mediatek: mtk-mmsys: Simplify with dev_err_probe()

> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
> 
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
> 
> Changes in v2:
> - Get rid of `ret = PTR_ERR(mmsys->regs);`.
> 
>  drivers/soc/mediatek/mtk-mmsys.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 938240714e54..a6e0c41c10ab 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -397,11 +397,9 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mmsys->regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(mmsys->regs)) {
> -		ret = PTR_ERR(mmsys->regs);
> -		dev_err(dev, "Failed to ioremap mmsys registers: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(mmsys->regs))
> +		return dev_err_probe(dev, PTR_ERR(mmsys->regs),
> +					"Failed to ioremap mmsys registers");

You're missing the \n at the end of the string.

Also, would look nicer if it was aligned like so:

		return dev_err_probe(dev, PTR_ERR(mmsys->regs),
				     "Failed to ioremap mmsys registers\n");

>  
>  	mmsys->data = of_device_get_match_data(&pdev->dev);
>  
> @@ -413,10 +411,9 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>  		mmsys->rcdev.ops = &mtk_mmsys_reset_ops;
>  		mmsys->rcdev.of_node = pdev->dev.of_node;
>  		ret = devm_reset_controller_register(&pdev->dev, &mmsys->rcdev);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Couldn't register mmsys reset controller: %d\n", ret);
> -			return ret;
> -		}
> +		if (ret)
> +			dev_err_probe(&pdev->dev, ret,
> +					"Couldn't register mmsys reset controller");

You're missing the return here. And the \n is also missing.

Also, here checkpatch actually complains about the alignment (run
'scripts/checkpatch.pl --strict' on your patch).

CHECK: Alignment should match open parenthesis
#50: FILE: drivers/soc/mediatek/mtk-mmsys.c:416:
+			dev_err_probe(&pdev->dev, ret,
+					"Couldn't register mmsys reset controller");

After making those changes you can add

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

