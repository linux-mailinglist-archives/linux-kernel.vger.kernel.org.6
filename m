Return-Path: <linux-kernel+bounces-356590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37F59963E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F8D28551F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5734188587;
	Wed,  9 Oct 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nHEJYzG3"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761417E019;
	Wed,  9 Oct 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463811; cv=none; b=dACj12EoFyVzsWnl54UvoNrzRMN/OK/a826ZjkSZeu+6D4nXf6o0B6ySdK0BSAb6IwfW1RuwgZbsegaX1OAjAY26wuQqevjevRqr/ChRKJMH7n4I4IIkb/a8dNPiJ6Uf/2D2UcTvC47UVld15xH03safq3l/fzCgdAZ96Q7ALOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463811; c=relaxed/simple;
	bh=4ywukS/WCgAXTE5vNe/GzmXlWbvKkhRuXp3Tk/MfOcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EMYwxmsFVHiYMS0uI2arx35yJKcxgzvG2vUYgcp4Sw6g1p+7tFsD2zTN8M5hV+kB7NV+e8qXgsDqh8sJnXZZszQy3PDoh9oEX4cSuBpzTnX0kBn0S3zS3CfYn7Qhn3dA+z8ePNmJcYSRMfs4JPSW3JxOZTxBkkcGd0Buptd6onQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nHEJYzG3; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7a08d47a861b11ef8b96093e013ec31c-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=/LfpGNkuO2alufeBmISrE7AJMEJiCLM0oNn5nvXUP1U=;
	b=nHEJYzG3p1perhQucYhdmsSwfqU58HBvMKFJDvKC6XsW62S2fvSSOkeGUMcjIgWbFvq58DqI1sQbjnoeukarXM8kSvmPHWWIU3cY3NOmD6n0ppHONoPd1CsoLW52Bew7X0uvwW53Dl/Dw8OQbtNRXCIGntHev11vSkVlhXOCypg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:5aa2afd8-37bf-4398-950d-0f3c61b10ee3,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:d64afc64-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 7a08d47a861b11ef8b96093e013ec31c-20241009
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 99283471; Wed, 09 Oct 2024 16:50:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 9 Oct 2024 16:50:02 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 9 Oct 2024 16:49:59 +0800
Message-ID: <f1bb941b-cb6d-32c4-2cf9-268fc3f43bf9@mediatek.com>
Date: Wed, 9 Oct 2024 16:49:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Fix dtbs_check error for
 tphy
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Jieyy Yang <jieyy.yang@mediatek.com>, Jian Yang <jian.yang@mediatek.com>,
	Jianguo Zhang <jianguo.zhang@mediatek.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Seiya Wang <seiya.wang@mediatek.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>, "Bear
 Wang" <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, "Macpaul
 Lin" <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, Chris-qj chen
	<chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
References: <20241008053514.6800-1-macpaul.lin@mediatek.com>
 <CAC=S1ngrsDxQ1Fe9xB_EevGbGB5nDoCB_n2oGb2VTLiv1vSsGA@mail.gmail.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <CAC=S1ngrsDxQ1Fe9xB_EevGbGB5nDoCB_n2oGb2VTLiv1vSsGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.653400-8.000000
X-TMASE-MatchedRID: zGP2F0O7j/sOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rfEt9Ay9zO7pE4FU2ZdQO4T7jCYv2QJPH7At+An9uo8zRCaZSKE/Os9BQ
	FWu9qPYbJcca6gmWU8Q8A0V8fZwPWVCAsGbzzwDfAJnGRMfFxyfioIsi7Sa0gs1qWTOOMIESRnE
	JOP6CIAvHyC+k6/enwJpJr7UBzLQgYB2fOueQzj4MbH85DUZXyseWplitmp0j6C0ePs7A07Xi4X
	EoPXecxAS0b2iWUgNy5tnIQjFqyCaZjfvjrnrJ4+Y9PUywXU4g=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.653400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9BD4915CE2DEFF6750EBB7161EA9A6CC18A176270AFFF248F20032925B0E03892000:8



On 10/8/24 15:10, Fei Shao wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Tue, Oct 8, 2024 at 1:36 PM Macpaul Lin <macpaul.lin@mediatek.com> wrote:
>>
>> The u3phy1 node in mt8195.dtsi was triggering a dtbs_check error.
>> The error message was:
>>   t-phy@11e30000: 'power-domains' does not match any of the regexes:
>>     '^(usb|pcie|sata)-phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
>> Fix this issue by dropping 'power-domains' of u3phy1 node.
>>
>> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
> 
> Apart from this, can you or Chunfeng confirm if we should make a
> similar change for MT8188[1]?
> 
> [1]: https://lore.kernel.org/all/20241004081218.55962-3-fshao@chromium.org/
> 
> Regards,
> Fei
> 

According to the suggestion and discussion in

[1]: 
https://lore.kernel.org/lkml/20241008-disorder-slacking-d8196ceb68f7@spud/T/#mccf978d76f52cc26970f3f3be6120055e4698fe6

I think adding 'power-domains' to PCIE node of MT8188 is okay.

Thanks
Macpaul Lin

