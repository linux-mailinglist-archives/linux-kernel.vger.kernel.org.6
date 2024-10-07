Return-Path: <linux-kernel+bounces-354027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3BA993681
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C604328445D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE7B1DE4EA;
	Mon,  7 Oct 2024 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMH/HDop"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A91DE4CD;
	Mon,  7 Oct 2024 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326680; cv=none; b=uh7p03OESagHpNdHSNHHgvOdQ4I7BWtjbmq0nJK+nqtxHHKlP/n86O7ixVHkqhx87m/3tJu+1xqZSwb+jCVfZBdpWr3VxWGWnCRW2TTH3YK8k0tmYwAJQBJD4zTbeJFca/B4oto68c+8Sh3Cezh5U9aLCAiWZiVL7Z6qXXEkKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326680; c=relaxed/simple;
	bh=jwWsg3YU4v0xlSLimuaOjcdP919QDUDeP73jZC/1+V0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=MLny5UFTQNuJIDuYm9SefQqX9x60J3I1uFHoEew0k6/N7n/0GwN9+Aq1Umsc6vTJkMQglsvDQ++jPy/WOXnUB+ubDvq2h1CKloOFknKvLn3s/TqNf5fRf8SeA+k/YRKHhJvRYstDYRGgm5/ZWBz3Nr2GdaBBU1Om3RvItllBsY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMH/HDop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6C6C4CED5;
	Mon,  7 Oct 2024 18:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728326680;
	bh=jwWsg3YU4v0xlSLimuaOjcdP919QDUDeP73jZC/1+V0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kMH/HDopUzwSiX1HmTuk4WTVp0/56i7J1In+bBrrLMywdizCyaNbdcawlNjaFEwUt
	 xRlEX5NV5ozNcL1VaEygLqpOP88Q6yj0CojQ7PbiCRrv46ainzzUn27mo0XWNjBzaX
	 tYfu0vKs5xB84jfM57HD3BUA5BrlFkSD0jAmX4EaHxNgTn45CTCze37GXqZgbYxB3c
	 kMwp82C/zK0xcxMd8Nj8u2Z3Ne8y1smJOT0zxxVsFHLNiD/LnPSseahmwhE8lAGRDG
	 9ZleFxMG76Vr9LcHJ19P4qrSXwyK0KNMAWY5TQGD8z3LQCBuLTjzeAAQviR52XWjC3
	 JdBJbbPZIkhfw==
Date: Mon, 07 Oct 2024 13:44:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de
In-Reply-To: <cfc3cfe1-086b-48f1-9b89-f17c9391d3cc@gmail.com>
References: <cfc3cfe1-086b-48f1-9b89-f17c9391d3cc@gmail.com>
Message-Id: <172832633132.2107701.18114963160370409205.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] ARM: dts: rockchip: fix nodename regulators


