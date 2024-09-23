Return-Path: <linux-kernel+bounces-335721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D701197E9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F96C1F21094
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF934196C9B;
	Mon, 23 Sep 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BLye5v/T"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A611946CD;
	Mon, 23 Sep 2024 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086492; cv=none; b=QFtlvJdfI5W0XDGl/l0DWw1k/Ro7wOqlfVWlXxHFhc0U3jlOtH1YE0na3eoayvY81lzW7Sj0dqCV8bQ288B8ZBPr7O89DmVXv2sHLnoe+mZqMcGEQrFFgWbMYmj8r6OUZDto64IsI7AI6cdridEaIRUftxQMpYGuC03USZUCsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086492; c=relaxed/simple;
	bh=4naAvuRiTLh/W08mGlC6sR55eAP2/bE+rIZw3yBKwIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jOX+wKDib8aN5hQ4BwCG05glye2zrJgFXVlzMiPGBAENB1DKHkHBNuLrd6KxifDlw6Y4vMDZhn//R8MmEJLyRmFQlxRW8+sBAOmW115C3uBxEFWMvBjHuZiYTQ9EOmZe5cpCJRobF6nKRpsUS11WFdNRVi/7ZVX9CCK5LRxOV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BLye5v/T; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a64aa178799411efb66947d174671e26-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=gbUKc5+M4A13tRhLrQDCXFDg4LvyvHUNk+/1687J63Y=;
	b=BLye5v/Tw+C33mJcqD2PHgoj51pf5r3SInQlFIx4NwyOTNED3kD95PR+glE15XnKxEn7OyW/R08j985zrQEICjtptJHR67GFVIQ7nUcgqELQYAfKbMft4sXogTz0H37yffoMExJGqem4EBuFnoQ8zbbX4c2KVPI3AqJoWzUQT1I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:672d9825-9eba-4cec-90d9-caf44858dce2,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:472b1c18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a64aa178799411efb66947d174671e26-20240923
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1772811456; Mon, 23 Sep 2024 18:14:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 18:14:41 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 23 Sep 2024 18:14:38 +0800
Message-ID: <bf45531a-eacf-22a9-65f1-f6474a2ca843@mediatek.com>
Date: Mon, 23 Sep 2024 18:14:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 Mali GPU
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-clk@vger.kernel.org>
References: <20240920134111.19744-1-pablo.sun@mediatek.com>
 <20240920134111.19744-6-pablo.sun@mediatek.com>
 <eb17085d-78ff-4833-a4de-17b9327d776c@collabora.com>
From: Pablo Sun <pablo.sun@mediatek.com>
In-Reply-To: <eb17085d-78ff-4833-a4de-17b9327d776c@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Angelo,

On 9/23/24 16:45, AngeloGioacchino Del Regno wrote:
[snipped]
> 
> Is there any real difference between MT8390 and MT8188 in terms of the 
> GPU OPPs?
> 
> I see that on MT8188, frequencies up to 880MHz want a DVDD_SRAM_GPU of 
> 0.750V,
> then 0.775/0.762/0.750 (bin1-4/5/6) on 915MHz, and 0.800/0.775/0.750 
> (bin1-4/5/6)
> on 950MHz.
> 
> Those never call for 0.850V...! So is MT8188 (Chromebooks) wrong, or is 
> MT8390
> different in that?

To the best of my knowledge, MT8390 and MT8188 has identical GPU
subsystem. Thus, the OPP table should have no difference.

To be specific, I list the link to the OPP table of Genio 700 EVK
(MT8390) in reference in [1]. It should match the setting in Chromebook
kernel branches.

The "typical" voltage in the datasheet is the voltage that would work
for all frequency settings. As long as it is smaller than the maximum
operating voltage, setting voltages higher than the ones specified in
the OPP table does not damage the hardware.

But this 0.85V setting is indeed not optimal. We should follow the
voltages described in the OPP table, if we want power savings.

I also considered model the regulator setting with 
'regulator-coupled-with' and 'regulator-coupled-max-spread', but I am 
not entirely sure how to describe the relation that "DVDD_GPU_SRAM 
should follow DVDD_GPU
if and only if DVDD_GPU is higher than 0.75V" - should I simply
set min-voltage to 0.75V and set 'regulator-coupled-with' ?

[1]: 
https://gitlab.com/mediatek/aiot/rity/meta-mediatek-bsp/-/blob/kirkstone/recipes-kernel/dtbo/mt8390/gpu-mali.dts

Many thanks,
Pablo


