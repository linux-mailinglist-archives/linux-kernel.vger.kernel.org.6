Return-Path: <linux-kernel+bounces-259566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 894B6939880
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390C41F219F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 02:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E11413D24E;
	Tue, 23 Jul 2024 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc6c+F2c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9513CFB6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721703460; cv=none; b=F9BMpCPE/rOEt62O91Bl4EFJhn/fDSX5WP7CAg/mTgDiAHpy0VZHlshPQ89TM5/m6dcJGw06ewGRf8nmmAJIYUjkr2aoUq6f7g6g/cdZm6RUAYpZlBIIywLYd3yd/DlK7ZnG6Q1Runzvx6F9hLIMs6orRKsuE7ziLEBkcgH2qio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721703460; c=relaxed/simple;
	bh=/TRII93/10eFu+qM4B82YYGwGymPU+swqszXC+vxlQw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=tXp6c1Isawowvlgq3AELivXAJ36I9Bwy7lH8Q87kNh+5V3x2mLfABtslgFQF+sSQ+2VTuKFnjW17o6PGxDIzc19bMflDBT3MmGLVJ8l07MWR9kI4ge5p+t2JbnR6OFBvihbUJwIpIPsbrWbnHx+sR1mEuWvxFRRW3LSKpAkBMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc6c+F2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A10FC32782;
	Tue, 23 Jul 2024 02:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721703460;
	bh=/TRII93/10eFu+qM4B82YYGwGymPU+swqszXC+vxlQw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uc6c+F2chvE9bqzu1K2My/iiu22H5744okPF42KJb+wQ1AEnL4lR0/0ggPQrWEe41
	 wv/XrBQAeBpW6y+nqNtWp0FkZxvMhdEsQrqaWjw3UUKkdFO3OsxsLG/gP14cUWixUV
	 RIbVfQJGhFmOzJAfYub9QLYpSRv+P2lWcw7uTei7Jkr71CVHHN9t7eD5ykpAYdSbY0
	 GZS30+8r3v1WqrxQZIMf9p3uzPvnetXjbqPVW8IQSJyj2B6D820riifnXZPLEG+lmn
	 Dj7iOc82o1lp69vJTLhjCum+P8te6DP7tCW2tlEeIBDpl6EZp1MeTHANh4InPl+7p5
	 x6lPms31MX4CQ==
Date: Mon, 22 Jul 2024 20:57:37 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: ukleinek@debian.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240721173723.919961-1-heiko@sntech.de>
References: <20240721173723.919961-1-heiko@sntech.de>
Message-Id: <172170324698.205262.12290895401170418124.robh@kernel.org>
Subject: Re: [PATCH v2 00/14] Expand available features on Qnap TS433


On Sun, 21 Jul 2024 19:37:09 +0200, Heiko Stuebner wrote:
> Thanks to the nicely supported rk3568, the hardest part for adding things,
> is to pull things from the vendor-kernel and translating them to mainline
> standards.
> 
> This series allows the TS433 to use all 4 bays [0], wiggle some LEDs and
> access devices connected to all 3 usb ports.
> 
> The device runs stable now and might be usable for actual usage.
> 
> There is still a todo-list though:
> - the ethernet mac address for the realtek chip seems correct,
>   but the gmac0 interface currently uses a wrong one
> - i2cdetect reports devices on i2c-1 on addresses 54,55,56,57
>   model_Q0B20_Q0B30_10_10.conf from the original rescue image labels them
>     VPD_MB = I2C:0x54, VPD_BP = I2C:0x56
>   the meaning currently being unknown. Some eeprom maybe?
> - The regulator tree is slightly dubious. Everthing seems to follow rk3568
>   reference designs, but especially the regulator labeled vcc3v3_sd
>   seems to supply some PCIe functionality. So I guess the device's
>   schematics will look quite different than the regulators added to the
>   vendor devicetree.
> - Quite a bit of functionality is provided by the MCU connected to uart0.
>   According to the model.conf there should be fan-control, a number of
>   additional LEDs (status,locate,usb?)
> 
> 
> Thanks to Qnap engineers adding an easily accessible header for maskrom
> mode on the board, replacing the bootloader is also quite a breeze. A
> branch on top of today's u-boot master branch can be found on [1]. I'll
> submit that code to u-boot once I can cherry-pick the dts patches.
> 
> 
> changes in v2:
> - add patches for tsadc, gpio-keys, cpu-supply, pmic, gpu and io-domains
> 
> 
> [0] I only have two drives right now, but I tested both the internal
> sata connector as well as the PCIe connected sata controller in different
> combinations.
> [1] https://github.com/mmind/u-boot-rockchip/tree/dev/qnap-ts433/v2024.07
> 
> 
> Heiko Stuebner (14):
>   arm64: dts: rockchip: add PCIe supply regulator to Qnap-TS433
>   arm64: dts: rockchip: enable second PCIe controller on the Qnap-TS433
>   arm64: dts: rockchip: enable uart0 on Qnap-TS433
>   arm64: dts: rockchip: enable usb ports on Qnap-TS433
>   arm64: dts: rockchip: add stdout path on Qnap-TS433
>   arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
>   arm64: dts: rockchip: add board-aliases for Qnap-TS433
>   arm64: dts: rockchip: add hdd leds to Qnap-TS433
>   arm64: dts: rockchip: enable the tsadc on the Qnap-TS433
>   arm64: dts: rockchip: add gpio-keys to Qnap-TS433
>   arm64: dts: rockchip: define cpu-supply on the Qnap-TS433
>   arm64: dts: rockchip: add missing pmic information on Qnap-TS433
>   arm64: dts: rockchip: enable gpu on Qnap-TS433
>   arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433
> 
>  .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 539 +++++++++++++++++-
>  1 file changed, 536 insertions(+), 3 deletions(-)
> 
> --
> 2.39.2
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3568-qnap-ts433.dtb' for 20240721173723.919961-1-heiko@sntech.de:

arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: sata@fc400000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#
arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: sata@fc800000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#






