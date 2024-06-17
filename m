Return-Path: <linux-kernel+bounces-218442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F6D90BFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894171C210EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0940A199EB0;
	Mon, 17 Jun 2024 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="iPs6tjZE"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA4194A52;
	Mon, 17 Jun 2024 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668239; cv=none; b=PMJV6Kxt2ANWb4ZSv1HYSlZ5Kz4ybBdW2cFjO6leE6+apFw2nPyGD2SrgzxXG6tvMaP1hI6B7i9U6Ig+bCGYVzPIWn0RHs1xEkB5OrmIT1C7BLRmaPehmb7KgXwJ4VNarkoO7HrMkeM3WktKB2O6MZiTxIf+h6cJeP83qH6hDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668239; c=relaxed/simple;
	bh=D/Uozen3NJBtfW2IaXMiqxQRvZkxJFeTt28xXjOSTfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6vlLRxKzPV2xu13d2pcPc0jph/jBEZ/R7I4jga91JuswwwS/mWLfl4j6S0biFRh5c51nVHeUQBN+PssOvtXSi0Q/EoMSUXMyWEzAcZGG3t0/NZxDZ8MDrr+j+C6SL3Jifo6wUEbQM6ilRXsf0tLOua4yxIMNT8OgjwMNZ5Ov7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=iPs6tjZE; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-79-194.adl-adc-lon-bras32.tpg.internode.on.net [118.210.79.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2C3522012B;
	Tue, 18 Jun 2024 07:50:30 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1718668234;
	bh=5H2azwNMw/NKvZISY+AJYUwrGQoNGdx8yOayGYYjxdM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iPs6tjZEkhMY3FV1OUzn8COHOIis1ne27apJzEnF+9CPL+nYcTNkaHS1hmsdJ5Qt1
	 xx+h4N6BUdMZN5iiCcAzqVCbCgtIuoj+kTrWIn57bWVRjfqlTi2cFuWMAQnmnS6XD2
	 QeCAV4hnjCDc5N+LN00rlL3NqZVbmzzyDp2ACMncUb7C3d+IlmPSumF8RDNceiSYh7
	 l+hYGf8xdnE40BnX/rtM6Qb57q6O7qRdsXF0tIa06muoXBOhcZdB0DA12U/buQl6kr
	 5BltwGkjzeL4f/Gm+atqwRIrFW0n0cr45+QUYYFXov5s65Jgw4nzvNyTOXXRKLKR1e
	 viaNQ6Kc8SYpQ==
Message-ID: <41922538da690d52122edea4f4095f45886acd33.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 6/7] ARM: dts: aspeed: Harma: remove multi-host
 property
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: kernel test robot <lkp@intel.com>, Peter Yin
 <peteryin.openbmc@gmail.com>,  patrick@stwcx.xyz
Cc: oe-kbuild-all@lists.linux.dev, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 18 Jun 2024 09:20:30 +0930
In-Reply-To: <202406180305.hrffmKGn-lkp@intel.com>
References: <20240613152425.1582059-7-peteryin.openbmc@gmail.com>
	 <202406180305.hrffmKGn-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter,

