Return-Path: <linux-kernel+bounces-360615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F58999D44
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5784C1C22C79
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6552209662;
	Fri, 11 Oct 2024 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DhDTtYN7"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF1A208994;
	Fri, 11 Oct 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629790; cv=none; b=txrLgSe4htcHpSuxFzh6sdqcJ3PpE6tMOP0RveVO6gJw92qP9b9rzlhFFDfiWPzlKFuBJF3qBnFD60YEQogQ4oPjLmBuy4tbN2IaVg/foO49UuysZONv5hiBFZPv0JfgAEdVB8mAbyvuMAGFMe+Ml70ddf/l/CbTYk9KvEuYTZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629790; c=relaxed/simple;
	bh=Xo0PyFhCMYGLny235IH5R9IegyfzF0hixbX2hUzIvFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r3TOxC19/MDUMGqZ8N5bzX4kdzH1msuK6PoycWjuWY21hM7i5fJ19vxglNLP6ffz/pd8DGTPY/aTsW/I6f2HgbZPiP/6ylrFHSg6cC4dhZw2jPrif04VHrZZ06cgjE69v6epduCxk4yzeaTCfU5WBjk9oOgxGilnL1b5bcN3lPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DhDTtYN7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eb0a1d90879d11ef8b96093e013ec31c-20241011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=8I6A2olOCtmG5k5rmKmYtyOQFqvwL84wIi1DSFnmSP4=;
	b=DhDTtYN7VILXZEY+98qOUyp4UqI61eyLpzzTIeiunRvIDx6XTFEh0X75rthRuaoQUrCI+mq1eyTgpIDhXUM8gXK5lOcUa5R0SYS3bztCesFmUgRiyia4wyyCxUr/yv3EjAT6mu9/nan51goeW47r2+Iojdoaozc1X2blvNx3jm4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:914c961f-83fa-4db2-89cf-ab41b53cf7b8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:a063a026-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eb0a1d90879d11ef8b96093e013ec31c-20241011
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1657576225; Fri, 11 Oct 2024 14:56:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 11 Oct 2024 14:56:18 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 11 Oct 2024 14:56:16 +0800
Message-ID: <30955c9f-2133-46fe-aaa8-6709d6e301c5@mediatek.com>
Date: Fri, 11 Oct 2024 14:56:15 +0800
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
To: Conor Dooley <conor@kernel.org>
CC: Jason-ch Chen <Jason-ch.Chen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexandre
 Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, Pablo
 Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen Chu
	<sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, MediaTek
 Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
References: <20240926101804.22471-1-macpaul.lin@mediatek.com>
 <20240926-treadmill-purr-b2e3279a14a4@spud>
 <3a970560-2458-f5f3-87c5-925079fa12a4@mediatek.com>
 <20241008-disorder-slacking-d8196ceb68f7@spud>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20241008-disorder-slacking-d8196ceb68f7@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/24 00:31, Conor Dooley wrote:
> On Tue, Oct 08, 2024 at 12:03:37PM +0800, Macpaul Lin wrote:
>>
>>
>> On 9/27/24 00:25, Conor Dooley wrote:
>>> On Thu, Sep 26, 2024 at 06:18:04PM +0800, Macpaul Lin wrote:
>>>> Some platforms requires a dependency for power-domains.
>>>
>>> Some, so not all? Why isn't this restricted on a per compatible basis?
>>
>> After discussion with Chunfeng and double check tphy design in detail.
>> Chunfeng commented that tphy dose not need to add mtcmos.
>> It is not necessary to add it, if the power of the phy is turned off,
>> it will affect other functions.
>>
>>  From the current USB hardware design perspective, even if mtcmos
>> is added to the phy, it is always on.
> 
> Firstly, I have no idea what "mtcmos" means, sorry. I am a dt-bindings
> guy, not someone familiar with mediatek hardware.
> Secondly, it sounds like this /does/ have a power domain, so it should
> be in the binding. That it is turned on by something else and must
> remain on doesn't mean it shouldn't be documented here. What if those
> things try to turn it off while the tphy is using it?

After discussion in MediaTek internal. Chunfeng agreed to
add 'power-domains' property to DT schema. The v2 patch will
also adding the reminder in the description for developers.

>>
>>>> So we add property 'power-domains' and set 'maxItems: 1' in the
>>>> DT Schema.
>>>>
>>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>>>> index 423b7c4e62f2..c77fe43c224a 100644
>>>> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>>>> @@ -125,6 +125,9 @@ properties:
>>>>        $ref: /schemas/types.yaml#/definitions/uint32
>>>>        default: 28
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>> +
>>>>    # Required child node:
>>>>    patternProperties:
>>>>      "^(usb|pcie|sata)-phy@[0-9a-f]+$":
>>>> -- 
>>>> 2.45.2
>>>>
>>

[snip]

V2 of this patch has been send.

Thanks
Macpaul Lin.

