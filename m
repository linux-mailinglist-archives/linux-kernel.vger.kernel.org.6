Return-Path: <linux-kernel+bounces-189909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD2E8CF6F3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE03F1C20D02
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 00:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335F84409;
	Mon, 27 May 2024 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lNTqFDgG"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429D4A29;
	Mon, 27 May 2024 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716768513; cv=none; b=f4dA9ec6trUPlSKBiNFbGBXsKE5XQF5TJtg9EgwFsXDiLdcuuKljbUsZpDmEF4gMMR3tY+gvlC1myvG8z/U/0xYZ+p9B6PrMrLXpM4bjRb2i/7ZQtXwYOk/7F2v/1Ev0eyBaQfTb9vvU2CW2I6/EmFFqw8e+6zgMkuweGZitRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716768513; c=relaxed/simple;
	bh=kMt/9K4aekZtS0tL2qV3sUj0+HulkMuYXH9I8nq2YHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwA5OsrEQvCvTTNAnrZKxTkNDxKnGUF8lmNX2Igse8U6q6iETwJqzooZfg8otW3xIh+qxUEhApWpX5AZlPvQhycp+WvcR2LBRmev6sZVQe3AQPN/C9fOX7IhAUwKQHLFZoEeua7tvnN25YF5ajEg5wUEwjp5QdhOnATIGC5HZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lNTqFDgG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716768508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vS3Q9SysKWzgyXS7FEcuivpq4F4boK7rd8WfyG4cURE=;
	b=lNTqFDgGCzw42sU9u+vr0JZgnUGWB+/GbRdc146ock1UWhHUg8z4r9KMgO7b5aRGoDxq8r
	S5yXUcv30k0mUE20ONktn8waypZ87wTqSmwMO2XjFmriU701hnAefdgFphe1iPeFlFfzg0
	M6UU/muCjhK4j9rdiAI1eX7YNDxd+sXKWxDjK0OtJNt6dthYqs+XP6hg2TO52ugQQAHd4C
	PivKrPexD+LYZ5k4v/5O40LuwUSBUeykYzvd10zqZDRJVpD/Q2eswCLJ29+NvQJLR1rfAB
	YX6Gx6v4arrkfp5zhCKxpcFtzHhLGpjbuOgly23hZpC1pHyWzfZjco6BrHMOFQ==
To: linux-sunxi@lists.linux.dev
Cc: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	uwu@icenowy.me,
	andre.przywara@arm.com,
	didi.debian@cknow.org,
	Marek Kraus <gamiee@pine64.org>
Subject: [PATCH v2 2/2] arm64: dts: allwinner: Correct the model names for Pine64 boards
Date: Mon, 27 May 2024 02:08:18 +0200
Message-Id: <4a988518e0dba5de3ecfc172a0fa2b0653c00d8b.1716768092.git.dsimic@manjaro.org>
In-Reply-To: <cover.1716768092.git.dsimic@manjaro.org>
References: <cover.1716768092.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Correct the model names of a few Pine64 boards and devices, according
to their official names used in the Pine64 wiki and on the official Pine64
website. [1][2][3]  This ensures consistency between the officially used
names and the names in the source code.

[1] https://wiki.pine64.org/wiki/PINE_A64
[2] https://wiki.pine64.org/wiki/PINE_H64
[3] https://pine64.org/devices/

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Marek Kraus <gamiee@pine64.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts         | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts        | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts             | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts           | 2 +-
 .../boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts     | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts            | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts   | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts    | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts            | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
index 596a25907432..709fe650a360 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
@@ -5,7 +5,7 @@
 #include "sun50i-a64-sopine-baseboard.dts"
 
 / {
-	model = "Pine64 LTS";
+	model = "Pine64 PINE A64 LTS";
 	compatible = "pine64,pine64-lts", "allwinner,sun50i-r18",
 		     "allwinner,sun50i-a64";
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
index b54099b654c8..026d843cd7e0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
@@ -4,7 +4,7 @@
 #include "sun50i-a64-pine64.dts"
 
 / {
-	model = "Pine64+";
+	model = "Pine64 PINE A64+";
 	compatible = "pine64,pine64-plus", "allwinner,sun50i-a64";
 
 	/* TODO: Camera, touchscreen, etc. */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 2accb5ddf783..09e71fd60785 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -9,7 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Pine64";
+	model = "Pine64 PINE A64";
 	compatible = "pine64,pine64", "allwinner,sun50i-a64";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 6c65d5bc16ba..379c2c8466f5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -13,7 +13,7 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	model = "Pinebook";
+	model = "Pine64 Pinebook";
 	compatible = "pine64,pinebook", "allwinner,sun50i-a64";
 	chassis-type = "laptop";
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
index 6265360ce623..86cc85eb3d48 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
@@ -9,7 +9,7 @@
 #include "sun50i-a64-pinetab.dts"
 
 / {
-	model = "PineTab, Early Adopter's version";
+	model = "Pine64 PineTab Early Adopter";
 	compatible = "pine64,pinetab-early-adopter", "allwinner,sun50i-a64";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index c6007df99938..f5fb1ee32dad 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -14,7 +14,7 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	model = "PineTab, Development Sample";
+	model = "Pine64 PineTab Developer Sample";
 	compatible = "pine64,pinetab", "allwinner,sun50i-a64";
 	chassis-type = "tablet";
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 5e66ce1a334f..be2347c8f267 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -8,7 +8,7 @@
 #include "sun50i-a64-sopine.dtsi"
 
 / {
-	model = "SoPine with baseboard";
+	model = "Pine64 SOPINE on Baseboard carrier board";
 	compatible = "pine64,sopine-baseboard", "pine64,sopine",
 		     "allwinner,sun50i-a64";
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
index 66fe03910d5e..066fbeff8bfa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
@@ -8,7 +8,7 @@
 /delete-node/ &reg_gmac_3v3;
 
 / {
-	model = "Pine H64 model B";
+	model = "Pine64 PINE H64 Model B";
 	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
 
 	wifi_pwrseq: pwrseq {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 3910393be1f9..c8b275552872 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -9,7 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Pine H64 model A";
+	model = "Pine64 PINE H64 Model A";
 	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
 
 	aliases {

