Return-Path: <linux-kernel+bounces-517833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0649A3865B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A05164F62
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7AA21CA17;
	Mon, 17 Feb 2025 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mJOE/RVj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66A216E29
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802354; cv=none; b=NY7qJI6WVqrg3C6Vz5gz2MtgaGNu7C9MgsIi+2J3lZOFTIOLNqlGhXNrh6uR1ln4yOllse91NqM7GbmOf6kv2OCQUOomfbRoQWgo+s593vT/X4XvOtamUxOYDVK306YIIp95IjAg4OvINxCJOnDIlcI9fE6Ho693BfJ7quL6mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802354; c=relaxed/simple;
	bh=GUAxZImZWtamppr8zlI/A9rVG2tyYKU95DwC2jGXbBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/1c5XMMqvKdm2y+T5yBMnZUtcbMKtVXUiBSkcXvlQC6a3VOmYfKQXUNgU4/85sqWwrRkzNB4cQd6wURqm95PIss78CG8AzMaA8F+dsaOMFFzY2D2Jdv5jculg3IB2cdqGvaxg8/xPfurPUqKxII2wIvwuh/yylhyXPU8XLUIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mJOE/RVj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739802350;
	bh=GUAxZImZWtamppr8zlI/A9rVG2tyYKU95DwC2jGXbBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mJOE/RVj3wNsVYObyE/oZbGXxop1evH9WUwdJoZUmA8+53sjNIBAVNW6klqDyio4L
	 OxQv+iqv5Lq/tD7aiwNo5rmA7a9FChrl45oo143dGcKIVxMJIufdV2b8IzE6eG2TWH
	 IOuxuElpbrjwjmuRzMIebMsDLB0+nPNVYi8E2wV18dZ/io13aQjFEGoD2I1bjiEzAw
	 A+oSCGd6CjFfz2+UbqZG7FY5oSdyn5PEp4sDFcEdQ4hJ4h0jh65WUMQGaFMjQ2lysj
	 t2Wz3yY13uQUyKxGnvd0YichLhTjV3Y98R/FBkIFgdlRQTk/ONx9VRx4SFGd+lHCG4
	 9UY81byDPryCQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D4D4117E0F86;
	Mon, 17 Feb 2025 15:25:49 +0100 (CET)
Message-ID: <041ffe38-ca24-4e05-90c1-e37f9323c7cf@collabora.com>
Date: Mon, 17 Feb 2025 15:25:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/mediatek: Change main display path to support PQ
 for MT8196
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 =?UTF-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>
Cc: =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
 "treapking@chromium.org" <treapking@chromium.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
References: <20250211025317.399534-1-sunny.shen@mediatek.com>
 <20250211025317.399534-6-sunny.shen@mediatek.com>
 <b3a6afa2e818d31dc60632615215a88449fb78bf.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <b3a6afa2e818d31dc60632615215a88449fb78bf.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/02/25 07:06, CK Hu (胡俊光) ha scritto:
> On Tue, 2025-02-11 at 10:52 +0800, Sunny Shen wrote:
>> Due to the path mux design of the MT8196, the following components
>> need to be added to support Picture Quality (PQ) in the main display
>> path: CCORR0, CCORR1, DITHER0, GAMMA0, MDP_RSZ0, POSTMASK0, TDSHP0.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> 
>>
>> Signed-off-by: Sunny Shen <sunny.shen@mediatek.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> index b810a197f58b..1c97dc46ae70 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> @@ -242,6 +242,13 @@ static const unsigned int mt8196_mtk_ddp_ovl0_main[] = {
>>   
>>   static const unsigned int mt8196_mtk_ddp_disp0_main[] = {

If you build the display controller path with an OF graph, you don't need to
introduce any mt8196_mtk_ddp_disp0_main, at all.

Since all this work was done and upstreamed, and was done because hardcoding
the display pipeline for each board is only bloating the driver (and wrong),
just express the pipeline with a graph in the devicetree.

The driver doesn't need that array, not anymore.

Regards,
Angelo

>>   	DDP_COMPONENT_DLI_ASYNC0,
>> +	DDP_COMPONENT_MDP_RSZ0,
>> +	DDP_COMPONENT_TDSHP0,
>> +	DDP_COMPONENT_CCORR0,
>> +	DDP_COMPONENT_CCORR1,
>> +	DDP_COMPONENT_GAMMA0,
>> +	DDP_COMPONENT_POSTMASK0,
>> +	DDP_COMPONENT_DITHER0,
>>   	DDP_COMPONENT_DLO_ASYNC1,
>>   };
>>   
> 




