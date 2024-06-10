Return-Path: <linux-kernel+bounces-207870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32186901D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95B8284F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA826F314;
	Mon, 10 Jun 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JjcWTaLH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AA64D8A0;
	Mon, 10 Jun 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009003; cv=none; b=PkmLMFCC0ctwY2XwLnGrtmn8v0y/D8vnX3d8TRQnvOLAA1SG+NOoKDZG6tK6jqpBlQTJaHE9fK+krilUjgYOoZL3PFzg3Hl87BFsAXH3DKOppzGB6IFvIMd77Nxzoh+KvINbZKCf36KsYVkD7hmBggHzeFZQj6BC/qdkI0ismms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009003; c=relaxed/simple;
	bh=LNIdzzsyqhCcgncvNLcOHzzyUBy2LZ72RSb393VPJD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIAHcphScg6itD4zxR6V2VrR4j1gktzUyoY3em8ZR8BL/1k+Q/ifZDIOYjOzNfDbADL898PapljONyD/Wzi7N7gaC8C2Af8xzNt4QWEk4ARGhbIdD/8U4dLtuajuvjlo169Ixyummkf7zJanhuvPYCm+7xxSdhDwWerOEH0AK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JjcWTaLH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718009000;
	bh=LNIdzzsyqhCcgncvNLcOHzzyUBy2LZ72RSb393VPJD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JjcWTaLH9RJQ8OsGhSaTMWLC5Fv/zpn5Gv1aSyQk78fF2Yx+4NKYt0+IVLJCbPibb
	 5B6368IDCGBDKI2/MMnHFxYrXRPEXDdkEUN0739oxncZij4l7SgxsKJ23Mn0VTk4PJ
	 XL0jKEPhjfmmF7kw1dPmRFmRYRfPYXlswCBbuyl+A/9bDww9tazb2H2WI66CU53R9c
	 QnPEpd1S2BoYDlN9bP/nmNZ86U7SCMz/5xHTdjooR1S4aV9cq008K15l8q3VV6dhLb
	 6uWN5CJXSJiHv2javX5Y9u5T2LLdtOZjD/d3LnzTBP5TzB1RvSn6K2NxdX+Uqaj5XS
	 vXsSNPQWxW6gg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E2EDC378148F;
	Mon, 10 Jun 2024 08:43:19 +0000 (UTC)
Message-ID: <29cb4283-34ef-4c90-ad53-ea572576d3fa@collabora.com>
Date: Mon, 10 Jun 2024 10:43:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
References: <20240608-md-drivers-regulator-v1-1-da338665db7a@quicinc.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240608-md-drivers-regulator-v1-1-da338665db7a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/06/24 06:53, Jeff Johnson ha scritto:
> On x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/da9121-regulator.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/rt4831-regulator.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/tps6286x-regulator.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all files
> which have a MODULE_LICENSE(). This includes mtk-dvfsrc-regulator.c, which
> did not produce a warning with the x86 allmodconfig, since it may cause
> this warning with other configurations.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   drivers/regulator/da9121-regulator.c     | 1 +
>   drivers/regulator/max20411-regulator.c   | 1 +
>   drivers/regulator/mtk-dvfsrc-regulator.c | 1 +
>   drivers/regulator/rt4831-regulator.c     | 1 +
>   drivers/regulator/tps6286x-regulator.c   | 1 +
>   5 files changed, 5 insertions(+)
> 
> diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
> index 96257551bb12..3571b6242e3a 100644
> --- a/drivers/regulator/da9121-regulator.c
> +++ b/drivers/regulator/da9121-regulator.c
> @@ -1192,4 +1192,5 @@ static struct i2c_driver da9121_regulator_driver = {
>   
>   module_i2c_driver(da9121_regulator_driver);
>   
> +MODULE_DESCRIPTION("Dialog Semiconductor DA9121/DA9122/DA9220/DA9217/DA9130/DA9131/DA9132 regulator driver");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/regulator/max20411-regulator.c b/drivers/regulator/max20411-regulator.c
> index 8c09dc71b16d..6614e767072f 100644
> --- a/drivers/regulator/max20411-regulator.c
> +++ b/drivers/regulator/max20411-regulator.c
> @@ -161,4 +161,5 @@ static struct i2c_driver max20411_i2c_driver = {
>   };
>   module_i2c_driver(max20411_i2c_driver);
>   
> +MODULE_DESCRIPTION("Maxim MAX20411 High-Efficiency Single Step-Down Converter driver");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/regulator/mtk-dvfsrc-regulator.c b/drivers/regulator/mtk-dvfsrc-regulator.c
> index f1280d45265d..1941aad5e247 100644
> --- a/drivers/regulator/mtk-dvfsrc-regulator.c
> +++ b/drivers/regulator/mtk-dvfsrc-regulator.c
> @@ -211,4 +211,5 @@ static void __exit mtk_dvfsrc_regulator_exit(void)
>   module_exit(mtk_dvfsrc_regulator_exit);
>   
>   MODULE_AUTHOR("Arvin wang <arvin.wang@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek DVFSRC regulator driver");

Can you please drop this one?
I have a series floating that is removing this driver entirely and replacing it
with a refactored one. Though, it has the same issue, so I'll have to send a v6.

Anyway, v5 is there:

https://lore.kernel.org/r/20240424095416.1105639-1-angelogioacchino.delregno@collabora.com


>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/regulator/rt4831-regulator.c b/drivers/regulator/rt4831-regulator.c
> index 97e6f7e2a0ba..7d1ba0c82271 100644
> --- a/drivers/regulator/rt4831-regulator.c
> +++ b/drivers/regulator/rt4831-regulator.c
> @@ -202,4 +202,5 @@ static struct platform_driver rt4831_regulator_driver = {
>   module_platform_driver(rt4831_regulator_driver);
>   
>   MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("Richtek RT4831 DSV RegulatorsRichtek RT4831 DSV Regulators driver");

Also, there's a typo here :-)

After dropping mtk-dvfsrc-regulator changes and after fixing the typo:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



