Return-Path: <linux-kernel+bounces-396471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352319BCD93
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9052281EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B001D5ADD;
	Tue,  5 Nov 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrzUDFWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D931D6DA5;
	Tue,  5 Nov 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812313; cv=none; b=vA1GNoe4v2g0Y1N5Wj4uFM3BEBqwbrujSrrwg3TuRPnkF+UAqQYFKdjDw/jzV295d6Z2an7PJOIVZ5oS66errry7lmpJO5ZAqVylmaTCLTf7LcVSs0UAJkmnVXvLe3LyjcGx5D7s9LsVRzY523El5XGvKzDiDpGsLOh3lX3Ir74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812313; c=relaxed/simple;
	bh=YLhgQZ3b+mFAPUPLHhQeQ8GMwm71ZLQrV9L93ZPAORQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QrNt6RTFy/AOmvgAFnLF7Vd2Gnq0mNlxAVI3lHtSVMGRy+adxvxnq6dVzZ2hnDFK9k4QKoTPQsbu4xNY/ACy1sbKjrKcZEhUmhU37HjfaK91DM/T0ezm09jdLmR5rSDGjMVtFMBGXqr2/z2LD9I6yUpYSVcTzzpp/s35JEwInmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrzUDFWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CF6C4CECF;
	Tue,  5 Nov 2024 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730812313;
	bh=YLhgQZ3b+mFAPUPLHhQeQ8GMwm71ZLQrV9L93ZPAORQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RrzUDFWt0w5l32h+Uy7elEVAgw68JdhSpYDfdMV3KY2uJ4Ls7I0phvNxWQB30fTWO
	 A7U6GZ3fAmCE87bfqvEOphawsVxp/yymop9vR2zpOmz8aDR6xfEM/idR9iWfJsPE+W
	 lwHQaTmr5vHjnLy2jazMt/dmvINXtSMnQbq7ViPstKAlx9StC2ZYoUbaXleDKymMT0
	 7xOiAeTiNKCEdLWHdWmxsA+fEmRm2muOnb87dNgmTsUU7tIfP02Xuc+rYaIECqRqiy
	 wsXuozXTVrCIohRxH5BBsuUVnebqqrygJ/TL8R7Rlvdrv/orzwpKmmtLK7MeYQmJEL
	 3y+bpj6d6GD4A==
Date: Tue, 05 Nov 2024 07:11:51 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20241105093222.4055774-1-fshao@chromium.org>
References: <20241105093222.4055774-1-fshao@chromium.org>
Message-Id: <173081219726.3053098.16931220466079803577.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Add device tree for MT8188-based Chromebook
 "Ciri"


