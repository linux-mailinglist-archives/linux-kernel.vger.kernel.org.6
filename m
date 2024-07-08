Return-Path: <linux-kernel+bounces-244374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DE692A36C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6BB1C20F25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B4F1369AC;
	Mon,  8 Jul 2024 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ITwbCiOE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD013541E;
	Mon,  8 Jul 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443917; cv=none; b=BHzo3M0n9SSYECCFogPRpepH4+UNF4VHv71ZM8d9kf4mRuK/BiT+UAh4iPQLWUQs+bvvBaSyj70C0tU1T2/EWgNj0kd+1DsqjV/A6wUoACK72TNx+awNrb0o7OpM/P8r1XMd1dGC8P3YCLRi/i3nCHYcIdBS50EZ/AM37J2J7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443917; c=relaxed/simple;
	bh=kAnBC4cPP4TigxhgUDYmEgJxQ3enxKsMkmrjeHAwj8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ra4Z9CCMRAkKxyQoIyFSIYbCZRkpAwFpzgbS9VQ2WGoykcOXkH2O6vHY7PWjw1UeI377VZ8QqMgvyDru4ztdaOxrjYmyeBKOmRJW7fQh4UlI+HB9iG8chqgnYtnYijiSVFEG46UaRGRvTweFTw/9GdhHlTigV5IwDdMt4X18wA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ITwbCiOE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720443915; x=1751979915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kAnBC4cPP4TigxhgUDYmEgJxQ3enxKsMkmrjeHAwj8I=;
  b=ITwbCiOEpteSLh+PhnLHGx1OMwSnVyxRJVHAdyN3dCDOuPeNHLLmnOa6
   YJSt8VyI72moVJuTOxRhQY3tSg+F3ZCfDJKwPDvhg4Ql2Nq/3TmDYLWHX
   XrKBMbmbObyFhJPv5M8D3OawCXvFVQyk6ocrygBwcHwEOCQSpLgB2L04b
   rxPAFrt59BFOSY0NjXB0F9Id5YhAn+Mo5S4rU6rwYU2Zud8z3ght28vkj
   SzVRYw3ZMQ9EXzjYqbnz3rc+yZ6/tv9/RCxUV20Wz+r9tZUGtwLqhrJ51
   konRTzjkqcIRYcoqOXFhxh/E1MlpsCXqhmN3KQrCU3gAOMq1EifKTBQPC
   A==;
X-CSE-ConnectionGUID: 0LdZ85tlTg+hosdCmeYfqQ==
X-CSE-MsgGUID: RPr7992ET7uDhognVecjJQ==
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="31593266"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2024 06:04:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jul 2024 06:04:29 -0700
Received: from [10.180.117.27] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 8 Jul 2024 06:04:26 -0700
Message-ID: <01ba4ebd-a4cf-4e9d-bf2e-b7f9afa5417c@microchip.com>
Date: Mon, 8 Jul 2024 15:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Move i2c address/size to
 dtsi
To: Alexander Dahl <ada@thorsis.com>, <devicetree@vger.kernel.org>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Manikandan M <Manikandan.M@microchip.com>,
	Hari Prasath <Hari.PrasathGE@microchip.com>, Durai Manickam
	<Durai.ManickamKR@microchip.com>
References: <20240528153109.439407-1-ada@thorsis.com>
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240528153109.439407-1-ada@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexander,

On 28/05/2024 at 17:31, Alexander Dahl wrote:
> These properties are common for all i2c subnodes, and marked as
> 'required' in atmel/microchip i2c bindings.

Yes, indeed.

