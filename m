Return-Path: <linux-kernel+bounces-307131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E480C9648CD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1779282078
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BE61B1503;
	Thu, 29 Aug 2024 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Gco9Pck2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71D1B14E5;
	Thu, 29 Aug 2024 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942536; cv=none; b=Dq/zaXC/I9u4KliXyZrK/oKmkwToWdZ1TrjokhGwhpC6UFXB07jD0yDtHcMokuG3THBB4eXxyGRs8hqGAm4jVn5uv0IXSUFTrcUhmaOsTBqWs9E9YzJIf8AesLpR5u9jUwBMa+iWLhJfj55P+5Sybj8ZDSwrBH2VnBgX03ztMhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942536; c=relaxed/simple;
	bh=sRYuU3YkOqesdGc/30AGkILwNmVUvPdw3djSMGL8CMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s0LcDD7+hSuWZvKl5Z2T14qn+RiCLI6trHAwxaT0hLsmf+QIlz8U/VGi4zufphc7BdCTi3tBQnHM5yM/4mDv1Ndxna7ELMS0pfz5maN6JZjeW8IHtjxqZ2pl7R3IVv8rA5ckFHMtQfYQnEnHbIh68Gyn7Gk70fnguNBQtWNDRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Gco9Pck2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724942535; x=1756478535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sRYuU3YkOqesdGc/30AGkILwNmVUvPdw3djSMGL8CMs=;
  b=Gco9Pck20J7iVr6byWlPiD7i3H6mAOu4pXjNpFI2dcLpXIeARAUeV1Rt
   xQsFE8MO+lH0wLdBpCjtWwz51b7Vc3bnf307KRsKFGsCdw+8VfvjVAQK2
   q15XLZr2vbcJekOYVsaXfXofxMeUIHecA+yDp1O5gC9RsZ/r05VBUo4l0
   rwfQ2rKl77uNoEBVLVVVOcbE8ZV9MgGMQSHx1SIVLy7HkZMRTLZ7HT3a2
   d241cq3NDzV8Bzh6LSuWVTRv0NV/yK7E8PhBv2lvfed3krVed7s4tdg8i
   PwgbMD5gJfLrc80wkKced55NMjOgccnzcdmcdWoFngOlEZ/yyoUAPVj37
   Q==;
X-CSE-ConnectionGUID: LQAVLlwfT06Kc5IPejiGRQ==
X-CSE-MsgGUID: WEyMVpPrTgWNZnZxmgygcA==
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="31055475"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2024 07:42:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Aug 2024 07:41:42 -0700
Received: from [10.180.117.88] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 29 Aug 2024 07:41:40 -0700
Message-ID: <744af115-3cfe-4d3a-9bf7-e6ac0cd12378@microchip.com>
Date: Thu, 29 Aug 2024 16:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: Add SAMA7D65 PMC compatible string
Content-Language: en-US, fr-FR
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Dharma Balasubiramani
	<dharma.b@microchip.com>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com>
 <20240829141003278e9ec2@mail.local>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240829141003278e9ec2@mail.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Alexandre,

On 29/08/2024 at 16:10, Alexandre Belloni wrote:
> On 29/08/2024 15:08:45+0530, Dharma Balasubiramani wrote:
>> Add the `microchip,sama7d65-pmc` compatible string to the existing binding,
>> since the SAMA7D65 PMC shares the same properties and clock requirements
>> as the SAMA7G5.
> 
> Shouldn't you rather use a fallback if you currently have no driver
> change?

The clock/pmc driver is (will be) different. Only the binding of the PMC 
uses the same properties and clocks specification as our recent SoCs (so 
can be added to the "enum").

Regards,
   Nicolas

>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
>> ---
>>   Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>> index c9eb60776b4d..885d47dd5724 100644
>> --- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>> @@ -43,6 +43,7 @@ properties:
>>                 - atmel,sama5d4-pmc
>>                 - microchip,sam9x60-pmc
>>                 - microchip,sam9x7-pmc
>> +              - microchip,sama7d65-pmc
>>                 - microchip,sama7g5-pmc
>>             - const: syscon
>>
>> @@ -90,6 +91,7 @@ allOf:
>>               enum:
>>                 - microchip,sam9x60-pmc
>>                 - microchip,sam9x7-pmc
>> +              - microchip,sama7d65-pmc
>>                 - microchip,sama7g5-pmc
>>       then:
>>         properties:
>>
>> ---
>> base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
>> change-id: 20240829-sama7d65-next-a91d089b56a3
>>
>> Best regards,
>> --
>> Dharma Balasubiramani <dharma.b@microchip.com>
>>
> 
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


