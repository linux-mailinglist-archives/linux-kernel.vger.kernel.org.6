Return-Path: <linux-kernel+bounces-241964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B19281D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1DF1F24579
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA5314036F;
	Fri,  5 Jul 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="cr+IWujE"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29551E494;
	Fri,  5 Jul 2024 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160403; cv=none; b=cpJLTW2qEKISxB9YaMd4hm+1cI/+BCqB0+PkppCNDdCGxRV4c65pgPRus+VXu4gD8qBytNvCeMKDSADrQlsV49emZwOo/ITV7QVYe7JWaA+xRuGpEBv8CGVsgLYCqr4zLxEzniIxPiCmV2OPY2zg/gmczN+Ec4Fw6XbeFogzqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160403; c=relaxed/simple;
	bh=kFfOIREu5RPuLvId8jmCcWGNZ0iwh46HdP1wvje9/zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIDmmbuHsuOmnSUqKi+yzXBRiiSoHITsVy2d+FelsJV1oA2Hk2ek3PQWr55kWukoPMP0O2CJEgA4P3FDurftc8OhZ/YXCHY0hsAzAUD2AZkO6amtesbXn0QU9SEddJDDyQsY7yphDZXus8pFj36bI3u7lpqalatZMpQ+p9LKSiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=cr+IWujE; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1D06148AA8F;
	Fri,  5 Jul 2024 08:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1720160390; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fmy9qAqpmWZ4y34jP0GUmsRdJ9tX2hDZ58Dx3lSOXDI=;
	b=cr+IWujE5N9tD4XbpGaRE37fqW0LvoQgR0DfAefMkq8nE6/1L6wkixrAljEGpx3go38yFj
	luci+3nqEm3ctqeOIiPeLn+1FDcfLmM2lp2cshyQUkifW8l49r7LxqJiC2XnrpJ0CyVg2k
	dnbQ0a99Thbf/ag0JO/yYBzUKc+aArNpGUjDzB0XLeB2lnslmyUFph9NtZrX/XBNEMHs/S
	Bm0oBh5R+GfdX/UnTqWmntgDQoB1it70diQvGueYyOzcSTJ2GuVrjKsfHei3PHU7v4ojTT
	+0XJH/AsGjR9nMoRgf7X0ky/fRRmVkfDmXpWlv74qdvwcMlXmAeHYsftrG5uoA==
Date: Fri, 5 Jul 2024 08:19:45 +0200
From: Alexander Dahl <ada@thorsis.com>
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Mihai Sain <mihai.sain@microchip.com>
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Move i2c address/size to
 dtsi
Message-ID: <20240705-defection-septum-dd9202836b23@thorsis.com>
Mail-Followup-To: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Mihai Sain <mihai.sain@microchip.com>
References: <20240528153109.439407-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528153109.439407-1-ada@thorsis.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

Am Tue, May 28, 2024 at 05:31:09PM +0200 schrieb Alexander Dahl:
> These properties are common for all i2c subnodes, and marked as
> 'required' in atmel/microchip i2c bindings.  Allows to add i2c device
> nodes (like an rtc for example) in other .dts files including
> sam9x60.dtsi without requiring to repeat these properties for each i2c
> device again and again.
> 
> Found on a custom board after adding this in .dts:
> 
>     &flx5 {
>             atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
>             status = "okay";
> 
>             i2c5: i2c@600 {
>                     pinctrl-0 = <&pinctrl_flx5_default>;
>                     status = "okay";
> 
>                     pcf8523: rtc@68 {
>                             compatible = "nxp,pcf8523";
>                             reg = <0x68>;
>                     };
>             };
>     };
> 
> … which created a warning like this:
> 
>     […]:236.4-17: Warning (reg_format): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
>     […]: Warning (pci_device_reg): Failed prerequisite 'reg_format'
>     […]: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>     […]: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
>     […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect #address-cells for I2C bus also defined at […]:228.16-238.4
>     […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect #size-cells for I2C bus also defined at […]:228.16-238.4
>     […]: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>     […]: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
>     […]: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>     […]:234.19-237.5: Warning (avoid_default_addr_size): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #address-cells value
>     […]:234.19-237.5: Warning (avoid_default_addr_size): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #size-cells value
>     […]: Warning (avoid_unnecessary_addr_size): Failed prerequisite 'avoid_default_addr_size'
>     […]: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
> 
> This probably should have been done with commit 84f23f3284d5 ("ARM: dts:
> at91: sam9x60: move flexcom definitions") already, where those
> address-cells and size-cells properties were left in the board .dts
> files instead of moving them to the dtsi.

It's been a while.  Is something wrong with the patch?  Or with the
commit message?

at91 support seems to have slowed down somehow lately? :-/

Greets
Alex

> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  .../dts/microchip/at91-sam9x60_curiosity.dts  |  2 --
>  .../arm/boot/dts/microchip/at91-sam9x60ek.dts |  4 ---
>  arch/arm/boot/dts/microchip/sam9x60.dtsi      | 26 +++++++++++++++++++
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> index c6fbdd29019f..b9ffd9e5faac 100644
> --- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> @@ -198,8 +198,6 @@ i2c0: i2c@600 {
>  		dmas = <0>, <0>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_flx0_default>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		i2c-analog-filter;
>  		i2c-digital-filter;
>  		i2c-digital-filter-width-ns = <35>;
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
> index f3cbb675cea4..3b38707d736e 100644
> --- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
> @@ -207,8 +207,6 @@ &flx0 {
>  	status = "okay";
>  
>  	i2c0: i2c@600 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		dmas = <0>, <0>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_flx0_default>;
> @@ -254,8 +252,6 @@ &flx6 {
>  	status = "okay";
>  
>  	i2c6: i2c@600 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		dmas = <0>, <0>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_flx6_default>;
> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> index 291540e5d81e..551b46894f47 100644
> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> @@ -215,6 +215,8 @@ i2c4: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -284,6 +286,8 @@ i2c5: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -394,6 +398,8 @@ i2c11: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -443,6 +449,8 @@ i2c12: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -600,6 +608,8 @@ i2c6: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -649,6 +659,8 @@ i2c7: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -698,6 +710,8 @@ i2c8: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -766,6 +780,8 @@ i2c0: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -834,6 +850,8 @@ i2c1: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -902,6 +920,8 @@ i2c2: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -970,6 +990,8 @@ i2c3: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -1074,6 +1096,8 @@ i2c9: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -1123,6 +1147,8 @@ i2c10: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> 
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> -- 
> 2.39.2
> 
> 

