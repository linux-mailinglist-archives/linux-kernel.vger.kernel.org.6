Return-Path: <linux-kernel+bounces-345176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5286198B2C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E06F1F23846
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455E31A3045;
	Tue,  1 Oct 2024 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nmebeck7"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2D1A302A;
	Tue,  1 Oct 2024 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727753927; cv=none; b=IJ745l6R1MLSDRgNn5EMNqE27KyYqjIZkLWC/LCVG22cvgNd0XZdOPUbJ7vGhKNboPOWvsQfnK0pcFRbtzROSnYoZMxGCkO8zQFslVtwohG/lp+lDVw65UgPjfLobwMd1aGJUMhKWxBwTi3iG6w1JUkNw3C+MV6J/UL9FfzDUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727753927; c=relaxed/simple;
	bh=BruhvztGVRz244FjNt3OmnFlYUoo08jl3Gsy1pYwjiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JoJh6pB7Y1FDQBePrQEBuMqyIhKu6weRMvZXzAWtRtzeTgRl1EEYrcV1iOxWkjaKVl0m/yl087BYbuKNkSEMcS+VB6PbN1C5issW9/elERXpqkhhnpODyGVySNTnl2HAQJdcMBdN0fTQJ2bzJ0tvuThBAJ5xccgKYk8p9lTFEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nmebeck7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a45739047fa611ef8b96093e013ec31c-20241001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=Gjo5+pSdTGHwq6JJECrTZEup0IvHwkFVyPMeb0WdRaM=;
	b=nmebeck7ebIeyinQZ2dJqTvoYFiPslU4ffov857EPbhwoXhLMHz9MBIbRsi1UhKBceD4msWOXH6cL2d/RLc87VCeM9NtaxnNbOHxkQFwNBPJ4ugyZ0tjZSzWpjAlJ6hJLzmD2yYJtucQ1ZDsgeAUKtCQzbUzJ+olXYxdICxcVp8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:6375fd9d-b426-4f14-9928-58c5951137ea,IP:0,U
	RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:3
X-CID-META: VersionHash:6dc6a47,CLOUDID:c986d39e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a45739047fa611ef8b96093e013ec31c-20241001
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1679239653; Tue, 01 Oct 2024 11:38:37 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Oct 2024 11:38:35 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 1 Oct 2024 11:38:33 +0800
Message-ID: <329b554b-e029-0dfe-7c18-67c7c58f8302@mediatek.com>
Date: Tue, 1 Oct 2024 11:38:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/6] nvmem: mtk-efuse: Enable postprocess for mt8188
 GPU speed binning
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-clk@vger.kernel.org>
References: <20240927103005.17605-1-pablo.sun@mediatek.com>
 <20240927103005.17605-4-pablo.sun@mediatek.com>
 <57dfe684-c9a1-4cb3-8c87-9d2fef09aed7@collabora.com>
From: Pablo Sun <pablo.sun@mediatek.com>
In-Reply-To: <57dfe684-c9a1-4cb3-8c87-9d2fef09aed7@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Angelo,


On 9/30/24 17:40, AngeloGioacchino Del Regno wrote:
> Il 27/09/24 12:30, Pablo Sun ha scritto:
>> Similar to mt8186, the efuse data for mt8188's GPU speed binning
>> requires post-process to convert the bit field format expected
>> by the OPP table.
>>
>> Since mt8188 efuse is not compatible to mt8186, add a new compatible
>> entry for mt8188 and enable postprocess.
>>
>> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> 
> I know I told you to just reuse the pdata from 8186, but there's something else
> that came to mind, here...
> 
> ...actually, the efuse block from 8188 is indeed compatible with 8186, meaning
> that the register r/w, etc, are all the same (bar the addresses, yes)
> 
> So, I wonder if it's not just a better idea to not even add mt8188-efuse in this
> driver's of_device_id array, and just add that to the binding so that we permit
> using
>          efuse: efuse@11f20000 {
>              compatible = "mediatek,mt8188-efuse",
>                       "mediatek,mt8186-efuse", "mediatek,efuse";
>              [etc]
>          }

Thanks for proposing this. I agree that in the case of Mali GPU speed binning
info, mt8188 behaves exactly the same as mt8186, only the cell addresses are
different.

I wrote "mt8188 efuse is not compatible to mt8186" because I thought
different eFuse cell layout leads to incompatibility, but it is correct that
the cell layout differences can be expressed by the device tree nodes,
so they are actually compatible in terms of hardware interface.

I'll drop this patch ("nvmem: mtk-efuse: Enable postprocess for mt8188 GPU speed binning")
in v3 and update dt-binding "mediatek,efuse.yaml" instead.

> Means that in mediatek,efuse.yaml you'll have to add...
> 
>        - items:
>            - enum:
>                - mediatek,mt8188-efuse
>            - const: mediatek,mt8186-efuse
>            - const: mediatek,efuse <---- or without this, even.
> 
> In the end, the "mediatek,efuse" property is somewhat deprecated, so that'd
> also be a good time to start the dropping process, as I imagine that future SoCs
> would also need the same speedbin transformations - which means that they'll all
> be compatible with 8186....
[snip]

But I am not sure if we should now drop "mediatek,efuse". The post-process for
GPU speed binning info is only applicable to ARM Mali. Since there are MediaTek
SoCs that are not using ARM Mali, or not having GPU at all, would it make more sense
to keep the "mediatek,efuse" fallback compatible for those cases?


Best regards,
Pablo

