Return-Path: <linux-kernel+bounces-338183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2051298546F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3B728322E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB9157466;
	Wed, 25 Sep 2024 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B3CXqL1Z"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647525634;
	Wed, 25 Sep 2024 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250400; cv=none; b=h/dJKXdzBRHzfOmxwKaVZohhPr7C6gWINvQjebleqTWlCS5KDsDVfe+pWdMNjodYV9Tx4WefaqivXU5702P+5PIIwi7PLq9m8AstZrGvJAmXiiD0lfvL2H6lzr85utrAj2qDffHE/GlpevHlggYjxzFGxm/hOZGG4ca2syo5Xbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250400; c=relaxed/simple;
	bh=sZD07Nz3JTxtQk22kFbo0BTn2I8r91GWAyKTpZgpZRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLwsooz6lFRUH1CPTD/qehp+ObMr/5kC+7GvON2EIfw7Wula+WwdFFxVHO4ZcA/EPWvMFOrzr85YXpx3zDnplcjde3e1wpVv742Mu1FRuYdS1sf+yS0i9OXJ5++8VgYKuYSh03FEjCcZQYGMtMGA2Y6Qg1bC9WI2TzHp/BD5Ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B3CXqL1Z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727250396;
	bh=sZD07Nz3JTxtQk22kFbo0BTn2I8r91GWAyKTpZgpZRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B3CXqL1Z4AgfpkGPaS6OxowMLRHD6RlxBEzgKBUrW2KagsdEi9Nw5hdzrkoJBVSYT
	 t6Wf3RTe2zyvX6taQmtQNS5amemwzdRilfwuwT1U8sDLeCMyIG0/DwUjTBqphL0tWj
	 JbE23qjZkxnNBI2jeFnspzfs8uLubXLoXnmt6XEuwGBWym5qubk00jWwpB2nX8vHwv
	 8hrSNyiQcA746tgvgKoqXfl1F07ycRmrKHNhWL8rQId97ZWlahvDidL2x4lFJu+4/e
	 ZBvTq12zVS5mHqsG6OP/XcMIlxn6KFd+5UPHeiqL8zRdjPV+web/+EBmk4Agp1fZOa
	 6MYPDJN10IoQw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 503D517E1034;
	Wed, 25 Sep 2024 09:46:36 +0200 (CEST)
Message-ID: <32e9ec0e-5ba6-4653-adf7-ccd0af7d58a9@collabora.com>
Date: Wed, 25 Sep 2024 09:46:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Call of_node_put(np) only once in
 svs_get_subsys_device()
To: Markus Elfring <Markus.Elfring@web.de>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Roger Lu <roger.lu@mediatek.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <884f0a5d-e6d3-47dc-8a9e-201bb86b271f@web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <884f0a5d-e6d3-47dc-8a9e-201bb86b271f@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/24 20:08, Markus Elfring ha scritto:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 24 Sep 2024 20:00:09 +0200
> 
> An of_node_put(np) call was immediately used after a pointer check
> for a of_find_device_by_node() call in this function implementation.
> Thus call such a function only once instead directly before the check.
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/soc/mediatek/mtk-svs.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 9a91298c1253..7c349a94b45c 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2133,14 +2133,12 @@ static struct device *svs_get_subsys_device(struct svs_platform *svsp,
>   	}
> 
>   	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
>   	if (!pdev) {
> -		of_node_put(np);
>   		dev_err(svsp->dev, "cannot find pdev by %s\n", node_name);
>   		return ERR_PTR(-ENXIO);
>   	}
> 
> -	of_node_put(np);
> -
>   	return &pdev->dev;
>   }
> 
> --
> 2.46.1
> 


