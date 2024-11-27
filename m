Return-Path: <linux-kernel+bounces-423266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AEC9DA530
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4025A283E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4810419924E;
	Wed, 27 Nov 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYzGaedn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F2194ACF;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701176; cv=none; b=hAAjRB8V4y09x0Sd209iKNp86AXy+i49yciw592KYRe2fIyfc/n7ojPiYzE5Sr0thKQBpIIza17sjztHUAR/p58XceXMAyNqDU94P8IRD3Essuv7b5cHS9ZpZ7yZXoicggDGseuWjJzcUj0UMNGn4+MkF9BkBjp9jnf8EMhEz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701176; c=relaxed/simple;
	bh=NtPyrw1FXMvbsmz7Nr23KWeYuAkw5uGGVtbW3/WwzPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WkzjDCN9kjnF1dtJXy7b/OB5lobuvMK5isGYYWcCEyGocHiQtnqIDcrq0KMhuAjlG9/pu6V9uA9Z0xlgvv6ZZemK/vlYutbl4SmCqEZUwX93jVOiOPXC+2Qs8DpBaWoqycFOIEwEtBId4HK4dQ2fy1zbwzBTS+ly3xuUeFbGO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYzGaedn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57E3CC4CEE2;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732701176;
	bh=NtPyrw1FXMvbsmz7Nr23KWeYuAkw5uGGVtbW3/WwzPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YYzGaednPqclMwf88qhc5dBrzUmrgOG4k7qWg+JJOXKeUtWxFmMunTO8WoCMULjMK
	 NUOQR94FyPC2oMsBcvHpF702j2sD+Kx1LG2dJMwNsUjN5sFRwX/ImFzvwPxaQ1iOdr
	 nSnGxjKJUj2a2PBMuPwIP0nxeVh4yGWbGTXBTkqC9tlftfcM6C84hYleeA/pd2tkjU
	 a7ikf9AiRvZq9S3CZ7DRrgnPwM0fQAgiLwUtAkD/Cygl9lWoUdpvP38WEUHr1vhCT4
	 s+BDrMy1PXdVwFH4VDaxnJEHytlqLp6CsBkhZA0s4ibtldh+wBGhfR/LZSa5YoOjDk
	 wDGNssoFgatlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8BAD609C1;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 27 Nov 2024 10:52:32 +0100
Subject: [PATCH RESEND 5/5] arm64: dts: apple: Add SPI NOR nvram partition
 to all devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-asahi-spi-dt-v1-5-907c9447f623@jannau.net>
References: <20241127-asahi-spi-dt-v1-0-907c9447f623@jannau.net>
In-Reply-To: <20241127-asahi-spi-dt-v1-0-907c9447f623@jannau.net>
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
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnS3199yz65NmvRLy/PKvT2HH3orSzo3i20U+PxT+eJJz
 uZfG5fEdJSyMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZhIfA3D/6Dd01wWcimWFCQK
 BD1dH/ZFfEeit7bZrT/GSQxSxe1HJjH84fweaFBQPCFc80/cl5kVc4qTd1yYsytiTXStSmXG9k/
 qzAA=
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



