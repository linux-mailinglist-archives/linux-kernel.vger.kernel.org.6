Return-Path: <linux-kernel+bounces-321670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50CD971DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A398F28511F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4467914A086;
	Mon,  9 Sep 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DZf/ylRM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370A60EC4;
	Mon,  9 Sep 2024 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894935; cv=none; b=GVn9PKLSarxKiXVk/Sbuj3kp2+vdbw1zeONxvqtRD3ZULaQc/xwoQAr/LZehAXgjf8Csac5mcCxWb5Buf4BDXQ54dNsCtrZ04R0I6FJ9sRFkFr1fUHYRrau4BDkVJuz92DEXYpX8zNCbtC0/s33NL2tg0m9TXgq7hhTw0sYzCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894935; c=relaxed/simple;
	bh=Kv95HuOyH4jOLtRTnSTsPX1+Mbx06lXUaXcNGAKCwSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LrSCxzYtlX7IVjCTJELWPdgyc4O2BSk3CDDnYi45HvvDpYnhTX5CFRCi0hVlzt8v/jeCmkBa+8ontWdq4/+xI/gD8vbWXYhBZmAx5QNdyDN8ND+Lu/30BJVgtaJY0lfZgaH/fJQ7OgBy8Rxtw/Yo83ddYiAA8kbHwRol4jhz93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DZf/ylRM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725894933; x=1757430933;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Kv95HuOyH4jOLtRTnSTsPX1+Mbx06lXUaXcNGAKCwSY=;
  b=DZf/ylRM8CLZK2WBhqYOl01MOhsy0pWomX6ZmK9TvJQ8YHq8h8difDr2
   1kqu/mOUe+UmvrK9c9hxTXndsdmeipPIWYtF6Ld9sCjSY4wAnIYi59lnW
   DySaZz5/uVb3QfgNk70WHBcBUWN1AfTyANCKjEqwR2ud3ah5156wrPwE4
   eDaRrtCYJQAEbMdg9w/u5t9KpvA/9EzHC+GT+JEgezEZ13kUtLIPxdaak
   1vV8PSgzKnCBqDzPcA9/3Zf/LUDcUOrtipEgntLsgis5/V98t0k0spqqB
   7cXvZhKASYo8DmxzkAcNj9b2P+IOrdYpUybnmzzgLnpPHdrLigit9LnoH
   A==;
X-CSE-ConnectionGUID: 2asziJ13SmWKAWPwHD4niQ==
X-CSE-MsgGUID: lp1o19g2QGKhLbqcIeferw==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="198959138"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 08:15:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 08:15:13 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 08:15:11 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 9 Sep 2024 17:14:48 +0200
Subject: [PATCH v2 8/9] dt-bindings: phy: sparx5: document lan969x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240909-sparx5-lan969x-serdes-driver-v2-8-d695bcb57b84@microchip.com>
References: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
In-Reply-To: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Lan969x is going to reuse the existing Sparx5 SERDES driver - document
that by adding compatible strings for the different SKU's that we
support, and a short description of the SERDES types and data rates
supported.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../bindings/phy/microchip,sparx5-serdes.yaml           | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
index bdbdb3bbddbe..fa0b02916dac 100644
--- a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
+++ b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
@@ -8,6 +8,7 @@ title: Microchip Sparx5 Serdes controller
 
 maintainers:
   - Steen Hegelund <steen.hegelund@microchip.com>
+  - Daniel Machon <daniel.machon@microchip.com>
 
 description: |
   The Sparx5 SERDES interfaces share the same basic functionality, but
@@ -62,12 +63,26 @@ description: |
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
+    oneOf:
+      - enum:
+          - microchip,sparx5-serdes
+          - microchip,lan9691-serdes
+      - items:
+          - enum:
+              - microchip,lan9698-serdes
+              - microchip,lan9696-serdes
+              - microchip,lan9694-serdes
+              - microchip,lan9693-serdes
+              - microchip,lan9692-serdes
+          - const: microchip,lan9691-serdes
 
   reg:
     minItems: 1

-- 
2.34.1


