Return-Path: <linux-kernel+bounces-333486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F4D97C977
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A101F239DF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6D019DFA7;
	Thu, 19 Sep 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="AkXE7NWd"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2A19B3FF;
	Thu, 19 Sep 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750207; cv=none; b=ewe+Fqv5kR8/PirAYzLErvOJYOnAzm2Unpfo7sJUoE7Tb5LC4PrW+BdX+DN78s20uL0+/TypfQ+vAyamHMqfsJB9nSMVMXtqrIvB2dAMlXCSnqaofv6fVuhurE38HwR1aemLHyVUnj6EeVLfe8/hwfIdZxDwT7at7Qwk/e3LQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750207; c=relaxed/simple;
	bh=J8H9Vkd951kdcWfVG4cmrmvYIGHGWbAFqpI6AG98CZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sb0YNzlFolceRK4y5uWN9KJN6XGnXI3cP1umsqg6QAf1mkIWboystRRGneHIDe/ubD0YhAWXz9JQgQfyuW0tK0pMc0WBs8BElB3F6YeuwUA9GAke9NLq7wmF+Y+KYDC7NrQaRppg3UgY0wb2+u4ia5KiAH12L2wtX8m87Ccf8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=AkXE7NWd; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1726750197;
	bh=DFUihjgu1Yv1D+fjiFL1PHa9IcrwAPwXN1SA1IoAdgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AkXE7NWdsm1XrH3tNe2r10dthpgaP/q75BPoVxXPJS9uztSFB6Q+juW/8hmr4ldbP
	 RDl2kw38lhKY+C79d5TYrkSFj/fuZhJ2/uA51BLk+5T2tgEbkhTCwmLni7/kD5k8Of
	 1Hkq8f7lIjM9zYyljotET+SwUso7x9aseLPJpvA0=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id DF276A05BD;
	Thu, 19 Sep 2024 14:49:56 +0200 (CEST)
Message-ID: <70d365f0-a386-408b-8d5f-5524496526a0@ysoft.com>
Date: Thu, 19 Sep 2024 14:49:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: usb: Add Diodes Incorporated
 PI5USB30213A Type-C Controller
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Herburger <gregor.herburger@ew.tq-group.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Michael Walle <mwalle@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240917151001.1289399-1-michal.vokac@ysoft.com>
 <20240917151001.1289399-4-michal.vokac@ysoft.com>
 <3ac31595-f596-4960-bba2-0b0b55041193@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <3ac31595-f596-4960-bba2-0b0b55041193@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18. 09. 24 15:16, Krzysztof Kozlowski wrote:
> On 17/09/2024 17:10, Michal Vokáč wrote:
>> From: Petr Benes <petr.benes@ysoft.com>
>>
>> Diodes Incorporated PI5USB30213A Type-C Controller supports host,
>> device, and dual-role mode based on voltage levels detected on CC
>> pin. Supports dual differential channel, 2:1 USB 3.0 Mux/Demux,
>> USB Type-C specification 1.1.
>>
>> Signed-off-by: Petr Benes <petr.benes@ysoft.com>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>>   .../bindings/usb/diodes,pi5usb30213a.yaml     | 95 +++++++++++++++++++
>>   1 file changed, 95 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml b/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
>> new file mode 100644
>> index 000000000000..1cae10724152
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
>> @@ -0,0 +1,95 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://eur02.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fusb%2Fdiodes%2Cpi5usb30213a.yaml%23&data=05%7C02%7Cmichal.vokac%40ysoft.com%7C925faa72b27547fa80c308dcd7e425f4%7Cb5839965430f4be2b282d7a3149f2b37%7C0%7C0%7C638622622118849100%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=T2NXqovVWUhM4ID1XdytvSaD9yQMKLH9QfQ%2FwFJ9xOs%3D&reserved=0
>> +$schema: https://eur02.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&data=05%7C02%7Cmichal.vokac%40ysoft.com%7C925faa72b27547fa80c308dcd7e425f4%7Cb5839965430f4be2b282d7a3149f2b37%7C0%7C0%7C638622622118861671%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=tAR73Ny5eXo1GmO4%2BAqiUhpqLdwEgOrfuzwtY4b7K%2Bs%3D&reserved=0
>> +
>> +title: PI5USB30213A Type-C port controller
>> +
>> +description:
>> +  Diodes Incorporated PI5USB30213A Type-C Controller supports host,
>> +  device, and dual-role mode based on voltage levels detected on CC
>> +  pin. Dual differential channel, 2:1 USB 3.0 Mux/Demux, USB Type-C
>> +  specification 1.1 compliant.
>> +
>> +maintainers:
>> +  - Petr Benes <petr.benes@ysoft.com>
> 
> Please put maintainers before description: block.

OK

>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - diodes,pi5usb30213a
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  connector:
>> +    type: object
>> +    $ref: ../connector/usb-connector.yaml#
> 
> Full path, so /schemas/connector/usb-....

OK.
  
>> +    unevaluatedProperties: false
>> +    description:
>> +      The managed USB Type-C connector.
> 
> Description should not be needed.

OK, I will remove it.

>> +
>> +    properties:
>> +      compatible:
>> +        const: usb-c-connector
> 
> Drop, not needed.

OK.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - connector
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      pi5usb30213a: tcpc@d {
> 
> typec@d
> 
> and drop label

OK.
  
>> +        compatible = "diodes,pi5usb30213a";
>> +        reg = <0xd>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&pinctrl_typec>;
>> +        interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
>> +        status = "okay";
> 
> Drop status

OK.

Thank you for the review,
Michal


