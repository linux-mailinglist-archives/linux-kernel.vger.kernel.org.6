Return-Path: <linux-kernel+bounces-256255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D998934B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D661F2441A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDFB84DE4;
	Thu, 18 Jul 2024 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oYggl5Yq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923478276
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721297379; cv=none; b=gbX9XTqlb5hddcDv6ejamIVOsxYmaIr3mGka3/P7hmz3KeG8mSpn/UGX9X7LN7AFnSbfXKZuvN/R3yGi9U0Un/iVovcwENjwnu/mmpIhP/bgE6zZN9Pt6xwucxLaLPGYdNhDv0+jSc03asY30KCbyuzXj88spHZYDuORTv5d4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721297379; c=relaxed/simple;
	bh=7W9NB+4beenTAyhTygX8/3CLonvIgT2Ws7zp0jH0pWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xb7ie4tgX6SB9e0ITG1invCnILIKJuQZY4QXUpBq9ApH8uzfHBNtPyxWr1FHJlPIrYEahm+q/c7Bh3nTdBN/5JyZjjM5fmsTe+EIyf7eGCcmITGh+Np/51Mx9fBBWDYUyqL3ovHAsJ2392W1jsGfdKoQjdPWDgMnVlDzQ7pJWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oYggl5Yq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721297373;
	bh=7W9NB+4beenTAyhTygX8/3CLonvIgT2Ws7zp0jH0pWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oYggl5YqOJlMmwn2fZXbxfLjSz9+mDZzx2Yu564ULzbOMeLZuLsGTkR2oOlw01KyW
	 fBWieElXAsPOf3lqOQmpFxWNMf5SR16lha+HGu5cZP0bAiM1OZpkrt1yWdgqIdQJ6o
	 s7Ckc5/xpPpKXd5Xh3Jeo8W6mSPa2ME22AWqgENFSE3s/tdG0TB9Y/B3ltHyEUsttN
	 JX/vHpHmI5peAgzgAicMmD4Gchp7uTphNywZh/iezEKGgX4CmXrcGb3js53NF/sl53
	 VOOFuCgCATbK5IbcoRAMbDohrGLqA6zkfj0gbQxZhEXI8wnMTEbLSUCxWsU1N9ZQtv
	 /IIQJ7nPXaMkw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B1F99378020A;
	Thu, 18 Jul 2024 10:09:32 +0000 (UTC)
Message-ID: <8fbe44af-8da3-4554-ac2b-5db58003449e@collabora.com>
Date: Thu, 18 Jul 2024 12:09:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: mtk-cmdq: Move
 devm_mbox_controller_register() after devm_pm_runtime_enable()
To: jason-jh.lin@mediatek.com, Jassi Brar <jassisinghbrar@gmail.com>,
 CK Hu <ck.hu@mediatek.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240718-mtk-cmdq-fixup-v2-1-f6bb3c052a60@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240718-mtk-cmdq-fixup-v2-1-f6bb3c052a60@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/07/24 10:38, Jason-JH.Lin via B4 Relay ha scritto:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> When mtk-cmdq unbinds, a WARN_ON message with condition
