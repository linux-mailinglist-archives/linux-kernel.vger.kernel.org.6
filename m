Return-Path: <linux-kernel+bounces-319408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF0596FC32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C581C21BE6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF5F1D3652;
	Fri,  6 Sep 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVNyp0so"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5307014B956;
	Fri,  6 Sep 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651461; cv=none; b=LyOAQ33vQgdqEu76YbkMmG4mlLg3t6B9HARXy/vPborhZuZM0l7OfY8HBnXUMmhAgaO06XI1+kaV+or1JCSuUecYgf9KURAZQzIPpNaTWuifA3u7OSpqIcPgeVOy6o/z/aQTDZjDhEm3LJ/p+VIVPwdMjlJgTxHlJdFaA2rIgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651461; c=relaxed/simple;
	bh=/gQVnhBcmD3QxeQHO0/3XmA2xRdVRLa4Aw/l+eidKOE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=WOCXy2Y9Kz4XtdLJGjuL/030s502m3goz92VeelJYUbvhmTfkQHJYpXZt4zc1X33UGml7Ob4MFWncfmHohDzO4q8c8gOlBKercXyDfsIRHyeKjPynH6LWjCVPedwURt1MEgFg4q0H+OaE5qDSY2t8MsasLEoLQMpaVSot26q+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVNyp0so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79E2C4CEC4;
	Fri,  6 Sep 2024 19:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725651460;
	bh=/gQVnhBcmD3QxeQHO0/3XmA2xRdVRLa4Aw/l+eidKOE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jVNyp0soCew9Hfm+BeUEMc/ns9Gb80ux/ROoM0TTwcRqgsJXF5LoK4APuKU9kJ8i+
	 ZLD3/YljHH8H3Jnjd1h5kEJNDatEu2dAxS45OEEKUjtLLyDswA3Rr2F1GkxHS3jWPp
	 YiFd93NNKq4gOqqHhKgOHjW2mqUIuKL8YbaCkNG7YcBoyoIpdby+iJcHJq2ML5vNd2
	 hE77NWCiQA/YDbwPZ2gUpSWB10PA48jruX620hcEqqemOLbwG9XQID4afAuTyDE8ZJ
	 xX/v8DdtH67hpOk4pc6G668vpHFlDd2jwO13OQr9VWoPcrTu/J6VKSTFAf9QSBESGk
	 PNPZIEfP+Wa9A==
Date: Fri, 06 Sep 2024 14:37:39 -0500
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
Cc: Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>, 
 Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240906045706.1004813-1-bigfoot@classfun.cn>
References: <20240906045706.1004813-1-bigfoot@classfun.cn>
Message-Id: <172565139759.2035112.3019218754029920923.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] Add support for Ariaboard Photonicat RK3568


On Fri, 06 Sep 2024 12:57:03 +0800, Junhao Xie wrote:
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
> Junhao Xie (3):
>   dt-bindings: vendor-prefixes: Add Shanghai Novotech Ariaboard
>   dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
>   arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3568-photonicat.dts   | 595 ++++++++++++++++++
>  4 files changed, 603 insertions(+)
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3568-photonicat.dtb' for 20240906045706.1004813-1-bigfoot@classfun.cn:

arch/arm64/boot/dts/rockchip/rk3568-photonicat.dtb: bluetooth: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml
arch/arm64/boot/dts/rockchip/rk3568-photonicat.dtb: phy@fe8c0000: 'phy-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/phy/rockchip,pcie3-phy.yaml
arch/arm64/boot/dts/rockchip/rk3568-photonicat.dtb: rfkill-modem: 'reset-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/rfkill-gpio.yaml






