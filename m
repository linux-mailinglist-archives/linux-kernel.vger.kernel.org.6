Return-Path: <linux-kernel+bounces-401335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA359C18F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C951F224EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ACB1E105E;
	Fri,  8 Nov 2024 09:19:00 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3595473E;
	Fri,  8 Nov 2024 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057540; cv=none; b=JVH9GTfZu5nQNTSEALNlhlCniIcoXmvW5phAY1Nvq2/EiaNmnreDVAoeFYXI741zihn/lr+4dcexb4sMMqiQflNGqvtaZrGZkxyBnnOAilldZYlm/yMileWMRmBv3zNiWSgAG1dAiZ+o88a3LVTGKFREO/2EBN79p9X+bufY9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057540; c=relaxed/simple;
	bh=xs6SPLbr6F+CL+35DWobkSBtLWkPO0hgz34wayh5oTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foBE1h5i7zPsTo2jvUfbd5vjtFb4NTBvIUZmXQUWbl9SN8XBURdpSfpHr6CxIPidDMt1g1lBlf1U0+fRZTi13ZgYAEY9sEyPd5lTLIIrQMkGtGp4k7YD22azpPAvvc3kcm+FZmYJPNQls1jwAGXDobIEiBwVC/9z1RODzwpoFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid10-sz.amlogic.com (10.28.11.69) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.39; Fri, 8 Nov 2024
 17:18:56 +0800
From: zelong dong <zelong.dong@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>, Rob Herring
	<robh@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kelvin.zhang@amlogic.com>, Zelong Dong <zelong.dong@amlogic.com>, "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v3 1/3 RESEND] dt-bindings: reset: Add compatible for Amlogic A4/A5 Reset Controller
Date: Fri, 8 Nov 2024 17:18:40 +0800
Message-ID: <20241108091842.36961-2-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20241108091842.36961-1-zelong.dong@amlogic.com>
References: <20241108091842.36961-1-zelong.dong@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zelong Dong <zelong.dong@amlogic.com>

Add new compatible for Amlogic A4/A5 Reset Controller

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../bindings/reset/amlogic,meson-reset.yaml   | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
index 695ef38a7bb3..0ad81fe7b629 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
@@ -12,14 +12,21 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
-      - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
-      - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
-      - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
-      - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
-      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
-      - amlogic,t7-reset
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
+              - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
+              - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
+              - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
+              - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
+              - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
+              - amlogic,t7-reset
+      - items:
+          - enum:
+              - amlogic,a4-reset
+              - amlogic,a5-reset
+          - const: amlogic,meson-s4-reset
 
   reg:
     maxItems: 1
-- 
2.35.1


