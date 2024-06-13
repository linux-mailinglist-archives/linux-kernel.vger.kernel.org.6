Return-Path: <linux-kernel+bounces-212666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E35906494
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622BA2849CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ABE137C23;
	Thu, 13 Jun 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s8CKTaLY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6859622;
	Thu, 13 Jun 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262429; cv=none; b=n83G82Z7Dwrwjt2T88AQ0F//UrQQOxYWnTyDHuNim7dTkznypQKJdYXQKZ+j/2ZTZH9LiBKkC9UhFT6cdgjD0Htw/Dj+YjhlIOpvKPjCJYZYs0WrbMVWRVTkVee8qPsYlLPsLHoxe4OBFog7ymfxpmfYrEEdItMiYn9XVwgloJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262429; c=relaxed/simple;
	bh=LWRFNapN+wyTQNvWofeQWCa3j7JgLf2cUA8hrrwkD5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBAcrxde2WNHh8Ksh3TlYi3X2udBnqp9yLiMYspPvd3qczNFpS9V/2bri/HiEtRfwpVD5ABo5wjWpWbTDU1GLHFRxHsNdcuUrc0xckUL2qG3F7mNnnShSIo4YF4VqT98aOMhlQ89XtryxH6YaIkBEwzRzURw1FqMqUnVh5b95OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s8CKTaLY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718262420;
	bh=LWRFNapN+wyTQNvWofeQWCa3j7JgLf2cUA8hrrwkD5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s8CKTaLYhTF7um/sKo5IvJYMtqaSw3zTlF3L0BvrgEvaJkN5o6lrXpzBsomCKOUFC
	 MeNTeggOihYDgpBHnJyTHpK97tzM+KyAqqHly23tjVpK5WjjRhl+Efw6OZiZzfYQkt
	 ko19+oDsiWUbJj1srwsje4hqe6Qnn+2NsXu17sdAswEWwiGlCFgHjCPrnHV/7BgCVY
	 4dpDcfMnKEk/4xUFs0gRDFP0D9JE3guGmQnnoHAGe7wHhf7VJrmeG6tYBW4d3bsbGs
	 2/3DW0Z+c9boXXN3UpZURtNhy5Ohbew0/+T4QWcg3PM2jK4aruMaPsXKAiDTV79YuN
	 C1ySXo9uPU4ag==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3198537821A3;
	Thu, 13 Jun 2024 07:06:59 +0000 (UTC)
Message-ID: <030a538b-bf28-4418-92fd-14225260eb85@collabora.com>
Date: Thu, 13 Jun 2024 09:06:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/2] clk: mediatek: mt8173-infracfg: Handle
 unallocated infracfg when module
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Chen-Yu Tsai <wenst@chromium.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-clk@vger.kernel.org
References: <20240612201211.91683-1-alpernebiyasak@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240612201211.91683-1-alpernebiyasak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/06/24 22:11, Alper Nebi Yasak ha scritto:
> The MT8173 infracfg clock driver does initialization in two steps, via a
> CLK_OF_DECLARE_DRIVER declaration. However its early init function
> doesn't get to run when it's built as a module, presumably since it's
> not loaded by the time it would have been called by of_clk_init(). This
> causes its second-step probe() to return -ENOMEM when trying to register
> clocks, as the necessary clock_data struct isn't initialized by the
> first step.
> 
> MT2701 and MT6797 clock drivers also use this mechanism, but they try to
> allocate the necessary clock_data structure if missing in the second
> step. Mimic that for the MT8173 infracfg clock as well to make it work
> as a module.
> 
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> 
> Changes in v2:
> - Rewrite patch subject for consistency
> 
> v1: https://lore.kernel.org/lkml/20231108213734.140707-1-alpernebiyasak@gmail.com/
> 
>   drivers/clk/mediatek/clk-mt8173-infracfg.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
> index 2f2f074e231a..ecc8b0063ea5 100644
> --- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
> +++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
> @@ -98,7 +98,17 @@ CLK_OF_DECLARE_DRIVER(mtk_infrasys, "mediatek,mt8173-infracfg",
>   static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
>   {
>   	struct device_node *node = pdev->dev.of_node;
> -	int r;
> +	int r, i;
> +
> +	if (!infra_clk_data) {
> +		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
> +		if (!infra_clk_data)
> +			return -ENOMEM;
> +	} else {
> +		for (i = 0; i < CLK_INFRA_NR_CLK; i++)
> +			if (infra_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
> +				infra_clk_data->hws[i] = ERR_PTR(-ENOENT);
> +	}
>   
>   	r = mtk_clk_register_gates(&pdev->dev, node, infra_gates,
>   				   ARRAY_SIZE(infra_gates), infra_clk_data);
> 
> base-commit: 03d44168cbd7fc57d5de56a3730427db758fc7f6