> pm_runtime_get_sync() < 0 occurs.
> 
> According to the call tracei below:
>    cmdq_mbox_shutdown
>    mbox_free_channel
>    mbox_controller_unregister
>    __devm_mbox_controller_unregister
>    ...
> 
> The root cause can be deduced to be calling pm_runtime_get_sync() after
> calling pm_runtime_disable() as observed below:
> 1. CMDQ driver uses devm_mbox_controller_register() in cmdq_probe()
>     to bind the cmdq device to the mbox_controller, so
>     devm_mbox_controller_unregister() will automatically unregister
>     the device bound to the mailbox controller when the device-managed
>     resource is removed. That means devm_mbox_controller_unregister()
>     and cmdq_mbox_shoutdown() will be called after cmdq_remove().
> 2. CMDQ driver also uses devm_pm_runtime_enable() in cmdq_probe() after
>     devm_mbox_controller_register(), so that devm_pm_runtime_disable()
>     will be called after cmdq_remove(), but before
>     devm_mbox_controller_unregister().
> 
> To fix this problem, cmdq_probe() needs to move
> devm_mbox_controller_register() after devm_pm_runtime_enable() to make
> devm_pm_runtime_disable() be called after
> devm_mbox_controller_unregister().
> 
> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
> When mtk-cmdq unbinds, a WARN_ON message with condition
> pm_runtime_get_sync() < 0 occurs.
> 
> According to the call tracei below:
>    cmdq_mbox_shutdown
>    mbox_free_channel
>    mbox_controller_unregister
>    __devm_mbox_controller_unregister
>    ...
> 
> The root cause can be deduced to be calling pm_runtime_get_sync() after
> calling pm_runtime_disable() as observed below:
> 1. CMDQ driver uses devm_mbox_controller_register() in cmdq_probe()
>     to bind the cmdq device to the mbox_controller, so
>     devm_mbox_controller_unregister() will automatically unregister
>     the device bound to the mailbox controller when the device-managed
>     resource is removed. That means devm_mbox_controller_unregister()
>     and cmdq_mbox_shoutdown() will be called after cmdq_remove().
> 2. CMDQ driver also uses devm_pm_runtime_enable() in cmdq_probe() after
>     devm_mbox_controller_register(), so that devm_pm_runtime_disable()
>     will be called after cmdq_remove(), but before
>     devm_mbox_controller_unregister().
> 
> To fix this problem, cmdq_probe() needs to move
> devm_mbox_controller_register() after devm_pm_runtime_enable() to make
> devm_pm_runtime_disable() be called after
> devm_mbox_controller_unregister().
> 
> Change-Id: I4f0e68eac5186fe8041ea2f16c8e852d52d71cb0
> ---
> Changes in v2:
> - Change to move the calling sequence of devm_mbox_controller_register()
>    and devm_pm_runtime_enable().
> - Link to v1: https://lore.kernel.org/r/20240613150626.25280-1-jason-jh.lin@mediatek.com
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index f1dfce9e27f5..002003c3970a 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -370,6 +370,8 @@ static void cmdq_remove(struct platform_device *pdev)
>   {
>   	struct cmdq *cmdq = platform_get_drvdata(pdev);
>   
> +	devm_mbox_controller_unregister(&pdev->dev, &cmdq->mbox);

...if you moved devm_mbox_controller_register() after devm_pm_runtime_enable(),
this means that the teardown sequence will disable pm runtime after unregistering
the mbox controller, so why do you need to call devm_mbox_controller_unregister()
manually here?

Cheers,
Angelo

> +
>   	if (cmdq->pdata->sw_ddr_en)
>   		cmdq_sw_ddr_enable(cmdq, false);
>   
> @@ -689,12 +691,6 @@ static int cmdq_probe(struct platform_device *pdev)
>   		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
>   	}
>   
> -	err = devm_mbox_controller_register(dev, &cmdq->mbox);
> -	if (err < 0) {
> -		dev_err(dev, "failed to register mailbox: %d\n", err);
> -		return err;
> -	}
> -
>   	platform_set_drvdata(pdev, cmdq);
>   
>   	WARN_ON(clk_bulk_prepare(cmdq->pdata->gce_num, cmdq->clocks));
> @@ -722,6 +718,12 @@ static int cmdq_probe(struct platform_device *pdev)
>   	pm_runtime_set_autosuspend_delay(dev, CMDQ_MBOX_AUTOSUSPEND_DELAY_MS);
>   	pm_runtime_use_autosuspend(dev);
>   
> +	err = devm_mbox_controller_register(dev, &cmdq->mbox);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register mailbox: %d\n", err);
> +		return err;
> +	}
> +
>   	return 0;
>   }
>   
> 
> ---
> base-commit: 797012914d2d031430268fe512af0ccd7d8e46ef
> change-id: 20240718-mtk-cmdq-fixup-40379650e96b
> 
> Best regards,