>  Allows to add i2c device
> nodes (like an rtc for example) in other .dts files including
> sam9x60.dtsi without requiring to repeat these properties for each i2c
> device again and again.
> 
> Found on a custom board after adding this in .dts:
> 
>      &flx5 {
>              atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
>              status = "okay";
> 
>              i2c5: i2c@600 {
>                      pinctrl-0 = <&pinctrl_flx5_default>;
>                      status = "okay";
> 
>                      pcf8523: rtc@68 {
>                              compatible = "nxp,pcf8523";
>                              reg = <0x68>;
>                      };
>              };
>      };
> 
> … which created a warning like this:
> 
>      […]:236.4-17: Warning (reg_format): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
>      […]: Warning (pci_device_reg): Failed prerequisite 'reg_format'
>      […]: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>      […]: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
>      […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect #address-cells for I2C bus also defined at […]:228.16-238.4
>      […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect #size-cells for I2C bus also defined at […]:228.16-238.4
>      […]: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>      […]: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
>      […]: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>      […]:234.19-237.5: Warning (avoid_default_addr_size): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #address-cells value
>      […]:234.19-237.5: Warning (avoid_default_addr_size): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #size-cells value
>      […]: Warning (avoid_unnecessary_addr_size): Failed prerequisite 'avoid_default_addr_size'
>      […]: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
> 
> This probably should have been done with commit 84f23f3284d5 ("ARM: dts:
> at91: sam9x60: move flexcom definitions") already, where those

Yes, and I think it was mentioned by Claudiu back then.

> address-cells and size-cells properties were left in the board .dts
> files instead of moving them to the dtsi.

I agree with the move, plus you addressed both of the current mainline 
boards:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Alexander, best regards,
   Nicolas

> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>   .../dts/microchip/at91-sam9x60_curiosity.dts  |  2 --
>   .../arm/boot/dts/microchip/at91-sam9x60ek.dts |  4 ---
>   arch/arm/boot/dts/microchip/sam9x60.dtsi      | 26 +++++++++++++++++++
>   3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> index c6fbdd29019f..b9ffd9e5faac 100644
> --- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> @@ -198,8 +198,6 @@ i2c0: i2c@600 {
>                  dmas = <0>, <0>;
>                  pinctrl-names = "default";
>                  pinctrl-0 = <&pinctrl_flx0_default>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
>                  i2c-analog-filter;
>                  i2c-digital-filter;
>                  i2c-digital-filter-width-ns = <35>;
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
> index f3cbb675cea4..3b38707d736e 100644
> --- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
> @@ -207,8 +207,6 @@ &flx0 {
>          status = "okay";
> 
>          i2c0: i2c@600 {
> -               #address-cells = <1>;
> -               #size-cells = <0>;
>                  dmas = <0>, <0>;
>                  pinctrl-names = "default";
>                  pinctrl-0 = <&pinctrl_flx0_default>;
> @@ -254,8 +252,6 @@ &flx6 {
>          status = "okay";
> 
>          i2c6: i2c@600 {
> -               #address-cells = <1>;
> -               #size-cells = <0>;
>                  dmas = <0>, <0>;
>                  pinctrl-names = "default";
>                  pinctrl-0 = <&pinctrl_flx6_default>;
> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> index 291540e5d81e..551b46894f47 100644
> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> @@ -215,6 +215,8 @@ i2c4: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -284,6 +286,8 @@ i2c5: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -394,6 +398,8 @@ i2c11: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -443,6 +449,8 @@ i2c12: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -600,6 +608,8 @@ i2c6: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -649,6 +659,8 @@ i2c7: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -698,6 +710,8 @@ i2c8: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -766,6 +780,8 @@ i2c0: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -834,6 +850,8 @@ i2c1: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -902,6 +920,8 @@ i2c2: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -970,6 +990,8 @@ i2c3: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -1074,6 +1096,8 @@ i2c9: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> @@ -1123,6 +1147,8 @@ i2c10: i2c@600 {
>                                          compatible = "microchip,sam9x60-i2c";
>                                          reg = <0x600 0x200>;
>                                          interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                          clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>                                          dmas = <&dma0
>                                                  (AT91_XDMAC_DT_MEM_IF(0) |
> 
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> --
> 2.39.2
> 


