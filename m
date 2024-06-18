Return-Path: <linux-kernel+bounces-219994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC8A90DB43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243891F22C95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C4914EC51;
	Tue, 18 Jun 2024 18:05:22 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96C145B31;
	Tue, 18 Jun 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733922; cv=none; b=ssMhmLGFAdJNWwkrRCwg5AtiIXJBhcVM326d0X/nFHRIs3TPLca6FKE2lKhXM2pKSE9opEOcbWWSEJrgyHtTuwwUBEff3VvnhULrr/YtikNq1/3hNuujwfRINWbHlkXsXlGe0EPGuxSA0E3Y2Z4krXjeKhzeC5Wj25s5LIf+AOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733922; c=relaxed/simple;
	bh=CUg5GWoTtbJgy3YKhVbq5zDegd0NVrO0IUzPvWFo27I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=beD5jQcKMbMuRmeqdRPfySRiW9YrgF8/ER3owbwQdSHekTAK1bTP6AH5j4XNqLB07bWY5N88FSoJmFF4e9S9n8xfwZOXk6McMB5yGIPJUKvTseNBAdVPh+0OvwRK9cd5cWXIiLxuHtPVObfiLu6ALHrE3mgTElOMzR4t526OS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1sJcX1-0077vb-Dj;
	Tue, 18 Jun 2024 17:22:07 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: freescale: imx8m*-venice-*: fix gw,gsc dt-schema warnings
Date: Tue, 18 Jun 2024 10:21:51 -0700
Message-Id: <20240618172150.1693704-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the dt-schema warnings due to #address-cells/#size-cells being
unnecessary when there are no children with reg cells.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts | 2 --
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts | 2 --
 5 files changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 35ae0faa815b..136cb30df03a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -364,8 +364,6 @@ gsc: gsc@20 {
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index c11260c26d0b..1d56f2a6c06a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -314,8 +314,6 @@ gsc: gsc@20 {
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
index db1737bf637d..45470160f98f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
@@ -280,8 +280,6 @@ gsc: gsc@20 {
 		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
index 05489a31e7fd..ef951bc9f0dd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
@@ -330,8 +330,6 @@ gsc: gsc@20 {
 		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 0b1fa04f1d67..72004ab6bda5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -312,8 +312,6 @@ gsc: gsc@20 {
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
-- 
2.25.1


