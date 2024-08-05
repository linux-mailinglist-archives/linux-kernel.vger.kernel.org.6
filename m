Return-Path: <linux-kernel+bounces-274849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969D2947D89
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B7B1C22093
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5863C15A4AF;
	Mon,  5 Aug 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONJ3ZGMy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9F165EFC;
	Mon,  5 Aug 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870021; cv=none; b=Bi5K2Q1tQPmLjzfKxJ1ZJym5VKj9Dy3G31zg1GUTToL+aE1yfQpHy/j8B22PSwXBLsLeTCfBGLVIyFH9f9q6icI89zevYs2Y34joR7PD+oWPlHcit/MkpGDZwEzUCymrch8dSsUGO9kGvURxyCVoXHdQmX/dDXLq1l3beesN7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870021; c=relaxed/simple;
	bh=PhfSQRf8H3TZsTuSausNtAMCdFdfAUdGXhQsaVMss3k=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=t4Jzf9I1A3Gqhh7fuN9Te6fO+z1BeiHlRX//i9YMMvgQJj1sHPteXhuXY7BiOz87UbXn22TgauV67mjEfrg0sl4Z3ifM5Pong6fntiXyu/AwXyisNyCHXyIaytRbI4KzC5/buObreeKnCdjvi4m4Dv7Uwbmz3Fx1JXL4BTf//2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONJ3ZGMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AF9C32782;
	Mon,  5 Aug 2024 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722870021;
	bh=PhfSQRf8H3TZsTuSausNtAMCdFdfAUdGXhQsaVMss3k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ONJ3ZGMyIZTwR7klAdXog2LgL2kzs8+wfeg3Nm7n7ZE32il1vUlHr32s4HWQMrSrN
	 bDQm5Soddk3DhTym56fzXeNrLvBiCvtSCN17yMH0f2i/PU6N12ZanYhRJW1i0IFWa0
	 vDMUmNhnrkBCitVrpOjcoJRRtToS/YCf14R/VCSfwg+xoMd8PG1OTb5p6+kvA+KKYg
	 FarSAYLArA9BaqXj/MBNIGSq4qWsvis5VqETlWM0+5Tfe7ybLOQpS5eetl/53cauVD
	 pQYfe90DAWVkmx+ZKr/9ipKvfqAUHYkOnJtwWTKZiLpPJtOkLErXGvLewh091naxOv
	 Fjfdx8BJFhi8A==
Date: Mon, 05 Aug 2024 09:00:20 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
In-Reply-To: <cover.1722842066.git.stano.jakubek@gmail.com>
References: <cover.1722842066.git.stano.jakubek@gmail.com>
Message-Id: <172286967300.2710789.8114229281680847298.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Cleanup Spreadtum/Unisoc ARM64 DT


On Mon, 05 Aug 2024 09:23:25 +0200, Stanislav Jakubek wrote:
> This series contains various minor cleanups for Spreadtum/Unisoc ARM64
> DeviceTrees. Also contains the 2nd patch from the SC2731 MFD cleanup series
> to reduce unnecessary noise and make these easier to apply.
> 
> Changes in V2:
>   - add 2nd patch from the SC2731 MFD cleanup series (1st patch was dropped
>     due to not being correct, dt-bindings will have to get fixed up instead)
>   - add Baolin's R-b
>   - rebase on next-20240805
> 
> Link to original V1: https://lore.kernel.org/lkml/cover.1720112081.git.stano.jakubek@gmail.com/
> Link to SC2731 MFD cleanup V1: https://lore.kernel.org/lkml/cover.1720957783.git.stano.jakubek@gmail.com/
> 
> Stanislav Jakubek (4):
>   arm64: dts: sprd: rename SDHCI nodes to mmc
>   arm64: dts: sprd: reorder clock-names after clocks
>   arm64: dts: sprd: move/add SPDX license to top of the file
>   arm64: dts: sprd: sc2731: rename fuel gauge node to be generic
> 
>  arch/arm64/boot/dts/sprd/sc2731.dtsi          |  5 +--
>  arch/arm64/boot/dts/sprd/sc9836-openphone.dts |  3 +-
>  arch/arm64/boot/dts/sprd/sc9836.dtsi          |  3 +-
>  arch/arm64/boot/dts/sprd/sc9860.dtsi          |  3 +-
>  arch/arm64/boot/dts/sprd/sc9863a.dtsi         |  8 ++--
>  arch/arm64/boot/dts/sprd/sharkl64.dtsi        |  3 +-
>  arch/arm64/boot/dts/sprd/sp9860g-1h10.dts     |  3 +-
>  arch/arm64/boot/dts/sprd/ums512.dtsi          |  4 +-
>  arch/arm64/boot/dts/sprd/whale2.dtsi          | 43 ++++++++++---------
>  9 files changed, 36 insertions(+), 39 deletions(-)
> 
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y sprd/sc9836-openphone.dtb sprd/sp9860g-1h10.dtb' for cover.1722842066.git.stano.jakubek@gmail.com:

arch/arm64/boot/dts/sprd/sp9860g-1h10.dtb: fuel-gauge@a00: 'battery-detect-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#
arch/arm64/boot/dts/sprd/sp9860g-1h10.dtb: fuel-gauge@a00: 'sprd,calib-resistance-micro-ohms' is a required property
	from schema $id: http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#
arch/arm64/boot/dts/sprd/sp9860g-1h10.dtb: fuel-gauge@a00: 'bat-detect-gpio', 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#






