Return-Path: <linux-kernel+bounces-526472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10801A3FF19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9005616FBF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A64B2512F6;
	Fri, 21 Feb 2025 18:54:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B7E1F2C56;
	Fri, 21 Feb 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164080; cv=none; b=RJyaEmVp4uVhOsnwF8vj9wgb+27lFXhEj9DI5afAPA1ZAO4c0eyY7LF7FKpJYZ0ldqkxw7yMgr9aqw3sn+KIPsBbofx/K/VXAW1K2gmz4nEpdYK5bdkh4mXf2BPDho7w6lLHrQzaAZZlUMTCwK8D8vZzLZFI9o5SycduwhfrMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164080; c=relaxed/simple;
	bh=f2mi2I+2wPOqTdmUO0+fO2T6ZsFuHE9rwHsdJ8BVwyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7/K6X9+LbHmHG99ba3x31FcsQ9XCu7TsmK2FEWdh5SDCoUbe5GADrN6Xi7/t4mVl2i9pkZytak2GdFruk4NS4cn9VdoloryJaAcRDfvtD1h8sacLdunXO690FAGz1nhoA59W2TFxmAM2RGeBPFLi4GXQnB5+XTnpzjtjsWRT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CE6E169C;
	Fri, 21 Feb 2025 10:54:55 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D780E3F59E;
	Fri, 21 Feb 2025 10:54:35 -0800 (PST)
Date: Fri, 21 Feb 2025 18:54:31 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v7 00/10] arm64: dts: Add Arm Morello support
Message-ID: <Z7jL5wBUJNjOlg4r@J2N7QTR9R3.cambridge.arm.com>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221180349.1413089-1-vincenzo.frascino@arm.com>

Hi Vincenzo,

On Fri, Feb 21, 2025 at 06:03:39PM +0000, Vincenzo Frascino wrote:
> The Morello architecture is an experimental extension to Armv8.2-A,
> which extends the AArch64 state with the principles proposed in
> version 7 of the Capability Hardware Enhanced RISC Instructions
> (CHERI) ISA [1].

None of the CHERI stuff is supported upstream, so from upstream's PoV
this is a low-volume dev-board/SoC with an experimental ARMv8.2-A CPU.

> This series adds dts support for the Arm Morello System Development
> Platform.

Do we actually need the dts for this board?

I have one on my desk; it boots vanilla Debian 12 via UEFI + ACPI just
fine, with the Debian 6.1.0-13-arm64 kernel.

Is there something that we can only do with the DT? i.e. some
functionality that isn't exposed via ACPI?

How do you expect this DT to be used?

Mark.

> 
> [1] https://www.morello-project.org/
> 
> To simplify the testing a linux tree rebased on 6.14-rc4 is accessible
> at [2].
> 
> [2] https://codeberg.org/vincenzo/linux/src/branch/morello/dts/v6
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Jessica Clarke <jrtc27@jrtc27.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Changes
> =======
> v7:
>   - Rebased on 6.14-rc4.
>   - Added review info.
> v6:
>   - Introduce arm,morello.yml.
>   - Split pmu patch.
>   - Address review comments.
> v5:
>   - Add support for fvp.
>   - Add support for pmu.
>   - Address review comments.
>   - Rebase on 6.14-rc1.
> v4:
>   - Add cache information.
>   - Address review comments.
> v3:
>   - Address review comments.
>   - Rebase on 6.13-rc5.
> v2:
>   - Addressed review comments.
>   - Rebased on 6.13-rc4.
>   - Renamed arm,morello to arm,morello-sdp for clarity.
> 
> Vincenzo Frascino (10):
>   arm64: Kconfig: Update description for CONFIG_ARCH_VEXPRESS
>   dt-bindings: arm: Add Morello compatibility
>   dt-bindings: arm: Add Morello fvp compatibility
>   dt-bindings: arm: Add Rainier compatibility
>   dt-bindings: arm-pmu: Add support for ARM Rainier PMU
>   perf: arm_pmuv3: Add support for ARM Rainier PMU
>   arm64: dts: morello: Add support for common functionalities
>   arm64: dts: morello: Add support for soc dts
>   arm64: dts: morello: Add support for fvp dts
>   MAINTAINERS: Add Vincenzo Frascino as Arm Morello Maintainer
> 
>  .../devicetree/bindings/arm/arm,morello.yaml  |  35 ++
>  .../devicetree/bindings/arm/cpus.yaml         |   1 +
>  .../devicetree/bindings/arm/pmu.yaml          |   1 +
>  MAINTAINERS                                   |   7 +
>  arch/arm64/Kconfig.platforms                  |   5 +-
>  arch/arm64/boot/dts/arm/Makefile              |   1 +
>  arch/arm64/boot/dts/arm/morello-fvp.dts       |  77 +++++
>  arch/arm64/boot/dts/arm/morello-sdp.dts       | 157 +++++++++
>  arch/arm64/boot/dts/arm/morello.dtsi          | 323 ++++++++++++++++++
>  drivers/perf/arm_pmuv3.c                      |   2 +
>  10 files changed, 606 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,morello.yaml
>  create mode 100644 arch/arm64/boot/dts/arm/morello-fvp.dts
>  create mode 100644 arch/arm64/boot/dts/arm/morello-sdp.dts
>  create mode 100644 arch/arm64/boot/dts/arm/morello.dtsi
> 
> -- 
> 2.43.0
> 

