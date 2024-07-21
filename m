Return-Path: <linux-kernel+bounces-258089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9A8938351
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 05:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F92D1F211F4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 03:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ABE2F44;
	Sun, 21 Jul 2024 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tsU6lK34"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377E20E6;
	Sun, 21 Jul 2024 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721533534; cv=none; b=nhiRvBL/micUig5qT1FhPzbfy36b8jGJ4v8tr93uUnMe+fag8IMTZzQ61lZBY/gQwKDuaYFP94dQ3qYvCsj8/WGSCXfNd5wr0yy08oD0bESPcPpWZ2CfOmTdzK1wD6gW9HUMAcseSL0PUpm9VBdVWtrpsqLyOx8GFVGEDKwgq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721533534; c=relaxed/simple;
	bh=65oMd9gmdinFhup5VpkZKOgzk27iDMCzB8EIbYM3M6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F8Z2yIGjCLKdD7BVIKvXWD+/s5tXeoph60Ib5+AhrWCfQ13LZamJhfhl2tIeJfKMDJkaX92Rijn3kjZ/Wkfr5VhdiChJDkooJDgsK/80oIIvQBH+njkOV+1cCqvcKrX+Ujh/joE2g9IRnJQGNe4yXj/g3+Q2i1JquTaxWoTKMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tsU6lK34; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721533526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hIeA1N27z3xcXOiVoRMm1GE/f7bvHy+yMPCX/cwB2lQ=;
	b=tsU6lK34nNI0q9hdzpPZO/yphZWHWsmwIOr1Cd9LrXIHvyL6yvKICamsg1AFIGRHczbVJO
	Ml+TYMXXe4s12PgawSBeZHmcYZanWKROeetdKGd0tNS9EI82X18nwsurlw77mCFiiCp41j
	r7heAvpmivDoC2zA6strfG+1RqGyyroYx+NzQsRxL4U49GyH2FfxS+e8VGb85upgFgQ9k8
	BGFWl14uK1eI0uqSLj8B/WzSBoH5PDms4gecLApWb6hIDBq0dczA4WnEaF9Jyw1uyLO+1F
	fh9Jmw647QoJFK6WVBSQapcaO/CDk1mCdo/CQ5YBHErRaX+Ip595lIK9IZ6szw==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Move RK3399 OPPs to dtsi files for SoC variants
Date: Sun, 21 Jul 2024 05:45:16 +0200
Message-Id: <9417b5c5b64f9aceea64530a85a536169a3e7466.1721532747.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Rename the Rockchip RK3399 SoC dtsi files and, consequently, adjust their
contents and the contents of the affected board dts(i) files appropriately,
to "encapsulate" the different CPU and GPU OPPs for each of the supported
RK3399 SoC variants into the respective SoC variant dtsi files.

Moving the OPPs to the SoC variant dtsi files, instead of requiring the
board dts(i) files to include both the SoC variant dtsi file and the right
OPP variant dtsi file, reduces the possibility for mismatched inclusion and
improves the overall hierarchical representation of data.

