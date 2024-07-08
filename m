Return-Path: <linux-kernel+bounces-244380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D639B92A380
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7CC282B8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96330137747;
	Mon,  8 Jul 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zgKTZb/+"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1388824BF;
	Mon,  8 Jul 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444520; cv=none; b=rDLj+gqp4hl+lUMTMz1xRXkkEn8Fd/7qXM68Wb0OOevoH9Y8JBIxeTLg4I8xg14Od1NovpzMeXNd0aJ7gnC5RiVlIp7vu3bDjOEvxOo112LwGv2OV8+a8rGWDIEcktgBDJY21wR57JiSkdOC6OlIdnDHnM7n/JGinBUr1yKaRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444520; c=relaxed/simple;
	bh=ov17mxicIUyS6HEtQslMSNSNcCOpJ/LXdUYLezDZ0O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=Qm/TQx8j/R6LOMa/vU/PcVweTnQNv7qZE3VGQT38Td3tEqKDE4LZk7Bvxvu8hSGXZ6Qy//EBTuL2zEmwhPtSVOTByB+3YVstC53EufqndDSrjeiZwi8GHgGDl3pZCzYajD1+980teI5m+7DAKZMg8SD3MuGdkgx2gLJ9M5JvAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zgKTZb/+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720444518; x=1751980518;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=ov17mxicIUyS6HEtQslMSNSNcCOpJ/LXdUYLezDZ0O8=;
  b=zgKTZb/+EIZ0SciGeyrEQT15g2dEGCbYYk/BFBuWhvxesW9iRsJviVin
   lXB+GAqpAI4fiKBFIAffAOZoRxxa3JdwlSWDyYsXyzIH1DxrJisZecdJX
   GkLKBB2Weo0rQZFXbsWZ6ZlLFY1+TyP0Oe1X8b0vTFCOXPwlvacX7Uk4Y
   pNyB3GuO1T5S7MXmdf5WCKnVi/DRHX25NCGr4cdXHaPwGl9nIPk/JSzkf
   qCYoRyRrcIIKUn6wlcyR8CozeKPdQgPCO7SHCKS1PKtyOcVDoNvjrxtbr
   TB62iCG2MbdLepW7VDA/MAeO+fWSkVNuzbqf+D3Vrzfec4p77tidZUx1F
   w==;
X-CSE-ConnectionGUID: wEVA1JoOSxKaGP+LiI4ERQ==
X-CSE-MsgGUID: M+bGeUdWTy2KIOpiFjcpPQ==
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="196351860"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2024 06:15:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jul 2024 06:15:04 -0700
Received: from [10.180.117.27] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 8 Jul 2024 06:15:01 -0700
Message-ID: <374d76aa-343e-4f28-8374-350316e91cb9@microchip.com>
Date: Mon, 8 Jul 2024 15:15:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Move i2c address/size to
 dtsi
Content-Language: en-US, fr-FR
To: <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20240528153109.439407-1-ada@thorsis.com>
 <20240705-defection-septum-dd9202836b23@thorsis.com>
CC: Manikandan M <Manikandan.M@microchip.com>, Durai Manickam
	<Durai.ManickamKR@microchip.com>, Mihai Sain <mihai.sain@microchip.com>,
	"Hari Prasath" <Hari.PrasathGE@microchip.com>, Patrice Vilchez
	<patrice.vilchez@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240705-defection-septum-dd9202836b23@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 05/07/2024 at 08:19, Alexander Dahl wrote:
