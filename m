Return-Path: <linux-kernel+bounces-350035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5898FEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5066282993
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98A13D619;
	Fri,  4 Oct 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YgBYMD1f"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466211802E;
	Fri,  4 Oct 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031225; cv=none; b=M4qXWFr086gFJeQrHrAKKq3MMI8/J5u3azj7Zgkqunag3MhsS14HrRpv4yu0PBM/HcU81x//sPYauwn+3AmrLlZ4tf4f4OUvr3sbP/2InsP7KPLtbe79zqWz7Pfx3L1Jhzej0tceNmWyFmeyfCR5EAw3AjkVh7902O7qIhB4er4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031225; c=relaxed/simple;
	bh=905AVJ1+V+02nok2d5huU149NOyTw9kkB582lLm4Kgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=geSeiaFGvH6WFnAguu+h5zs7L0dvm9KqAU1h8zfJMo4HNxAL62CuBGk0viscmyJbT3IW6uj+D8Cc+dftmA9qcK9zh+uJ7ltEdu7JamFSRUV3oZoKCkPMRlhzklVO2i1q/kgkJjvsJI4zXvXO/LJUvhlem8lFMDX9dUo3ewmRnZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YgBYMD1f; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 481a7984822c11ef8b96093e013ec31c-20241004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=sKwcQTdi1z6XfJ8YlR6rEfMwt8LTLhlGfQB2vS/hKN8=;
	b=YgBYMD1fRUnkI/89E+ASjzC8doSN3zYbu7/pziuMZfjYLrCS9QbqmK8G6vUW6BF7eTvhw+rgX0up3+ZnyQS++yJ+EV2jTsoQBwIj2z+32GAq+HJ4tcw6ewIpsitn6H/HIdHqqoVKwTh1VwLYUs4kfNYoTrM94oCxZFbKmWUutpc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:5eb5d169-94e7-4a79-8332-7e0a6f97473f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:9b1cbd64-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 481a7984822c11ef8b96093e013ec31c-20241004
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 953801011; Fri, 04 Oct 2024 16:40:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Oct 2024 16:40:13 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 4 Oct 2024 16:40:10 +0800
Message-ID: <b07db9a3-62c1-f0e6-33db-98999a517c3f@mediatek.com>
Date: Fri, 4 Oct 2024 16:40:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: power: mediatek: Refine multiple level power
 domain nodes
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, Pablo Sun
	<pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen Chu
	<sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, MediaTek
 Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
References: <20241004074938.6571-1-macpaul.lin@mediatek.com>
 <CAC=S1nhW7ervk-b31mxtx_c-KUeLuC0P_Yr=9jtumUXAm6AZ_A@mail.gmail.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <CAC=S1nhW7ervk-b31mxtx_c-KUeLuC0P_Yr=9jtumUXAm6AZ_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 10/4/24 16:24, Fei Shao wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Fri, Oct 4, 2024 at 3:53 PM Macpaul Lin <macpaul.lin@mediatek.com> wrote:
>>
>> Extract duplicated properties and support more levels of power
>> domain nodes.
>>
>> This change fix following error when do dtbs_check,
>>   mt8390-genio-700-evk.dtb:
>>     power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30:
>>     Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32'
>>     were unexpected)
>>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>  .../devicetree/bindings/power/mediatek,power-controller.yaml  | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> index 8985e2df8a56..a7df4041b745 100644
>> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> @@ -54,6 +54,10 @@ patternProperties:
>>              patternProperties:
>>                "^power-domain@[0-9a-f]+$":
>>                  $ref: "#/$defs/power-domain-node"
>> +                patternProperties:
>> +                  "^power-domain@[0-9a-f]+$":
>> +                    $ref: "#/$defs/power-domain-node"
>> +                    unevaluatedProperties: false
>>                  unevaluatedProperties: false
>>              unevaluatedProperties: false
>>          unevaluatedProperties: false
> 
> For reference, I sent the exact same patch and it's been acked:
> https://lore.kernel.org/all/20241001113052.3124869-2-fshao@chromium.org/
> 
> Regards,
> Fei
> 

Thanks for the reminder.
This patch could be dropped by duplicate works.

Regards,
Macpaul Lin

