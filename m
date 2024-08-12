Return-Path: <linux-kernel+bounces-283385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9094F1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8EC1C221C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8B186E3B;
	Mon, 12 Aug 2024 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw3zSjCA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67B184557;
	Mon, 12 Aug 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476816; cv=none; b=i4tsa7EFcWkVpBT65/uED0QToJBPmBNo2kj/ETaGVy5SFxMkhOd7MhDVAxTS0oAG3OgYV7Ug5/f59B47WUMxV4QlzT98jCLEjmVtPvy0EiF+3cf7T64DLZm67MEk1F2b0blflo7b/qbYQF5EQnXCyF6JFgLprOPpI54jZXsKSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476816; c=relaxed/simple;
	bh=3YcUz/gYUpu/WoU8sGgEivj/OljS8lw6NdxvpOBI6c4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=tLaBQ+GyLzDQXvU3g71+AAOpmn9FMSmsX8ijmkzc6yg1/olsjZqwxGwHmVPe4yuW0wCml1MSDvfzKGY4B3yehbRd/uDjIhpWIXpT7XQcG4K7u4Tw7ejrvnck2Szw+PxPA9frCbiGb5sG7Fg/uFCwaOZXuzQ+b4d5yTDVsMatG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw3zSjCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70782C4AF0D;
	Mon, 12 Aug 2024 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476815;
	bh=3YcUz/gYUpu/WoU8sGgEivj/OljS8lw6NdxvpOBI6c4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tw3zSjCATi5KqV5SuRHT7pP4uoa7HN/bCdQqHvlBhRxa86wJ5kv5MKlXJTzdNECuM
	 knvx+aYVB4uifUIG/ihQIhq84FiZUyLayqmqDlAyOtX6uT2Dywu4qt+44+jOVODk8c
	 H//dfNqRqI5KSDANF7q31YOfO93xtfxX168nl2wo9S9w3HDAysLGfP9DH1Ea24Qo6/
	 wWlQi8YGrGgkjo11yoMZy1ndeXfmO7OWk2Nsy3Rja1rosh38RdP2IqcnJbi//wlo+y
	 yFbmGzKVPKTiXVtEAF1CEc7Vw0LT8FE+J3QGpsphrkqMpv59x5TFZ7GGM456teCMS/
	 8RkWVniaYObdQ==
Date: Mon, 12 Aug 2024 09:33:33 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: alexandre.belloni@bootlin.com, krzk+dt@kernel.org, 
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, broonie@kernel.org, 
 devicetree@vger.kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240812135231.43744-1-andrei.simion@microchip.com>
References: <20240812135231.43744-1-andrei.simion@microchip.com>
Message-Id: <172347672887.922611.11316946762732938797.robh@kernel.org>
Subject: Re: [PATCH v2 0/7] Add input voltage suppliers for PMIC MCP16502
 regulators


