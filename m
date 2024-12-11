Return-Path: <linux-kernel+bounces-441594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF529ED07E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF9E1881F39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6C41DACB1;
	Wed, 11 Dec 2024 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD4w8jRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD11DA116;
	Wed, 11 Dec 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932485; cv=none; b=ukkQipPxLwUvBQ8CD+N3HYSpStgmt6GR2uUboFjtUBmgmyQim7xmhZ7Csxt4ccF7olGb245NyaCtGSacOD09ItbWhrUa5SPg7Vrt2NFr0+7YSp5HULYWvUGcEMOGRVOarfRUsWp/pLy04+bsWnr7lHOOpB4PTpiJyPyRClGAjS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932485; c=relaxed/simple;
	bh=fAtpFU5o1h8YJcA6IRudumE4PM0E6ftZoO/iy29wxhs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mF3JaZkZuluhWg1lJ9iY6JqDS0sN5vH8Z7O4jHjEU1xWBio+JmdxAG6oas8fKONDOA3OeCQVoJLOG1RLmu92dOcXemJzP1Zzg24XMm9B6DKO88o3MA3Vu1XJ81/ZbUYqMuwTKFEZ+xkvvoyDvfWlzCc6PR7jFSfvoWcSFNFZsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD4w8jRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A3CC4CED4;
	Wed, 11 Dec 2024 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733932485;
	bh=fAtpFU5o1h8YJcA6IRudumE4PM0E6ftZoO/iy29wxhs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aD4w8jRIi5OxX3I7JaG5HNrTi7cZ86UlXSCIeMWi56us7kfrgQXGR21qKlLLZlN8B
	 BaF4Fv+I9qAMl9qycu8PLBXFwR/ViNMo0jC3v7pVPQMVFgR4m5p2qMn0XgsVN1hhCg
	 dox1hXfIBlE/djXlGOVaPrmO8xKNUvn/+BeMUOvBkiee9zI3VPYzfac/37iZy2ki92
	 XnA90BNTCDLMNcd7nL7c/tBw/corbCM1wO6ILKR8P9+Gli48mDcNzN7r7+saycF4tT
	 BQuks1MCZ+PfFYxQJCDSlr6jNy754ivvaaBD7yUQuue6Ma/uuXZV5be0YiOg07rSid
	 5z9lf23U/zbxg==
Date: Wed, 11 Dec 2024 09:54:43 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
 michal.simek@xilinx.com, monstr@monstr.eu, git@xilinx.com
To: Michal Simek <michal.simek@amd.com>
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Message-Id: <173393224728.3091150.11085112233542602601.robh@kernel.org>
Subject: Re: [PATCH 00/15] ARM: zynq: Sync DTs with U-Boot


On Wed, 11 Dec 2024 13:41:19 +0100, Michal Simek wrote:
> Hi,
> 
> over years there were some changes pushed to U-Boot which were never merged
> back to Linux. U-Boot introduced new option OF_UPSTREAM and start to sync
> up DTs from Linux back to U-Boot.
> This series is addressing differences.
> There are still 3 more differences but they should be addressed separately.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (14):
>   ARM: zynq: Remove deprecated device_type property
>   ARM: zynq: DT: List OCM memory for all platforms
>   ARM: zynq: Mark boot-phase-specific device nodes
>   ARM: zynq: Do not define address/size-cells for nand-controller
>   ARM: zynq: Wire smcc with nand/nor memories on zc770 platform
>   ARM: zynq: Add ethernet phy reset information to DT(zc702)
>   ARM: zynq: Define u-boot bootscrip addr via DT
>   ARM: zynq: Point via nvmem0 alias to eeprom on zc702/zc706
>   ARM: zynq: Define rtc alias on zc702/zc706
>   ARM: zynq: Rename i2c?-gpio to i2c?-gpio-grp
>   ARM: zynq: Fix fpga region DT nodes name
>   ARM: zynq: Enable QSPIs on platforms
>   ARM: zynq: Add sdhci to alias node
>   ARM: zynq: Remove ethernet0 alias from Microzed
> 
> Sai Krishna Potthuri (1):
>   ARM: zynq: Replace 'io-standard' with 'power-source' property
> 
>  arch/arm/boot/dts/xilinx/zynq-7000.dtsi       | 33 ++++++-
>  arch/arm/boot/dts/xilinx/zynq-cc108.dts       | 41 ++++++++-
>  arch/arm/boot/dts/xilinx/zynq-microzed.dts    | 10 ++-
>  arch/arm/boot/dts/xilinx/zynq-parallella.dts  |  1 -
>  arch/arm/boot/dts/xilinx/zynq-zc702.dts       | 87 +++++++++++++------
>  arch/arm/boot/dts/xilinx/zynq-zc706.dts       | 67 +++++++++++---
>  arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts | 39 ++++++++-
>  arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts | 31 +++++++
>  arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts | 35 ++++++++
>  arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts | 41 ++++++++-
>  arch/arm/boot/dts/xilinx/zynq-zed.dts         | 43 ++++++++-
>  .../boot/dts/xilinx/zynq-zturn-common.dtsi    |  8 ++
>  arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts     | 10 ++-
>  arch/arm/boot/dts/xilinx/zynq-zybo.dts        |  9 +-
>  14 files changed, 404 insertions(+), 51 deletions(-)
> 
> --
> 2.43.0
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


New warnings running 'make CHECK_DTBS=y xilinx/zynq-cc108.dtb xilinx/zynq-microzed.dtb xilinx/zynq-parallella.dtb xilinx/zynq-zc702.dtb xilinx/zynq-zc706.dtb xilinx/zynq-zc770-xm010.dtb xilinx/zynq-zc770-xm011.dtb xilinx/zynq-zc770-xm012.dtb xilinx/zynq-zc770-xm013.dtb xilinx/zynq-zed.dtb xilinx/zynq-zybo-z7.dtb xilinx/zynq-zybo.dtb' for cover.1733920873.git.michal.simek@amd.com:

arch/arm/boot/dts/xilinx/zynq-parallella.dtb: ethernet@e000b000: ethernet-phy@0: Unevaluated properties are not allowed ('marvell,reg-init' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/cdns,macb.yaml#
arch/arm/boot/dts/xilinx/zynq-zc702.dtb: ethernet@e000b000: Unevaluated properties are not allowed ('phy-reset-active-low', 'phy-reset-gpio' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/cdns,macb.yaml#






