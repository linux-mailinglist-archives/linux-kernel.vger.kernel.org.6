Return-Path: <linux-kernel+bounces-262681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F14C93CAC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497C12822E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4903148305;
	Thu, 25 Jul 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGYjFfpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A5145A06
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946020; cv=none; b=TrU554A9rn42x8DbViFUlnEPSoQJ4tGlrm/wo0Bm/Thx7eGh/Gf1nBSr0+uXHxjn46Kiw2U0COIf+BjoSOSArpcFI/6jVZVpXw72F2jWGzQU3Xjmsy6ODVeHUs0RbEtHznF0YiAiv7hYFdXktxukfYysswudKeFsEET/7Q3fZms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946020; c=relaxed/simple;
	bh=ZRBNkkK2wEtPoDx1gVCpdzsuUoZfcrDb9qkuaGNq6yU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=duKzFr376RSsPVOV7+BTjTI30bXC3q3fN19MW2zCN+6VU/YZS1AOoUHkPxXy8CITU3n5sqiMySYgEECLlqsmk8cjPNUuy2uc5B8BtFLd4kGCUaBw2j31oIZwrBWogZcmhNI9uZG1G2UATM8VzRuzarKJkN08F+gy7wo0z00Ufrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGYjFfpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFCFC4AF0A;
	Thu, 25 Jul 2024 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721946020;
	bh=ZRBNkkK2wEtPoDx1gVCpdzsuUoZfcrDb9qkuaGNq6yU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sGYjFfpMmQI6XTByFF8V8flHdWlRsmUv1cUlJlIWlF0xOBz9buXRzg2WEhLRpv/4G
	 VIUzGsQjw0pU/JCKuw2xhYws7RGUc7DjTRHa79o7odYpm/I/Or9ET0Gzh+AFp5t7JO
	 y5NBllJwS0YvexGTEGtHT9gLvHzpF7I0jQn+DWTf/twrgS3hyKj52bF7wsaYNZRoNA
	 s0zZOxXqpajUItVwK2fZfZGi7KtsmsyM7lGFWyvfVVzP6zZTeCjKO/a+joKAoxjbwl
	 TtnTlEBFOsq0hONPsOiy1Yc7t8L73GtUFexg/YOmGMKNLZMASIDeRqhGBHKf2CtJa8
	 cYpJ830kcUOWQ==
Date: Thu, 25 Jul 2024 17:20:18 -0500
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
Cc: linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, ukleinek@debian.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240723195538.1133436-1-heiko@sntech.de>
References: <20240723195538.1133436-1-heiko@sntech.de>
Message-Id: <172194566400.4001296.2011158817086396400.robh@kernel.org>
Subject: Re: [PATCH v3 00/14] Expand available features on Qnap TS433


On Tue, 23 Jul 2024 21:55:24 +0200, Heiko Stuebner wrote:
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
> changes in v3:
> - fix the two regulator node-names, I noticed after sending v2
> - add Uwe's Tested-by tags
> - fold in some of Uwe's suggestions:
>   - remove some phandles
>   - more comments to explain what is connected where
>   - handle the two RTCs in the system, though not by hacking around
>     to disable the pmic-one, instead just make sure the real one
>     stays the first rtc
> changes in v2:
> - add patches for tsadc, gpio-keys, cpu-supply, pmic, gpu and io-domains
> 
> 
> [0] I only have two drives right now, but I tested both the internal
> sata connector as well as the PCIe connected sata controller in different
> combinations.
> [1] https://github.com/mmind/u-boot-rockchip/tree/dev/qnap-ts433/v2024.07
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
>  .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 546 +++++++++++++++++-
>  1 file changed, 543 insertions(+), 3 deletions(-)
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3568-qnap-ts433.dtb' for 20240723195538.1133436-1-heiko@sntech.de:

arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: sata@fc400000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#
arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: sata@fc800000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#






