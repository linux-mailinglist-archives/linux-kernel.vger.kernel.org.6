Return-Path: <linux-kernel+bounces-325070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB92975487
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354441F2306B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8FD19E996;
	Wed, 11 Sep 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUYHNgHy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77419E963;
	Wed, 11 Sep 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062612; cv=none; b=YYlCpIEFSUnQ8BqdJpbUtb/cPIKrbpPacV522L6isgOalatdVUva/GfyxzkR2PCJJ93zOhQStNspCipT2ZMGY/eZZ6ez8FDrQZTe4Qf+reUttKMK5gRVL6i2rF8vBXg/OgB460Gfcfov9WlFGX5h6Q2Gco7geaXOsaxh4eS/BBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062612; c=relaxed/simple;
	bh=21HFruj9izzHUrFvhKMjGFBM1aMTp37x1C3yOXzfRVk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=D3qfe0LpoQBJVRpqVQM08M8bWfh1XZbXCXuyxawPaTr/tzixl0r1/ez/y9/ttK1d3PiNrlLaSGtlcjqAEW/DM8oXraGD+tO9hJJHZOmlYZB7EB6wtah4EFReg5x3mUOFbfuv9wb7WC6yvjff7OD8bS9+DBSq/Z6b06YtOrK4+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUYHNgHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22315C4CED0;
	Wed, 11 Sep 2024 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062612;
	bh=21HFruj9izzHUrFvhKMjGFBM1aMTp37x1C3yOXzfRVk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oUYHNgHy6/sMNVfGc8+368rfOLenOQrami0cuO7ASPBVRrOH5oO/buyNPBvsiYWfG
	 9j91xVYqzx09YbFcAqVoAPhqPX3WT6ZomXvO3EI3lgJPJYh1GO3K3B9UodvsHp6Y/H
	 QdoPrYxVB+w+LjjLjRifBFJ0Yz4NN33W8H4VfbNWDgMucTU6MESzobGwUYYsRwIXPJ
	 WgfH8F2MY7mIgH3r9zN+dOkcX6XldOU/Yj0t/nwjVNi0AS7tZf6Rth+pJNB10hCkFe
	 d9Qs3cYcZVwIRiY5P9205eT0JO/wFuc/BVPfW/MQVADr2aPpCEAWx6S9AUPrBmRfqN
	 g+PXW3TYiZk4g==
Date: Wed, 11 Sep 2024 08:50:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, linux-kernel@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 linux-arm-kernel@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>, 
 devicetree@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20240911122809.1789778-2-bigfoot@classfun.cn>
References: <20240911122809.1789778-2-bigfoot@classfun.cn>
Message-Id: <172606224388.90730.44787008983831368.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] Add support for Ariaboard Photonicat RK3568


On Wed, 11 Sep 2024 20:28:07 +0800, Junhao Xie wrote:
> Add dts for Ariaboard Photonicat RK3568.
> 
> This series bring support for:
> * Debug UART
> * SDIO QCA9377 WiFi and Bluetooth
> * M.2 E-Key PCIe WiFi and Bluetooth
> * M.2 B-Key USB Modem WWAN
> * Ethernet WAN Port
> * MicroSD Card slot
> * eMMC
> * HDMI Output
> * Mali GPU
> * USB Type-A
> 
> Changed from v1:
> - move some general nodes (firmware, ramoops, reboot-mode) to rk356x.dtsi
> - gmac1 change to phy-mode rgmii-id
> - corrected some regulator to be closer to schematics
> - rename rk3568-ariaboard-photonicat.dts to rk3568-photonicat.dts
> https://lore.kernel.org/lkml/20240904111456.87089-1-bigfoot@classfun.cn/
> 
> Changed from v2:
> - remove unused headers
> - corrected some regulator to be closer to schematics
> - remove usb_host1_ohci, usb_host1_ehci, usb2phy1_host that have no connection
> https://lore.kernel.org/lkml/20240906045706.1004813-1-bigfoot@classfun.cn/
> 
> Junhao Xie (3):
>   dt-bindings: vendor-prefixes: Add prefix for Ariaboard
>   dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
>   arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3568-photonicat.dts   | 586 ++++++++++++++++++
>  4 files changed, 594 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> 
> --
> 2.46.0
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3568-photonicat.dtb' for 20240911122809.1789778-2-bigfoot@classfun.cn:

arch/arm64/boot/dts/rockchip/rk3568-photonicat.dtb: bluetooth: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
arch/arm64/boot/dts/rockchip/rk3568-photonicat.dtb: phy@fe8c0000: 'phy-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/phy/rockchip,pcie3-phy.yaml#
arch/arm64/boot/dts/rockchip/rk3568-photonicat.dtb: rfkill-modem: 'reset-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/rfkill-gpio.yaml#






