Return-Path: <linux-kernel+bounces-295167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1011B959811
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4521C21C92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C660C1AF4D8;
	Wed, 21 Aug 2024 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eXtOxnJs"
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836B1AF4CF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230383; cv=none; b=n7XLbgzrYAgjV8V6J98alNp9Ajy3w5y3giwIt3rYOBE1nuRKDViWMKlWQrHUOfelXirRKpniidqbXqWjJl2zQPL6zvlPudQbjeZXwSmFPJzd+iS+5N+UwbI8EsBiTPKIQtVPO4+/RvVtdz7eh7JKIfAC7Gf2OkSIzGGGh3je6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230383; c=relaxed/simple;
	bh=eQ0lRGmxhBKrmsCrYIZnXk1EPkKYAJq+d1QdFzwIHSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9LH77fr/yKZCQh0nCajS7VRsSnG3dGku1aHORCzBh5RsC/Kt3StSTTk4Zd7SEil/B2r4j96uH0y2XIKe4TiBbMT+VrrYakC48mG7b0yL/FxHChScQojpXhgWp3YJcu/XuZcSE4I0UCtmzFTy18yGHl8KbJh0WUMZj6wkWFLuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eXtOxnJs; arc=none smtp.client-ip=80.12.242.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gfK9so4gXJokxgfK9sTirb; Wed, 21 Aug 2024 09:00:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724223607;
	bh=MBvRzI7GXsEtw0mfN/60SlpupZEWydInYQb9ZLdmiBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=eXtOxnJsqgRJOJEFbTiw62RbgtPG7xp5y1ELk8NQPZuAWwTAZs8Myg9DKmsGrdG3K
	 UC4RBjEp0EMRDIJyrRF9KOIIO5PXDw3ZME2qsW6pFiMDoTzzOPfePhmNsfhYxEEQ7Q
	 oRVPnf4BDBa8dUSjhGlaULqYWAcWqXW/2BAA/D0oFy8X1fYnAQIYJxxmcFlquTb8lG
	 o4iHDPF2qht2ICBBfriuhPJ82v8ccgujJy/GpoOdmHhHWvsHiW3P8Z9P1SPdF1QnuU
	 DixooiYw6A4g/ncSTYwzYTNH6fxpc7LwDRlyE6SgfvLLvxG2OzgkoYSQNeZ2dGlIvV
	 cVvUio0zWXJTg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 09:00:07 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8f577565-69b7-4da0-a7fe-2e94bf37948c@wanadoo.fr>
Date: Wed, 21 Aug 2024 09:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: sprd: Use devm_clk_get_enabled() helpers
To: Huan Yang <link@vivo.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240821013901.787555-1-link@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240821013901.787555-1-link@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 03:39, Huan Yang a écrit :
> The devm_clk_get_enabled() helpers:
>       - call devm_clk_get()
>       - call clk_prepare_enable() and register what is needed in order to
>        call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> Due to clk only used in probe, not in suspend\resume, this pointer can
> remove from sprd_mbox_priv to save a little memory.
> 
> Signed-off-by: Huan Yang <link@vivo.com>
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Nitpick: no need to add this S-b. I just made a comment when looking at 
your patch in order to improve it. I'm not the one that suggested the 
initial change. All merit is yours.

Also, I think that, if used, it should be above your Signed-off.


Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

> ---
> v1 -> v2: remove clk pointer from sprd_mbox_priv
> 
>   drivers/mailbox/sprd-mailbox.c | 25 ++++---------------------
>   1 file changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> index 9ae57de77d4d..ee8539dfcef5 100644
> --- a/drivers/mailbox/sprd-mailbox.c
> +++ b/drivers/mailbox/sprd-mailbox.c
> @@ -62,7 +62,6 @@ struct sprd_mbox_priv {
>   	void __iomem		*outbox_base;
>   	/*  Base register address for supplementary outbox */
>   	void __iomem		*supp_base;
> -	struct clk		*clk;
>   	u32			outbox_fifo_depth;
>   
>   	struct mutex		lock;
> @@ -291,19 +290,13 @@ static const struct mbox_chan_ops sprd_mbox_ops = {
>   	.shutdown	= sprd_mbox_shutdown,
>   };
>   
> -static void sprd_mbox_disable(void *data)
> -{
> -	struct sprd_mbox_priv *priv = data;
> -
> -	clk_disable_unprepare(priv->clk);
> -}
> -
>   static int sprd_mbox_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct sprd_mbox_priv *priv;
>   	int ret, inbox_irq, outbox_irq, supp_irq;
>   	unsigned long id, supp;
> +	struct clk *clk;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -331,20 +324,10 @@ static int sprd_mbox_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->outbox_base))
>   		return PTR_ERR(priv->outbox_base);
>   
> -	priv->clk = devm_clk_get(dev, "enable");
> -	if (IS_ERR(priv->clk)) {
> +	clk = devm_clk_get_enabled(dev, "enable");
> +	if (IS_ERR(clk)) {
>   		dev_err(dev, "failed to get mailbox clock\n");
> -		return PTR_ERR(priv->clk);
> -	}
> -
> -	ret = clk_prepare_enable(priv->clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(dev, sprd_mbox_disable, priv);
> -	if (ret) {
> -		dev_err(dev, "failed to add mailbox disable action\n");
> -		return ret;
> +		return PTR_ERR(clk);
>   	}
>   
>   	inbox_irq = platform_get_irq_byname(pdev, "inbox");


