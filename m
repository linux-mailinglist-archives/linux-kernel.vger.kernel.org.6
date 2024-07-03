Return-Path: <linux-kernel+bounces-238941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ADC9253B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03860289618
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CDB136672;
	Wed,  3 Jul 2024 06:31:31 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AD132114;
	Wed,  3 Jul 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988290; cv=none; b=Qai1VvcO4LituOuVkdGKurrfMdue5254Lx4KdVViAxGfhncNsqq+wRwrM6DLckZhyU7qmQX3dFL2n/Brc0UKQKftCedrL4SEvEY5pZyp3sNCYOqRL/J2BY/N4caCYdfCPpY1TFzyXjwS+NjXVULVuExRineUESYozgBLxnPYPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988290; c=relaxed/simple;
	bh=x2xNuCIicL4+SrPjjJ8UVnqMsdrAZsE26XQfBmUAc+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrgyiAHjFyvt3A/eUUM4pN8uZRoYmLSZMAbYzTqYkCMXSuGngIfNyVt/dMtjfb/BKPZg9mzsgJvotH5KLXpkMdL5S2V135+v25G59CGpJsrWw4yBhrL+kpZgjzU6njPPijFeEQGmIFMDe8IEXeWCP2ppTzHlHwwZZjUJl5d+DHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid10-sz.amlogic.com (10.28.11.69) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Wed, 3 Jul 2024
 14:16:15 +0800
From: zelong dong <zelong.dong@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>, Rob Herring
	<robh@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kelvin.zhang@amlogic.com>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 1/3] dt-bindings: reset: Add compatible and DT bindings for Amlogic A4/A5 Reset Controller
Date: Wed, 3 Jul 2024 14:16:08 +0800
Message-ID: <20240703061610.37217-2-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240703061610.37217-1-zelong.dong@amlogic.com>
References: <20240703061610.37217-1-zelong.dong@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zelong Dong <zelong.dong@amlogic.com>

Add new compatible and DT bindings for Amlogic A4/A5 Reset Controller

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 .../bindings/reset/amlogic,meson-reset.yaml   | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
index f0c6c0df0ce3..80345af81d5a 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
@@ -12,13 +12,21 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
-      - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
-      - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
-      - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
-      - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
-      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
+              - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
+              - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
+              - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
+              - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
+              - amlogic,t7-reset
+      - items:
+          - enum:
+              - amlogic,a4-reset
+              - amlogic,a5-reset
+              - amlogic,c3-reset
+          - const: amlogic,meson-s4-reset
 
   reg:
     maxItems: 1
-- 
2.35.1


