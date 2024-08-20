Return-Path: <linux-kernel+bounces-294012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F99D9587C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04E0283C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542A19006B;
	Tue, 20 Aug 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="F8TW1QY7"
Received: from msa.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45618CC08
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159997; cv=none; b=EBsfCaiA75e+R22jYmGbWUuktqdU4+ZtJU4OYQwxjV5fr180BrCe1dki5OEgWy0b7ZNGc8EheLRxlOOUsLKYc4TqleMNXcy8aELkhQnV7s62M0vLRpRpzD9YTd+tKYEbsA8QxKhBQFULz/rzRiA23xjVCYGGUj6ZHlvFBiw2Tp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159997; c=relaxed/simple;
	bh=an1ERuFzmoue5lNyVfBeZVHvvx5v13z8z2BJbEJE9+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6QdTVC9wogNL5RSxrWochVITrs6Sdq0WjxQA3FyvaO8TZuljH43jaC926OHpzJrjMbCemXoCYD8GRi/5nIbjPqGHV9wzOC3YhP6vXMQ3lATRn1cNWooC/B95VDLVvRJoyIsIhEsZzGb8pt+ymCC5aZEf6LCWShoXrprM6/vbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=F8TW1QY7; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gOm5sTZ6wG0zwgOm6s6Uq9; Tue, 20 Aug 2024 15:19:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724159991;
	bh=fbXaCNGFVEs+vdDITROYBteYIhyfvO/bLrS2t7V1yYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=F8TW1QY76yWGcr+8ahVbRjQsz+rcpHiTIwdYR57wVZTvNA9dqFncXzCtaB376FolL
	 g2a5sywzWw2SxKqCqgsq0bJnMy93hfF8w81Uuow4rGpDmawP/Jt6/4BlWtpP8ehAgi
	 XAFUaSxTvIh/0ki0Mnx++GCrNlfee1ZI0Aayn2KCPzszsSLMuf6VEdWrl63KLfoH94
	 QC7zAf70deIHVdHjNA1hHNe7E8+ZMA2tL/m11jN+ENQnAq9TVn6CeREb8y9AP7v9to
	 KjCM60tkzofvUM6I0kCb8qcWBPuntBTwv7aDe2EJTT1RC8dHetMNtlEFXUTlZO37FY
	 zWL8W2flXDsdg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 20 Aug 2024 15:19:51 +0200
X-ME-IP: 90.11.132.44
Message-ID: <ffe31e2b-1e21-4624-aa9d-558bbf4a880a@wanadoo.fr>
Date: Tue, 20 Aug 2024 15:19:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: sprd: Use devm_clk_get_enabled() helpers
To: Huan Yang <link@vivo.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240820102255.132605-1-link@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240820102255.132605-1-link@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/08/2024 à 12:22, Huan Yang a écrit :
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
removed from struct sprd_mbox_priv.

Just my 2c.

CJ

>   drivers/mailbox/sprd-mailbox.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> index 9ae57de77d4d..dca83026928f 100644
> --- a/drivers/mailbox/sprd-mailbox.c
> +++ b/drivers/mailbox/sprd-mailbox.c
> @@ -291,13 +291,6 @@ static const struct mbox_chan_ops sprd_mbox_ops = {
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
> @@ -331,22 +324,12 @@ static int sprd_mbox_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->outbox_base))
>   		return PTR_ERR(priv->outbox_base);
>   
> -	priv->clk = devm_clk_get(dev, "enable");
> +	priv->clk = devm_clk_get_enabled(dev, "enable");
>   	if (IS_ERR(priv->clk)) {
>   		dev_err(dev, "failed to get mailbox clock\n");
>   		return PTR_ERR(priv->clk);
>   	}
>   
> -	ret = clk_prepare_enable(priv->clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(dev, sprd_mbox_disable, priv);
> -	if (ret) {
> -		dev_err(dev, "failed to add mailbox disable action\n");
> -		return ret;
> -	}
> -
>   	inbox_irq = platform_get_irq_byname(pdev, "inbox");
>   	if (inbox_irq < 0)
>   		return inbox_irq;


