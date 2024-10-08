Return-Path: <linux-kernel+bounces-354461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9392993DC5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA9E1C232D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985D674C08;
	Tue,  8 Oct 2024 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iaHsXtf6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D602533CA;
	Tue,  8 Oct 2024 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360235; cv=none; b=mvhSDOGPibibllhiHqUiKnXfdqJsCgPubQrnr7+X6U3l9e7lfqZaVRlA9RzsLEdx0EAf81F7ByZa2FK8SerOb9dOIa1STpOMfu7ZJ3QGByVD/NPspPnZOsWIaRo7h7hwLVogeXvHkrw0LgiCAjj3gQ0Y7A6nZaxZUVH7KAyxGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360235; c=relaxed/simple;
	bh=I/Er5nsXCFA4qiwG/cy7GiECil0ndyiV7ITbEyOhjQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kWurrETvj0lzzq6PVTNdDqtVhHv1pkLJlYvALBLrdZ9Q9qA2lL0s2RI3XOniWmZQWpuWxpn3lHNcvyxNwUvbIqN96/PaGqkUeeTmtNOergIypvcYrZeGaTNMsoGCjLDV7UVw05i+AOyHOeCpoKq8f0yxlEIYwLqMDGKmem7AIco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iaHsXtf6; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4e404752852a11ef8b96093e013ec31c-20241008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=mwTHTTsRLjvACOCxRw8N0aIBKWsdNo6TgCo9mXIoopg=;
	b=iaHsXtf6Rw0jYxC0w/UHeGf/u82Oiul5qQOcx4Fymap1mSSh7OcuhZvigAfrEidjnhT+3feWte8eJssZq398qQX1uJJqaErGMf1Kmjs/BezRPWB+nESMlMbT08c0i7/il8ngl98T6NAwBJFhhCKdkqAjE96CsoqTwm1xds7HBPY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:8694662a-45eb-4a20-8b53-5455f62f7b67,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:6394e764-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4e404752852a11ef8b96093e013ec31c-20241008
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 345459854; Tue, 08 Oct 2024 12:03:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Oct 2024 12:03:39 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 8 Oct 2024 12:03:38 +0800
Message-ID: <3a970560-2458-f5f3-87c5-925079fa12a4@mediatek.com>
Date: Tue, 8 Oct 2024 12:03:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: phy: mediatek: tphy: add a property for
 power-domains
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Jason-ch Chen
	<Jason-ch.Chen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, "Chris-qj
 chen" <chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
References: <20240926101804.22471-1-macpaul.lin@mediatek.com>
 <20240926-treadmill-purr-b2e3279a14a4@spud>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20240926-treadmill-purr-b2e3279a14a4@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.403700-8.000000
X-TMASE-MatchedRID: csPTYAMX1+EOwH4pD14DsPHkpkyUphL9mX+W7bzPOQEsElh8RiHU9TRO
	5DLJAPjbbIezkMyOt2/FtYuDam42iwdNdS6cTLNYoaP4nSNLOYuwR/wKmchi2fJ/jS86DpPDFVk
	w4X07kmgXw0prgDEKYG2UIwvQdMxgucM7lDuTbby8coKUcaOOvaOI1u80g4PZZ5yuplze9puVQ2
	bE9K2FgiEn+59qml4SkZOl7WKIImrvXOvQVlExsFZ0V5tYhzdWxEHRux+uk8h+ICquNi0WJOQuX
	NATtBTvuMcQkP5KqdH9y2dEXTBNtCv1l1GAoBYzftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.403700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C4C001A2C3E0140BF9ED2D1FF23C06F2DC8DAACE6EC962175BCD71A962969DD42000:8



On 9/27/24 00:25, Conor Dooley wrote:
> On Thu, Sep 26, 2024 at 06:18:04PM +0800, Macpaul Lin wrote:
>> Some platforms requires a dependency for power-domains.
> 
> Some, so not all? Why isn't this restricted on a per compatible basis?

After discussion with Chunfeng and double check tphy design in detail.
Chunfeng commented that tphy dose not need to add mtcmos.
It is not necessary to add it, if the power of the phy is turned off,
it will affect other functions.

 From the current USB hardware design perspective, even if mtcmos
is added to the phy, it is always on.

>> So we add property 'power-domains' and set 'maxItems: 1' in the
>> DT Schema.
>>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>> index 423b7c4e62f2..c77fe43c224a 100644
>> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>> @@ -125,6 +125,9 @@ properties:
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>       default: 28
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>   # Required child node:
>>   patternProperties:
>>     "^(usb|pcie|sata)-phy@[0-9a-f]+$":
>> -- 
>> 2.45.2
>>

Please drop this patch and I'll send a new fix to mt8195.dtsi.

Thanks
Macpaul Lin

