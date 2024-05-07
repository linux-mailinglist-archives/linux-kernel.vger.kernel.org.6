Return-Path: <linux-kernel+bounces-170783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F358BDC03
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2221C21370
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200279B84;
	Tue,  7 May 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="illmbUWL"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2171754;
	Tue,  7 May 2024 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065444; cv=none; b=tNfpFxuVPV99LxqbJ7JiU/EEDJXOM9fAU9ZBhTj6LfBsYnOHrgWpJHp3qDCapq/DxUN4e1vr2H+Sla6ObvJ5PeyXwJudrlL9SVR+YhLJ1qn9a6hHJo1SEHDgKUPJVQ7s+tju8NsT0cZMZSSSkyxO9/7FtGzEQvUSGe6RyUHmXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065444; c=relaxed/simple;
	bh=f5Y+RPch/7mrTdblk+FuyORnXeTj5LvlcQlkeUJhWus=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NYcNWyLnYXokrmg9RKIzIoMZQugj73U1ts0p3CmXKLpjQ6qzNR5mnpY6RHbAqY64rcJckstu165hNEFFiJFfj5jxgJY4tFM5W+U/pz4HCmETDFpv3rTA9VVCKdkhPQfIs3G1uMcTRCPs6F7FFL4yFAIKn2xkekJkupLr2zBOA3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=illmbUWL; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D6E6D120003;
	Tue,  7 May 2024 10:03:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D6E6D120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715065430;
	bh=H/kIGo3J8gDU/CLl+ICpmHfUJ577I1NNpGXMj98OV+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=illmbUWLUP6z8cEOzU19cEiOVtGCj2hwDhcZGlI5Yc5uaDBZNel5WH65as/Sb8LBg
	 VRUTi/IrnSR7J71oIRujD2zE2S34MUJAYcEOgCKtvPddm2+fQMYRy5FMzZXIhCBDDa
	 0oUKtm8Rr2b5lcfITxxpEyD74goehnon3BreSRjJ3z2ZZTHRDaJq1CsS9QU54T96ej
	 sqHd53GI8LkbXLxZj129aPUcrHiPBoBobxuHCXaF7/gCfd2dzhjW1Is/1PcieG/xHl
	 +0wBNCL0dtDy3trbWSiaOSlxlKfFPmD4QcU97jsxgyj1KH3vjyVTlpBnZcaUoNoaV3
	 8lvQHeDAoV1dQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  7 May 2024 10:03:50 +0300 (MSK)
Received: from [172.28.226.125] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 7 May 2024 10:03:50 +0300
Message-ID: <d90f9d3d-7823-503f-4cc6-73783a083d0e@salutedevices.com>
Date: Tue, 7 May 2024 09:53:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<oxffffaa@gmail.com>, <kernel@sberdevices.ru>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
 <20240416085101.740458-2-avkrasnov@salutedevices.com>
 <20240506154858.003bab54@xps-13>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20240506154858.003bab54@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185102 [May 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/07 04:23:00 #25112995
X-KSMG-AntiVirus-Status: Clean, skipped



On 06.05.2024 16:48, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@salutedevices.com wrote on Tue, 16 Apr 2024 11:51:00 +0300:
> 
>> Boot ROM code on Meson requires that some pages on NAND must be written
>> in special mode: "short" ECC mode where each block is 384 bytes and
>> scrambling mode is on.
> 
> Ok
> 
>> Such pages located with the specified interval within specified offset.
> 
> I'm sorry I don't get that sentence.

Sorry, I mean this (let me draw :) ) :

[ page 0 ][ page 1 ][ page 2 ][ page 3 ][ page 4 ][ page 5 ][ page 6 ][ page 7 ][ page 8 ][ page 9 ]

For example, we have 10 pages starting from the beginning of the chip - this is "within specified offset",
e.g. offset is 10. BootROM on axg needs that (for example) every third page must be written in "special"
mode: scrambling is on and ECC is 384 bytes. Such pages are 0, 2, 4, 6, 8. E.g. "specified interval" will
be 3.

So:

amlogic,boot-pages: 10
amlogic,boot-page-step: 3


> 
>> Both interval and offset are located in the
>> device tree and used by driver if 'nand-is-boot-medium' is set for
>> NAND chip.
> 
> This sentence is probably not needed.

Ok

> 
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>  .../bindings/mtd/amlogic,meson-nand.yaml           | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> index 57b6957c8415..67b2f7c1259c 100644
>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>> @@ -64,11 +64,25 @@ patternProperties:
>>          items:
>>            maximum: 0
>>  
>> +      amlogic,boot-pages:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          Number of pages starting from 0, where special ECC
> 
> from *offset* 0 I guess?

Yes, or may be better "from beginning of the chip" ?

May be i can place here ascii picture from above, with reduced number of pages?
And also place this picture in the commit message ?

> 
>> +          algorithm will be used by the driver.
> 
> "where a special ECC configuration must be used because it is accessed
> by the ROM code"? Maybe you can even detail what are these values if
> they are fixed.
> 
> You should probably inform that scrambling shall be on as well.
>  
>> +
>> +      amlogic,boot-page-step:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          Interval between pages, read/written by the driver with
>> +          special ECC algorithm.
> 
> I'm not sure I fully get the description. What is the unit here? can
> you draw a small ascii-art diagram?

May be i can place here "please see diagram above" ? And in 'amlogic,boot-pages' there
will be diagram.


> 
>> +
>>      unevaluatedProperties: false
>>  
>>      dependencies:
>>        nand-ecc-strength: [nand-ecc-step-size]
>>        nand-ecc-step-size: [nand-ecc-strength]
>> +      amlogic,boot-pages: [nand-is-boot-medium, "amlogic,boot-page-step"]
>> +      amlogic,boot-page-step: [nand-is-boot-medium, "amlogic,boot-pages"]
>>  
>>  
>>  required:
> 
> 
> Thanks,
> Miquèl

Thanks, Arseniy

