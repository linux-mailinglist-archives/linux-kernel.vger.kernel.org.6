Return-Path: <linux-kernel+bounces-524743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2DBA3E690
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783554203AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BBF2641F8;
	Thu, 20 Feb 2025 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCX2WI1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF57A1E9B07;
	Thu, 20 Feb 2025 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086954; cv=none; b=TabluOfGSwn34Ufbr95iEPRxecBw8bpbpxoi8QoQ+BLtKL8z4pR3o0oc0fdakEvgd9iL92Xg27llfXWyOBoH4xXW4tsAmJWEroQInI1PcKFcsGcyDfg651fX6bT7j/+JqvM+kQOKY9HuGj1x3Brgxm0WDtRnyo6jcfAp1Oy44ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086954; c=relaxed/simple;
	bh=1LzKD5qoGe+7J8FFy17/aBvXUPhvRt/+7kn4AUDJuIM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=OO1fC0iFU6bZQOfL9ybj3z08SCpewvFbj2Dh2LKsPgGtGjlVMcOYS5lHpQUCXJX2u7Pf7nPs3Q1rV2hnYM475+OrH56DKX/dshV0p4wotqSDjlYn3jIZYqnvC9bbUv22jvxbnU/TCjybsWUVGtY9mgkbY9t9IpCrgAt1LfQiSME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCX2WI1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AACC4CED1;
	Thu, 20 Feb 2025 21:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740086954;
	bh=1LzKD5qoGe+7J8FFy17/aBvXUPhvRt/+7kn4AUDJuIM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=fCX2WI1i8AW9OzSVUbY5oRDLpRA2Ul+aEzQn5vYT2AOMYD2L+5MctGRlUjLajx0za
	 dWMpjk2BgFJrLMOoj/x3XaemFUiH7XCyAaIUQkvrk78y7b5bdwlRibGLW+U0mtRCUk
	 b7KT7uhEGIBcQv6pV7e3pirjhVkv83X8Iz2YDQW0mRyIPP+WujfckGyfDwM3ViOgte
	 QRZuqW7V0iPtmEnn0JJK5oaG0uQgysCuK0f/9iUyJYj6HBw4Q6UF5ndrz/b1ITVy46
	 4/ZaJli7EiAZ52K6T0mo+Zw3N0LrOi3GrUexY9DQ/pUa43wfGWVbGGPAL4Zw11M4cw
	 IFW3Hfoj2rNuA==
Date: Thu, 20 Feb 2025 15:29:12 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: catalin.marinas@arm.com, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com, 
 conor+dt@kernel.org, will@kernel.org, linux-arm-kernel@lists.infradead.org, 
 arnd@arndb.de
To: Peter Chen <peter.chen@cixtech.com>
In-Reply-To: <20250220084020.628704-1-peter.chen@cixtech.com>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
Message-Id: <174008661558.4046640.6970051965598213885.robh@kernel.org>
Subject: Re: [PATCH 0/6] arm64: Introduce CIX P1 (SKY1) SoC


On Thu, 20 Feb 2025 16:40:14 +0800, Peter Chen wrote:
> Cixtech P1 (internal name sky1) is high performance generic Armv9 SoC.
> Orion O6 is the world's first open source Arm V9 Motherboard built by
> Radxa. You could find brief introduction for SoC and related boards at:
> https://radxa.com/products/orion/o6#overview
> 
> In this series, we add initial SoC and board support for Kernel building.
> Patch 1-2: Add dt-binding doc for CIX and its sky1 SoC
> Patch 3: add related maintainter entry
> Patch 4-5: add Arm64 build support
> Patch 6: add initial dts support for SoC and Orion O6 board
> 
> To run upstream kernel at Orion O6 board, you need to use BIOS
> released by Radxa:
> https://docs.radxa.com/en/orion/o6/bios/install-bios
> 
> Fugang Duan (1):
>   arm64: Kconfig: add ARCH_CIX for cix silicons
> 
> Peter Chen (5):
>   dt-bindings: arm: add CIX P1 (SKY1) SoC
>   dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
>   MAINTAINERS: Add CIX SoC maintainer entry
>   arm64: defconfig: Enable CIX SoC
>   arm64: dts: cix: add initial CIX P1(SKY1) dts support
> 
>  .../devicetree/bindings/arm/cix.yaml          |  26 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   8 +
>  arch/arm64/Kconfig.platforms                  |   6 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/cix/Makefile              |   2 +
>  arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  21 ++
>  arch/arm64/boot/dts/cix/sky1.dtsi             | 264 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  9 files changed, 331 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cix.yaml
>  create mode 100644 arch/arm64/boot/dts/cix/Makefile
>  create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>  create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi
> 
> --
> 2.25.1
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/cix/' for 20250220084020.628704-1-peter.chen@cixtech.com:

redistributor-stride: size (4) error for type uint64
arch/arm64/boot/dts/cix/sky1-orion-o6.dtb: /: compatible: ['radxa,orion-o6'] is too short
	from schema $id: http://devicetree.org/schemas/arm/cix.yaml#
arch/arm64/boot/dts/cix/sky1-orion-o6.dtb: /: memory@80000000: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/memory.yaml#
arch/arm64/boot/dts/cix/sky1-orion-o6.dtb: soc@0: uart@040d0000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm64/boot/dts/cix/sky1-orion-o6.dtb: uart@040d0000: $nodename:0: 'uart@040d0000' does not match '^serial(@.*)?$'
	from schema $id: http://devicetree.org/schemas/serial/pl011.yaml#
arch/arm64/boot/dts/cix/sky1-orion-o6.dtb: interrupt-controller@0e001000: redistributor-stride: 262144 is not a 'uint64'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/arm,gic-v3.yaml#
arch/arm64/boot/dts/cix/sky1-orion-o6.dtb: interrupt-controller@0e001000: 'its@e050000' does not match any of the regexes: '^(msi-controller|gic-its|interrupt-controller)@[0-9a-f]+$', '^gic-its@', '^interrupt-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/arm,gic-v3.yaml#






