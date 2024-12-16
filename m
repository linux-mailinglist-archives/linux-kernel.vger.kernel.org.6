Return-Path: <linux-kernel+bounces-447692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D959F360A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986AE16646F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EA11FF7D4;
	Mon, 16 Dec 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Roi7m7tT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11C1885A5;
	Mon, 16 Dec 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366559; cv=none; b=PP1eZe+oBAVT5hh7aVr9Gia3P7878GDMXNf40edjK6hVP/wpf4eDxJEU2xoIR/o16GhAc3861vQ3H35W9WoFXGEuyTL6JDs90tW4dvq0w41YrwIFIFHK9USlxPqGET1PBZTFXa2wwLvbClJVyC2pMzM7SiIVMayUNJn82FYxSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366559; c=relaxed/simple;
	bh=eTH5PAJYArUjyYFUhkavXr9IHbyJp0cHmZVtDEdnjTA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=G9vQ0uIVuMAa0Mex9dfbX87N0oIHitOwO61xb6Gzhv7hL3arywbi5zSbeBL2akj6NMjGoQXuMfKxR8MLEAY08vmvMBxFCkwcFhnABz1mGSMGqd/3FfV8IdGz66I/KUTNSwiUfSW7USMLL0LWug3elMsb3zrDpdmc0T6/m72vEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Roi7m7tT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76040C4CED0;
	Mon, 16 Dec 2024 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366558;
	bh=eTH5PAJYArUjyYFUhkavXr9IHbyJp0cHmZVtDEdnjTA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Roi7m7tTvG8r+dOMRufBtBzf5LMU1seuLVmkSmHbU3rEmITSOGpJPXpjrhRr6X/Hw
	 HjJNiLkX/IW0bMxbpw8I7wXh2MYhrvMJhlBy9D5p7t7HDayiUqPKsRawGDGMovBNlS
	 avFCa7hVK+M+YD265Uh72h9hwn8tGEtfrsQuVmO6n24edW5BlwsRWomv+RYm5062dz
	 ITYKSdLGCLsY/0nuuRu3xeW+So58/l4eeCXi4FPGK0wtN10XmDGoDR4YfAIyqSobCa
	 EKeJEo+JrYhxJiit9foSGLVBy/GqYkyGTePRQtBGUgGQvaGbbHcSryDpo13zLU/db7
	 8vatbl3MVjO4w==
Date: Mon, 16 Dec 2024 10:29:15 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: andrew@codeconstruct.com.au, linux-arm-kernel@lists.infradead.org, 
 krzk+dt@kernel.org, eajames@linux.ibm.com, joel@jms.id.au, 
 devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20241213145037.3784931-1-ninad@linux.ibm.com>
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
Message-Id: <173436597537.264948.12611164276777551472.robh@kernel.org>
Subject: Re: [PATCH v1 0/8] DTS updates for system1 BMC


On Fri, 13 Dec 2024 08:50:26 -0600, Ninad Palsule wrote:
> Hello
> 
> Please review the patch set. It has various device tree changes for
> system1 BMC after hardware testing.
> 
> NINAD PALSULE (7):
>   ARM: dts: aspeed: system1: Add IPMB device
>   ARM: dts: aspeed: system1: Add GPIO line name
>   ARM: dts: aspeed: system1: Add RGMII support
>   ARM: dts: aspeed: system1: Reduce sgpio speed
>   ARM: dts: aspeed: system1: Update LED gpio name
>   ARM: dts: aspeed: system1: Remove VRs max8952
>   ARM: dts: aspeed: system1: Mark GPIO line high/low
> 
> Ninad Palsule (1):
>   ARM: dts: aspeed: system1: Disable gpio pull down
> 
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 178 ++++++++++++------
>  1 file changed, 119 insertions(+), 59 deletions(-)
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20241213145037.3784931-1-ninad@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: ethernet@1e660000: phy-mode:0: 'rgmii-rxid' is not one of ['rgmii', 'rmii']
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'fan_controller_reset', 'isolate_errs_cpu1', 'rtc_reset', 'srtc_reset' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: rtc_reset: $nodename:0: 'rtc_reset' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: srtc_reset: $nodename:0: 'srtc_reset' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: fan_controller_reset: $nodename:0: 'fan_controller_reset' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: isolate_errs_cpu1: $nodename:0: 'isolate_errs_cpu1' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb@1e780000/bus@1e78a000/i2c@280/bmc_slave@10: failed to match any schema with compatible: ['ipmb-dev']






