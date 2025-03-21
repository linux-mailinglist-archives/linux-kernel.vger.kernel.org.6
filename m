Return-Path: <linux-kernel+bounces-571498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EB5A6BDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214C13ADB78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DDC5CDF1;
	Fri, 21 Mar 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgBowR4O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2F42A94;
	Fri, 21 Mar 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569534; cv=none; b=RkFSVOqhA2iNDovGbTcTM0twBIYubo19/Y/vUa7oKZhRhH7Fi/i3eJFjnAv1MJqJHe84aH1IDsvB+zcL4E+c0DaxREAtMCNlzmsrxqvNc0DumIy52opHjlcmVKA5KtgNWCQ2wFbZEWuMfR9fHlipaL9rjZdy4YPl9tRyhycXHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569534; c=relaxed/simple;
	bh=PfOQ0FP+8YX/koHyI8Fcu+/q5N8sChby5arINuhCyWg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rJHZ0ZqzhOYZa7AqqKcfKCt1mHFVAHEb85BuJjiHS1gxz8dMj21qHneoiBrSFdsiLcrD4A1M9J3N2jSrUPvPNi3ADsmudFwIa7/kDitCW04/RWrpg5g4IUOtjOM7dTOP7b71y2MeR0nk6TSLOOIDbdoPKHsC8BFl8bsFkY5LMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgBowR4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC1BC4CEE3;
	Fri, 21 Mar 2025 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742569534;
	bh=PfOQ0FP+8YX/koHyI8Fcu+/q5N8sChby5arINuhCyWg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JgBowR4OhM3a0EdNODoa+6b93RS5XJtcSRdUZsDIuf98P1S4gTZ2AzwV/JV6PuaMB
	 BCU15njrWpKDVRGlkEPDaN+4IaovNoalpKI8l8npc64YUW3VrjSRSS8rcMZmo7RQ8n
	 Dawu3V/UjI3SQuFhbkhKxTgsVwNTrM8g6m+RoIYQmaPt/+ag/TdokexHoYY/6l9JNL
	 eukYKlLpWe/AqahYYIPMxhN4DF/uXkBNTjDemyowHEFLVroPq2VIxfrDBcRSZ96+3Z
	 03lJQRVurqiqz0orKBk/NMTsHz7SVqlRusu7AKo1dtP4Kf83VvKvWkIWpfP9gPyGIC
	 jDaSi2t4LGSfA==
Date: Fri, 21 Mar 2025 10:05:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 patrick@stwcx.xyz, krzk+dt@kernel.org, joel@jms.id.au, 
 Jason Hsu <jason-hsu@quantatw.com>, devicetree@vger.kernel.org, 
 andrew@codeconstruct.com.au, yang.chen@quantatw.com, jerry.lin@quantatw.com, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org
To: Jason Hsu <jasonhell19@gmail.com>
In-Reply-To: <20250321123731.1373596-1-jason-hsu@quantatw.com>
References: <20250321123731.1373596-1-jason-hsu@quantatw.com>
Message-Id: <174256796315.3336760.12396122805182974784.robh@kernel.org>
Subject: Re: [PATCH v5 0/2] Add Meta(Facebook) Ventura BMC(AST2600)


On Fri, 21 Mar 2025 20:37:29 +0800, Jason Hsu wrote:
> Add Linux device tree entry related to Meta(Facebook) Ventura specific
> devices connected to BMC(AST2600) SoC.
> 
> ---
> v1:
>     1. Create ventura dts file.
>     2. Add commit msg.
>     3. Use format-patch to generate patch.
>     4. Add subject prefixes matching the subsystem.
> ---
> v2:
>     1. Modify email content.
> ---
> v3:
>     1. Add mail list.
> ---
> v4:
>     1. Apply git send-email --thread option.
>     2. Sort nodes in the dts alphanumerically.
> ---
> v5:
>     1. Run scripts/checkpatch.pl and fix reported warnings.
>     2. Remove unnecessary 88E6393X CONFIG FRU.
> ---
> v6:
>     1. Add a new stage for the DTS change.
>     2. Run scripts/checkpatch.pl and fix reported error.
>     3. Fix the issue in a separate patch.
> ---
> Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
> 
> Jason Hsu (2):
>   dt-bindings: arm: aspeed: add Meta Ventura board
>   ARM: dts: aspeed: ventura: add Meta Ventura BMC
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |    1 +
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1399 +++++++++++++++++
>  3 files changed, 1401 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
> 
> 
> base-commit: b3ee1e4609512dfff642a96b34d7e5dfcdc92d05
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250321123731.1373596-1-jason-hsu@quantatw.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: bus@1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: syscon@1e6e2000: 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^silicon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/syscon@1e6e2000/interrupt-controller@560: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic0']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/syscon@1e6e2000/interrupt-controller@570: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic1']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: adc@1e6e9000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: adc@1e6e9100: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: crypto@1e6fa000: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/video@1e700000: failed to match any schema with compatible: ['aspeed,ast2600-video-engine']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: lpc@1e789000: lpc-snoop@80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: lpc@1e789000: reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@24: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@28: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@2c: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@114: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: sdc@1e740000: sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: sdc@1e740000: sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: fsi@1e79b000: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: fsi@1e79b100: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dtb: /ahb/apb/pwm-tacho-controller@1e786000: failed to match any schema with compatible: ['aspeed,ast2500-pwm-tacho']