> Hei hei,
> 
> Am Tue, May 28, 2024 at 05:31:09PM +0200 schrieb Alexander Dahl:
>> These properties are common for all i2c subnodes, and marked as
>> 'required' in atmel/microchip i2c bindings.  Allows to add i2c device
>> nodes (like an rtc for example) in other .dts files including
>> sam9x60.dtsi without requiring to repeat these properties for each i2c
>> device again and again.
>>
>> Found on a custom board after adding this in .dts:
>>
>>      &flx5 {
>>              atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
>>              status = "okay";
>>
>>              i2c5: i2c@600 {
>>                      pinctrl-0 = <&pinctrl_flx5_default>;
>>                      status = "okay";
>>
>>                      pcf8523: rtc@68 {
>>                              compatible = "nxp,pcf8523";
>>                              reg = <0x68>;
>>                      };
>>              };
>>      };
>>
>> … which created a warning like this:

[..]

>> This probably should have been done with commit 84f23f3284d5 ("ARM: dts:
>> at91: sam9x60: move flexcom definitions") already, where those
>> address-cells and size-cells properties were left in the board .dts
>> files instead of moving them to the dtsi.
> 
> It's been a while.  Is something wrong with the patch?  Or with the
> commit message?

Sorry about that.

> at91 support seems to have slowed down somehow lately? :-/

Sorry for this feeling that you have. I guarantee it's not ;-)

Thanks a lot for your contribution, we'll make sure to react in a timely 
manner to your efforts on Microchip platforms.

Best regards,
   Nicolas

>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>> ---
>>   .../dts/microchip/at91-sam9x60_curiosity.dts  |  2 --
>>   .../arm/boot/dts/microchip/at91-sam9x60ek.dts |  4 ---
>>   arch/arm/boot/dts/microchip/sam9x60.dtsi      | 26 +++++++++++++++++++
>>   3 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
>> index c6fbdd29019f..b9ffd9e5faac 100644
>> --- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
>> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
>> @@ -198,8 +198,6 @@ i2c0: i2c@600 {
>>                dmas = <0>, <0>;
>>                pinctrl-names = "default";
>>                pinctrl-0 = <&pinctrl_flx0_default>;
>> -             #address-cells = <1>;
>> -             #size-cells = <0>;
>>                i2c-analog-filter;
>>                i2c-digital-filter;
>>                i2c-digital-filter-width-ns = <35>;
>> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
>> index f3cbb675cea4..3b38707d736e 100644
>> --- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
>> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
>> @@ -207,8 +207,6 @@ &flx0 {
>>        status = "okay";
>>
>>        i2c0: i2c@600 {
>> -             #address-cells = <1>;
>> -             #size-cells = <0>;
>>                dmas = <0>, <0>;
>>                pinctrl-names = "default";
>>                pinctrl-0 = <&pinctrl_flx0_default>;
>> @@ -254,8 +252,6 @@ &flx6 {
>>        status = "okay";
>>
>>        i2c6: i2c@600 {
>> -             #address-cells = <1>;
>> -             #size-cells = <0>;
>>                dmas = <0>, <0>;
>>                pinctrl-names = "default";
>>                pinctrl-0 = <&pinctrl_flx6_default>;
>> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
>> index 291540e5d81e..551b46894f47 100644
>> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
>> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
>> @@ -215,6 +215,8 @@ i2c4: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -284,6 +286,8 @@ i2c5: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -394,6 +398,8 @@ i2c11: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -443,6 +449,8 @@ i2c12: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -600,6 +608,8 @@ i2c6: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -649,6 +659,8 @@ i2c7: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -698,6 +710,8 @@ i2c8: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -766,6 +780,8 @@ i2c0: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -834,6 +850,8 @@ i2c1: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -902,6 +920,8 @@ i2c2: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -970,6 +990,8 @@ i2c3: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -1074,6 +1096,8 @@ i2c9: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -1123,6 +1147,8 @@ i2c10: i2c@600 {
>>                                        compatible = "microchip,sam9x60-i2c";
>>                                        reg = <0x600 0x200>;
>>                                        interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>>                                        clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>>                                        dmas = <&dma0
>>                                                (AT91_XDMAC_DT_MEM_IF(0) |
>>
>> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
>> --
>> 2.39.2
>>
>>