On Tue, 2024-06-18 at 03:18 +0800, kernel test robot wrote:
> Hi Peter,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on linus/master v6.10-rc4 next-20240613]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Yin/ARM-dts-=
aspeed-Harma-revise-hsc-chip/20240613-232915
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git fo=
r-next
> patch link:    https://lore.kernel.org/r/20240613152425.1582059-7-peteryi=
n.openbmc%40gmail.com
> patch subject: [PATCH v1 6/7] ARM: dts: aspeed: Harma: remove multi-host =
property
> config: arm-randconfig-051-20240614 (https://download.01.org/0day-ci/arch=
ive/20240618/202406180305.hrffmKGn-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> dtschema version: 2024.6.dev1+g833054f
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240618/202406180305.hrffmKGn-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202406180305.hrffmKGn-lkp=
@intel.com/
>=20
> dtcheck warnings: (new ones prefixed by >>)
>=20

*snip*

>=20
>    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: pinctrl: i3c2_=
default:function:0: 'I3C2' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11',=
 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6'=
, 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', 'FSI=
2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2', '=
GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', 'GPI=
U3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C12',=
 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6'=
, 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', =
'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1',=
 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'N=
CTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR=
1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', =
'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWA=
KE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM15', =
'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1', '=
RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1', 'R=
XD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', 'SAL=
T14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', 'SAL=
T7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'S=
IOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'S=
IOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2=
', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TAC=
H15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9=
', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UAR=
T10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9', 'US=
BAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB2BH', 'VB', 'VGAHS', 'VG=
AVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
>    	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600=
-pinctrl.yaml#
>    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: pinctrl: i3c2_=
default:groups:0: 'I3C2' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC11', '=
ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'ADC6', =
'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMCG1', 'EMMCG4', 'EMMCG8', 'ESPI', 'ES=
PIALT', 'FSI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0',=
 'GPIT1', 'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'G=
PIU1', 'GPIU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'HVI3C3', 'HVI=
3C4', 'I2C1', 'I2C10', 'I2C11', 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16'=
, 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', '=
I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', =
'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4'=
, 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', '=
NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDT=
R1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'N=
RTS2', 'NRTS3', 'NRTS4', 'OSCCLK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10G0', 'PW=
M10G1', 'PWM11G0', 'PWM11G1', 'PWM12G0', 'PWM12G1', 'PWM13G0', 'PWM13G1', '=
PWM14G0', 'PWM14G1', 'PWM15G0', 'PWM15G1', 'PWM2', 'PWM3', 'PWM4', 'PWM5', =
'PWM6', 'PWM7', 'PWM8G0', 'PWM8G1', 'PWM9G0', 'PWM9G1', 'QSPI1', 'QSPI2', '=
RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', =
'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10G0', 'SALT10G1', 'SALT11G0'=
, 'SALT11G1', 'SALT12G0', 'SALT12G1', 'SALT13G0', 'SALT13G1', 'SALT14G0', '=
SALT14G1', 'SALT15G0', 'SALT15G1', 'SALT16G0', 'SALT16G1', 'SALT2', 'SALT3'=
, 'SALT4', 'SALT5', 'SALT6', 'SALT7', 'SALT8', 'SALT9G0', 'SALT9G1', 'SD1',=
 'SD2', 'SD3', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2', 'SIOONCTRL', 'SIOPBI', '=
SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5', 'SIOSCI', 'SPI1', 'SPI1A=
BR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI2CS2', 'TACH0', 'TACH1', '=
TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', 'TACH15', 'TACH2', 'TACH3'=
, 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'TACH9', 'THRU0', 'THRU1', '=
THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', 'UART10', 'UART11', 'UART1=
2G0', 'UART12G1', 'UART13G0', 'UART13G1', 'UART6', 'UART7', 'UART8', 'UART9=
', 'USBA', 'USBB', 'VB', 'VGAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3',=
 'WDTRST4']