On Sat, 05 Oct 2024 22:39:05 +0200, Johan Jonker wrote:
> The nodename for fixed-regulators has changed to
> pattern: '^regulator(-[0-9]+v[0-9]+|-[0-9a-z-]+)?$'
> 
> Fix all Rockchip DT regulator nodenames.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> regulator: dt-bindings: fixed-regulator: Add a preferred node name
> https://lore.kernel.org/r/20240426215147.3138211-1-robh@kernel.org
> 
> Some rk3288-veyron regulators are skipped for now.
> ---
>  arch/arm/boot/dts/rockchip/rk3036-kylin.dts   |  2 +-
>  .../boot/dts/rockchip/rk3066a-bqcurie2.dts    |  4 +--
>  .../boot/dts/rockchip/rk3066a-marsboard.dts   |  6 ++--
>  arch/arm/boot/dts/rockchip/rk3066a-mk808.dts  | 12 ++++----
>  .../boot/dts/rockchip/rk3066a-rayeager.dts    | 16 +++++------
>  arch/arm/boot/dts/rockchip/rk3128-evb.dts     |  4 +--
>  .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts | 28 +++++++++----------
>  .../boot/dts/rockchip/rk3188-bqedison2qc.dts  | 14 +++++-----
>  arch/arm/boot/dts/rockchip/rk3188-px3-evb.dts |  2 +-
>  .../boot/dts/rockchip/rk3188-radxarock.dts    |  8 +++---
>  arch/arm/boot/dts/rockchip/rk3228-evb.dts     |  2 +-
>  arch/arm/boot/dts/rockchip/rk3229-evb.dts     | 16 +++++------
>  arch/arm/boot/dts/rockchip/rk3229-xms6.dts    | 16 +++++------
>  .../boot/dts/rockchip/rk3288-evb-act8846.dts  |  4 +--
>  arch/arm/boot/dts/rockchip/rk3288-evb.dtsi    |  8 +++---
>  .../rockchip/rk3288-firefly-reload-core.dtsi  |  2 +-
>  .../dts/rockchip/rk3288-firefly-reload.dts    | 18 ++++++------
>  .../arm/boot/dts/rockchip/rk3288-firefly.dtsi | 16 +++++------
>  arch/arm/boot/dts/rockchip/rk3288-miqi.dts    |  8 +++---
>  .../boot/dts/rockchip/rk3288-phycore-rdk.dts  |  6 ++--
>  .../boot/dts/rockchip/rk3288-phycore-som.dtsi |  6 ++--
>  .../arm/boot/dts/rockchip/rk3288-popmetal.dts | 10 +++----
>  arch/arm/boot/dts/rockchip/rk3288-r89.dts     |  8 +++---
>  .../boot/dts/rockchip/rk3288-rock2-som.dtsi   |  4 +--
>  .../boot/dts/rockchip/rk3288-rock2-square.dts |  6 ++--
>  arch/arm/boot/dts/rockchip/rk3288-tinker.dtsi |  4 +--
>  .../boot/dts/rockchip/rk3288-veyron-brain.dts |  6 ++--
>  .../rockchip/rk3288-veyron-chromebook.dtsi    | 10 +++----
>  .../dts/rockchip/rk3288-veyron-fievel.dts     | 10 +++----
>  .../dts/rockchip/rk3288-veyron-mickey.dts     |  4 +--
>  arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi |  8 +++---
>  .../boot/dts/rockchip/rk3288-vmarc-som.dtsi   |  2 +-
>  arch/arm/boot/dts/rockchip/rk3288-vyasa.dts   | 18 ++++++------
>  .../rockchip-radxa-dalang-carrier.dtsi        |  8 +++---
>  .../arm/boot/dts/rockchip/rv1108-elgin-r1.dts |  2 +-
>  arch/arm/boot/dts/rockchip/rv1108-evb.dts     |  2 +-
>  .../dts/rockchip/rv1126-edgeble-neu2-io.dts   |  6 ++--
>  .../dts/rockchip/rv1126-edgeble-neu2.dtsi     |  2 +-
>  38 files changed, 154 insertions(+), 154 deletions(-)
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3036-kylin.dtb rockchip/rk3066a-bqcurie2.dtb rockchip/rk3066a-marsboard.dtb rockchip/rk3066a-mk808.dtb rockchip/rk3066a-rayeager.dtb rockchip/rk3128-evb.dtb rockchip/rk3128-xpi-3128.dtb rockchip/rk3188-bqedison2qc.dtb rockchip/rk3188-px3-evb.dtb rockchip/rk3188-radxarock.dtb rockchip/rk3228-evb.dtb rockchip/rk3229-evb.dtb rockchip/rk3229-xms6.dtb rockchip/rk3288-evb-act8846.dtb rockchip/rk3288-firefly-reload.dtb rockchip/rk3288-miqi.dtb rockchip/rk3288-phycore-rdk.dtb rockchip/rk3288-popmetal.dtb rockchip/rk3288-r89.dtb rockchip/rk3288-rock2-square.dtb rockchip/rk3288-veyron-brain.dtb rockchip/rk3288-veyron-fievel.dtb rockchip/rk3288-veyron-mickey.dtb rockchip/rk3288-vyasa.dtb rockchip/rv1108-elgin-r1.dtb rockchip/rv1108-evb.dtb rockchip/rv1126-edgeble-neu2-io.dtb rockchip/px30-evb.dtb rockchip/px30-firefly-jd4-core-mb.dtb rockchip/px30-ringneck-haikou.dtb rockchip/rk3308-evb.dtb rockchip/rk3308-roc-cc.dtb rockchip/rk3308-rock-pi-s.d
 tb rockchip/rk3318-a95x-z2.dtb rockchip/rk3326-gameforce-chi.dtb rockchip/rk3328-a1.dtb rockchip/rk3328-evb.dtb rockchip/rk3328-nanopi-r2s.dtb rockchip/rk3328-orangepi-r1-plus.dtb rockchip/rk3328-roc-cc.dtb rockchip/rk3328-rock-pi-e.dtb rockchip/rk3328-rock64.dtb rockchip/rk3368-geekbox.dtb rockchip/rk3368-lba3368.dtb rockchip/rk3368-lion-haikou.dtb rockchip/rk3368-orion-r68-meta.dtb rockchip/rk3368-px5-evb.dtb rockchip/rk3368-r88.dtb rockchip/rk3399-eaidk-610.dtb rockchip/rk3399-evb.dtb rockchip/rk3399-firefly.dtb rockchip/rk3399-gru-kevin.dtb rockchip/rk3399-hugsun-x99.dtb rockchip/rk3399-kobol-helios64.dtb rockchip/rk3399-leez-p710.dtb rockchip/rk3399-nanopc-t4.dtb rockchip/rk3399-nanopi-m4.dtb rockchip/rk3399-nanopi-neo4.dtb rockchip/rk3399-nanopi-r4s.dtb rockchip/rk3399-orangepi.dtb rockchip/rk3399-pinebook-pro.dtb rockchip/rk3399-pinephone-pro.dtb rockchip/rk3399-puma-haikou.dtb rockchip/rk3399-roc-pc-mezzanine.dtb rockchip/rk3399-roc-pc-plus.dtb rockchip/rk3399-rock-4c-plus.d
 tb rockchip/rk3566-lubancat-1.dtb rockchip/rk3566-quartz64-a.dtb rockchip/rk3566-quartz64-b.dtb rockchip/rk3566-radxa-cm3-io.dtb rockchip/rk3566-roc-pc.dtb rockchip/rk3566-rock-3c.dtb rockchip/rk3566-soquartz-blade.dtb rockchip/rk3566-soquartz-cm4.dtb rockchip/rk3566-soquartz-model-a.dtb rockchip/rk3568-bpi-r2-pro.dtb rockchip/rk3568-evb1-v10.dtb rockchip/rk3568-lubancat-2.dtb rockchip/rk3568-odroid-m1.dtb rockchip/rk3568-radxa-e25.dtb rockchip/rk3568-roc-pc.dtb rockchip/rk3568-rock-3a.dtb rockchip/rk3568-wolfvision-pf5.dtb rockchip/rk3588-armsom-sige7.dtb rockchip/rk3588-armsom-w3.dtb rockchip/rk3588-coolpi-cm5-evb.dtb rockchip/rk3588-coolpi-cm5-genbook.dtb rockchip/rk3588-evb1-v10.dtb rockchip/rk3588-jaguar.dtb rockchip/rk3588-nanopc-t6-lts.dtb rockchip/rk3588-nanopc-t6.dtb rockchip/rk3588-ok3588-c.dtb rockchip/rk3588-orangepi-5-plus.dtb rockchip/rk3588-quartzpro64.dtb rockchip/rk3588-rock-5b.dtb rockchip/rk3588-tiger-haikou.dtb rockchip/rk3588-toybrick-x0.dtb rockchip/rk3588s-coo
 lpi-4b.dtb rockchip/rk3588s-gameforce-ace.dtb rockchip/rk3588s-indiedroid-nova.dtb rockchip/rk3588s-khadas-edge2.dtb rockchip/rk3588s-nanopi-r6s.dtb rockchip/rk3588s-orangepi-5.dtb rockchip/rk3588s-rock-5a.dtb' for cfc3cfe1-086b-48f1-9b89-f17c9391d3cc@gmail.com:

arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: regulator-vcc1v8-lcd: 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: regulator-vcc2v8-lcd: 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtb: regulator-vcc-3v3-sd-s0: Unevaluated properties are not allowed ('enable-active-low' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/fixed-regulator.yaml#






