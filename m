Return-Path: <linux-kernel+bounces-208816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8093902985
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73791C2229E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8014E2EA;
	Mon, 10 Jun 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhBaCMGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE921BC39;
	Mon, 10 Jun 2024 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049313; cv=none; b=tpPZTpp5M9U79o31xqwQZXI9ZBNK30A1+QtE8VkC+7heQNq8GYHclJ+x5ROxNO67ANTutolv1KnrhAUSbQiQ2xJl6/kl+DEedzHSdFBV8c3yWDG3esbYxNmrDFhpzsEog4rLNXlNPvGoHPeYCnsd6JftyVV0UKDTguXeyAiq8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049313; c=relaxed/simple;
	bh=ZXno21ruQX7U9aDUjGK6FqcPyvaWK4QVLpAwyNfzCEE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=i6RFh2FjRTG58ip8l5/FJBKAazI/lYtMY7JdexrvsWodsSKbAAO8zr38KEPaX0PoQE7RkZiMAcKTbIpGJjRSEfqvm5yJ+1bsaKlBeVetvblll0JQCXc64eLF/f5mKZhiVX+EGDuiG2KzOXhAN3rqhFgRsE2V9WgcKdg+1hClMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhBaCMGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5207CC2BBFC;
	Mon, 10 Jun 2024 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718049312;
	bh=ZXno21ruQX7U9aDUjGK6FqcPyvaWK4QVLpAwyNfzCEE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nhBaCMGNS+8oSuHkiBunoxU4rsqzW0XmtDCnlK20fkoFpO7rkBYeODA0BBq/A6LSl
	 Wf7OpAqQwKFvY0IZTYo2QO1UfB4uW675xM/IpqEvTWaChULATQSyHNa08X5QItebKs
	 GXIzB62HYXI5LvORc9C31gn8I6U0Oqtw8O9m/dp6bcY4pEH+KjpoXEuKVciQiARj6z
	 Tcl6u/NTe7CUzttQYJndBc+CSNRF1X1l1QcYXnjINKyRP+37YIUDsq3Uyxv4dFOJPz
	 9THunnSLwyta25WX0LIJHqxrtmkIm/xUyUmZSXwANWikwA2G7rV2zhQfxCIO0yxCDm
	 g/k4HQnVl7OMg==
Date: Mon, 10 Jun 2024 13:55:11 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Viacheslav Bocharov <adeep@lexina.in>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-amlogic@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240607145148.2246990-1-adeep@lexina.in>
References: <20240607145148.2246990-1-adeep@lexina.in>
Message-Id: <171804879810.2984676.7472745438656826180.robh@kernel.org>
Subject: Re: [PATCH v1 0/2] arm64: meson: add support for JetHome JetHub D2


On Fri, 07 Jun 2024 17:50:02 +0300, Viacheslav Bocharov wrote:
> Add support for new controller.
> JetHome Jethub D2 (j200) is a home automation controller with the following
> features:
>   - DIN Rail Mounting
>   - Amlogic S905X3 (ARM Cortex-A55) quad-core
>   - micro-HDMI video out
>   - 4GB LPDDR4
>   - 32GB eMMC flash
>   - 1 x USB 2.0
>   - 1 x 10/100/1000Mbps ethernet
>   - two module slots for radio/wire interface cards
>   - 2 x gpio LEDS
>   - 1 x 1-Wire
>   - 1 x RS-485
>   - 3 x dry contact digital GPIO inputs
>   - 2 x relay GPIO outputs
>   - DC 9-36V power source with battery UPS on board option
> 
> Viacheslav Bocharov (2):
>   dt-bindings: arm: amlogic: add binding for JetHome JetHub D2
>   arm64: dts: meson-axg: add support for JetHome JetHub D2 (j200)
> 
>  .../devicetree/bindings/arm/amlogic.yaml      |   1 +
>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  .../amlogic/meson-sm1-jethome-jethub-j200.dts | 614 ++++++++++++++++++
>  3 files changed, 616 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dts
> 
> 
> base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
> --
> 2.45.2
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


New warnings running 'make CHECK_DTBS=y amlogic/meson-sm1-jethome-jethub-j200.dtb' for 20240607145148.2246990-1-adeep@lexina.in:

arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: /soc/bus@ff600000/bus@60000/clock-controller@0: failed to match any schema with compatible: ['amlogic,sm1-audio-clkc']
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller@300: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller@340: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller@380: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller@3c0: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-0: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-0: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-0: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-1: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-1: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-1: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-1: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-2: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-2: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: audio-controller-2: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-sound-card.yaml#
arch/arm64/boot/dts/amlogic/meson-sm1-jethome-jethub-j200.dtb: sound: 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#






