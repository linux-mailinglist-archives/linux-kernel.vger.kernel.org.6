Return-Path: <linux-kernel+bounces-570607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC64A6B27C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24F8189D4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7F829405;
	Fri, 21 Mar 2025 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="I3Ca8Lzs"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7D184F;
	Fri, 21 Mar 2025 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742519207; cv=none; b=ZSEBmMLsaNQR2zo6kGQFpM4rRwE/77o2EBXPCOGtgmSQIX6aYin3ANFhmuyunvw9Ef4CbPJRFHlrmXjamCJepO5vgxb7Az9OA7mQ05jbCCDyWS/cqCldIm0PViaP2Nk9PTnv69ri2BdO0rzbVGy+KqloMPsN9liMYxjoW3Zq6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742519207; c=relaxed/simple;
	bh=7LjDymQPV/JFsOgAFzuvK8gI8KQUK45IdrgIAv3AgUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XN/qqWbuyzEj30Lrm4CqZDsGWDOK8sCjsPga2cFyii+teeX+B3AMIVz41NhNY8vXE2oNQ3DvQ6AXSwN5v4ZhOJ9PRhX6trs6E9/okE8Z9yY+8XGnOG9vUtZVrRUqvD98+bpQc/35dsMntI1xLPVkX7HnCB8LRcXLk+PhqqD3rCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=I3Ca8Lzs; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742519201;
	bh=7LjDymQPV/JFsOgAFzuvK8gI8KQUK45IdrgIAv3AgUY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I3Ca8LzsDShrd9bn/2RdZJZCg/rULYZoSQ5iyPZS6eL6U8+01IHQkxX8CKz+pi9Fq
	 ZLtxC4l1vzTJs4/jRnS10Dv+mu82/3ZAaikRSAztf97rzyWy3iUiBNy7KFa6cyNVZa
	 Cn8H++9ta9jvHr+kYeWWcry8S8LvyqlduYH6KJK2oZ4MnjHCCSM9C+qWHc9gXt1qJF
	 9d68b1Tz74pLo4Ur2cozOJLLePiaojIrl0zYk1tpesgjQZOWOEwIycRfAbHVgBwCIT
	 dBQDZrhSODyQ1nJlip6P/DU858JAELTM8+a95BOlU/DTkWcxAa3EahKbd5DF33RVtg
	 WpJtNasKEiuWQ==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3941E7A886;
	Fri, 21 Mar 2025 09:06:38 +0800 (AWST)
Message-ID: <4471e1948ab420ae0574e1442d445800bc19240c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 0/2] Add device tree for Nvidia's GB200NVL BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Willie Thai <wthai@nvidia.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Paul Menzel
 <pmenzel@molgen.mpg.de>,  tingkaic@nvidia.com, kees@kernel.org, Krzysztof
 Kozlowski <krzk@kernel.org>,  Mars Yang <maryang@nvidia.com>,
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, Andrew Lunn
 <andrew@lunn.ch>, linux-hardening@vger.kernel.org, gpiccoli@igalia.com, 
 linux-aspeed@lists.ozlabs.org, leohu@nvidia.com, openbmc@lists.ozlabs.org, 
 krzk+dt@kernel.org, dkodihalli@nvidia.com, joel@jms.id.au, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 tony.luck@intel.com
Date: Fri, 21 Mar 2025 11:36:37 +1030
In-Reply-To: <174249492169.658140.8130213005563532857.robh@kernel.org>
References: <20250320164633.101331-1-wthai@nvidia.com>
	 <174249492169.658140.8130213005563532857.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Willie,

On Thu, 2025-03-20 at 13:26 -0500, Rob Herring (Arm) wrote:
>=20
> On Thu, 20 Mar 2025 16:46:31 +0000, Willie Thai wrote:
> > The GB200NVL BMC is an Aspeed Ast2600 based BMC
> > for Nvidia Blackwell GB200NVL platform.
> > Reference to Ast2600 SOC [1].
> > Reference to Blackwell GB200NVL Platform [2].
> >=20
> > Co-developed-by: Mars Yang <maryang@nvidia.com>
> > Signed-off-by: Mars Yang <maryang@nvidia.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> > Link: https://www.aspeedtech.com/server_ast2600/=C2=A0[1]
> > Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703=
=C2=A0[2]
> > Signed-off-by: Willie Thai <wthai@nvidia.com>
> > ---
> > Changes v1 -> v2:
> > =C2=A0 - Fix the SOB name [Krzysztof]
> > =C2=A0 - Fix warnings from scripts/checkpatch.pl run [Krzysztof]
> > =C2=A0 - Fix DTS coding style [Krzysztof]
> > =C2=A0 - Move pinctrl override to the bottom [Krzysztof]
> > =C2=A0 - Drop bootargs [Krzysztof]
> > =C2=A0 - Follow DTS coding style and change naming for leds node [Krzys=
ztof]
> > =C2=A0 - Change flash 0 status property [Krzysztof]
> > =C2=A0 - Change the phy-mode to rgmii [Andrew]
> > =C2=A0 - Remove the max-speed in mac0 [Andrew]
> > =C2=A0 - Put gpio line name in one line per group of 8 gpios, but keep =
some b/c they can exceed length limit [Paul]
> > Changes v2 -> v3:
> > =C2=A0 - Fix missing new line [Krzysztof]
> > =C2=A0 - Fix missing binding define, adding it in the patch no.1 of thi=
s patch set v3 [Krzysztof, Rob]
> > =C2=A0 - Fix DTS coding style [Krzysztof]
> > =C2=A0 - Modify nodes name to generic name for: i2c expander pca9546, g=
pio expander pca9555, power monitor lm5066i, fan controller max31790 [Krzys=
ztof]
> > =C2=A0 - Skip mac setting and wait till the delay issue in phy-mode fix=
 from Aspeed SOC vendor side [Andrew]
