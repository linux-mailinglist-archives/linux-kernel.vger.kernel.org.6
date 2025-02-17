Return-Path: <linux-kernel+bounces-518371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E2A38E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4181891CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A281A8404;
	Mon, 17 Feb 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="g0p+iRUu"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE91A76AE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827958; cv=none; b=o5n2YL+9d+uEcEcr8gqzOxHGk4axpLm/2wzCsln4DbY4jQ6e7zPdZOxMoYzF/BOeWnagzZTPsWN57qNdl/T4cLCW8KLpb/XZxlxxCS01BRNYHRU9BZRfuypWEmKgBVJA8edDdN/F2QGAIf5eSiNSz1i1pmsN0SQClMaBEwt6cBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827958; c=relaxed/simple;
	bh=qgDOk7ldMzPb3j2kj6nz6o9DIKmpFktmmEBU5U0AflM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxVtsSAfqIgtoHCmApZ53dDPPxeMkf9kGzSDmbYz0HFmT7s4HVXrqnQVJUe9jLnD58gFqtHZqHOroHKp076F9auYo9Vej2v04ZysqVgYNyn19pI4oeFCyXhowQdb+OGHDCWLAwcJo7MeXExuyeR+rrW7a5ARjvvpw3YksPaJWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=g0p+iRUu; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=g0p+iRUuoZnUVXfktRhis8fC9qRVU18v/gVPXqud0rbn3QgjEocpiPUXkSI+F0xE30+KXefDMrHrP7RLEofcBD3ZZB9Ji57Y1px3d+dUtJSVA9h5rkVRrj7zT8hSbK5vqMXCchIM9US3MvGor1TkRTn/GQcivdNNW+afm1q5qnaXvAkj6J5qjCzojUL4VpzBMfpMjchf7CiGFNrW0fuMVZsPXFKOTxV38ONnNNfffq0mC6yZPugwXK4myY81d+2yLnS9QfFB65IUMfIy77R8m9xa6g+o0jKCdm4X6HubE5F7RtwCNbARg+SfiNT9pA9iLyBeXcOScANRyVZJ2QmKNg==; s=purelymail3; d=purelymail.com; v=1; bh=qgDOk7ldMzPb3j2kj6nz6o9DIKmpFktmmEBU5U0AflM=; h=Feedback-ID:Received:From:Date:Subject:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 42194286;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Feb 2025 21:32:34 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Mon, 17 Feb 2025 22:32:03 +0100
Subject: [PATCH 1/5] arm64: dts: exynos990: Enable watchdog timer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-exynos990-dt-changes-febuary-v1-1-99935218cbf4@mentallysanemainliners.org>
References: <20250217-exynos990-dt-changes-febuary-v1-0-99935218cbf4@mentallysanemainliners.org>
In-Reply-To: <20250217-exynos990-dt-changes-febuary-v1-0-99935218cbf4@mentallysanemainliners.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739827951; l=1586;
 i=igor.belwon@mentallysanemainliners.org; s=20241206;
 h=from:subject:message-id; bh=qgDOk7ldMzPb3j2kj6nz6o9DIKmpFktmmEBU5U0AflM=;
 b=jTqHwUcADANqg3+1rFaDQe65F8DeCfF1Dws5Ykg64WRdK/bdE6bLM1a4IZDzGzoEbTV/AV053
 KbegePrAtyZCFyDRG+OmIjml7leUaHPjK6eI19wijLShxvTWfqDIeWx
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=qKAuSTWKTaGQM0vwBxV0p6hPKMN4vh0CwZ+bozrG5lY=

Enable the two watchdog timer clusters (cl0, cl2) present
on the Exynos990 SoC.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 arch/arm64/boot/dts/exynos/exynos990.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos990.dtsi b/arch/arm64/boot/dts/exynos/exynos990.dtsi
index dd7f99f51a75412f5c3b91c3425a63652546fa5e..4446a1a54ba2de56879353c9c4a898b1d697fc13 100644
--- a/arch/arm64/boot/dts/exynos/exynos990.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos990.dtsi
@@ -211,6 +211,30 @@ timer@10040000 {
 				     <GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		watchdog_cl0: watchdog@10050000 {
+			compatible = "samsung,exynos990-wdt";
+			reg = <0x10050000 0x100>;
+			interrupts = <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_peris CLK_GOUT_PERIS_WDT_CLUSTER0_PCLK>,
+				 <&oscclk>;
+			clock-names = "watchdog",
+				      "watchdog_src";
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			samsung,cluster-index = <0>;
+		};
+
+		watchdog_cl2: watchdog@10060000 {
+			compatible = "samsung,exynos990-wdt";
+			reg = <0x10060000 0x100>;
+			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_peris CLK_GOUT_PERIS_WDT_CLUSTER2_PCLK>,
+				 <&oscclk>;
+			clock-names = "watchdog",
+				      "watchdog_src";
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			samsung,cluster-index = <2>;
+		};
+
 		gic: interrupt-controller@10101000 {
 			compatible = "arm,gic-400";
 			reg = <0x10101000 0x1000>,

-- 
2.47.2


