Return-Path: <linux-kernel+bounces-301157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63495ED18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74AB1F21916
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285F7144D27;
	Mon, 26 Aug 2024 09:27:49 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594213AD3F;
	Mon, 26 Aug 2024 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664468; cv=none; b=nkIoHis/BtwGq0iNT7R5LfMvhkTKU9IaVvxXGLPc8ZIb7yJeQJV/XvbQLnknTKaJjEnS56N/BIXhpEqayBfFeHXxP61TVqCx5LwOWq9yqfCswXaNtV+7P6T7xgAfy7nY2rkFYlkNUHjRM/KzEIQp3k4KV8Ie4p9vH8AR8SfYVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664468; c=relaxed/simple;
	bh=m0c4P9PL6AO6iaD2QbgMEKqSM6WELU5uReA8nE/G1Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4c7VCjIhd3TsrTSkaSuxuYSf3prtV7V44vJ+Raza0i2XCUWF3c3qP3DHILIS9qPBQ7BwpNqaakBdoDMeYZIP9qGcFfSXboqtublih6uFz8ssma+0R22Q5Sbb9mX4LOuP9MSrRtvoOiSu65H8EtDJTo3mjh+9MlPnXFg0tAdAqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [58.61.141.165])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 14FA77E0195;
	Mon, 26 Aug 2024 15:01:13 +0800 (CST)
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
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for LCKFB Taishan Pi RK3566
Date: Mon, 26 Aug 2024 15:01:09 +0800
Message-Id: <20240826070109.55659-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826044530.726458-4-bigfoot@classfun.cn>
References: <20240826044530.726458-4-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUtIVkkYQhhNHkhKSR1LTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0pVSk1OWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NNVUpLS1VLWQ
	Y+
X-HM-Tid: 0a918d7d201b03a2kunm14fa77e0195
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6NBw5ETIrCh80GB9MM1Yt
	SgwKFEtVSlVKTElPTU5OTUxIQ0JCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
	VU1KVUpPSlVKTU5ZV1kIAVlBSEhOTjcG

Hi Junhao,

> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts
> ...
> +	aliases {
> +		mmc0 = &sdmmc0;
> +		mmc1 = &sdhci;
> +		mmc2 = &sdmmc1;
> +		wifi = &brcmf;
> +		bluetooth = &bluetooth;
> +	};

WiFi and Bluetooth do not need aliases.

> ...
> +	vcc5v0_host: vcc5v0-host-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_host";
> +		regulator-boot-on;
> +		regulator-always-on;

This regulator does not need always-on and boot-on.

> ...
> +	vccio_flash: vccio-flash {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vccio_flash";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_1v8>;
> +	};

Generally speaking, vccio_flash is not a DCDC regulator,
it is directly connected to vcc_1v8. Maybe you need to
confirm the schematics.

> +
> +	vccio_wl: vccio-wl {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vccio_wl";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3>;
> +	};

Same as above, usually like this:
VCC_1V8 or VCCA1V8_PMU - 0R - VCCIO_WL
`sd-uhs-sdr104` requires 1.8v io voltage,
you need to confirm the schematics.

> ...
> +&pinctrl {
> ...
> pmic {
> +	pmic {
> +		pmic_int: pmic_int {

Only the pmic_int is needed.
Also `pmic_int: pmic-int {`

> ...
> +&sdhci {
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe &emmc_rstnout>;
> +	status = "okay";
> +	vmmc-supply = <&vccio_flash>;
> +	vqmmc-supply = <&vccio_flash>;
> +};

The vmmc requires 3.3V supply (on rk356x).

> ...
> +&sdmmc1 {
> ...
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vccio_wl>;
> +	vqmmc-supply = <&vccio_wl>;

Same as above.

> ...
+&uart1 {
> ...
+		vbat-supply = <&vcc3v3_sys>;
+		vddio-supply = <&vccio_wl>;

Here corresponds to sdmmc1.

Thanks,
Chukun

-- 
2.25.1