On Mon, 12 Aug 2024 16:52:24 +0300, Andrei Simion wrote:
> In this series of patches, support for the *-supply property [1]  is added
> (correlated with supply_name [2]) from the core regulator.
> Link [1]: https://github.com/torvalds/linux/blob/master/drivers/regulator/core.c#L471
> Link [2]: https://github.com/torvalds/linux/blob/master/drivers/regulator/core.c#L2064
> 
> I modified the mcp16502.c driver and the dts that use this PMIC.
> We added these improvements to provide a complete description of the board power scheme.
> 
> Snippet (as an example) from /sys/kernel/debug/regulator/regulator_summary
> (for at91-sama7g5ek):
>  # cat regulator_summary
>  regulator                      use open bypass  opmode voltage current     min     max
> ---------------------------------------------------------------------------------------
>  regulator-dummy                  1    0      0 unknown     0mV     0mA     0mV     0mV
>  5V_MAIN                          6    6      0 unknown  5000mV     0mA  5000mV  5000mV
>     VDD_IO                        5    4      0  normal  3300mV     0mA  3300mV  3300mV
>        e1208000.mmc-vqmmc         1                                 0mA     0mV     0mV
>        e1208000.mmc-vmmc          1                                 0mA  3300mV  3400mV
>        e1204000.mmc-vmmc          1                                 0mA  3300mV  3400mV
>        VDDOUT25                   3    2      0 unknown  2500mV     0mA  2500mV  2500mV
>           e1000000.adc-vref       1                                 0mA     0mV     0mV
>           e1000000.adc-vddana     1                                 0mA     0mV     0mV
>     VDD_DDR                       1    0      0  normal  1350mV     0mA  1350mV  1350mV
>     VDD_CORE                      1    0      0  normal  1150mV     0mA  1150mV  1150mV
>     VDD_OTHER                     2    1      0  normal  1050mV     0mA  1050mV  1250mV
>        cpu0-cpu                   1                                 0mA  1050mV  1225mV
>     LDO1                          2    1      0 unknown  1800mV     0mA  1800mV  1800mV
>        e1204000.mmc-vqmmc         1                                 0mA     0mV     0mV
>     LDO2
> 
> -------------------------------------------------------------------------------------------
> 
> Changelog:
> 
> v1 -> v2:
>  - drop (lvin|pvin[1-4])-supply from each regulators sub-node
>  - add voltage input supply documentation in the yaml schema
>  - add lvin-supply, pvin[1-4]-supply to PMIC node
> 
> Andrei Simion (7):
>   regulator: mcp16502: Add supplier for regulators
>   regulator: dt-bindings: microchip,mcp16502: Add voltage input supply
>     documentation
>   ARM: dts: microchip: at91-sama7g5ek: Add reg_5v to supply PMIC nodes
>   ARM: dts: microchip: at91-sama7g54_curiosity: Add reg_5v to supply
>     PMIC nodes
>   ARM: dts: microchip: at91-sama5d2_icp: Add reg_5v to supply PMIC nodes
>   ARM: dts: microchip: at91-sama5d27_wlsom1: Add reg_5v to supply PMIC
>     nodes
>   ARM: dts: microchip: sama5d29_curiosity: Add reg_5v to supply PMIC
>     nodes
> 
>  .../regulator/microchip,mcp16502.yaml         | 20 +++++++++++++++++++
>  .../dts/microchip/at91-sama5d27_wlsom1.dtsi   | 13 ++++++++++++
>  .../dts/microchip/at91-sama5d29_curiosity.dts | 13 ++++++++++++
>  .../boot/dts/microchip/at91-sama5d2_icp.dts   | 13 ++++++++++++
>  .../dts/microchip/at91-sama7g54_curiosity.dts | 13 ++++++++++++
>  .../arm/boot/dts/microchip/at91-sama7g5ek.dts | 13 ++++++++++++
>  drivers/regulator/mcp16502.c                  | 17 ++++++++--------
>  7 files changed, 94 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 9e6869691724b12e1f43655eeedc35fade38120c
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


New warnings running 'make CHECK_DTBS=y microchip/at91-sama5d29_curiosity.dtb microchip/at91-sama5d2_icp.dtb microchip/at91-sama7g54_curiosity.dtb microchip/at91-sama7g5ek.dtb' for 20240812135231.43744-1-andrei.simion@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7g5ek.dtb: /soc/chipid@e0020000: failed to match any schema with compatible: ['microchip,sama7g5-chipid']
arch/arm/boot/dts/microchip/at91-sama7g5ek.dtb: /soc/mmc@e120c000: failed to match any schema with compatible: ['microchip,sama7g5-sdhci', 'microchip,sam9x60-sdhci']
arch/arm/boot/dts/microchip/at91-sama7g5ek.dtb: /soc/mmc@e120c000: failed to match any schema with compatible: ['microchip,sama7g5-sdhci', 'microchip,sam9x60-sdhci']