These changes follow the approach used for the Rockchip RK3588 SoC variants,
which was introduced and described further in commit def88eb4d836 ("arm64:
dts: rockchip: Prepare RK3588 SoC dtsi files for per-variant OPPs").  Please
see that commit for a more detailed explanation.

No functional changes are introduced, which was validated by decompiling and
comparing all affected dtb files before and after these changes.  In more
detail, all decompiled dtb files remain exactly the same, except the files
list below, which results from all of them stemming from the same base board
dtsi file (rk3399-rock-pi-4.dtsi), while all of them include one of the three
different RK3399 SoC variant dtsi files by themselves:

  - rk3399-rock-4se.dtb
  - rk3399-rock-pi-4a.dtb
  - rk3399-rock-pi-4a-plus.dtb
  - rk3399-rock-pi-4b.dtb
  - rk3399-rock-pi-4b-plus.dtb
  - rk3399-rock-pi-4c.dtb

When compared with the decompiled original dtb files, these dtb files have
some of their blocks shuffled around a bit and some of their phandles have
different values, as a result of the changes to the order in which the
building blocks from the parent dtsi files are included into them, but they
still effectively remain the same as the originals.

The only exception to the "include only a SoC variant dtsi" is found in
rk3399-evb.dts, which includes rk3399-base.dtsi instead of rk3399.dtsi.
This is intentional, because this board dts file doesn't enable the TSADC,
so including rk3399.dtsi would enable the SoC to go into higher OPPs with
no thermal throttling in place.  Let's hope that people interested in this
board will fix this in the future.

As a side note, due to the nature of introduced changes, this commit is best
viewed using the --break-rewrites option for git-log(1).

Related-to: def88eb4d836 ("arm64: dts: rockchip: Prepare RK3588 SoC dtsi files for per-variant OPPs")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/{rk3399.dtsi => rk3399-base.dtsi} | 0
 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts              | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts                    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts                | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                   | 3 +--
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts             | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi           | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts         | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts              | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi               | 1 -
 .../boot/dts/rockchip/{rk3399-op1-opp.dtsi => rk3399-op1.dtsi} | 2 ++
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts               | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts           | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts          | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                  | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi                | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts           | 3 +--
 arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts               | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi             | 2 --
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts        | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts             | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts        | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts             | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts             | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi               | 3 +--
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi             | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi              | 1 -
 .../boot/dts/rockchip/{rk3399-t-opp.dtsi => rk3399-t.dtsi}     | 2 ++
 arch/arm64/boot/dts/rockchip/{rk3399-opp.dtsi => rk3399.dtsi}  | 2 ++
 arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts         | 1 -
 30 files changed, 16 insertions(+), 30 deletions(-)
 rename arch/arm64/boot/dts/rockchip/{rk3399.dtsi => rk3399-base.dtsi} (100%)
 rename arch/arm64/boot/dts/rockchip/{rk3399-op1-opp.dtsi => rk3399-op1.dtsi} (99%)
 rename arch/arm64/boot/dts/rockchip/{rk3399-t-opp.dtsi => rk3399-t.dtsi} (98%)
 rename arch/arm64/boot/dts/rockchip/{rk3399-opp.dtsi => rk3399.dtsi} (98%)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/rockchip/rk3399.dtsi
rename to arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
index 173da81fc231..1489eb32e266 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
@@ -8,7 +8,6 @@
 #include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/usb/pd.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "OPEN AI LAB EAIDK-610";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 55eca7a50a1f..54e67d2dac09 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -5,7 +5,7 @@
 
 /dts-v1/;
 #include <dt-bindings/pwm/pwm.h>
-#include "rk3399.dtsi"
+#include "rk3399-base.dtsi"
 
 / {
 	model = "Rockchip RK3399 Evaluation Board";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 260415d99aeb..f4491317a1b0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -9,7 +9,6 @@
 #include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/usb/pd.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Firefly-RK3399 Board";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 3cd63d1e8f15..776c0eec04d7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -6,8 +6,7 @@
  */
 
 #include <dt-bindings/input/input.h>
-#include "rk3399.dtsi"
-#include "rk3399-op1-opp.dtsi"
+#include "rk3399-op1.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index 4a6ab6c2e24c..5a02502d21cd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -4,7 +4,6 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Hugsun X99 TV BOX";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index 9d9297bc5f04..c772985ae4e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -9,7 +9,6 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
index 9586bb12a5d8..b0c1fb0b704e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -12,7 +12,6 @@
 
 /dts-v1/;
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Kobol Helios64";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
index cb69e2145fa9..f12b1eb00575 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
@@ -8,7 +8,6 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Leez RK3399 P710";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index b7f1e47978a6..7debc4a1b5fa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -14,7 +14,6 @@
 /dts-v1/;
 #include <dt-bindings/input/linux-event-codes.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
similarity index 99%
rename from arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
rename to arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
index 783120e9cebe..b24bff511513 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
@@ -3,6 +3,8 @@
  * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
  */
 
+#include "rk3399.dtsi"
+
 / {
 	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index e26e2d86279c..07ec33f3f55f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -10,7 +10,6 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "dt-bindings/usb/pd.h"
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Orange Pi RK3399 Board";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 294eb2de263d..292f3fa84442 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -12,7 +12,6 @@
 #include <dt-bindings/usb/pd.h>
 #include <dt-bindings/leds/common.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Pine64 Pinebook Pro";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index ef754ea30a94..1a44582a49fb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -14,7 +14,6 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Pine64 PinePhone Pro";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index ccbe3a7a1d2c..8c16527cd456 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -5,7 +5,6 @@
 
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index ca7a446b6568..d95b1cde1fc3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -7,7 +7,6 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Firefly ROC-RK3399-PC Board";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
index 972aea843afd..d4b4dced3e39 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
@@ -7,8 +7,7 @@
 
 /dts-v1/;
 #include <dt-bindings/leds/common.h>
-#include "rk3399.dtsi"
-#include "rk3399-t-opp.dtsi"
+#include "rk3399-t.dtsi"
 
 / {
 	model = "Radxa ROCK 4C+";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts
index 7cfc198bbae7..9dd26150c369 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts
@@ -5,8 +5,8 @@
  */
 
 /dts-v1/;
+#include "rk3399-t.dtsi"
 #include "rk3399-rock-pi-4.dtsi"
-#include "rk3399-t-opp.dtsi"
 
 / {
 	model = "Radxa ROCK 4SE";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index b9d6284bb804..9666504cd1c1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -4,11 +4,9 @@
  * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
  */
 
-/dts-v1/;
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pwm/pwm.h>
-#include "rk3399.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
index f5a68d8d072d..725ac3c1f6f6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
@@ -5,8 +5,8 @@
  */
 
 /dts-v1/;
+#include "rk3399-op1.dtsi"
 #include "rk3399-rock-pi-4.dtsi"
-#include "rk3399-op1-opp.dtsi"
 
 / {
 	model = "Radxa ROCK Pi 4A+";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
index c68f45849c44..32d6bce5e3d4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
@@ -5,8 +5,8 @@
  */
 
 /dts-v1/;
+#include "rk3399.dtsi"
 #include "rk3399-rock-pi-4.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Radxa ROCK Pi 4A";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
index 8a17c1eaae15..682e8b7297c1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
@@ -5,8 +5,8 @@
  */
 
 /dts-v1/;
+#include "rk3399-op1.dtsi"
 #include "rk3399-rock-pi-4.dtsi"
-#include "rk3399-op1-opp.dtsi"
 
 / {
 	model = "Radxa ROCK Pi 4B+";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
index 6ea3180e57ca..55285c7c6e54 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
@@ -5,8 +5,8 @@
  */
 
 /dts-v1/;
+#include "rk3399.dtsi"
 #include "rk3399-rock-pi-4.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Radxa ROCK Pi 4B";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
index 5274938bf1b8..82ad2ca6b5c2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
@@ -6,8 +6,8 @@
  */
 
 /dts-v1/;
+#include "rk3399.dtsi"
 #include "rk3399-rock-pi-4.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	model = "Radxa ROCK Pi 4C";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index c920ddf44baf..8146f870d2bd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -5,9 +5,8 @@
  * Copyright (c) 2018 Linaro Ltd.
  */
 
-#include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
+#include "rk3399.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index f30b82a10ca3..11d99d8b34a2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -7,7 +7,6 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index b3ef1c85e754..31832aae9ab6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -6,7 +6,6 @@
 #include "dt-bindings/pwm/pwm.h"
 #include "dt-bindings/input/input.h"
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	compatible = "rockchip,rk3399-sapphire", "rockchip,rk3399";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-t.dtsi
similarity index 98%
rename from arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
rename to arch/arm64/boot/dts/rockchip/rk3399-t.dtsi
index 1ababadda9df..72989f03fcb1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-t.dtsi
@@ -4,6 +4,8 @@
  * Copyright (c) 2022 Radxa Limited
  */
 
+#include "rk3399-base.dtsi"
+
 / {
 	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
similarity index 98%
rename from arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
rename to arch/arm64/boot/dts/rockchip/rk3399.dtsi
index fee5e7111279..6bc1249d99e6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -3,6 +3,8 @@
  * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
  */
 
+#include "rk3399-base.dtsi"
+
 / {
 	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
index c58fb7658d7a..d3c628218ce3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
@@ -7,7 +7,6 @@
 
 /dts-v1/;
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 #include <arm/rockchip/rockchip-radxa-dalang-carrier.dtsi>
 #include "rk3399pro-vmarc-som.dtsi"
 

