Return-Path: <linux-kernel+bounces-393336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB579B9F5C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF001F21CAA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD686198A30;
	Sat,  2 Nov 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfCLKIVl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADF717A58C;
	Sat,  2 Nov 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547264; cv=none; b=eQaMR4SDYZUlc5bh+10ngi8xsYNSnByihpnWdzqy6SIrLDMqC8dFh5eHJ8CJ3Xn4JxUmWU3fUXME0effC+Zb3kMWRq7kkzhS8HBBRLBbVtVvBYCdbnpoPrM/J1nVth0s0UUJk4nrF88133dfK1FnrVJj8DXhOtj9ZI1GYcZatME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547264; c=relaxed/simple;
	bh=NtPyrw1FXMvbsmz7Nr23KWeYuAkw5uGGVtbW3/WwzPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgWbPe3nJYGunsZGsejZvP+Efh/yyziaEV2iEOymXQEs+anL7gRYx6No4ivglQ4RI9FRLQWZEx6jyOFWTw6CBBFtV1X55sPXT72kb7c0riq32u9kPCrIhqCXU/hX/W/E2ig07roFqlJnhGbnQF8w+15Irnyhrv6EAdNp8Lcy9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfCLKIVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFBECC4CED7;
	Sat,  2 Nov 2024 11:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730547263;
	bh=NtPyrw1FXMvbsmz7Nr23KWeYuAkw5uGGVtbW3/WwzPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tfCLKIVlF/qtmS2TbdOnH5+/SIaiaQcg2HUFOpxXUlRzU3G8dLnXgNkBbejhx8PqB
	 dAcQlY1hlZC8G4jPMgvw6O/dBRPxD1D6tpJkkdY/m7cI5tLd0GPx967Qq82aBM8/AT
	 VlDnF7aKpvESPZIyrUVZH9xPjI6qo5Ng5Zgc1uMY1Cq0Uoco8plg1hxGyQjJlQzCFW
	 yKFvAFMM7uvwo5WbIZj4UYq9mEpzOGXPk+zw+xUC3dLHHdO1YrYobU/UhMydLdHDUj
	 3gBHUXcvc04CE0VHEOqF/9ChKO4IMyK1A96uKyp4uFQtGYSWaDK31gTmYW/9NbJmc9
	 iGHol/hK3sSaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F30E677FD;
	Sat,  2 Nov 2024 11:34:23 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 02 Nov 2024 12:34:24 +0100
Subject: [PATCH 5/5] arm64: dts: apple: Add SPI NOR nvram partition to all
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-asahi-spi-dt-v1-5-7ac44c0a88f9@jannau.net>
References: <20241102-asahi-spi-dt-v1-0-7ac44c0a88f9@jannau.net>
In-Reply-To: <20241102-asahi-spi-dt-v1-0-7ac44c0a88f9@jannau.net>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=4sH2FvtVOU7J6ZD/GsHPG804yvHnrTdh0gHvxrTVtvc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnQ1PrvyhtB54ap732lO8opJM52R+f/D5FkNsoGxHWksx
 +wqDt/pKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJH10YwMR55PusaXVe8n5XBh
 Jqvmi6X3HwnWcxaqPZLuPqRQ7laTxMjwjb09Sa9la9eqb9+XvDPIMT0xK+7G9qk8gW1XQyw2N6m
 zAQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Janne Grunau <j@jannau.net>

All known M1* and M2* devices use an identical SPI NOR flash
configuration with a partition containing a non-volatile key:value
storage. Use a .dtsi and include it for every device.
The nvram partition parameters itself depend on the version of the
installed Apple iboot boot loader. m1n1 will fill in the current values
provided by Apple's iboot.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/spi1-nvram.dtsi      | 39 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi |  2 ++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      |  2 ++
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi      |  2 ++
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi      |  2 ++
 5 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/spi1-nvram.dtsi b/arch/arm64/boot/dts/apple/spi1-nvram.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..3df2fd3993b52884d7c00b65099c88d830a7a4c3
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/spi1-nvram.dtsi
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Devicetree include for common spi-nor nvram flash.
+//
+// Apple uses a consistent configiguration for the nvram on all known M1* and
+// M2* devices.
+//
+// Copyright The Asahi Linux Contributors
+
+/ {
+	aliases {
+		nvram = &nvram;
+	};
+};
+
+&spi1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <25000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			nvram: partition@700000 {
+				label = "nvram";
+				/* To be filled by the loader */
+				reg = <0x0 0x0>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
index 2e471dfe43cf885c1234d36bf0e0acfdc4904621..22ebc78e120bf8f0f71fd532e9dce4dcd117bbc6 100644
--- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -119,3 +119,5 @@ sdhci0: mmc@0,0 {
 &fpwm0 {
 	status = "okay";
 };
+
+#include "spi1-nvram.dtsi"
diff --git a/arch/arm64/boot/dts/apple/t600x-j375.dtsi b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
index 1e5a19e49b089d4b3c5e12828b682d1993e35e75..d5b985ad567936111ee5cccc9ca9fc23d01d9edf 100644
--- a/arch/arm64/boot/dts/apple/t600x-j375.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
@@ -126,3 +126,5 @@ &pcie0_dart_2 {
 &pcie0_dart_3 {
 	status = "okay";
 };
+
+#include "spi1-nvram.dtsi"
diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
index 5988a4eb6efaa008c290b1842e0da2aae8052ba4..8e82231acab59ca0bffdcecfb6681f59661fcd96 100644
--- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
@@ -90,3 +90,5 @@ bluetooth0: bluetooth@0,1 {
 &nco_clkref {
 	clock-frequency = <900000000>;
 };
+
+#include "spi1-nvram.dtsi"
diff --git a/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
index f5edf61113e7aa869613d672b281f7b7e84efb79..6da35496a4c88dbaba125ebbe8c5a4a428c647c3 100644
--- a/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
@@ -79,3 +79,5 @@ &i2c3 {
 &nco_clkref {
 	clock-frequency = <900000000>;
 };
+
+#include "spi1-nvram.dtsi"

-- 
2.47.0



