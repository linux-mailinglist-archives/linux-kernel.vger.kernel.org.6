Return-Path: <linux-kernel+bounces-288053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2265C95323F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0752B237E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BFF1B3F0B;
	Thu, 15 Aug 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6O2ZoQo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3834A1B3747;
	Thu, 15 Aug 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730529; cv=none; b=o1ecuwfgDSOJ3jCMKdwL4xvBONfIx8PBaObPMW9VgLRjPGW/Q0PF2nHifLCT0f+ESLxD8ZVeQ+N2k8ciRQJKIm1+qdzvST2YTKqEVfVDrGNW8DhW81vI8VMqgqtv4ZRTJGG4RzrONhKbSvWODg5JNMMrNjuynxEDBxgmnGHlELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730529; c=relaxed/simple;
	bh=6/BDDzn6NjgJMHOa8BpYXh/OmIkUNmyDyx/qEELsamA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAymUYbFWC7cC4G/BUmjTXSXgkWNjNtzJvHyyYxWl+7QKaR9sIdExOPha8I7UAZog2JQE/4o5FsmWbnjBaTGkaClDj7zxwxuZN2dr7E79RzdMhkLhhLGQbluLQpWPF3qAAg70Y51Tsxbl9/+h51JkAKj4EkxdtR6vFiYbOzSsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6O2ZoQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE22C4AF0A;
	Thu, 15 Aug 2024 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730529;
	bh=6/BDDzn6NjgJMHOa8BpYXh/OmIkUNmyDyx/qEELsamA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6O2ZoQoc4awh3MvU70X5edxGhKV1a/OmLUXo6vRtJTnxtt6ZJlSz4NJTuhlWVhHW
	 AS4OB8qdbx6emxhdXzMWjQyIRKZab+oY3CVQaq5xhIbY1j9tYxB5Lp+ZgSKlkHFnjJ
	 1AeGuskC9QOrQ8dWa8UhAo+2GxA7R0m612Srt9cSh6e/OjT5wj+2/W+6kWvsc2pxIe
	 NuP/rs6roXN/WF170qn9ZJVAvyon9D/lwEK4NdLuwzyLkADKn0XbNK2xVTV+K2YUED
	 hR9/7mz3wbGlzE9kPZm2HwfBdZmIdWzib5ydrEaYdVaQ3CSQAwSpU318Bh7OY5O3ku
	 Pc6kwC9wT12AA==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/11] riscv: dts: microchip: convert clock and reset (TODO: fixup phandle)
Date: Thu, 15 Aug 2024 15:01:14 +0100
Message-ID: <20240815-handsaw-estranged-f9f33c533564@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=P0nSk7Ep1qroS73NOlAoSWLxzzlqao33UjAL2l5A8Ag=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uPTulz/r+bFwd5e4kENnWZjmdt//y99Vpecky0hMW akr89G0o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABPhX8Pwvzxkx335PN5ZYS9z LgfMbM+bu+Ga/9U5M2bOy3m0NLrv1AeGvzJGyv8ibETvKVyccqX9b41Q7/sdF+58qGTe4Lxw09/ DR3kB
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 1d655126b66f..6c5b6fef313f 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -254,14 +254,11 @@ pdma: dma-controller@3000000 {
 		mss_top_scb: syscon@20002000 {
 			compatible = "microchip,mpfs-mss-top-sysreg", "syscon", "simple-mfd";
 			reg = <0x0 0x20002000 0x0 0x1000>;
-		};
 
-		clkcfg: clkcfg@20002000 {
-			compatible = "microchip,mpfs-clkcfg";
-			reg = <0x0 0x20002000 0x0 0x1000>, <0x0 0x3E001000 0x0 0x1000>;
-			clocks = <&refclk>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
+			rst: reset-controller {
+				compatible = "microchip,mpfs-reset";
+				#reset-cells = <1>;
+			};
 		};
 
 		sysreg_scb: syscon@20003000 {
@@ -457,7 +454,7 @@ mac0: ethernet@20110000 {
 			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
 			clock-names = "pclk", "hclk";
-			resets = <&clkcfg CLK_MAC0>;
+			resets = <&rst CLK_MAC0>;
 			status = "disabled";
 		};
 
@@ -471,7 +468,7 @@ mac1: ethernet@20112000 {
 			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
 			clock-names = "pclk", "hclk";
-			resets = <&clkcfg CLK_MAC1>;
+			resets = <&rst CLK_MAC1>;
 			status = "disabled";
 		};
 
@@ -559,5 +556,12 @@ syscontroller_qspi: spi@37020100 {
 			clocks = <&scbclk>;
 			status = "disabled";
 		};
+
+		clkcfg: clkcfg@3e001000 {
+			compatible = "microchip,mpfs-clkcfg";
+			reg = <0x0 0x3e001000 0x0 0x1000>;
+			clocks = <&refclk>;
+			#clock-cells = <1>;
+		};
 	};
 };
-- 
2.43.0


