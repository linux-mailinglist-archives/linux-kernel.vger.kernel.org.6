Return-Path: <linux-kernel+bounces-410876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA219CEC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9743A1F2900B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F30D1D5CEA;
	Fri, 15 Nov 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtXe5RO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B41D5CC9;
	Fri, 15 Nov 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683591; cv=none; b=frtVBVO47iR52Qtn68X2Ds3hrozWf1xEPn4Z9LJO9y9dyK/6SfJ/pqpNW1JWcmGiPyEWAl1YfTXNanpni1BrZHBiCVuV7q217HOF79tt+LYCxLm/RGfgCwrRHW51Ah7SpeoWkFQis6Ptv/lStw05z+BJYAHomqNqD4Fd730rNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683591; c=relaxed/simple;
	bh=tkkm3Dprf75KMyhZXFHRBmbpABU0uYoMcD94+1XAHDk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=HIquh4mJ7VwOavIrQfW0q95ePUlxupDoY3q/lFEhEzTgFMbVodYYusnQbPVmx5HKzfKBTBwQ/rE3pi7+cPnlygVCHMNFHZA3c2uRCdlYU+QiDoBStElji/VIAbHWBnyR/eD7CSD6LJ/jk8MMESNb8+Gm87Ag+q0GEmGjjeoV8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtXe5RO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3967CC4CED5;
	Fri, 15 Nov 2024 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731683591;
	bh=tkkm3Dprf75KMyhZXFHRBmbpABU0uYoMcD94+1XAHDk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qtXe5RO6h48pceWkqHcf35A2h7vrGZqYQ/O4nQ31pt22c0QHmx+KRzgF+epWHY/U1
	 BO3+5Y6IUYrqYDP1XZn4f1YU3lQNbGwlELat7rbDK64mFpGzpDi0tePB+Uiu/lkrY9
	 wt/NtJStU8MNvFQbY5Ec5wC9Ag0vHR9cwMiTsbQPfk7QgQusnlxRWW0p2OKoy/NsAO
	 +bJA7k1vqzlOEKinHq01TgfnGAL/GMTh4Hx4J3rgA1A1mRHVyEpDszLxv+8LWEft0a
	 Cw1etht4SDocG16D/ffFvzyn5Qb7DQOpJtgQKURsJDBoQebJyEzeh2nRdYvwIxm/PY
	 r6Si50wdvMkLA==
Date: Fri, 15 Nov 2024 09:13:09 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
In-Reply-To: <20241113-damu-v4-1-6911b69610dd@chromium.org>
References: <20241113-damu-v4-1-6911b69610dd@chromium.org>
Message-Id: <173168321208.2749684.5154968423883102453.robh@kernel.org>
Subject: Re: [PATCH RESEND v4] arm64: dts: mt8183: set DMIC one-wire mode
 on Damu


On Wed, 13 Nov 2024 16:16:53 +0800, Hsin-Te Yuan wrote:
> From: Hsin-Yi Wang <hsinyi@chromium.org>
> 
> Sets DMIC one-wire mode on Damu.
> 
> Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v4:
> - Add Reviewed-by tag back, which is dropped in v3
> - Link to v3: https://lore.kernel.org/r/20241009-damu-v3-1-1294c8e16829@chromium.org
> 
> Changes in v3:
> - Add missing Sign-off-by tag
> - Link to v2: https://lore.kernel.org/r/20240910-one-wire-v2-1-2bb40d5a3cf8@chromium.org
> 
> Changes in v2:
> - Add fixes tag
> - Link to v1: https://lore.kernel.org/r/20240910-one-wire-v1-1-d25486a6ba6d@chromium.org
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts | 4 ++++
>  1 file changed, 4 insertions(+)
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8183-kukui-jacuzzi-damu.dtb' for 20241113-damu-v4-1-6911b69610dd@chromium.org:

arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: mmc0-pins-default:pins-clk:mediatek,pull-down-adv: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: mmc0-pins-uhs:pins-clk:mediatek,pull-down-adv: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: mmc0-pins-uhs:pins-ds:mediatek,pull-down-adv: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: mmc1-pins-default:pins-cmd-dat:mediatek,pull-up-adv: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: mmc1-pins-default:pins-clk:mediatek,pull-down-adv: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: mmc1-pins-uhs:pins-cmd-dat:mediatek,pull-up-adv: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: mmc1-pins-uhs:pins-clk:mediatek,pull-down-adv: 10 is not one of [0, 1, 2, 3]
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: panel-pins-default: 'panel-reset' does not match any of the regexes: '^pins', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: pp3300-panel-pins: 'panel-3v3-enable' does not match any of the regexes: '^pins', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: touchscreen-pins: 'touch-int-odl', 'touch-rst-l' do not match any of the regexes: '^pins', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: trackpad-pins: 'trackpad-int' does not match any of the regexes: '^pins', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: volume-button-pins: 'voldn-btn-odl', 'volup-btn-odl' do not match any of the regexes: '^pins', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: pinctrl@10005000: 'audiopins', 'audiotdmoutoff', 'audiotdmouton', 'da7219_pins', 'ec-ap-int-odl', 'gpio-line-names', 'h1-int-od-l', 'i2c0', 'i2c1', 'i2c2', 'i2c3', 'i2c4', 'i2c5', 'i2c6', 'pp1000-mipibrdg-en', 'pp1800-mipibrdg-en', 'pp3300-mipibrdg-en', 'ppvarn-lcd-en', 'ppvarp-lcd-en', 'pwm0-pin-default', 'scp', 'spi0', 'spi1', 'spi2', 'spi3', 'spi4', 'spi5' do not match any of the regexes: '-pins(-[a-z]+)?$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt8183-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: touchscreen@10: 'reset-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/input/hid-over-i2c.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: /soc/audio-controller@11220000: failed to match any schema with compatible: ['mediatek,mt8183-audiosys', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: /soc/audio-controller@11220000/mt8183-afe-pcm: failed to match any schema with compatible: ['mediatek,mt8183-audio']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: syscon@13000000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/clock/mediatek,syscon.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: dsi@14014000: ports: 'port@0' is a required property
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dsi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: dsi@14014000: ports: 'port@1' is a required property
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dsi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: dsi@14014000: Unevaluated properties are not allowed ('ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dsi.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: vcodec@17020000: 'assigned-clocks' is a required property
	from schema $id: http://devicetree.org/schemas/media/mediatek,vcodec-encoder.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: vcodec@17020000: 'assigned-clock-parents' is a required property
	from schema $id: http://devicetree.org/schemas/media/mediatek,vcodec-encoder.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: thermal-zones: 'tboard1', 'tboard2' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\-]{1,10}-thermal$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: /mt8183-sound: failed to match any schema with compatible: ['mediatek,mt8183_da7219_max98357']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb: bt-sco: '#sound-dai-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sound/linux,bt-sco.yaml#






