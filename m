Return-Path: <linux-kernel+bounces-526391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9011DA3FE28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DC919C712F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421162512EF;
	Fri, 21 Feb 2025 18:03:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1E1E9B23;
	Fri, 21 Feb 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161038; cv=none; b=RHsZpwHpzb5wQ+by2ZNqxG9VIGArWrJwC701kPPh5ABjdlvUq0ewypIS6V5sZ+TGw14R1pVg0+H6bfFe8JQaCN2ifV3lJEurbxa6LFGGArjWsGnuyw+obwcF9wsNSJZL0eHJK1WBprrRyqpS2ewBUgebHSZwv5q3EFVQDWTK6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161038; c=relaxed/simple;
	bh=rRBbX/Yn38PcC0htFCpxPJi1YLpVt65QrAnrpWp6rxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZ/k1AmS2shctauLrIof6vaQuxXGQqPqiQrV0ik/8EBkkVwlhlIPdfa+ut6Z/fV1Sm2zuYopDKS8fF/46vwnfc9ilLWANaTKL4xXVOkvtnka2jzzWak4gEwHUrXjP/jpoPqbrIbgpRqEqQCzO9uGLRqMurQoGMraJXYZSpEPgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2435169C;
	Fri, 21 Feb 2025 10:04:13 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 283C43F59E;
	Fri, 21 Feb 2025 10:03:54 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH v7 00/10] arm64: dts: Add Arm Morello support
Date: Fri, 21 Feb 2025 18:03:39 +0000
Message-ID: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Morello architecture is an experimental extension to Armv8.2-A,
which extends the AArch64 state with the principles proposed in
version 7 of the Capability Hardware Enhanced RISC Instructions
(CHERI) ISA [1].

This series adds dts support for the Arm Morello System Development
Platform.

[1] https://www.morello-project.org/

To simplify the testing a linux tree rebased on 6.14-rc4 is accessible
at [2].

[2] https://codeberg.org/vincenzo/linux/src/branch/morello/dts/v6

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org> 
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Changes
=======
v7:
  - Rebased on 6.14-rc4.
  - Added review info.
v6:
  - Introduce arm,morello.yml.
  - Split pmu patch.
  - Address review comments.
v5:
  - Add support for fvp.
  - Add support for pmu.
  - Address review comments.
  - Rebase on 6.14-rc1.
v4:
  - Add cache information.
  - Address review comments.
v3:
  - Address review comments.
  - Rebase on 6.13-rc5.
v2:
  - Addressed review comments.
  - Rebased on 6.13-rc4.
  - Renamed arm,morello to arm,morello-sdp for clarity.

Vincenzo Frascino (10):
  arm64: Kconfig: Update description for CONFIG_ARCH_VEXPRESS
  dt-bindings: arm: Add Morello compatibility
  dt-bindings: arm: Add Morello fvp compatibility
  dt-bindings: arm: Add Rainier compatibility
  dt-bindings: arm-pmu: Add support for ARM Rainier PMU
  perf: arm_pmuv3: Add support for ARM Rainier PMU
  arm64: dts: morello: Add support for common functionalities
  arm64: dts: morello: Add support for soc dts
  arm64: dts: morello: Add support for fvp dts
  MAINTAINERS: Add Vincenzo Frascino as Arm Morello Maintainer

 .../devicetree/bindings/arm/arm,morello.yaml  |  35 ++
 .../devicetree/bindings/arm/cpus.yaml         |   1 +
 .../devicetree/bindings/arm/pmu.yaml          |   1 +
 MAINTAINERS                                   |   7 +
 arch/arm64/Kconfig.platforms                  |   5 +-
 arch/arm64/boot/dts/arm/Makefile              |   1 +
 arch/arm64/boot/dts/arm/morello-fvp.dts       |  77 +++++
 arch/arm64/boot/dts/arm/morello-sdp.dts       | 157 +++++++++
 arch/arm64/boot/dts/arm/morello.dtsi          | 323 ++++++++++++++++++
 drivers/perf/arm_pmuv3.c                      |   2 +
 10 files changed, 606 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,morello.yaml
 create mode 100644 arch/arm64/boot/dts/arm/morello-fvp.dts
 create mode 100644 arch/arm64/boot/dts/arm/morello-sdp.dts
 create mode 100644 arch/arm64/boot/dts/arm/morello.dtsi

-- 
2.43.0


