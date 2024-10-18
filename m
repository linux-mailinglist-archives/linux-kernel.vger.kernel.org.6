Return-Path: <linux-kernel+bounces-371706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E109A3EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672CF2879DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EEB1D79B2;
	Fri, 18 Oct 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWM+De/G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D3118872C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255950; cv=none; b=N1bYUIEloRjR8OF1ByBhL0bPy1VrBCUOjSygnh0J/1QfXaY1MfwJMR74jXoPMOr4bO83L+QyVTiipc7J5mA3Fy4/teEsYlfHubV+3xsX25ZnjDtDDsk4KmBEqNVLt85REX3K3N9EI8my7OCbwYNAcW8ia2Idy+e6xinFK73vJzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255950; c=relaxed/simple;
	bh=wcjdS04309JEdjmFyG61jjDT88GK+yM48adeQ4B/XXg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=nuEXwi9vh28FlhGqbZ+uOD/lYaJiAlIqJuro6NFu9EJFYK+q+L/3sjq0swnWKo77Akaz6rrcSI4L53UUeYa1wf6NJW7PY+VxgOpmk162lSsrgVU94PRM01OE7q/ouyXUuUmoYZ9oo7a/8BI6GT/MA15XcLZkic2AqW5BNciTL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWM+De/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE018C4CECF;
	Fri, 18 Oct 2024 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729255949;
	bh=wcjdS04309JEdjmFyG61jjDT88GK+yM48adeQ4B/XXg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AWM+De/Gt5ea4aMATDJAyW908HnRRFIiQ2/25JFnrUiC7Adcw6DB9go2SFdCGkfSs
	 S7thuAKMZjbvGUcSx7kVVxPyUyX0w2OppZWnzWIfI7CMZ9se6GEOefnjmHoru00e1s
	 hsArXDoC1B+13wIuE90STwcrEpih+1p0cGDPeoNGQTZ/yOcw0iO4kpRY62sCSlb/Xp
	 Z3nP7p86DSE7se3m+9t842fFuYiHZYsJW9p4k4M3bPAhfGw2rd6Y83MA/TssLz3W55
	 Y7+Ygr9kPvgC/lV5ZQXQ+xLCdQePzULgThzb5MrcQJBE4p2dCgwNUSnY0H1NRmcTE+
	 MJ1nBLKBkSmpQ==
Date: Fri, 18 Oct 2024 07:52:28 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Cc: devicetree@vger.kernel.or, wenst@chromium.org, matthias.bgg@gmail.com, 
 linux-mediatek@lists.infradead.org, angelogioacchino.delregno@collabora.com, 
 hsinyi@chromium.org, sean.wang@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org
In-Reply-To: <20241018091135.17075-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241018091135.17075-1-xiazhengqiao@huaqin.corp-partner.google.com>
Message-Id: <172925540039.17739.8191775806524492819.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: mediatek: Add MT8186 Chinchou


On Fri, 18 Oct 2024 17:11:32 +0800, Zhengqiao Xia wrote:
> This is v2 of the MT8186 Chromebook device tree series to support
> MT8186 chinchou platform. It is based on the "corsola" design.
> It includes chinchou and chinchou360, including LTE, stylus,
> touchscreen combinations.
> 
> Changes in v2:
> - Modify location of "const: google,chinchou-sku17" in mediatek.yaml
> - rename "pin-report" to "pin-report-pins"
> - add "vcc33-supply" and "vcc33-supply"
> - rename "cbj-sleeve-gpio" to "cbj-sleeve-gpios"
> - modify subnode of sound
> - Link to v1: https://lore.kernel.org/all/172900161180.733089.8963543745385219831.robh@kernel.org/
> 
> Zhengqiao Xia (3):
>   dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
>   arm64: dts: mediatek: Add MT8186 Chinchou Chromebooks
>   arm64: dts: mediatek: Add exton node for DP bridge
> 
>  .../devicetree/bindings/arm/mediatek.yaml     |  29 ++
>  arch/arm64/boot/dts/mediatek/Makefile         |   3 +
>  .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
>  .../mediatek/mt8186-corsola-chinchou-sku1.dts |  35 ++
>  .../mt8186-corsola-chinchou-sku16.dts         |  29 ++
>  .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 321 ++++++++++++++++++
>  .../boot/dts/mediatek/mt8186-corsola.dtsi     |   6 +
>  7 files changed, 441 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
> 
> --
> 2.17.1
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8186-corsola-chinchou-sku0.dtb mediatek/mt8186-corsola-chinchou-sku1.dtb mediatek/mt8186-corsola-chinchou-sku16.dtb' for 20241018091135.17075-1-xiazhengqiao@huaqin.corp-partner.google.com:

arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dtb: pmic: 'codec' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dtb: pmic: 'codec' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dtb: pmic: 'codec' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#






