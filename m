Return-Path: <linux-kernel+bounces-426916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C289DFA07
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C1AB21CF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE4D1F8AFA;
	Mon,  2 Dec 2024 04:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="dBqagzb1"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAF2A1CA;
	Mon,  2 Dec 2024 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114992; cv=none; b=BkJBdFDHOtR3i+Vs+I4MpFFlQWSDzGcfqXwJ5oBenU4E6f3cvjeqHLFSvEd9BOH0M13Zwa80WdpT56Jn/R54EUzrybuwhM3+mhVxb2E2qwjvncOdwhmYvugo+d0m56iglTSBFih35si0kiDrVpcTpIoXOU3hMcmOj7SegBMmNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114992; c=relaxed/simple;
	bh=c7DrF4FY6ek6JMuSQX4DMWp2SLBG/+HX8Rg78u1FF5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=osR/3h/yS3FGTzg7HWYBy/wrbqSr40uCN7vlUvNmriRz736yPQ8AiEqVZJMRVAQOC9kiYmW/hRisWKFQRescG4Mo60ysBzbCN7CuYsMio561VDozm5WYWhS/+nq+evq2pFet1PguqXLblT1tXk6AsLfrt/+TUMHcDYEpCsE/uMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=dBqagzb1; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1733114627;
	bh=c7DrF4FY6ek6JMuSQX4DMWp2SLBG/+HX8Rg78u1FF5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dBqagzb1CFLZ4juBxO+3shH0BexnFVBgz4rTYgptwcYNP3CpnalGsKNgXBi2yR3en
	 go8UM4LGs1a7MNMozITf5qtHb216sKbMj2FfNnMDDzTtH3jGsT2Xa1hkqxDjqp47sg
	 1fMYZQJf/uW6iV+SNQKwulyncODdPHQIQkBewoyg7k9Sk90TDAlkpUxqEc0olmqb3G
	 hGGh6u4qh6eulZ/mQFBMmtjATUud2FDc7Tr5ArUqYQRWYfRN7H1z9nUYqC7JEnOecu
	 P483uscsys5NR8/TTy54HcfT+3pBUL3apwXLtPlo8UfNovVrQ8l8E8Bg1ks5GcO6ed
	 OOyDhV09H9kmQ==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
Date: Mon, 02 Dec 2024 00:43:27 -0400
Subject: [PATCH 2/2] arm64: dts: allwinner: a100: Add syscon nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-a100-syscon-v1-2-86c6524f24d7@epochal.quest>
References: <20241202-a100-syscon-v1-0-86c6524f24d7@epochal.quest>
In-Reply-To: <20241202-a100-syscon-v1-0-86c6524f24d7@epochal.quest>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Parthiban Nallathambi <parthiban@linumiz.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>
X-Mailer: b4 0.14.2

The Allwinner A100 has a system configuration block, denoted as SYS_CFG
in the user manual's memory map. It is undocumented in the manual, but
a glance at the vendor tree shows this block is similar to its
predecessors in the A64 and H6. The A100 also has 3 SRAM blocks: A1, A2,
and C. Add all of these to the SoC's device tree.

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 29ac7716c7a5284ccf8af675db9c7d016785f0ff..31540a7ca1f01c6c2e69e329054aca16ffd112c4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -101,6 +101,37 @@ soc {
 		#size-cells = <1>;
 		ranges = <0 0 0 0x3fffffff>;
 
+		syscon: syscon@3000000 {
+			compatible = "allwinner,sun50i-a100-system-control",
+				     "allwinner,sun50i-a64-system-control";
+			reg = <0x03000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_a1: sram@20000 {
+				compatible = "mmio-sram";
+				reg = <0x00020000 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00020000 0x4000>;
+			};
+			sram_c: sram@24000 {
+				compatible = "mmio-sram";
+				reg = <0x024000 0x21000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x024000 0x21000>;
+			};
+			sram_a2: sram@100000 {
+				compatible = "mmio-sram";
+				reg = <0x0100000 0x14000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x0100000 0x14000>;
+			};
+		};
+
 		ccu: clock@3001000 {
 			compatible = "allwinner,sun50i-a100-ccu";
 			reg = <0x03001000 0x1000>;

-- 
2.47.1


