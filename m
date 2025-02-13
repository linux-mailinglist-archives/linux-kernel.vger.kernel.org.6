Return-Path: <linux-kernel+bounces-513645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E327A34D09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1346B3AD5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051C26989D;
	Thu, 13 Feb 2025 18:03:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CC026983F;
	Thu, 13 Feb 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469807; cv=none; b=bvQPjemeJJ3s1KT0h5b0bzDOkr9Wn9FJToUCMBVGcfxKpSBcoc0doiYE8S8a9n/zKV/GPa+x9q75Tw9elAKQ/1WQ4gzbW2CsChsiKa3jtueDTE4K1Dfxlqexcnu7FfvRHSLGJUi+DKhSsj2y1K96LhMqSBqR1WgXT0kAkKcmESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469807; c=relaxed/simple;
	bh=mDz0xlWp9rLv+KPhAgViY4OUn0Qp1EADLYFHesLlFSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChBtJCj5ApQdDhXIs2F5atGD/YSLbM4g0cfIYk4XVmEV17qL5qJbUmLnloNBtCkJeL4YWLgvOu2LgxAXzFJwZjo4WlCZ+rdTNx6NjUuNHbFnkpcV518MAeyFLxMmeW5ulcrlkVlJCvQH/cuKUwT/7wqbwOsxQDHaiztsiFQ+vDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4535113E;
	Thu, 13 Feb 2025 10:03:44 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D9713F5A1;
	Thu, 13 Feb 2025 10:03:22 -0800 (PST)
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
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 0/8] arm64: dts: Add Arm Morello support
Date: Thu, 13 Feb 2025 18:03:01 +0000
Message-ID: <20250213180309.485528-1-vincenzo.frascino@arm.com>
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

To simplify the testing a linux tree rebased on 6.14-rc1 is accessible
at [2].

[2] https://codeberg.org/vincenzo/linux/src/branch/morello/dts/v5

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
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Changes
=======
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


Vincenzo Frascino (8):
  dt-bindings: arm: Add Morello compatibility
  dt-bindings: arm: Add Morello fvp compatibility
  dt-bindings: arm: Add Rainier compatibility
  perf: arm_pmuv3: Add support for ARM Rainier PMU
  arm64: dts: morello: Add support for common functionalities
  arm64: dts: morello: Add support for soc dts
  arm64: dts: morello: Add support for fvp dts
  MAINTAINERS: Add Vincenzo Frascino as Arm Morello Maintainer

 .../bindings/arm/arm,vexpress-juno.yaml       |   8 +
 .../devicetree/bindings/arm/cpus.yaml         |   1 +
 .../devicetree/bindings/arm/pmu.yaml          |   1 +
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/arm/Makefile              |   1 +
 arch/arm64/boot/dts/arm/morello-fvp.dts       |  78 +++++
 arch/arm64/boot/dts/arm/morello-sdp.dts       | 157 +++++++++
 arch/arm64/boot/dts/arm/morello.dtsi          | 323 ++++++++++++++++++
 drivers/perf/arm_pmuv3.c                      |   2 +
 9 files changed, 577 insertions(+)
 create mode 100644 arch/arm64/boot/dts/arm/morello-fvp.dts
 create mode 100644 arch/arm64/boot/dts/arm/morello-sdp.dts
 create mode 100644 arch/arm64/boot/dts/arm/morello.dtsi

-- 
2.43.0


