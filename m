Return-Path: <linux-kernel+bounces-568951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A92A69C98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52996188EF75
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F76223338;
	Wed, 19 Mar 2025 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wrgt/+Cu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8EF22331B;
	Wed, 19 Mar 2025 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425846; cv=none; b=i+JS6HT0B7ttmVGPlb2BQHpv/SZZ+kNshnyf+ueZpaFQkODfGNhgBoB4Qsq+nZRXhZJXeOMgnAiwN674l5Xp8eVI5vCyaA8WAnJk+0wK34hJXDTjpSni+4+qqpuEnWd9jMZBhZLG6tbjztfeeJffXUAlPy/bf4je78yPICID/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425846; c=relaxed/simple;
	bh=hpem3UEpjL9zg0df1KCgbi91SjPixiAmgIzpZt1KUJg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bFROOFisWYqiiKH6bs6SpM+FZjidj4SA1yZgnXUn99NhCgb0NgNHyXqwugzYJn1IL1v4eBYhElVQ/1roJnixNDDf1stMZLp6dfMn6fldzmXvZmLwfyM6K784xT07ZT5DIgX+IZsIC0LSinja2WoqSHtVm7Mvl3QuuA0AuSNl8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wrgt/+Cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E28C4CEE4;
	Wed, 19 Mar 2025 23:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742425845;
	bh=hpem3UEpjL9zg0df1KCgbi91SjPixiAmgIzpZt1KUJg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Wrgt/+Cu7qJjwLfGyMrE5m390d+gbteLAjKaxp7899EkxuXYaUzs3o357/afeEo2I
	 sNea93qPS9XMTYzjNX16xtSCWnp1IZD9m0e+1f9kSTvJa79v3D8D5EQmpYVnHP6xeg
	 leFvxd9RuBzF+zGHCXZ07MdrJ4hgrp00T4UPMq49J2AGybnTVxfCfWbMdvcKbUUqBu
	 OozrPjc5+2ug9gvQRSzzHV0z5Uu9AA/2se8ukJ5/lnkwrZ9AQmO/dAY20iEz4q0ChP
	 /R5CXDqRTYNXAAbsw/KF0Xcnko/nK1bTni/lrIMM0NVFvEZJc/kxjA10AXYjzUP+v3
	 V12O2lP/89qUA==
Date: Wed, 19 Mar 2025 18:10:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, jian.xu@amlogic.com, zhe.wang@amlogic.com, 
 Michael Turquette <mturquette@baylibre.com>, 
 Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org, 
 shuai.li@amlogic.com, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-clk@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-amlogic@lists.infradead.org, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jiebing chen <jiebing.chen@amlogic.com>
In-Reply-To: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
Message-Id: <174242564271.2499930.16784872359354582008.robh@kernel.org>
Subject: Re: [PATCH v4 0/6] Add support for S4 audio


On Wed, 19 Mar 2025 15:04:43 +0800, jiebing chen wrote:
> Add s4 audio base driver.
> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---
> Changes in v4:
> - fix dtb check warning
> - add maxItems of power domain for dt-bindings
> - fixed audio clock pads regmap base and reg offset
> - use dapm widget to control tocodec bclk and mclk enable
> - Link to v3: https://lore.kernel.org/r/20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com
> 
> Changes in v3:
> - remove g12a tocodec switch event
> - Modify the incorrect title for dt-bindings
> - Link to v2: https://lore.kernel.org/r/20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com
> 
> Changes in v2:
> - remove tdm pad control and change tocodec base on g12a
> - change hifipll rate to support 24bit
> - add s4 audio clock
> - Link to v1: https://lore.kernel.org/r/20250113-audio_drvier-v1-0-8c14770f38a0@amlogic.com
> 
> ---
> jiebing chen (6):
>       dt-bindings: clock: meson: Add audio power domain for s4 soc
>       dt-bindings: clock: axg-audio: Add mclk and sclk pad clock ids
>       dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
>       ASoC: meson: g12a-toacodec: Add s4 tocodec driver
>       clk: meson: axg-audio: Add the mclk pad div for s4 chip
>       arm64: dts: amlogic: Add Amlogic S4 Audio
> 
>  .../bindings/clock/amlogic,axg-audio-clkc.yaml     |  20 +-
>  .../bindings/sound/amlogic,g12a-toacodec.yaml      |   1 +
>  .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     | 219 ++++++++++
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 372 ++++++++++++++++-
>  drivers/clk/meson/axg-audio.c                      | 441 ++++++++++++++++++++-
>  drivers/clk/meson/axg-audio.h                      |   6 +
>  include/dt-bindings/clock/axg-audio-clkc.h         |  11 +
>  sound/soc/meson/g12a-toacodec.c                    |  46 +++
>  8 files changed, 1111 insertions(+), 5 deletions(-)
> ---
> base-commit: 6ecd20965bdc21b265a0671ccf36d9ad8043f5ab
> change-id: 20250110-audio_drvier-07a5381c494b
> 
> Best regards,
> --
> jiebing chen <jiebing.chen@amlogic.com>
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/amlogic/' for 20250319-audio_drvier-v4-0-686867fad719@amlogic.com:

arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: sound: 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
arch/arm64/boot/dts/amlogic/meson-axg-s400.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-a311d-bananapi-m2s.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12a-u200.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-s922x-bananapi-m2s.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#