> > =C2=A0 - Remove i2c-scl-clk-low-timeout-us which is Apseed proprietary =
property [Mars]
> > ---
> >=20
> > Willie Thai (2):
> > =C2=A0 ARM: dts: aspeed: Add device tree for Nvidia's GB200NVL BMC
> > =C2=A0 dt-bindings: arm: aspeed: add Nvidia's GB200NVL BMC
> >=20
> > =C2=A0.../bindings/arm/aspeed/aspeed.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > =C2=A0.../aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts | 1168 ++++++++++++=
+++++
> > =C2=A03 files changed, 1170 insertions(+)
> > =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb2=
00nvl-bmc.dts
> >=20
> > --
> > 2.25.1
> >=20
> >=20
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
> =C2=A0 pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy for arch/arm/boot/dts/aspeed/' =
for 20250320164633.101331-1-wthai@nvidia.com:
>=20
...

>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: pinctrl: emm=
cg5_default:groups:0: 'EMMCG5' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC=
11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'A=
DC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMCG1', 'EMMCG4', 'EMMCG8', 'ESPI=
', 'ESPIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'G=
PIT0', 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU=
0', 'GPIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'HVI3C3'=
, 'HVI3C4', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', '=
I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3=
C1', 'I3C2', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LP=
C', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', =
'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCSI3', 'NCSI4=
', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', =
'NDSR1', 'NDSR2', 'NDSR3'
> =C2=A0, 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI=
3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0',=
 'PWM1', 'PWM10G0', 'PWM10G1', 'PWM11G0', 'PWM11G1', 'PWM12G0', 'PWM12G1', =
'PWM13G0', 'PWM13G1', 'PWM14G0', 'PWM14G1', 'PWM15G0', 'PWM15G1', 'PWM2', '=
PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8G0', 'PWM8G1', 'PWM9G0', 'PWM9G=
1', 'QSPI1', 'QSPI2', 'RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMI=
I2', 'RMII3', 'RMII4', 'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10G0',=
 'SALT10G1', 'SALT11G0', 'SALT11G1', 'SALT12G0', 'SALT12G1', 'SALT13G0', 'S=
ALT13G1', 'SALT14G0', 'SALT14G1', 'SALT15G0', 'SALT15G1', 'SALT16G0', 'SALT=
16G1', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT=
9G0', 'SALT9G1', 'SD1', 'SD2', 'SD3', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', '=
SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', '=
SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS=
2', 'TACH0', 'TACH1', 'TACH10'
> =C2=A0, 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3=
', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', =
'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART=
12G0', 'UART12G1', 'UART13G0', 'UART13G1', 'UART6', 'UART7', 'UART8', 'UART=
9', 'USBA', 'USBB', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3'=
, 'WDTRST4']
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/pinctrl/aspeed,ast2600-pinctrl.yaml#

...

> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c@80: Unev=
aluated properties are not allowed ('disable-master' was unexpected)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/i2c/aspeed,i2c.yaml#

...

> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: gpio@21: '#a=
ddress-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-9]+=
|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: gpio@21: '#a=
ddress-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-9]+=
|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: gpio@21: '#a=
ddress-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-9]+=
|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: pwm@20: '#ad=
dress-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$'=
, 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: pwm@23: '#ad=
dress-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$'=
, 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: pwm@2c: '#ad=
dress-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$'=
, 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: pwm@2f: '#ad=
dress-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$'=
, 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: gpio@20: '#a=
ddress-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-9]+=
|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: gpio@21: '#a=
ddress-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-9]+=
|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: gpio@27: '#a=
ddress-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-9]+=
|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: gpio@74: '#a=
ddress-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-9]+=
|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/gpio/gpio-pca95xx.yaml#

Please fix all of the warnings highlighted above before submitting v4.

Thanks,

Andrew

