Return-Path: <linux-kernel+bounces-316288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE296CD83
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820F4289EC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448271494CF;
	Thu,  5 Sep 2024 03:57:50 +0000 (UTC)
Received: from mail-m102.netease.com (mail-m102.netease.com [154.81.10.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C710E9;
	Thu,  5 Sep 2024 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725508669; cv=none; b=Nrx47o90Vb/kJ1xYmGQfkSDXdvDA+LZORzQnrMkR4WljHSvgHcCH457Qtjf2Q8wgyUgZoHnxd0cayyEEHbZh5m73EiP+nJh1WrEsRjFWB2Zuv0vxkH2OgCVq4tJvWm/90W+eXImmYWVdfJ4uHM6yZVSheQsRbL2ixNMH9G8xsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725508669; c=relaxed/simple;
	bh=d7rDZxzeOZ7ybHx7fCJfeza0Hj8Jzsr7IIcsy0otlGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDlgiVlPtP+KoudIcWHBQx5OVUH8fxYsoyN5MRVN4N8NpXkzOhr0L2ZDCnVLeOqddfUXBILGgxgykW0VVDgmsqaOGEB96hQjdnHsfKELnOObhj7MzJ4jkB/zCZeQfndEmBuMQWuNCbIdAZ5HPmeIY+ysmguoFv3nqF/lxlDQU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=154.81.10.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.212.181])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 1A1F47E018A;
	Thu,  5 Sep 2024 11:40:12 +0800 (CST)
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
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
Date: Thu,  5 Sep 2024 11:40:09 +0800
Message-Id: <20240905034009.28124-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904111456.87089-4-bigfoot@classfun.cn>
References: <20240904111456.87089-4-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSk0ZVkseH04dTRpISUkdTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSEpMTElVSktLVU
	pCS0tZBg++
X-HM-Tid: 0a91c044aed003a2kunm1a1f47e018a
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6Myo6PjIzOEI4AhkqUSwY
	IQxPCzNVSlVKTElOTktMTUpJQ0tDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpJVUpDSllXWQgBWUFPTExJNwY+

Hi Junhao,

> ...
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dts

This should be 'rk3568-photonicat.dts',
e.g. "Radxa ROCK 3A" -> rk3568-rock-3a.dts

> ...
> +	model = "Ariaboard Photonicat RK3568";
> +	compatible = "ariaboard,photonicat", "rockchip,rk3568";

The official model name does not include 'RK3568'.

> ...
> +	firmware {
> +		optee: optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +
> ...
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ramoops: ramoops@110000 {
> +			compatible = "ramoops";
> +			reg = <0 0x110000 0 0xf0000>;
> +			console-size = <0x80000>;
> +			ftrace-size = <0x00000>;
> +			pmsg-size = <0x50000>;
> +			record-size = <0x20000>;
> +		};
> +	};

Maybe these can be moved to rk356x.dtsi?

> ...
> +	vcca1v8: regulator-1v8-vcca {

schematics: VCCA_1V8

> ...
+	vcc3v3_pcie: regulator-3v3-vcc-pcie {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_enable_h>;

schematics: pcie_pwren_h
vcc_syson -> vcc3v3_pi6c
vcc_syson -> vcc3v3_pcie

> +		regulator-always-on;
> +		regulator-boot-on;

No need.

> ...
> +	vcc5v0_sys: regulator-5v0-vcc-sys {

There is no vcc5v0_sys, but vcc_syson.

vcc_syson (5v) -> vcc3v3_sys
vcc_sysin (5v) - (mcu) -> vcc_syson
vccin_5v -> vcc_sysin

> ...
> +	vcc5v0_usb_host: regulator-5v0-vcc-usb-host {

schematics: VCC5V0_USB30_OTG0 and usb_host_pwren_h
It's a little weird, but that's what they're calling it.
Also: VCCIN_5V -> VCC5V0_USB30_OTG0

> ...
> +	vcc5v0_usb_modem: regulator-5v0-vcc-usb-modem {

Are you sure this regulator is 5v?

> ...
> +	vdda0v9: regulator-0v9-vdda {

schematics: VDDA_0V9

> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h>;

schematics: wifi_reg_on_h
Also you need to enable the clk:

		clocks = <&pmucru CLK_RTC_32K>;
		clock-names = "ext_clock";
		pinctrl-names = "default";
		pinctrl-0 = <&wifi_reg_on_h &clk32k_out1>;

> +		post-power-on-delay-ms = <200>;
> +		reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
> +	};

> ...
> +&pcie30phy {
> +	phy-supply = <&vcc3v3_pcie>;

phy-supply = <&vcc3v3_pi6c>;

> ...
> +&pcie3x2 {
> +	max-link-speed = <1>;
> +	num-lanes = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x2m1_pins>;

These are actually pcie30x1m0_pins.

> ...
> +&pmugrf {
> +	reboot-mode {

Maybe these can be moved to rk356x.dtsi?

> ...
> +&sdhci {

Missing mmc-hs200-1_8v;

> ...
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;

Why does sdcard need cap-mmc-highspeed?

> +	max-frequency = <150000000>;
> +	sd-uhs-sdr104;

The sdcard does not have 1.8v io voltage,
so this is wrong, please add no-1-8-v;

> +&sdmmc1 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	disable-wp;

sdio wifi does not need disable-wp.

> +	qca_wifi: qca-wifi@1 {
> +		compatible = "qcom,ath10k";

ath10k does not need compatible.

> ...
> +&uart1 {
> ...
> +		clocks = <&pmucru CLK_RTC_32K>;
> +		enable-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_enable_h>;

schematics: bt_reg_on_h
Missing clock-names = "lpo";

-- 
2.25.1


