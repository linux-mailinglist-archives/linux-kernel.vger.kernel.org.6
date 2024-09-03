Return-Path: <linux-kernel+bounces-313114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DCC96A073
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974D51F26BB8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615A51C3E;
	Tue,  3 Sep 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZNl6SxO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4D6F31C;
	Tue,  3 Sep 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373601; cv=none; b=OHFKrpaCg0k/J4C3Kle8X0mMPuMSNXszV6kZWhU1lAkF8Bx/3l+EX1ih9gnviQT0QTS9z4/vHSOxr+h5QYuXy47j6963K+DCUbzMulR43Cq/dcu56cloeNriHQWFbxnQLAkRm7h+ftM2qeDgaQxUgHR7VCE6tZGAwo7NFuap6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373601; c=relaxed/simple;
	bh=oepubW5xCjnomthQWrM+V31kgGapv4R6djjQTRdai7g=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VlvrRgBVyjvCrlyByAMNy6e077qIHHpTO0Lg6lapALgys+xgk0A76XECIMJTz2fi84SBfeX50lVYBBhKz81kJ8peiQIiK1fROJTOtG7WK3HOPZWTACk7Qd3bFJCUxGX98BNkuzSa9qj+Ondc1Y+0F2JuwtHG3Rx3us4vgl1EmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZNl6SxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664ABC4CEC7;
	Tue,  3 Sep 2024 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373600;
	bh=oepubW5xCjnomthQWrM+V31kgGapv4R6djjQTRdai7g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RZNl6SxOy3lRIAGl0KBzxJnXKwr/4wIqks5ps/W01gjbCvPlsC2X8eu6OWOutjYhV
	 a+64ojJLBCLo8FSYCIYdtle3x1ox0YzNE5bE1HWjeWk2lm/hURdSDw1RVjXxbSN5Vf
	 QgA+YgGZvVlQvdKUk0pkpjbfoDNnapuY/SJxs+VEgw5KjRzniQB+zrrOuuenWd+C9K
	 wHbx/B1cDFpwoZhymfQNfTn4K8e9PoS9frP+Zqb3ed6UJpDcfusewTF7HKAl5clCUB
	 Ws9k6f1Hy2NxC60GUF8jmo0a4d6QyUgx150NYL5koZkBI7RRC10lwLWM33MR9cmuXo
	 CoH4/tk/jeXeg==
Date: Tue, 03 Sep 2024 09:26:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Dongjin Kim <tobetter@gmail.com>, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20240901112020.3224704-1-jonas@kwiboo.se>
References: <20240901112020.3224704-1-jonas@kwiboo.se>
Message-Id: <172537334390.873091.5239461386156277757.robh@kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add Hardkernel ODROID-M2


On Sun, 01 Sep 2024 11:20:13 +0000, Jonas Karlman wrote:
> This series add initial support for the Hardkernel ODROID-M2 board.
> 
> The Hardkernel ODROID-M2 is a single-board computer based on Rockchip
> RK3588S2 SoC. It features e.g. 8/16 GB LPDDR5 RAM, 64 GB eMMC, SD-card,
> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0/Type-C.
> 
> Schematics for ODROID-M2 can be found at:
> https://wiki.odroid.com/_media/odroid-m2/hardware/m2_main_rev1.0_240611.pdf
> 
> The device tree was created based on the schematics with regulator
> voltage values adjusted to closer match vendor downstream device tree.
> 
> Testing was done booting into Linux using mainline U-Boot from [1],
> a test build of mainline U-Boot for ODROID-M2 can be found at [2].
> 
> U-Boot patches will be sent once DT reach the devicetree-rebasing tree.
> 
> [1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3xxx-2024.10/
> [2] https://github.com/Kwiboo/u-boot-build/actions/runs/10653436524
> 
> Jonas Karlman (2):
>   dt-bindings: arm: rockchip: Add Hardkernel ODROID-M2
>   arm64: dts: rockchip: Add Hardkernel ODROID-M2
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588s-odroid-m2.dts   | 903 ++++++++++++++++++
>  3 files changed, 909 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3588s-odroid-m2.dtb' for 20240901112020.3224704-1-jonas@kwiboo.se:

arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: video-codec@fdb50000: compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3588-vpu121', 'rockchip,rk3568-vpu'] is too long
	'rockchip,rk3588-vpu121' is not one of ['rockchip,rk3036-vpu', 'rockchip,rk3066-vpu', 'rockchip,rk3288-vpu', 'rockchip,rk3328-vpu', 'rockchip,rk3399-vpu', 'rockchip,px30-vpu', 'rockchip,rk3568-vpu', 'rockchip,rk3588-av1-vpu']
	'rockchip,rk3188-vpu' was expected
	'rockchip,rk3228-vpu' was expected
	'rockchip,rk3066-vpu' was expected
	'rockchip,rk3399-vpu' was expected
	from schema $id: http://devicetree.org/schemas/media/rockchip-vpu.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: /video-codec@fdb50000: failed to match any schema with compatible: ['rockchip,rk3588-vpu121', 'rockchip,rk3568-vpu']
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: /video-codec@fdba0000: failed to match any schema with compatible: ['rockchip,rk3588-vepu121']
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: /video-codec@fdba4000: failed to match any schema with compatible: ['rockchip,rk3588-vepu121']
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: /video-codec@fdba8000: failed to match any schema with compatible: ['rockchip,rk3588-vepu121']
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: /video-codec@fdbac000: failed to match any schema with compatible: ['rockchip,rk3588-vepu121']






