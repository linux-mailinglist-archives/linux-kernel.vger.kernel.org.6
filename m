Return-Path: <linux-kernel+bounces-318898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F296F4BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8F21C23DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00841CEAC9;
	Fri,  6 Sep 2024 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OMs7ZvQ7"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682A1CE6FF;
	Fri,  6 Sep 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627249; cv=none; b=fOLhmc1l93a03dW1gmgOgC5DKWAhhbfTKw2x2YeUr1uUnQJBJ2AcgC0cNj59y4kxfjlAPGZBLsaL1mmCqQ1kqR3ur+6zSaAiPr//rkNNRTDhJfk4u2GbTIYwyctL609I2mGxdpZOIQniJICSUmEE3d0wgZCCk5QIa1du8IdmgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627249; c=relaxed/simple;
	bh=YuZBdtQE5MqcdrUj6rfc2zVrFcaYBODaSIfNfhlSw14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=k/m/zUDoOw0vSUZSI+H+/RBMH+KfNmdGI4jyL3FijV0xuTcBmdoAls+GcaA1Nol8FJpgB2vMUHDg05b961Kl6RPWGtS6BxbHxaxjpBrhTDJR+QvsoAB/CGKJC/94VZFL9VINfkTYcsWsjQ1TJ8Nn9vjNE0UYR1fs2hSV3zot4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OMs7ZvQ7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725627247; x=1757163247;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YuZBdtQE5MqcdrUj6rfc2zVrFcaYBODaSIfNfhlSw14=;
  b=OMs7ZvQ7zjskPbhOKjWN6RtOVSmyQKCvOlBnnOvBDC1y2pkKrK5aB/VG
   fy7t8BspBjS4HXKAbLq9AmSirL6zVaBOCpOyrQOAlb/VH66oHvobKuGDr
   JnXHuy20jVHW5NVep0v1sSicukVBeGaZc3PV/hP44da98zvFMhXaG/scr
   3qzjg+Frc+2ufbgliSfxDR3KmmeJmLpFetptFR7Bbkzb/xhJVa2Q20nYa
   k3yyH9/Dto3c5Zbxem+iWyZ/jDOPMHN8HDs4cNB+aOxEjDoiM6xHRr/ds
   KjhscZ97Oo6rQBcseBmhEcs990MdM1jjkY1YzIha+JWOQ9LhHNCZcu67S
   Q==;
X-CSE-ConnectionGUID: sLMTJciFQoOe3QYYo7sv+w==
X-CSE-MsgGUID: xjGOYz0LQ8G5DM5GODpyag==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="31334947"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 05:54:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 05:53:32 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Sep 2024 05:53:29 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 6 Sep 2024 14:52:45 +0200
Subject: [PATCH 8/9] dt-bindings: phy: sparx5: document lan969x in sparx5
 dt-bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240906-sparx5-lan969x-serdes-driver-v1-8-8d630614c58a@microchip.com>
References: <20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com>
In-Reply-To: <20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Document lan969x in the existing Sparx5 dt-bindings.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../bindings/phy/microchip,sparx5-serdes.yaml          | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
index bdbdb3bbddbe..1e07a311e8a5 100644
--- a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
+++ b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
@@ -8,6 +8,7 @@ title: Microchip Sparx5 Serdes controller
 
 maintainers:
   - Steen Hegelund <steen.hegelund@microchip.com>
+  - Daniel Machon <daniel.machon@microchip.com>
 
 description: |
   The Sparx5 SERDES interfaces share the same basic functionality, but
@@ -62,12 +63,17 @@ description: |
   * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
   * 25.78125 Gbps (25GBASE-KR/25GBASE-CR/25GBASE-SR/25GBASE-LR/25GBASE-ER)
 
+  lan969x has ten SERDES10G interfaces that share the same features, operating
+  modes and data rates as the equivalent Sparx5 SERDES10G interfaces.
+
 properties:
   $nodename:
     pattern: "^serdes@[0-9a-f]+$"
 
   compatible:
-    const: microchip,sparx5-serdes
+    enum:
+      - microchip,sparx5-serdes
+      - microchip,lan969x-serdes
 
   reg:
     minItems: 1
@@ -90,11 +96,19 @@ additionalProperties: false
 
 examples:
   - |
-    serdes: serdes@10808000 {
+    serdes@10808000 {
       compatible = "microchip,sparx5-serdes";
       #phy-cells = <1>;
       clocks = <&sys_clk>;
       reg = <0x10808000 0x5d0000>;
     };
 
+  - |
+    serdes@e3410000 {
+      compatible = "microchip,lan969x-serdes";
+      #phy-cells = <1>;
+      clocks = <&fabric_clk>;
+      reg = <0xe3410000 0x150000>;
+    };
+
 ...

-- 
2.34.1


