Return-Path: <linux-kernel+bounces-511041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD9CA324F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8B918867C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6665020E314;
	Wed, 12 Feb 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIEQHlT8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3635920E03B;
	Wed, 12 Feb 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359761; cv=none; b=Z5wfs+jn1VB6ZNUaJTTqJAuE96g0mV8DBkTY8Thg2WqPHFc9a9bMeRyCb8pln5r5SYMrDCSNdd310gQJzaRGMjjpsMjLKJeB8PKlUptj6jIGfiMgw31ImaqLZiuLI3WM3ihnLX1mra2L+3T5MchuhzspceCCiNSFYhMCFfRwjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359761; c=relaxed/simple;
	bh=ZkCZwKSdx0DSw7NKE/kuifcxpWJJ6EApm7Ls5SmmHYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TXDVi+OumtYVaOppxkp3qEaBIBLsWcsxT3ga97ennQLw4y5YqF9hZOvFwhA5oZKExrFoEpRuN7nRTZZwNQijQrkFEcF4ZBopCaNmUBNvH1T+UWNiuNUFTU8cgNZ8ylzuLL04jQB1XqMmC4EGaUcZC2pJ6ALCKIjZIHXtMdc7Awo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIEQHlT8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739359760; x=1770895760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZkCZwKSdx0DSw7NKE/kuifcxpWJJ6EApm7Ls5SmmHYA=;
  b=eIEQHlT8eT7Yo8OpOrf+xB1B6v7fdCrUNVeBJwuj7/a3IP0vJErRqHRT
   d0wPHkXvpTg5gx6iCgaUvapIzE6MBZC0d7SYI4FPPk0d+jxTbKolHSSCI
   BJQIFn9KMzJU2nwXx1L64vMMUsn2XFzp3Vm+nilt32PpfV3zi3RDe7FHq
   Mx6lqz3JZe7Ei2ufMjHxSql+WqLVRULXc69bJO9nkFMsRJohw6cEjenK6
   2pbj3LD7cLHHmoQMxbF5qwj7PoqqBzElz4kSmEULhBqSYAixmKFIzHl/5
   UHXmfT7WqEQTSfpV5prxaLrb9XBSey0ApGwrA/LmeuoWf6J+Cyv+eXK67
   Q==;
X-CSE-ConnectionGUID: d28fNLC5RN+JqhZpx/sdbQ==
X-CSE-MsgGUID: XNHbk6kxS1SYhSUDL/Iy1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39895761"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39895761"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:29:20 -0800
X-CSE-ConnectionGUID: lQEPo361RRaeXAR1ueUlwQ==
X-CSE-MsgGUID: dUehkeDKTryCLT4/qPXviQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112648516"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2025 03:29:16 -0800
From: niravkumar.l.rabara@intel.com
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] arm64: dts: socfpga: agilex5: add clock-names property to nand node
Date: Wed, 12 Feb 2025 19:25:35 +0800
Message-Id: <20250212112535.2674256-3-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212112535.2674256-1-niravkumar.l.rabara@intel.com>
References: <20250212112535.2674256-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add required clock-names property to the nand node.

Fixes: 2d599bc43813 (arm64: dts: agilex5: add initial support for Intel Agilex5 SoCFPGA)
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 51c6e19e40b8..27f75e1bc8eb 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -271,6 +271,7 @@ nand: nand-controller@10b80000 {
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkmgr AGILEX5_NAND_NF_CLK>;
+			clock-names = "nf_clk";
 			cdns,board-delay-ps = <4830>;
 			status = "disabled";
 		};
-- 
2.25.1


