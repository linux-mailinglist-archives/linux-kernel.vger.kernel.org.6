Return-Path: <linux-kernel+bounces-367231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C56509A0015
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775451F25FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E6187350;
	Wed, 16 Oct 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="diRL//Ls"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE84A0C;
	Wed, 16 Oct 2024 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052262; cv=none; b=VkviF3WRflvXDtDvFsRVEn8AhfqhUXkI4tKOjvucN+WJxj9ptg5JMyrDBa4BcOMsKqyepV0KX/Jn4pxpLJNP81PdLG/ylBNDCTJY360g2m+dhjedGb5b70Td3+aeH58ts9/pl0W2qalhoHeIT8lZTO5YGA/h10kdffyKXJD7740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052262; c=relaxed/simple;
	bh=YFJHhbYS31Y75rTWk27g/bb9SPMx5GuFvaJtJ59ODFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fXUGGO2CeqgeuUL2At+aDzn8Sd1BTAyw1yrFi0efek3X7IQlmgvcKk52YXdT+LGSsXj/tU2qfqiw/fGvU7XDkep2vMrZk0XMqCQBJqN67j3K4hPojuCZg0k64H+Lq/KR7BaubQLUi+XCCupDySMgxzIx83aCzfmhDPFzTrdc3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=diRL//Ls; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 90fc54728b7511ef88ecadb115cee93b-20241016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=1DCabenPzzIyCe0g7pTxKCjOOLbiMHBzb+xs4rZe8uQ=;
	b=diRL//LscT81YGMHp1OQMg8w8XvR0XuqNXXdjO9X3Dq6nRvYqMtXs9fkPCWcGh+XZ/jgPesKbUlcrLwxqYhglGbd9fGEjyH4rDYgb7WCGkC0W3lTnag0GuN6AiljslJFA1k2xfLwEOWPHOtD+qhWHXlTe8FwPULwyq6MsgutYLY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:7a7c2788-16b5-435d-b964-0de5d69abcd6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:fa755165-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 90fc54728b7511ef88ecadb115cee93b-20241016
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 992852966; Wed, 16 Oct 2024 12:17:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 16 Oct 2024 12:17:31 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 16 Oct 2024 12:17:31 +0800
Message-ID: <f624ea86-1754-c365-ab22-a2890960b94c@mediatek.com>
Date: Wed, 16 Oct 2024 12:17:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: usb: mtu3: add mediatek,usb3-drd property
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, ChiYuan
 Huang <cy_huang@richtek.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bear Wang
	<bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin
	<macpaul@gmail.com>, <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>
References: <20241015172100.15150-1-macpaul.lin@mediatek.com>
 <20241015222046.GA2164669-robh@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20241015222046.GA2164669-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 06:20, Rob Herring wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Wed, Oct 16, 2024 at 01:21:00AM +0800, Macpaul Lin wrote:
>> Add optional 'mediatek,usb3-drd' property to MediaTek MTU3 DT Schema.
>> This flag specify whether it is a USB3 Dual-role device hardware.
>> 
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>> index d4e187c78a0b..1e70af0dac82 100644
>> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>> @@ -155,6 +155,12 @@ properties:
>>        property is used. See graph.txt
>>      $ref: /schemas/graph.yaml#/properties/port
>>  
>> +  mediatek,usb3-drd:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      Specify whether it is a USB3 Dual-role device hardware.
>> +    type: boolean
>> +
> 
> Don't the standard properties such as usb-role-switch or dr_mode work
> for you?

I've found there are some hardware capability registers could be read
when probing the device. I'll try if the platform I'm using could access
these capability registers.
This patch can be discard. If the hardware really need specify the 
capability in dts and there is no capability registers, I'll resend
this patch that time.

>>    enable-manual-drd:
>>      $ref: /schemas/types.yaml#/definitions/flag
>>      description:
>> -- 
>> 2.45.2
>> 
> 

Thanks!
Macpaul Lin

