Return-Path: <linux-kernel+bounces-567007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6969A67FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0FA422656
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754B3211471;
	Tue, 18 Mar 2025 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH88LQLf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD70202971;
	Tue, 18 Mar 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336762; cv=none; b=lUvuhQXRAvgaRHbmEVdlv0KRKLzvOUT1g9a4wesy6XiztvoyjibYiuPUJAcvy+1hGaropZsJn4R6gR15GszZzH6poVzYnuxXS2XLVE8BnWhmigf6vzlyZO+NHNd43MJCWMpEhcwDKFsyq85hNlQVhjTojIUbaACfO+NILghZmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336762; c=relaxed/simple;
	bh=S6b5tIyxlL76u1HOEUbmL4KypMzP2/sfBQnAeEgV4RU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LlmyU66eeeiefH7AjK0BhaZTj9AEtFgVcT4CvHdGud0ZuNOpiT0jswc/PyistcolM+ojDKgXi+dJX0GmrHVz+lQZeeFi3SdkFCx6RYQBA9cqcHtza0LMJwBL/Ejtv8slLR/Mi6TaugixD+JvnBBK/mVkFCXz1d3gym9q3Au0kCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH88LQLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9641C4CEDD;
	Tue, 18 Mar 2025 22:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742336762;
	bh=S6b5tIyxlL76u1HOEUbmL4KypMzP2/sfBQnAeEgV4RU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=vH88LQLf31YVWkb5Yw4PRmYINlIm3tAWuqJCgXRhA4sbkwSx9IHurH2qbOT3s5+jH
	 ZHjb6d1VzDNf5fiEgUk2x/tBaCP6KNvvCJV2PMpmpLYNC3uDzvVqECJ+JYuvKHN3Tp
	 /wdeGE2L93vnrUZlqqV3sqkdgM9o5QLyTWqIajdjELmK3/KipC0Trx0af8rwRiMutb
	 TKF2mNWygZfYbcQhhsbHyz1FZZNYhDOH5o7B4+bi0Uk7X4mHp5Ld914n9Yu/w3GFQ5
	 8sWJ8emRGJK18PpMXTc0GWuM6hAbHKACNjWhH36X1dM2GfrDi3RWtLipoMtUbCa4s1
	 EInLireOG+/dw==
Date: Tue, 18 Mar 2025 17:26:00 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh+dt@kernel.org, 
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, jothayot@amd.com, 
 linux-aspeed@lists.ozlabs.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org
To: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
In-Reply-To: <20250318174730.1921983-1-Rajaganesh.Rathinasabapathi@amd.com>
References: <20250318174730.1921983-1-Rajaganesh.Rathinasabapathi@amd.com>
Message-Id: <174233663954.4094319.18412685456723022993.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: aspeed: Add AMD Onyx BMC
 compatible


On Tue, 18 Mar 2025 12:47:29 -0500, Rajaganesh Rathinasabapathi wrote:
> Document new AMD Onyx BMC board compatibles
> 
> Signed-off-by: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250318174730.1921983-1-Rajaganesh.Rathinasabapathi@amd.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: bus@1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: syscon@1e6e2000: 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^silicon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/apb@1e6e0000/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/apb@1e6e0000/syscon@1e6e2000/interrupt-controller@560: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic0']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/apb@1e6e0000/syscon@1e6e2000/interrupt-controller@570: failed to match any schema with compatible: ['aspeed,ast2600-scu-ic1']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/apb@1e6e0000/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: adc@1e6e9000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: adc@1e6e9100: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: crypto@1e6fa000: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: sdc@1e740000: sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: sdc@1e740000: sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/apb@1e780000/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: lpc@1e789000: lpc-snoop@80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: lpc@1e789000: reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: kcs@24: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: kcs@28: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: kcs@2c: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: kcs@114: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/apb@1e780000/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/apb@1e780000/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: mbeeprom@50: $nodename:0: 'mbeeprom@50' does not match '^eeprom@[0-9a-f]{1,2}$'
	from schema $id: http://devicetree.org/schemas/eeprom/at24.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: mbeeprom@50: Unevaluated properties are not allowed ('$nodename' was unexpected)
	from schema $id: http://devicetree.org/schemas/eeprom/at24.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: fsi@1e79b000: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/apb@1e790000/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: fsi@1e79b100: compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/apb@1e790000/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: /ahb/apb@1e790000/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-nf5280m6.dtb: /ahb/apb@1e6e0000/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']






