Return-Path: <linux-kernel+bounces-326411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FB6976802
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88979B219D1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224819599C;
	Thu, 12 Sep 2024 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="latU+9OM"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFBB29CF6;
	Thu, 12 Sep 2024 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141113; cv=none; b=dIs29dMcHrlDV/FBlOeI25+GuJUQZfEeOvS+k05uvcRZrez7c/l1Qqepvdb4uTEn0mt3t31VA5ISqxRrOXZ+HljdCaWcAzYaWxBot9qMFf4bEDqvbIdog0vIX+syq72HUh0s9R4mAGMv/3M/xDpvMkHgfYjas8Ovu7pW77qncrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141113; c=relaxed/simple;
	bh=hilndm36269LUYBh4eirr0Z179Ugs3I2OsaZrmx0zB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O8xqDGQ2+FN1Rl9t1v5+Z2cPe6V67b2g1mf4BAsLzhNinLWNpPSliUzFmjUZLwA5tqp9URSbJHlnlXxN7+Ow6nlpp0/Ve5wPTqcywRoZlfPnd15E7lIKgFsnWEBos1w6doCHPM9IAtDnjbi54hiW2lG7kfc0ivGoLRnJxBqivYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=latU+9OM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 81acf11e70fb11efb66947d174671e26-20240912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=zMl5165Nco4nnPRdvUh/bXbQdA86zHrP4M9QbnMQj9k=;
	b=latU+9OMDNRD3zIVStiqfee1ZoKpvQIhRs60H1Ip3llZ0jB1FR5hR73iXp0c5pItX8/PDlS++5TUPfsW5wQIqSSJkpGMv3a58Y6/wYPAQ+0eeu8+PIsoN8i2d9lgNnhXP4loYUcZNHqmiDOfiNAxFEmovOyKM7U36zYs/ceeDDY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:23332369-de2a-4755-a624-3b43f97f1cfb,IP:0,U
	RL:25,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:26
X-CID-META: VersionHash:6dc6a47,CLOUDID:3006e9b6-8c4d-4743-b649-83c6f3b849d4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 81acf11e70fb11efb66947d174671e26-20240912
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1815120095; Thu, 12 Sep 2024 19:38:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Sep 2024 19:38:12 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 12 Sep 2024 19:38:12 +0800
Message-ID: <30184391-12a6-c095-7862-35c7677b0ede@mediatek.com>
Date: Thu, 12 Sep 2024 19:38:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable GPU
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20240910143245.5282-1-pablo.sun@mediatek.com>
 <01020191e04d4237-204596e1-6cc1-491c-a60f-de3917af7d42-000000@eu-west-1.amazonses.com>
 <2fd45240-a341-806b-f336-78d0595a8031@mediatek.com>
 <01020191e5383829-7eb375ea-ee17-419e-b173-30df46f61863-000000@eu-west-1.amazonses.com>
From: Pablo Sun <pablo.sun@mediatek.com>
In-Reply-To: <01020191e5383829-7eb375ea-ee17-419e-b173-30df46f61863-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.398400-8.000000
X-TMASE-MatchedRID: VfovoVrt/oYNtKv7cnNXnSa1MaKuob8P2r3/CX4MlKCqvcIF1TcLYIKO
	HgdS51oIY8pnlWhODINRVnZsGmIphSw+COFH6OKxioK033WJkCk4m0JsW63IXBKCZ+Q6yB8qy7F
	bVebgF6C5u9/qS1btcB+SaFrhL/iTQjr0vbZGNcuWLCkl1lq7B0Crr/LkAQ46+3n3Z6rbGhNjy0
	xoWgR6JLEwnnFnQnmnUNHYJMizeW5f2oN5IGbAjgXysW33GYMpfkXv6w7OOZIKM+BgluLK4HJZ1
	Ae+gMbqAZ/Skj4ls4+Rk6XtYogiau9c69BWUTGwVnRXm1iHN1bEQdG7H66TyMdRT5TQAJnA0heq
	/DjysoVjrbuJifCzbU4niEfXGAFbP/pFwct6g8CeqD9WtJkSIw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.398400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1049EF671E4F33D3EAD7E1E3BDF8DDDA43F8B73B2326C84DD876E49E57F162052000:8

Hi Angelo,

On 9/12/24 15:52, AngeloGioacchino Del Regno wrote:
[snip]
>>
> 
> The range should match the target device's Vin constraints; in this 
> case, it
> should be no lower than the minimum working voltage of the Vgpu-in of 
> the Mali IP.
> 
> The drivers will be responsible of setting the lowest possible voltage for
> enhanced efficiency (power saving), taking into account the fused chip 
> quality bits
> (in this case, the MediaTek SVS driver!).
> 
> You should, at this point, check the constraints of SVS, as in, given a 
> reference
> voltage (in this case, located in the GPU OPP table, the voltage 
> associated with
> the lowest frequency of the GPU), what is the maximum voltage 
> *subtraction* that
> SVS will do on the VGPU?
> 
> After the subtraction, may this voltage be lower than 0.546V? :-)

Thanks for the clear explanation. While there are no explicit constraint 
in the maximum voltage subtraction in the SVS driver, I have
confirmed that the fuse data of MT8395 is written in a way that the SVS
driver would never go lower than the minimum recommended operating
voltage of DVDD_GPU in the datasheet[1], which supplies power to the 
Mali IP.

I have sent patch v2 to remove the always-on property and add a note
about the fuse(eFuse) data in [2].


[1]: 
https://mediatek-marketing.files.svdcdn.com/production/documents/MTK_MT8395_Application-Processor-Datasheet_v1.8.pdf?dm=1724252510
[2]: https://lkml.org/lkml/2024/9/12/285

Many thanks,
Pablo

