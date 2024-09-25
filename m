Return-Path: <linux-kernel+bounces-337969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1989851B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251DC284762
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E72E14B088;
	Wed, 25 Sep 2024 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y92XEjkV"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D01494B2;
	Wed, 25 Sep 2024 04:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727236943; cv=none; b=QQDrJIbAl9cietkCRP1YdOTntR+DL/KF2omCHtOb2vf7gtERK8Gz3P/h2CtBp9TbOBDRQimENCddojRzL9dGzYI8cKKVT87fKXrsy6k7N7QHKYZpZ2azM1Lr0X5XwImpsAL7322uNYMFquPSGAo+s8PjV7ogZCQSs1wl7Oi3Tw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727236943; c=relaxed/simple;
	bh=YyCULtk26eCl3gKY8Ro4q6V7hKa4FNfSafs6x4dRNWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=or/TTtxXvk5vkZKWD+eW8k/a5AH0RPY9W52e3tilD7YQ6TXYjfKLyIw0g2G2DK3/IhpO9tjeqL8fljYsjcvYZ7E1HIp9ZSwOIORmFBusNSEoJlGUXMkxsOXprxc5OKH0oNcuEa4x0QCH/gmsZ2wO7NYNZcsvDoAUzONPUasCSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Y92XEjkV; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f2b369827af211ef8b96093e013ec31c-20240925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=twaJu/2TtkxNW0jn3fGndnnffWJ7HwGagBI7rxFX6ys=;
	b=Y92XEjkVtVNNhsqnq7PGkDyqYA+dvT5i0ctK0dOXRs330mwZtHN4A7kV7AqHra51xlfSyUlFbU34hzEMwEbEzendqq6Z0favaL9cOqC9VzknwexNTp0QmIP3iIVjz6s1svOA5MrviXdnWVUqLdTjgHv/eF0B7MRqabfI5Mk52MQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:17e16855-7c89-46f1-b0d0-4b11b7980231,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:2860b9d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f2b369827af211ef8b96093e013ec31c-20240925
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 3084873; Wed, 25 Sep 2024 12:02:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Sep 2024 12:02:13 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 25 Sep 2024 12:02:03 +0800
Message-ID: <216a2a51-7fcb-54df-7287-de504f6dc510@mediatek.com>
Date: Wed, 25 Sep 2024 12:02:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 6/6] dt-bindings: display: mediatek: dpi: Add mt8195
 support in power domains
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yong Wu
	<yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>, <rohiagar@chromium.org>, <tommyyl.chen@mediatek.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, Chris-qj
 chen <chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
References: <20240924103156.13119-1-macpaul.lin@mediatek.com>
 <20240924103156.13119-6-macpaul.lin@mediatek.com>
 <ed0c25ba-2816-4d4b-9023-2e07976f4341@collabora.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <ed0c25ba-2816-4d4b-9023-2e07976f4341@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 9/24/24 19:48, AngeloGioacchino Del Regno wrote:

> Il 24/09/24 12:31, Macpaul Lin ha scritto:
>> Add power domain binding to the mediatek DPI controller for MT8185.
>> 
>> The dpi node in mt8195.dtsi was triggering a dtbs_check error:
>>    dp-intf@1c113000: power-domains: False schema does not allow [[44, 18]]
>> 
>> Fixes: 5474d49b2f79 ("dt-bindings: display: mediatek: dpi: Add power domains")
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
>>   1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> index 3a82aec9021c..07acc8a76bfc 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> @@ -89,6 +89,7 @@ allOf:
>>                   - mediatek,mt6795-dpi
>>                   - mediatek,mt8173-dpi
>>                   - mediatek,mt8186-dpi
>> +                - mediatek,mt8195-dp-intf
> 
> The dp_intf1 block has a power domain (VDOSYS1)... so that will break the check
> for the other one.
> 
> Besides, I'm fairly sure that the right fix is to actually add the missing VDOSYS0
> power domain to dp_intf0 instead, as that block is indeed in VDO0.
> 
> So.. for this patch: nak.
> 
> Cheers,
> Angelo

Tommy and I was wondering why DP-INTF0 will work without power domain.
After lookup others node in the mt8195.dtsi, I guess this is because the 
power domain VDOSYS0 has been enabled by other modules.

However this patch is still required after adding power domain to DP-INTF0.
Otherwise the dpi errors will become two. :~
  dp-intf@1c015000: power-domains: False schema does not allow [[44, 16]]
  dp-intf@1c113000: power-domains: False schema does not allow [[44, 18]]

I'll send a separate patch to add VDOSYS0 for DP-INTF0.

Thanks
Macpaul Lin