>    	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600=
-pinctrl.yaml#
>    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: pinctrl: usb11=
bhid_default:function:0: 'USB11BHID' is not one of ['ADC0', 'ADC1', 'ADC10'=
, 'ADC11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC=
5', 'ADC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'F=
SI1', 'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', =
'GPIT2', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GP=
IU2', 'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11'=
, 'I2C12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C=
5', 'I2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM'=
, 'LHPD', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', '=
MACLINK1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', '=
MDIO4', 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDC=
D4', 'NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4'=
, 'NRI1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCC=
LK', 'PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14',=
 'PWM15', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', '=
RGMII1', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', =
'RXD1', 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SAL=
T13', 'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SA=
LT6', 'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', '=
SGPS2', 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', '=
SIOS5', 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1'=
, 'SPI2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TAC=
H14', 'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH=
8', 'TACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'T=
XD4', 'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'U=
ART9', 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB2BH', 'VB', 'V=
GAHS', 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
>    	from schema $id: http://devicetree.org/schemas/pinctrl/aspeed,ast2600=
-pinctrl.yaml#
>    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: pinctrl: usb2a=
d_default:function:0: 'USB2AD' is not one of ['ADC0', 'ADC1', 'ADC10', 'ADC=
11', 'ADC12', 'ADC13', 'ADC14', 'ADC15', 'ADC2', 'ADC3', 'ADC4', 'ADC5', 'A=
DC6', 'ADC7', 'ADC8', 'ADC9', 'BMCINT', 'EMMC', 'ESPI', 'ESPIALT', 'FSI1', =
'FSI2', 'FWQSPI', 'FWSPIABR', 'FWSPID', 'FWSPIWP', 'GPIT0', 'GPIT1', 'GPIT2=
', 'GPIT3', 'GPIT4', 'GPIT5', 'GPIT6', 'GPIT7', 'GPIU0', 'GPIU1', 'GPIU2', =
'GPIU3', 'GPIU4', 'GPIU5', 'GPIU6', 'GPIU7', 'I2C1', 'I2C10', 'I2C11', 'I2C=
12', 'I2C13', 'I2C14', 'I2C15', 'I2C16', 'I2C2', 'I2C3', 'I2C4', 'I2C5', 'I=
2C6', 'I2C7', 'I2C8', 'I2C9', 'I3C3', 'I3C4', 'I3C5', 'I3C6', 'JTAGM', 'LHP=
D', 'LHSIRQ', 'LPC', 'LPCHC', 'LPCPD', 'LPCPME', 'LPCSMI', 'LSIRQ', 'MACLIN=
K1', 'MACLINK2', 'MACLINK3', 'MACLINK4', 'MDIO1', 'MDIO2', 'MDIO3', 'MDIO4'=
, 'NCTS1', 'NCTS2', 'NCTS3', 'NCTS4', 'NDCD1', 'NDCD2', 'NDCD3', 'NDCD4', '=
NDSR1', 'NDSR2', 'NDSR3', 'NDSR4', 'NDTR1', 'NDTR2', 'NDTR3', 'NDTR4', 'NRI=
1', 'NRI2', 'NRI3', 'NRI4', 'NRTS1', 'NRTS2', 'NRTS3', 'NRTS4', 'OSCCLK', '=
PEWAKE', 'PWM0', 'PWM1', 'PWM10', 'PWM11', 'PWM12', 'PWM13', 'PWM14', 'PWM1=
5', 'PWM2', 'PWM3', 'PWM4', 'PWM5', 'PWM6', 'PWM7', 'PWM8', 'PWM9', 'RGMII1=
', 'RGMII2', 'RGMII3', 'RGMII4', 'RMII1', 'RMII2', 'RMII3', 'RMII4', 'RXD1'=
, 'RXD2', 'RXD3', 'RXD4', 'SALT1', 'SALT10', 'SALT11', 'SALT12', 'SALT13', =
'SALT14', 'SALT15', 'SALT16', 'SALT2', 'SALT3', 'SALT4', 'SALT5', 'SALT6', =
'SALT7', 'SALT8', 'SALT9', 'SD1', 'SD2', 'SGPM1', 'SGPM2', 'SGPS1', 'SGPS2'=
, 'SIOONCTRL', 'SIOPBI', 'SIOPBO', 'SIOPWREQ', 'SIOPWRGD', 'SIOS3', 'SIOS5'=
, 'SIOSCI', 'SPI1', 'SPI1ABR', 'SPI1CS1', 'SPI1WP', 'SPI2', 'SPI2CS1', 'SPI=
2CS2', 'TACH0', 'TACH1', 'TACH10', 'TACH11', 'TACH12', 'TACH13', 'TACH14', =
'TACH15', 'TACH2', 'TACH3', 'TACH4', 'TACH5', 'TACH6', 'TACH7', 'TACH8', 'T=
ACH9', 'THRU0', 'THRU1', 'THRU2', 'THRU3', 'TXD1', 'TXD2', 'TXD3', 'TXD4', =
'UART10', 'UART11', 'UART12', 'UART13', 'UART6', 'UART7', 'UART8', 'UART9',=
 'USBAD', 'USBADP', 'USB2AH', 'USB2AHP', 'USB2BD', 'USB2BH', 'VB', 'VGAHS',=
 'VGAVS', 'WDTRST1', 'WDTRST2', 'WDTRST3', 'WDTRST4']
>=20

FYI these pinctrl binding issues should be resolved on linux-
pinctrl.git devel as of yesterday. The new issue that was picked up
(snipped out of the text above) should be addressed though.

Andrew

