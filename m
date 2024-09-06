Return-Path: <linux-kernel+bounces-318421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C59796ED97
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F811C234C6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A6815749A;
	Fri,  6 Sep 2024 08:17:55 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6391158A00;
	Fri,  6 Sep 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610675; cv=none; b=cFZVKexSIMfoPbmWllxcjjDpkPWMRpqJZblj9H/hVU3HBOeCHsYMVDlZj4K4Nag88XqAOC/yyc77gqiJ4DmmU+If0ZJILLwlMUDPLazkCylFv6yld/H6swCOvbsvh0Gj2yt8lLZP83OGw+Hpfo3M8ZigIRqySUrYY+922zs58ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610675; c=relaxed/simple;
	bh=Vo9LU6QDb8aoSpr8SmuWlxjZN7aPvw1PXzFw8rq1QT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sd4pUW8npq44V0RhmJGYZ6bAIZa5e1DmRmZiZrRePyd+N5yunGE+PiJRIL7zS2fPGBTI6qmTqhbdk7CYp2LNnASG6PLDb6mwuP4caMeaqGfK9ZC6HpAiwkEghTUK5SNGv9S7oyCVURkoecO0I17qPY4YAAP95D1ukX1tvi+9k5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.212.181])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 80F117E016D;
	Fri,  6 Sep 2024 16:10:10 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: bigfoot@classfun.cn
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
Date: Fri,  6 Sep 2024 16:10:05 +0800
Message-Id: <20240906081005.69334-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906045706.1004813-4-bigfoot@classfun.cn>
References: <20240906045706.1004813-4-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTE9CVkoZQh1LGhhLGE9ISVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSEpMTElVSktLVU
	pCS0tZBg++
X-HM-Tid: 0a91c66235eb03a2kunm80f117e016d
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6KRw6QjI4HT4wIzE2FR8L
	AUoKCxRVSlVKTElOTUpLSUpKSEJIVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpJVUpDSllXWQgBWUFITEpJNwY+

Hi Junhao,

> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> @@ -0,0 +1,595 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include <dt-bindings/soc/rockchip,boot-mode.h>

No need for input.h, leds/common.h and boot-mode.h.

> +#include "rk3568.dtsi"
> ...
> +	vcc3v3_sd: regulator-3v3-vcc-sd {
> +		pinctrl-0 = <&vcc_sd_h>;

schematics: sdmmc0_pwren

> ...
> +	vcc3v3_rf: regulator-3v3-vcc-rf {

schematics: VCC3V4_RF
VCCIN_5V -> VCC3V4_RF

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc3v3_rf_pwren_en>;

schematics: RF_PWR_EN

> ...
> +	vcc5v0_sysin: regulator-5v0-vcc-sysin {

schematics: VCC_SYSIN

> ...
> +	vcc5v0_syson: regulator-5v0-vcc-syson {

schematics: VCC_SYSON

> ...
> +	vcc5v0_usb30_otg0: regulator-5v0-vcc-usb-host {
> ...
> +		vin-supply = <&vcc5v0_syson>;

VCCIN_5V -> VCC5V0_USB30_OTG0

> ...
> +&gmac1 {
> ...
> +	tx_delay = <0x0>;
> +	rx_delay = <0x0>;

Please remove the tx_delay and rx_delay, it's useless.
I know there is an error log, but please ignore it first.

> ...
> +&pinctrl {
> ...
> +		bt_reg_on_h: bt-enable-h {
> +		pcie_pwren_h: pcie-enable-h {
> +		wifi_reg_on_h: wifi-enable-h {
> +		vcc3v3_rf_pwren_en: vcc5v0-modem-en {
> +		usb_host_pwren_h: vcc5v0-host-en {

obviously (

> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> ...
> +&pinctrl {
> ...
> +	sdio-pwrseq {

I tend to write like this:

```
&pinctrl {
	wifi {
		wifi_reg_on_h: wifi-reg-on-h {
```

> +	vcc_sd {
> +		vcc_sd_h: vcc-sd-h {

Overwrite original to match `sdmmc0_pwren`

sdmmc0 {
	sdmmc0_pwren: sdmmc0-pwren {

> +			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +

Extra blank lines.

> +};
> ...
> &sdmmc1 {
> ...
> 	max-frequency = <150000000>;

`max-frequency = <150000000>;` already defined in rk356x.dtsi

> ...
> +&usb_host0_ohci {
> ...
> +&usb_host0_ehci {

&usb_host0_ehci {
&usb_host0_ohci {

Same for usb_host1

> ...
> &usb2phy1_host {
> 	phy-supply = <&vcc3v3_rf>;
> 	status = "okay";
> };

Is usb2phy1_host connected?

-- 
2.25.1


