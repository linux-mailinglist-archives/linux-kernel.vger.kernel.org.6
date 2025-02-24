Return-Path: <linux-kernel+bounces-529014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780ECA41ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ABA3AA121
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A8D24888F;
	Mon, 24 Feb 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hQpPXP8y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6223BD17;
	Mon, 24 Feb 2025 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399541; cv=none; b=JJgcImqB+By5E+NiLIsmpb5y41v7hrOb85MRdTUQ1DAifqsVugsx1Z7Z9MUXU0pB575+ZVhGzgu+rY4kiVwb+9Bq8VuJ1v7JvzrSZrnq1vUeGElt+xNdzvI7L9NJ/dvXgmOzJu9e5JcEnDsVnD45E3IQ3cNWpUBT6qX4RXT1sC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399541; c=relaxed/simple;
	bh=TgNZAgjSLI03J+0oLYbfYvcRE9moSayu1l7EX/brVYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvJ/+d0h2ZhpLwDR2aVFmSNN3CazogoUqlDiIx2Qgcaf11n4OPZdCqODfo0LWMqZLCns1iNhwqwerGsA9HJyLS2KzZ6RAxxat2ApRe8iKAFv11VBxYr9iQTFMDSrivHySB3WoxlR6YLqcaA8+AbOO4YY7xQAdrLMXXTd16EW3m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hQpPXP8y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740399537;
	bh=TgNZAgjSLI03J+0oLYbfYvcRE9moSayu1l7EX/brVYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hQpPXP8ypkU1j0KONnWG3KE49hGsbMsEcL9kT47k/YJQs2fnJ1m8V/ezcvfUvH5jr
	 s2ZgH3FWlJZpogW58JV5dQMv55OmnJdRSsmJQZizXWFlWz3etQcqUaurC6FrD9bUtB
	 ZGKTj2m4BYEn7ysUTpCN1GWJsha7aECg7uILTrVeATjweKW6xZRN8VE+BOPpz+PHcS
	 C7Fa2rSyjbN3iHkECVjpdNBsWb9OIOXjZJDoRGMMnQTgkyEGxUiqMPJTOTEWU2Z14u
	 JdKVeEbL3rbnAFpyBI9CUDniQUtBB3OdVkV2mZPeuikzzZqU3bt49hknaL4OfXQFT3
	 qhsXQ8hCFjc4g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B21C617E00EC;
	Mon, 24 Feb 2025 13:18:56 +0100 (CET)
Message-ID: <fd173075-df66-4ee7-a9fa-07e840976f26@collabora.com>
Date: Mon, 24 Feb 2025 13:18:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: mtu3: Add ports property
To: =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Cc: "macpaul@gmail.com" <macpaul@gmail.com>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?UTF-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20250220142230.2530583-1-macpaul.lin@mediatek.com>
 <0e58bfb8f2f7b7e83e3da6075986ddbcc84531fc.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <0e58bfb8f2f7b7e83e3da6075986ddbcc84531fc.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 22/02/25 09:35, Chunfeng Yun (云春峰) ha scritto:
> On Thu, 2025-02-20 at 22:22 +0800, Macpaul Lin wrote:
>> Define the ports property in the mediatek,mtu3 device tree binding
>> schema.
>> Include definitions for port@0 and port@1, specifying their roles as
>> High Speed (HS) and Super Speed (SS) data buses, respectively.
>>
>> Suggested-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   .../devicetree/bindings/usb/mediatek,mtu3.yaml       | 12
>> ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>> b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>> index d4e187c78a0b..21fc6bbe954f 100644
>> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>> @@ -155,6 +155,18 @@ properties:
>>         property is used. See graph.txt
>>       $ref: /schemas/graph.yaml#/properties/port
>>   
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: High Speed (HS) data bus.
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: Super Speed (SS) data bus.
>> +
>>     enable-manual-drd:
>>       $ref: /schemas/types.yaml#/definitions/flag
>>       description:
> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> Thank you
> 

Is everyone okay if I pick this (and the XHCI one [1]) in the MediaTek trees?

This is so that I don't get devicetree warnings when picking the DT patches
that are adding USB MUX/TCPC to the MediaTek boards.

[1]: 
https://lore.kernel.org/r/20250220105514.43107-2-angelogioacchino.delregno@collabora.com

Thanks,
Angelo

