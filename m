Return-Path: <linux-kernel+bounces-343713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB8989E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A111F22189
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA305189BAC;
	Mon, 30 Sep 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P35XlTt8"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59231188735;
	Mon, 30 Sep 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689219; cv=none; b=Q68RrwNPdlFHIwF/nOIqq35dfKmo5po8ijpwI1q7DiSFwg3YAb5aRUmNCI9KDAngOO/P29orOcWPGm9Ts6Fugw877mGXFnAZlwQRB+cBmxUMdNYVG/jaz4MmZCsP20g8zKwppWJQ3pTKVp29DPRnL11c2JI6GY9PiBbbB9mNlb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689219; c=relaxed/simple;
	bh=morSWfr1TfMGPO5UKWsSeeHNUs1wlUZiPwNAmlEjidI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxFQE2+e/BQorkl8vw+DcBd6FOKiDVZ2vbUCKY10Pc9Mnsmwa99SVfQnYs1styHnsrVmQuT2xDG4dIZ4aWaZEqP2R5lWZKqYexQp9K9COSnkY4MLMN9AVxjMQ2pRHpAfwuJNUOjXWT/7mXBixEYFET0m7QgpsgfTHO4+IMi70Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P35XlTt8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727689215;
	bh=morSWfr1TfMGPO5UKWsSeeHNUs1wlUZiPwNAmlEjidI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P35XlTt8282gqz35vELPtYBH1CIQb6tu8A/3DFY3CFYLIZCt8SG/ZNoF6ognQgeMV
	 ROkoNt3eYANU2fdZTnfRgglV8tSMCdjr6WKa8+QlDu+edUgaOwOZJelzG/KfBysOTQ
	 Ud50YWLIo0cGkpcqRIy/LWRwSkOksnQYiXmZOVlLF2qKe53ZBrnPsPV9DXiw5eUaq7
	 01B8TdAu5nNAMkxVQceUYFj8gySaNzgfQJPmYKeAFoiWMm2LWOwTkQi+iAabUY0KOF
	 RS68jgOvfuih9hfuiHO0eK8HdWqM2uCEviCLzNiUrjvvkVsqETSKeZrvLGOmi2Cfj4
	 jT26RjK6NiQKA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3879B17E10C2;
	Mon, 30 Sep 2024 11:40:15 +0200 (CEST)
Message-ID: <57dfe684-c9a1-4cb3-8c87-9d2fef09aed7@collabora.com>
Date: Mon, 30 Sep 2024 11:40:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] nvmem: mtk-efuse: Enable postprocess for mt8188
 GPU speed binning
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240927103005.17605-1-pablo.sun@mediatek.com>
 <20240927103005.17605-4-pablo.sun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240927103005.17605-4-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/09/24 12:30, Pablo Sun ha scritto:
> Similar to mt8186, the efuse data for mt8188's GPU speed binning
> requires post-process to convert the bit field format expected
> by the OPP table.
> 
> Since mt8188 efuse is not compatible to mt8186, add a new compatible
> entry for mt8188 and enable postprocess.
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>

I know I told you to just reuse the pdata from 8186, but there's something else
that came to mind, here...

...actually, the efuse block from 8188 is indeed compatible with 8186, meaning
that the register r/w, etc, are all the same (bar the addresses, yes)

So, I wonder if it's not just a better idea to not even add mt8188-efuse in this
driver's of_device_id array, and just add that to the binding so that we permit
using
		efuse: efuse@11f20000 {
			compatible = "mediatek,mt8188-efuse",
				     "mediatek,mt8186-efuse", "mediatek,efuse";
			[etc]
		}

Means that in mediatek,efuse.yaml you'll have to add...

       - items:
           - enum:
               - mediatek,mt8188-efuse
           - const: mediatek,mt8186-efuse
           - const: mediatek,efuse <---- or without this, even.

In the end, the "mediatek,efuse" property is somewhat deprecated, so that'd
also be a good time to start the dropping process, as I imagine that future SoCs
would also need the same speedbin transformations - which means that they'll all
be compatible with 8186....

Cheers,
Angelo

> ---
>   drivers/nvmem/mtk-efuse.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index 9caf04667341..38d26e5c097a 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -112,6 +112,7 @@ static const struct mtk_efuse_pdata mtk_efuse_pdata = {
>   static const struct of_device_id mtk_efuse_of_match[] = {
>   	{ .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
>   	{ .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
> +	{ .compatible = "mediatek,mt8188-efuse", .data = &mtk_mt8186_efuse_pdata },
>   	{ .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
>   	{/* sentinel */},
>   };



