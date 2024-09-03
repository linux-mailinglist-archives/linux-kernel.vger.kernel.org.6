Return-Path: <linux-kernel+bounces-313117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D196A079
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75801C239F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139F515572B;
	Tue,  3 Sep 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNFGi62x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15314F9D6;
	Tue,  3 Sep 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373603; cv=none; b=CT1hlgff0ioBqZDc8J1zbDjsrb7TAN8P8LbD/dw0nVSl48SyUjTAHzu+jfP+tvy/BQxHWL+maQG1A8wsMTbJaloyiFpwCvCUwmoKWLsmoaqXT/zmMxzZ1pcBy9RRiRIiKM+mJycleGdnp42MkHzaUrpy5uTr2RImpsc0UTsOuuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373603; c=relaxed/simple;
	bh=vNf7+NPKLJz2pRFDejb0+aPYw+4hvofcQuqX4TuSGDs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=hH4vYtyy+WjJyGHAKq4F1LSmK/ZfgpFTk0Wc6Vp+HV8jvH1pNgC3A/9Lwrirfr9uxeHCvBMr2KKPokTejewbpfRp4ChjedWebMfGWM30SAdDFnXapt2dui7QwscozxZdqdtMVlZveN+dgBjaJqH78QRroOwbNl6q2v5MO1oc/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNFGi62x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EA3C4CEC8;
	Tue,  3 Sep 2024 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373603;
	bh=vNf7+NPKLJz2pRFDejb0+aPYw+4hvofcQuqX4TuSGDs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MNFGi62xJFOzGeIt8v3Tp1HEJgVBnI8X5ZYKOgS68XwsyAetom3v6TZoxpb7/tHgQ
	 dxPQBzRJr7tOgirU68QMGgudNuHzMsPAk/wSUNlLLf+pkTm95GOr9A98tZcKXOUGHq
	 H6vqGWRg2SJZu3QP1f+WqymO6vTaIMzXCPNMbltWkaP40RswZMK41RrFI1QaMHlymE
	 T6ZsOi6U/2/GosO+EAtgLara7fIbrGBJUmKmT2ivKelzbg6Vf97FKJ7Yrl5g+si7NR
	 YXKJ7AAIs5oqw8PvIpUr8LrApED3nZqNVfZkVroIJFory3oedbvlNo7Pb9tGNL9mk1
	 EC3Dh+TvrNfog==
Date: Tue, 03 Sep 2024 09:26:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Cc: krzk+dt@kernel.org, knoxchiou@google.com, 
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 hsinyi@google.com, matthias.bgg@gmail.com, conor+dt@kernel.org
In-Reply-To: <20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com>
References: <20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com>
Message-Id: <172537334835.874724.17274682551076220258.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: mediatek: Add MT8186 Ponyta


On Tue, 03 Sep 2024 14:16:01 +0800, Jianeng Ceng wrote:
> This is v2 of the MT8186 Chromebook device tree series.
> 
> Jianeng Ceng (2):
>   dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
>   arm64: dts: mediatek: Add MT8186 Ponyta Chromebooks
> 
>  .../devicetree/bindings/arm/mediatek.yaml     | 11 +++++
>  arch/arm64/boot/dts/mediatek/Makefile         |  2 +
>  .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 24 ++++++++++
>  .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 27 ++++++++++++
>  .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 44 +++++++++++++++++++
>  5 files changed, 108 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8186-corsola-ponyta-sku0.dtb mediatek/mt8186-corsola-ponyta-sku1.dtb' for 20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com:

arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6366', 'mediatek,mt6358']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6366', 'mediatek,mt6358']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic/codec: failed to match any schema with compatible: ['mediatek,mt6366-sound', 'mediatek,mt6358-sound']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic/codec: failed to match any schema with compatible: ['mediatek,mt6366-sound', 'mediatek,mt6358-sound']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6366', 'mediatek,mt6358']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6366', 'mediatek,mt6358']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic/codec: failed to match any schema with compatible: ['mediatek,mt6366-sound', 'mediatek,mt6358-sound']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic/codec: failed to match any schema with compatible: ['mediatek,mt6366-sound', 'mediatek,mt6358-sound']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,mt6366-rtc', 'mediatek,mt6358-rtc']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,mt6366-rtc', 'mediatek,mt6358-rtc']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,mt6366-rtc', 'mediatek,mt6358-rtc']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,mt6366-rtc', 'mediatek,mt6358-rtc']
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: dp-bridge@5c: 'extcon' is a required property
	from schema $id: http://devicetree.org/schemas/display/bridge/ite,it6505.yaml#
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: touchpad@2c: 'vcc-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/input/hid-over-i2c.yaml#
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: dp-bridge@5c: 'extcon' is a required property
	from schema $id: http://devicetree.org/schemas/display/bridge/ite,it6505.yaml#
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: sound: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/sound/mt8186-mt6366-rt1019-rt5682s.yaml#
arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: sound: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/sound/mt8186-mt6366-rt1019-rt5682s.yaml#