On Tue, 05 Nov 2024 17:30:11 +0800, Fei Shao wrote:
> Hi maintainers,
> 
> This is the v2 series to introduce the device trees for Ciri, a
> MT8188-based Chromebook, commercially known as the Lenovo Chromebook
> Duet (11", 9).
> 
> Ciri is a detachable device based on the ChromeOS Geralt reference
> design, where Geralt is the codename for the MT8188 platform. Ciri has 8
> SKUs to accommodate the combinations of second-source components,
> including audio codecs, speaker amplifiers, and MIPI-DSI panels.
> 
> The Geralt design is not used in any actual products, so its device tree
> is not included.
> 
> The device trees are taken from the ChromeOS downstream v6.1 kernel,
> ported to the mainline kernel and with cleanups. This series aims to
> provide a basic device tree with the enabled components and features.
> Additional support will be added in the future after validation with
> the mainline kernel.
> 
> This series has been tested on top of the next-20241018 branch.
> 
> Patch 1 adds entries for Ciri in the MediaTek DT binding.
> Patch 2 adds the dtsi files for Geralt and Ciri, followed by 8 dts files
> for all the available Ciri SKUs at this moment.
> 
> Note that there are some known dtbs_check warnings:
> - sound: Unevaluated 'mediatek,adsp' property
>     >> see [1] for the fix
> - amplifier: '#sound-dai-cells' does not match any of the regexes
>     >> see [2] for the fix
> - dp-tx: '#sound-dai-cells' does not match any of the regexes
>     >> see [3] for the fix
> - audio-codec: 'interrupts-extended' does not match any of the regexes
>     >> see [4] for the fix
> - pmic: 'compatible' is a required property; 'adc', 'mt6359codec',
>   'mt6359rtc' do not match any of the regexes
>     >> see [5] for the fix
> - amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
>     >> ti,tas2781 binding specifies that ti,tas2563 register range is
>        0x4c-0x4f. The DT follows what the binding literally suggests.
>        I tried changing the binding locally but didn't help.
> 
> [1]:
> https://lore.kernel.org/all/20241105091246.3944946-1-fshao@chromium.org/
> [2]:
> https://lore.kernel.org/all/20241105091513.3963102-1-fshao@chromium.org/
> [3]:
> https://lore.kernel.org/all/20241105090207.3892242-1-fshao@chromium.org/
> [4]:
> https://lore.kernel.org/all/20241105091910.3984381-1-fshao@chromium.org/
> [5]:
> https://lore.kernel.org/all/20241004030148.13366-2-macpaul.lin@mediatek.com/
> 
> [v1]:
> https://lore.kernel.org/all/20241025110111.1321704-1-fshao@chromium.org/
> 
> Regards,
> Fei
> 
> Changes in v2:
> - remove invalid or undocumented properties
>     e.g. mediatek,dai-link, maxim,dsm_param_name etc.
> - remove touchscreen as the driver is not yet accepted in upstream
> - update sound DAI link node name to match the binding
> - add missing pinctrls in audio codec nodes
> 
> Fei Shao (2):
>   dt-bindings: arm: mediatek: Add MT8188 Lenovo Chromebook Duet (11", 9)
>   arm64: dts: mediatek: Introduce MT8188 Geralt platform based Ciri
> 
>  .../devicetree/bindings/arm/mediatek.yaml     |   13 +
>  arch/arm64/boot/dts/mediatek/Makefile         |    8 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku0.dts  |   11 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |   60 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku2.dts  |   56 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |   15 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku4.dts  |   43 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |   73 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku6.dts  |   69 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |   47 +
>  .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |  397 +++++
>  .../boot/dts/mediatek/mt8188-geralt.dtsi      | 1492 +++++++++++++++++
>  12 files changed, 2284 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> 
> --
> 2.47.0.277.g8800431eea-goog
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8188-geralt-ciri-sku0.dtb mediatek/mt8188-geralt-ciri-sku1.dtb mediatek/mt8188-geralt-ciri-sku2.dtb mediatek/mt8188-geralt-ciri-sku3.dtb mediatek/mt8188-geralt-ciri-sku4.dtb mediatek/mt8188-geralt-ciri-sku5.dtb mediatek/mt8188-geralt-ciri-sku6.dtb mediatek/mt8188-geralt-ciri-sku7.dtb' for 20241105093222.4055774-1-fshao@chromium.org:

arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: sound: Unevaluated properties are not allowed ('mediatek,adsp' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: sound: Unevaluated properties are not allowed ('mediatek,adsp' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: sound: Unevaluated properties are not allowed ('mediatek,adsp' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: sound: Unevaluated properties are not allowed ('mediatek,adsp' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: sound: Unevaluated properties are not allowed ('mediatek,adsp' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: sound: Unevaluated properties are not allowed ('mediatek,adsp' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: sound: Unevaluated properties are not allowed ('mediatek,adsp' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: sound: Unevaluated properties are not allowed ('mediatek,adsp' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: pmic: 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: pmic: 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: pmic: 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: pmic: 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: pmic: 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: pmic: 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: pmic: 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: pmic: 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: amplifier@38: '#sound-dai-cells', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: amplifier@39: '#sound-dai-cells', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: audio-codec@19: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/everest,es8326.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: amplifier@38: '#sound-dai-cells', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: amplifier@39: '#sound-dai-cells', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: audio-codec@19: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/everest,es8326.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: audio-codec@19: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/everest,es8326.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
	from schema $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
	from schema $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: audio-codec@19: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/everest,es8326.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: amplifier@38: '#sound-dai-cells', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
	from schema $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: amplifier@39: '#sound-dai-cells', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
	from schema $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: amplifier@38: '#sound-dai-cells', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: amplifier@39: '#sound-dai-cells', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: jpeg-decoder@1a040000: iommus: [[141, 685], [141, 686], [141, 690], [141, 691], [141, 692], [141, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: jpeg-decoder@1a040000: iommus: [[141, 685], [141, 686], [141, 690], [141, 691], [141, 692], [141, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: jpeg-decoder@1a040000: iommus: [[139, 685], [139, 686], [139, 690], [139, 691], [139, 692], [139, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: jpeg-decoder@1a040000: iommus: [[139, 685], [139, 686], [139, 690], [139, 691], [139, 692], [139, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: jpeg-decoder@1a040000: iommus: [[139, 685], [139, 686], [139, 690], [139, 691], [139, 692], [139, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: jpeg-decoder@1a040000: iommus: [[141, 685], [141, 686], [141, 690], [141, 691], [141, 692], [141, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: jpeg-decoder@1a040000: iommus: [[139, 685], [139, 686], [139, 690], [139, 691], [139, 692], [139, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: jpeg-decoder@1a040000: iommus: [[141, 685], [141, 686], [141, 690], [141, 691], [141, 692], [141, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#






