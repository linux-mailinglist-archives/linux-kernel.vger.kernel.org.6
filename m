Return-Path: <linux-kernel+bounces-239505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC092610D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A632870DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168CC17B410;
	Wed,  3 Jul 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VabEia4W"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39EA17B401;
	Wed,  3 Jul 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011741; cv=none; b=QfVHpaKgod/uzhZPBLsZkn0Uv7lPWXY8Kxsak67QRtQ91NaixOzgnPIczINCOcJ/KdlLaAmFyYFdA/Wkbj5DALpj3Yzw/hxBOzid229gwVRTBxxEY2VpNCI2bMbSobtx4Dg4cRqeHktxwt6jtyrjWya15B3FO5uWtf44ruWjeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011741; c=relaxed/simple;
	bh=U7o86Tzjl5rNpCoW+Rril6FhOJHsZrYDpqqOuEg+aL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDUxZzE9mT8X7fK83ck/SRYkqX+56umlYqn6nNCMtMQVC3Xt4Z6iDXqrXfsHO0RmKnaiHPmk0DRduJkAPvEAEMcUTMyiNK8qoLX8H4ie0jxHUm2Ao2a+oCyYSfsq1tXIccwNFrYVYvWTyLwiY+BTUwXl45owIH7KvdfB5HuCSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VabEia4W; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720011738;
	bh=U7o86Tzjl5rNpCoW+Rril6FhOJHsZrYDpqqOuEg+aL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VabEia4WzYXeIl+dydiNkvL7svyzEy6Kvg26UTjdNAD9lXvGZtbFsPX0NCzCERqDp
	 0H7CYL8ft1eyBkmxtcMzpF0bqvo0OYHlfA+jAnDtiEzO6XovgmiO2Q4ceuuNTMZuG4
	 6id5pHEIg6UjAw6ODPThkMw/cm2iebkxSehoOpNcOokB4l3HMrHqHsXXNkKBePpZ2c
	 a/n7zTyzTysGIx9Co7F7D7cUo2/Hu9LCQxD3Fk9zsk1o0ZrZwOeqhc2kjRNtB3N9aY
	 V3jXVYhwONBmxs7e/PUb54NRM9XAnc8yEciFwc8KehIZjSZrHiVO7GWbIWQb++SkQe
	 FbqblFX7cIIxg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ACBBE3782194;
	Wed,  3 Jul 2024 13:02:17 +0000 (UTC)
Message-ID: <c85ed66d-6a9f-43e3-9ab3-740551f34f7c@collabora.com>
Date: Wed, 3 Jul 2024 15:02:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] soc: mediatek: pwrap: Constify struct
 pmic_wrapper_type
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 matthias.bgg@gmail.com, fparent@baylibre.com, fchiby@baylibre.com,
 s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1719652155.git.christophe.jaillet@wanadoo.fr>
 <ee3160978ac6564663d044815f24cf79e2e0744e.1719652155.git.christophe.jaillet@wanadoo.fr>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ee3160978ac6564663d044815f24cf79e2e0744e.1719652155.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/06/24 11:19, Christophe JAILLET ha scritto:
> 'struct pmic_wrapper_type' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>     text	   data	    bss	    dec	    hex	filename
>    45336	   8724	     16	  54076	   d33c	drivers/soc/mediatek/mtk-pmic-wrap.o
> 
> After:
> =====
>     text	   data	    bss	    dec	    hex	filename
>    45528	   8532	     16	  54076	   d33c	drivers/soc/mediatek/mtk-pmic-wrap.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Compile tested-only
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index efd9cae212dc..0da0cdec5050 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -2397,7 +2397,7 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
>   	.init_soc_specific = pwrap_mt8183_init_soc_specific,
>   };
>   
> -static struct pmic_wrapper_type pwrap_mt8195 = {
> +static const struct pmic_wrapper_type pwrap_mt8195 = {
>   	.regs = mt8195_regs,
>   	.type = PWRAP_MT8195,
>   	.arb_en_all = 0x777f, /* NEED CONFIRM */
> @@ -2423,7 +2423,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
>   	.init_soc_specific = NULL,
>   };
>   
> -static struct pmic_wrapper_type pwrap_mt8516 = {
> +static const struct pmic_wrapper_type pwrap_mt8516 = {
>   	.regs = mt8516_regs,
>   	.type = PWRAP_MT8516,
>   	.arb_en_all = 0xff,
> @@ -2435,7 +2435,7 @@ static struct pmic_wrapper_type pwrap_mt8516 = {
>   	.init_soc_specific = NULL,
>   };
>   
> -static struct pmic_wrapper_type pwrap_mt8186 = {
> +static const struct pmic_wrapper_type pwrap_mt8186 = {
>   	.regs = mt8186_regs,
>   	.type = PWRAP_MT8186,
>   	.arb_en_all = 0xfb27f,




