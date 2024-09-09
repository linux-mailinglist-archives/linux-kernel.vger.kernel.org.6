Return-Path: <linux-kernel+bounces-321708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA307971E60
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A6928506F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A83130495;
	Mon,  9 Sep 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oovaTBbY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8F25589C;
	Mon,  9 Sep 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896719; cv=none; b=LChbgHYRXAwL7BJ0zl83IfFYt1obh06AViYMmKzuSmKHvldC1b3OBfOtHDuW6fzH9Kni9DUKgEmuGD3aluDvRFIWl44ac89b9+c1UcV5413U3BP+FhdiP1FtHK8dLqKjwf3/VYayrH7flaXPqANJFtU4vvk9geEop5+M9s6qa0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896719; c=relaxed/simple;
	bh=Ur507D/9IZAyiU6XEqp8riPXsLXhfJupKj8cr1+m2pE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KkMki/W/f+wuG+RczZAoFnT38Wc1apJANjPVI1LzEk4E/UGGXv67Inbmaw4Ns4YRTyly5MBgRIE2x2/glr1Kg90TJBKaxN2nU+3ajjvDUA8dyb4Vui6/gRE1SkxFJGD493Kgkmd0C/D4u01NtzWgHkyxPrH3jFSOJwt6TaLZlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oovaTBbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE5CC4CEC7;
	Mon,  9 Sep 2024 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725896718;
	bh=Ur507D/9IZAyiU6XEqp8riPXsLXhfJupKj8cr1+m2pE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oovaTBbY3CzWuyUKTX786FZQwx2gT3U5PUPQ9XoK0h08O2YTXJ9fnHsmfPCaZlAvZ
	 Ovw5vm45HMw/seE0fw/A8j007TWa6qotq6HeP3Rb2P/C/FwSv3/fiQzWwq4YAcfmYo
	 oJeC53COu7aI84MQHUDwM72zbF7EOH9B4M3BtXrNFifVjKEbu4GCTC0h5zr/G2ltaj
	 9jvC2R8obKb1i1FGs6HGAXwp5MR5a3RAZePIWNni2pmmoNxqyJeWrR+2yHFQD0iQwo
	 eLptuClzZPUkU9B9kbCOry2utj2hjnKdbGfPzCIlh441+GytAHNAwHCEKdEvHHm1ZK
	 RIPKEBGS8EsEg==
Date: Mon, 09 Sep 2024 10:45:17 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
 Joel Stanley <joel@jms.id.au>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, patrick@stwcx.xyz, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
Message-Id: <172589661042.199175.14634437656639420015.robh@kernel.org>
Subject: Re: [PATCH v18 0/3] Add i2c-mux and eeprom devices for Meta
 Yosemite4


On Mon, 09 Sep 2024 18:54:15 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Changelog:
>   - v18
>     - Fix warnings for reg_format reporting by dts checking tool.
>   - v17
>     - Add SoB for the patches.
>   - v16
>     - Reorganized the patches.
>     - Add i2c-mux and resolve the dt-validate errors.
>     - Revise Yosemite 4 devicetree for devices behind i2c-mux.
>     - Add mctp config and sensors for NIC after i2c-mux on bus 15.
>     - Add fan led config for BMC to control according the status of fan.
>   - v15
>     - Add ISL28022 support
>   - v14
>     - Add SQ52205 support
>     - Add GPIO I6 pin
>   - v13
>     - Add RTQ6056-support-on-bus-11
>   - v12
>     - Fix GPIO linename typo and add missing GPIO pin initial state.
>   - v11
>     - Revise all GPIO line name with bottom line
>   - v10
>     - adjust mgm cpld ioexp bus
>     - add GPIOO7 name
>     - remove mctp driver
>   - v9
>     - add XDP710 support
>     - add RTQ6056 support
>     - add MP5990 support
>   - v8
>     - add fan led config
>   - v7
>     - Revise pca9506 i2c address
>   - v6
>     - Revise i2c duty-cycle for meeting 400khz spec
>   - v5
>     - Support medusa board adc sensors
>     - support NIC eeprom
>   - v4
>     - Re-format gpio linename
>     - Revise i2c device node names
>     - Split patches by logic changes
>   - v3
>     - Correct patch for revising gpio name
>   - v2
>     - Revise mx31790 fan tach config
>     - Add mctp config for NIC
>     - Support mux to cpld
>     - Revise gpio name
>   - v1
>     - Add gpio and eeprom behind i2c-mux
>     - Remove redundant idle-state setting for i2c-mux
>     - Enable adc 15, wdt2,spi gpio for yosemite4 use
>     - Revise quad mode to dual mode to avoid WP pin influnece the SPI
>     - Revise power sensor adm1281 for yosemite4 schematic change
>     - Add gpio pca9506 I/O expander for yosemite4 use
>     - remove space for adm1272 compatible
>     - enable interrupt setting for pca9555
>     - add eeprom for yosemite4 medusa board/BSM use
>     - remove temperature sensor for yosemite4 schematic change
>     - add power sensor for power module reading
>     - Revise adc128d818 adc mode for yosemite4 schematic change
>     - Revise ina233 for yosemite4 schematic change
>     - Remove idle state setting for yosemite4 NIC connection
>     - Initialize bmc gpio state
>     - Revise mx31790 fan tach config
>     - Add mctp config for NIC
>     - Support mux to cpld
>     - Revise gpio name
> 
> Ricky CX Wu (3):
>   ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
>   ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC
>   ARM: dts: aspeed: yosemite4: add fan led config
> 
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 706 ++++++++++++++++--
>  1 file changed, 660 insertions(+), 46 deletions(-)
> 
> --
> 2.25.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-yosemite4.dtb' for 20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm@20: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm@2f: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@74/i2c@0/gpio@61: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm@20: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm@2f: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@74/i2c@1/gpio@61: failed to match any schema with compatible: ['nxp,pca9552']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@800/i2c-mux@72/i2c@0/temperature-sensor@3c: failed to match any schema with compatible: ['smsc,emc1403']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@800/i2c-mux@72/i2c@1/temperature-sensor@3c: failed to match any schema with compatible: ['smsc,emc1403']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@800/i2c-mux@72/i2c@2/temperature-sensor@3c: failed to match any schema with compatible: ['smsc,emc1403']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@1e78a000/i2c@800/i2c-mux@72/i2c@3/temperature-sensor@3c: failed to match any schema with compatible: ['smsc,emc1403']






