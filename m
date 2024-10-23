Return-Path: <linux-kernel+bounces-377521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C19ABFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCA6281ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A665A1531EF;
	Wed, 23 Oct 2024 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B2C0OyiY"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF231487BE;
	Wed, 23 Oct 2024 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667798; cv=none; b=R6vNHoKFVkWH0x84sb9fpNE/oba/2BkJQqA1WiW7ErOIbzrbJsU1whHkR3lsV/8Ld0/5WviNVxqmRA6enutJ1RCRL0nOlxt/Z/S5+STveIARKh9kE6EJ9EFIfu387UrsIIeOtjdA5InKSIFaW7QotpqrNJRz4VTqnug0FygjdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667798; c=relaxed/simple;
	bh=lHCHrd+Ef2TVeKK9oypNt14QhjDX6xjsnGXBA7NIa3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rkn2mq0emVH+hHSW+P1jhVzhJ4vS9L/wLvUxclNNiS6lMcqVS/caA9tX4xWl0pJmNYnAwjE6wiTQh3SUNoBz2j7n8blbwcWDB0T3f+/A38+tXG+kZoa3/Fb4Eay1p8PR2yW+ktYmOg4bmNy8w6Pn1WcdUtCAlDncnsJ0b4GtLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=B2C0OyiY; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b8c319c0910e11efb88477ffae1fc7a5-20241023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=NLT2EELlLA5EsEZukw2FmKQ26xxJRaMm4DbGbcReVJY=;
	b=B2C0OyiYJjImkCwepFfqDZd/vs5dh12JW14Uj6cJcckbxZAZhsyczdQmuMCCHobmUrl0uhcgJd1sY3dp+aXx9hcWaTYL4rAV8fNYNOt5QSc+uBhVF/+eye3BQCCptgRw47XpGEd58Q3d+D3DedfoyWykqoJd9GBtGpHZ+dRa/+E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:98be8e3e-019f-4b7a-b421-c10657f8f4a2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:ca28b341-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b8c319c0910e11efb88477ffae1fc7a5-20241023
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1966275101; Wed, 23 Oct 2024 15:16:28 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 15:16:27 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 23 Oct 2024 15:16:26 +0800
Message-ID: <0d0b1ebc-6fdd-cf65-510e-51c273856cb9@mediatek.com>
Date: Wed, 23 Oct 2024 15:16:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: usb: mediatek,mt6360-tcpc: add ports
 properties
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
References: <20241015103337.20479-1-macpaul.lin@mediatek.com>
 <20241015205405.GA1934266-robh@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20241015205405.GA1934266-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 04:54, Rob Herring wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Tue, Oct 15, 2024 at 06:33:36PM +0800, Macpaul Lin wrote:
>> Add 'ports' and sub node 'port' properties to specify connectors on the
>> High-Speed/Super-Speed data bus, or Sideband Use (SBU) AUX lines
>> endpoints of the USB controller.
>> 
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>  .../bindings/usb/mediatek,mt6360-tcpc.yaml    | 21 +++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
>> index 053264e60583..5b6ea0d734ea 100644
>> --- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
>> @@ -32,6 +32,27 @@ properties:
>>      description:
>>        Properties for usb c connector.
>>  
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    description:
>> +      Any connector to the data bus of this controller should be specified.
>> +    properties:
> 
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 0
> 
> No need for these, already defined in the $ref'ed schema.
> 
>> +
>> +    patternProperties:
>> +      "port@[0-2]$":
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description:
>> +          It could be one of the following interface types. High-Speed
>> +          (HS) data bus endpoint to the Type-C connector, SuperSpeed (SS)
>> +          data bus endpoint to the Type-C connector, or Sideband Use (SBU)
>> +          AUX lines endpoint to the Type-C connector for the purpose of
>> +          handling altmode muxing and orientation switching.
> 
> You have to define what each port number is.
> 
> However, I'm completely confused as to why you need any of this. The
> description sounds like the usb-c-connector which is already defined as
> a child node.
> 
> Rob
> 

After checking the internal reference DTS, I've found the
intent was wrong for these ports. I'll send [2/2] of v2 for the
DTS update. Hence this change to DT Schema is no longer required.
Please drop this patch.

Thanks!
Macpaul Lin

