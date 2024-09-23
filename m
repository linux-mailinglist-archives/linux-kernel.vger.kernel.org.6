Return-Path: <linux-kernel+bounces-335578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D755797E7AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AAA281AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9F719408C;
	Mon, 23 Sep 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lb8S9reE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4C2F2D;
	Mon, 23 Sep 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080674; cv=none; b=EED/YdG4si6tm0v8u8ZToybSgjyu5MbtQeDkv/BG+yZW5DWRpdud0ZJd8ZPXEAkYu8cxg6srqj6ShDDUFlTdY517UMwnKyz6X4um/qrusfX5z3sB42FscwKLHPGAdm1dzZ/DUe8XOkibswJr95PnMbbc2EZbWeIi2EVylPEP00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080674; c=relaxed/simple;
	bh=uZQIK87N4ujgLv/ZX4cs/F+dr+2lXS1YW420lR8BHLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfbsQ3ali212Pay27AZnGlBDHOc0noGSl9Gqk2J5FMFIp2fFcQy6dFimHUJWOx+CGDfdrwxSu3kj51v33x6jyFhUgkQNCMbF2X4+gTwIxdeG7/FwVDY7Dvqp4kC3i/c5scm4lxXsl9hyasbc8obhNUpFo3jXcFCQSMZrFLPvIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lb8S9reE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727080670;
	bh=uZQIK87N4ujgLv/ZX4cs/F+dr+2lXS1YW420lR8BHLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lb8S9reEfu2Q90fzfVIaVABHDCgxhDm0CGNP1NxL1fMXQjixXnQKP24xe3NQzmrWy
	 AVD6TD0lVQDBEAHJ1XkE/400N7KHunEdKc/PJKc3kApY/mzE6iNlUfYd0FFBIzjz/x
	 exNQXKAY1c10jINtV5sEu4CjiI6IujID28WtIWpuLRHnsedv5DkSgl/j4/WkJ2PbLn
	 J6H5Iin+qx39qdT9xaTAmxZclK4VnfPVzh8aNBfnIweG7mZhjjOiioTVjJO5pTJ+XS
	 Hc8P4uKbzTq16WJX/ARDZc8NUlkos/OyKIIhH0eegw/5x2kx6OUkKZh98jBoNE+Tqe
	 5RaOoKTpSf82Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C591C17E105F;
	Mon, 23 Sep 2024 10:37:49 +0200 (CEST)
Message-ID: <866d7cd8-856b-431a-9408-527cdc021922@collabora.com>
Date: Mon, 23 Sep 2024 10:37:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvmem: mtk-efuse: Enable postprocess for mt8188 GPU
 speed binning
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240920134111.19744-1-pablo.sun@mediatek.com>
 <20240920134111.19744-4-pablo.sun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240920134111.19744-4-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/09/24 15:41, Pablo Sun ha scritto:
> Similar to mt8186, the efuse data for mt8188's GPU speed binning
> requires post-process to convert the bit field format expected
> by the OPP table.
> 
> Since mt8188 efuse is not compatible to mt8186, add a new compatible
> entry for mt8188 and enable postprocess.
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> ---
>   drivers/nvmem/mtk-efuse.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index 9caf04667341..4984145025bb 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -105,6 +105,10 @@ static const struct mtk_efuse_pdata mtk_mt8186_efuse_pdata = {
>   	.uses_post_processing = true,
>   };
>   
> +static const struct mtk_efuse_pdata mtk_mt8188_efuse_pdata = {
> +	.uses_post_processing = true,
> +};
> +
>   static const struct mtk_efuse_pdata mtk_efuse_pdata = {
>   	.uses_post_processing = false,
>   };
> @@ -112,6 +116,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pdata = {
>   static const struct of_device_id mtk_efuse_of_match[] = {
>   	{ .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
>   	{ .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
> +	{ .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8188_efuse_pdata },

Please reuse mtk_mt8186_efuse_pdata. There's no need to add a duplicate.

{ .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8186_efuse_pdata },

Cheers,
Angelo

>   	{ .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
>   	{/* sentinel */},
>   };



