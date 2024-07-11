Return-Path: <linux-kernel+bounces-248566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5180C92DF11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079672846E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E6E374DD;
	Thu, 11 Jul 2024 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NpblMkig"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23817BBB;
	Thu, 11 Jul 2024 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720671200; cv=none; b=PMrI3JnNqoMBlf12USYMXVjeT/wzqNEKfW9qpfLitbzXRGdJk55uC2XC/NjiJS9kyp2ZF38NMSehKZPbrmpsgw9sfjbvNYc6gmuOsNGmd4dae2mLvZA2FHP/uQuEBggrQ0OK0paouZVIKAanMwoBtvtZkP4S6ude7J054pbJZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720671200; c=relaxed/simple;
	bh=eOaU90Sakb86O1wTszSDiKLUMO6y2138VCQ1E98y/Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZtCPiiwQ/VgB4vuVTRnddXVGVYbcTOn9lxANNSeo8AXN4m0mZEeNcNrnVbO9WSAT8ez501jZG+s97oD7Swa5W5vYLWFCTK8R9eKW8489+Xu/U6yTiQ1TiLp8ZCUCFzQW2iJGgnqb4r1uGDppOmTgwtTlMEw4benyVtkeD4kmITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NpblMkig; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e3011acc3f3b11efb5b96b43b535fdb4-20240711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=tRvWdH2sgEWMYZdUksWGlEzG3jsHq5MNinuSGFz8Ric=;
	b=NpblMkigXzN5S9G2DSwzw1k0fGbyUVDauKYm3mULBHVA/wTpt41ErLPoFl1RDjk2RKRBKaXWIIVa4mFuoxhcQQJEith3L4/RQwu5f+kHVewph58v+0oj7MyddvoF+B0J/RAYofjq2MeN5a4TBhUSz9KUU0FtHRrcvYDYQ30iupk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:b6a51dcd-6d0b-44be-98ee-51d71332c415,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:bf19520d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: e3011acc3f3b11efb5b96b43b535fdb4-20240711
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 187544350; Thu, 11 Jul 2024 12:13:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Jul 2024 12:13:11 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 11 Jul 2024 12:13:07 +0800
Message-ID: <da27d957-866f-f055-9e83-cdc362d98dc7@mediatek.com>
Date: Thu, 11 Jul 2024 12:13:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Probe failure of usb controller @11290000 on MT8195 after
 next-20231221
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <kernel@collabora.com>, Chen-Yu Tsai
	<wenst@chromium.org>, Bear Wang <bear.wang@mediatek.com>, Pablo Sun
	<pablo.sun@mediatek.com>
References: <9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano>
 <064935d8-fbda-4eda-b013-8c8fc63b561c@collabora.com>
 <375b2345-657a-4b8f-b5e3-dc16784ffde9@notapiano>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <375b2345-657a-4b8f-b5e3-dc16784ffde9@notapiano>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 7/11/24 03:15, Nícolas F. R. A. Prado wrote:
> On Fri, Jan 19, 2024 at 10:12:07AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 18/01/24 19:36, Nícolas F. R. A. Prado ha scritto:
>>> Hi,
>>>
>>> KernelCI has identified a failure in the probe of one of the USB controllers on
>>> the MT8195-Tomato Chromebook [1]:
>>>
>>> [   16.336840] xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
>>> [   16.337081] xhci-mtk 11290000.usb: xHCI Host Controller
>>> [   16.337093] xhci-mtk 11290000.usb: new USB bus registered, assigned bus number 5
>>> [   16.357114] xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
>>> [   16.357119] xhci-mtk 11290000.usb: can't setup: -110
>>> [   16.357128] xhci-mtk 11290000.usb: USB bus 5 deregistered
>>> [   16.359484] xhci-mtk: probe of 11290000.usb failed with error -110
>>>
>>> A previous message [2] suggests that a force-mode phy property that has been
>>> merged might help with addressing the issue, however it's not clear to me how,
>>> given that the controller at 1129000 uses a USB2 phy and the phy driver patch
>>> only looks for the property on USB3 phys.
>>>
>>> Worth noting that the issue doesn't always happen. For instance the test did
>>> pass for next-20240110 and then failed again on today's next [3]. But it does
>>> seem that the issue was introduced, or at least became much more likely, between
>>> next-20231221 and next-20240103, given that it never happened out of 10 runs
>>> before, and after that has happened 5 out of 7 times.
>>>
>>> Note: On the Tomato Chromebook specifically this USB controller is not connected
>>> to anything.
>>>
>>> [1] https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/659ce3506673076a8c52a428/__;!!CTRNKA9wMg0ARbw!jtg5drII8WUPwTiL4sWZiSRPXN-EBN8ctTGI85sirqvkmaUbA5z-wrLqPPfxlZZkQ7NItOWDT97OSdENT5oGHKY$
>>> [2] https://lore.kernel.org/all/239def9b-437b-9211-7844-af4332651df0@mediatek.com/
>>> [3] https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/65a8c66ee89acb56ac52a405/__;!!CTRNKA9wMg0ARbw!jtg5drII8WUPwTiL4sWZiSRPXN-EBN8ctTGI85sirqvkmaUbA5z-wrLqPPfxlZZkQ7NItOWDT97OSdENi-d0sVc$
>>>
>>> Thanks,
>>> Nícolas
>>
>> Hey Nícolas,
>>
>> I wonder if this is happening because of async probe... I have seen those happening
>> once in a (long) while on MT8186 as well with the same kind of flakiness and I am
>> not even able to reproduce anymore.
>>
>> For MT8195 Tomato, I guess we can simply disable that controller without any side
>> effects but, at the same time, I'm not sure that this would be the right thing to
>> do in this case.
>>
>> Besides, the controller at 11290000 is the only one that doesn't live behind MTU3,
>> but I don't know if that can ring any bell....
> 
> An update on this issue: it looks like it only happens if "xhci-mtk
> 11290000.usb" probes before "mtk-pcie-gen3 112f8000.pcie". What they have in
> common is that both of those nodes use phys that share the same t-phy block:
> pcie uses the usb3 phy while xhci uses the usb2 phy. So it seems that some of
> the initialization done by the pcie controller might be implicitly needed by the
> usb controller.
> 
> This should help to narrow down the issue and find a proper fix for it.
> 
> Thanks,
> Nícolas

'force-mode' should only applied to the boards which require XHCI 
function instead of a PCIE port.

For example, mt8395-genio-1200-evk.dts requires property 'force-mode' to 
fix probe issue for USBC @11290000.

https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git/commit/?h=v6.10-next/dts64&id=666e6f39faff05fe12bfc64c64aa9015135ce783

'force-mode' should be no need for tomato boards and the behavior should 
be the same as before.

Another possibility is the firmware change on tomato boards. I'm not 
sure if there is any changes on tomato's recent firmware for tphy of 
this port, which could also be a reason causes this kind of failure.
I don't have tomato boards on hand.

Thanks
Macpaul Lin

