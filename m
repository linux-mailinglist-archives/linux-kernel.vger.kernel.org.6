Return-Path: <linux-kernel+bounces-230831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219DB918271
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCF21F25AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E88181BBF;
	Wed, 26 Jun 2024 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7jeLE29"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89E8825;
	Wed, 26 Jun 2024 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408691; cv=none; b=rphFq5sT0Vm9KpnDcyetDrTH5vnCxVr3AZcFsYegk1I6Am3x3OTB3sWzpZ2y5ZjA04HkBxRv2vP6D9KiWF+061gT6scqrVDaeY4Lks1jdmzWLD68gI0hoG0JdvHFMIkuSF7lavN2TRgs+3TkDQDfVn0M6UgvxSRYli9gZL6FcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408691; c=relaxed/simple;
	bh=qWRZjYdp6f0m7F2CPEnOeoB7wAZFdZxYUWa0DLizaZs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jkuuS4T6uq8vZMkKGyS1SMZQIbDzfjsT+SnXUP12vA/oT50OzJNcJxzl5MDZxSruTGbGpbVw9ae6h05JIxxuLGirLinyNJaA3M7dxMBhOAlpf1avMCJmIP262rhU6PjEl1FfWWtJCUYsW6KTzZDcBcDrwHPZqZlih49Fdahfjt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7jeLE29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F693C2BD10;
	Wed, 26 Jun 2024 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408690;
	bh=qWRZjYdp6f0m7F2CPEnOeoB7wAZFdZxYUWa0DLizaZs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=R7jeLE29XB+cvHIPvyIyRJcrkMxEW5ws6Wh4978oi2akpn6WdF5kDSjm/KjNozEkF
	 nKuti987SfpPxl03XISvVyULKG4QjvWq6gHMIaFMWgSXsXM5+qxuDvU1c7XUeoOX6C
	 9TjMHyBKwatoLS9wiVdVmFofbXQbREZVsORFi071mhIgtDJQJ9LcBan+yQTRjtEvlJ
	 AcORB5oi1FFKTFcgl2xrpVJRKXyLAde9IGafuWemicR39ET+8CliOcZ9cSMy6NLTwr
	 3zJavJcJAJ4wXiLb6qlX4d+sowu57kYbkzRJrwTvHtfmwO1s0hafO03xDWzi1mlPUP
	 EliXnIUIqrw/A==
Date: Wed, 26 Jun 2024 07:31:29 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yang Chen <yangchen.openbmc@gmail.com>
Cc: andrew@codeconstruct.com.au, patrick@stwcx.xyz, joel@jms.id.au, 
 linux-arm-kernel@lists.infradead.org, Jerry.Lin@quantatw.com, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Message-Id: <171940832692.2961326.910026599869370818.robh@kernel.org>
Subject: Re: [PATCH 00/17] Revise Facebook Minerva BMC DTS


On Tue, 25 Jun 2024 20:18:18 +0800, Yang Chen wrote:
> Revise the Linux device tree entry related to Facebook platform Minerva
> specific devices connected to the Aspeed AST2600 BMC.
> 
> Yang Chen (17):
>   ARM: dts: aspeed: minerva: change the address of tmp75
>   ARM: dts: aspeed: minerva: Add spi-gpio
>   ARM: dts: aspeed: minerva: change aliases for uart
>   ARM: dts: aspeed: minerva: add eeprom on i2c bus
>   ARM: dts: aspeed: minerva: change RTC reference
>   ARM: dts: aspeed: minerva: enable mdio3
>   ARM: dts: aspeed: minerva: remove unused bus and device
>   ARM: dts: aspeed: minerva: Define the LEDs node name
>   ARM: dts: aspeed: minerva: Add adc sensors for fan board
>   ARM: dts: aspeed: minerva: add linename of two pins
>   ARM: dts: aspeed: minerva: enable ehci0 for USB
>   ARM: dts: aspeed: minerva: add tmp75 sensor
>   ARM: dts: minerva: add power monitor xdp710
>   ARM: dts: aspeed: minerva: revise sgpio line name
>   ARM: dts: aspeed: minerva: Switch the i2c bus number
>   ARM: dts: aspeed: minerva: remove unused power device
>   ARM: dts: aspeed: minerva: add ltc4287 device
> 
>  .../aspeed/aspeed-bmc-facebook-minerva.dts    | 516 +++++++++++++-----
>  1 file changed, 373 insertions(+), 143 deletions(-)
> 
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-minerva.dtb' for 20240625121835.751013-1-yangchen.openbmc@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /: spi-gpio: {'status': ['okay'], 'compatible': ['spi-gpio'], '#address-cells': 1, '#size-cells': 0, 'gpio-sck': [61, 203, 0], 'gpio-mosi': [61, 204, 0], 'gpio-miso': [61, 205, 0], 'num-chipselects': 1, 'cs-gpios': [[61, 200, 1]], 'tpmdev@0': {'compatible': ['infineon,slb9670', 'tcg,tpm_tis-spi'], 'spi-max-frequency': 33000000, 'reg': [[0]]}} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: $nodename:0: 'spi-gpio' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-sck: False schema does not allow [61, 203, 0]
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-miso: False schema does not allow [61, 205, 0]
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-mosi: False schema does not allow [61, 204, 0]
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: 'sck-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'gpio-miso', 'gpio-mosi', 'gpio-sck', 'tpmdev@0' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: tpmdev@0: $nodename:0: 'tpmdev@0' does not match '^tpm(@[0-9a-f]+)?$'
	from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#






