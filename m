Return-Path: <linux-kernel+bounces-246063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90A292BD2C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E504F1C2119D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED3C19B5B1;
	Tue,  9 Jul 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTz/GTuE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611119CCED;
	Tue,  9 Jul 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536023; cv=none; b=aqYI3iJZ9BnIYo0DPQMj/QdXydPoMxsJzgWEzlAU8bdJUGSNIMLhz/j8K0ABqHKBMPcphUSvTeA5mmNunwxvIOsPRPbXTW0Xnh0tlVZhnux0WXcuugCy+VMNQA+sUZpNYd6ViAy2/asbMvkssILU5cQKymggySMHi9Ddu0bctus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536023; c=relaxed/simple;
	bh=/G4GuTkKcgMXBGq60NgbcMauLpRbpodm8ks3HsbBiS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rEVNTAsdcI30AS0KCtuc+Lj4EZ01b8MlUkSM0h1Sn1M0fMna65MnoFmn5q9e2nN+D60PaBaEYx7LfVd2+B1jyqaxE8Ihmol+l8cCUSKJo6KFZwncrXRS+XPsANup6nloHr0qZHBh27yoPEyEPK1HDxZzs3SgCfkRMTktWLbB4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTz/GTuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B16C3277B;
	Tue,  9 Jul 2024 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720536023;
	bh=/G4GuTkKcgMXBGq60NgbcMauLpRbpodm8ks3HsbBiS8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HTz/GTuECFUEskrP/v7dNC3RFM+NFJQbiAX6R6sCT63fSmCeo12jkM2huquTBrVGO
	 sSJc7u+2yqSXrBE16KowDCaippqQ46DJCAZOcn7tFp//ivaEMIiPSCDUSObyQrKuH+
	 3/q/LfiiebNLx3kbRR6p+T8zoX18mSrxASl2bmUPFSQnM08CGDVeKcPAlcTbPXB9bd
	 NbUgvVGdg2AveqXL/IMK2TFXFXxqTdGQwysl83B1hTiVSU9IjqY19135ZhPpmVAFwV
	 i3z2VXlut2tz1YBBf3IpIZOBZ0dHRQ9M4mCpvlwLy88SWxlOPi0sNyhBiYt6kNnuGc
	 D5+0KX8ZAQCAA==
Message-ID: <5b8dd7f9-66fb-44c9-943b-f9f83d314579@kernel.org>
Date: Tue, 9 Jul 2024 16:40:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Move i2c address/size to
 dtsi
To: claudiu beznea <claudiu.beznea@tuxon.dev>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Mihai Sain <mihai.sain@microchip.com>
References: <20240528153109.439407-1-ada@thorsis.com>
 <20240705-defection-septum-dd9202836b23@thorsis.com>
 <30fc0b41-49b9-41b8-82ef-c27d202492e6@tuxon.dev>
 <20240709-specked-paging-b821f10a657b@thorsis.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240709-specked-paging-b821f10a657b@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/07/2024 12:41, Alexander Dahl wrote:
> Hello Claudiu,
> 
> Am Mon, Jul 08, 2024 at 07:23:47PM +0300 schrieb claudiu beznea:
>>
>>
>> On 05.07.2024 09:19, Alexander Dahl wrote:
>>> Hei hei,
>>>
>>> Am Tue, May 28, 2024 at 05:31:09PM +0200 schrieb Alexander Dahl:
>>>> These properties are common for all i2c subnodes, and marked as
>>>> 'required' in atmel/microchip i2c bindings.  Allows to add i2c device
>>>> nodes (like an rtc for example) in other .dts files including
>>>> sam9x60.dtsi without requiring to repeat these properties for each i2c
>>>> device again and again.
>>>>
>>>> Found on a custom board after adding this in .dts:
>>>>
>>>>     &flx5 {
>>>>             atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
>>>>             status = "okay";
>>>>
>>>>             i2c5: i2c@600 {
>>>>                     pinctrl-0 = <&pinctrl_flx5_default>;
>>>>                     status = "okay";
>>>>
>>>>                     pcf8523: rtc@68 {
>>>>                             compatible = "nxp,pcf8523";
>>>>                             reg = <0x68>;
>>>>                     };
>>>>             };
>>>>     };
>>>>
>>>> … which created a warning like this:
>>>>
>>>>     […]:236.4-17: Warning (reg_format): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
>>>>     […]: Warning (pci_device_reg): Failed prerequisite 'reg_format'
>>>>     […]: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>>>>     […]: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
>>>>     […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect #address-cells for I2C bus also defined at […]:228.16-238.4
>>>>     […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect #size-cells for I2C bus also defined at […]:228.16-238.4
>>>>     […]: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>>>>     […]: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
>>>>     […]: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>>>>     […]:234.19-237.5: Warning (avoid_default_addr_size): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #address-cells value
>>>>     […]:234.19-237.5: Warning (avoid_default_addr_size): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #size-cells value
>>>>     […]: Warning (avoid_unnecessary_addr_size): Failed prerequisite 'avoid_default_addr_size'
>>>>     […]: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
>>>>
>>>> This probably should have been done with commit 84f23f3284d5 ("ARM: dts:
>>>> at91: sam9x60: move flexcom definitions") already, where those
>>>> address-cells and size-cells properties were left in the board .dts
>>>> files instead of moving them to the dtsi.
>>>
>>> It's been a while.  Is something wrong with the patch?  Or with the
>>> commit message?
>>
>> Please CC your patches to proper people (e.g., use
>> ./script/get_maintainer.pl). I see no Microchip AT91 maintainers in the
>> initial to/cc list of your patch.
> 
> You can be sure I did.  This is the list I got on my patch and you see
> I CCed everone listed as a _maintainer_ from that output:
> 
>     % ./scripts/get_maintainer.pl outgoing/arm-dts-microchip/0001-ARM-dts-microchip-sam9x60-Move-i2c-address-size-to-d.patch 
>     Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>     Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>     Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>     Nicolas Ferre <nicolas.ferre@microchip.com> (supporter:ARM/Microchip (AT91) SoC support)
>     Alexandre Belloni <alexandre.belloni@bootlin.com> (supporter:ARM/Microchip (AT91) SoC support)
>     Claudiu Beznea <claudiu.beznea@tuxon.dev> (supporter:ARM/Microchip (AT91) SoC support,commit_signer:1/2=50%,authored:1/2=50%,added_lines:32/45=71%,removed_lines:32/45=71%)
> 
> Not sure why Nicolas, Alexandre, and you are listed as "supporter"
> only?  I think you should have been in the CC list in the first place,
> sorry about that.
> 
> Besides, I just noticed arch/arm/boot/dts/microchip/sam9x60.dtsi is
> not covered by specific matches in MAINTAINERS file, just through a
> generic fallback for all dts.  Lines in question are these, sam9 is
> not matched:
> 
>     F:  arch/arm/boot/dts/microchip/at91*
>     F:  arch/arm/boot/dts/microchip/sama*
> 
> Okay for the next time I will also CC supporters, but I found the
> output of get_maintainer.pl some kind of confusing here.

get_maintainers is mostly (for typical cases) used through scripts, like
cc-cmd or b4, thus no one cares about actual title. But if supported
confused you, then why not checking its meaning in MAINTAINERS file?

Best regards,
Krzysztof


