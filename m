Return-Path: <linux-kernel+bounces-235889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F82B91DADB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBBA288001
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45219127B56;
	Mon,  1 Jul 2024 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gCuxPa7E"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67C85C5E;
	Mon,  1 Jul 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824368; cv=none; b=JAGYfgMvMY5EmKSAZEslkiq1WXgYyBCeuf57jLg3AaWYI4XzRRezxfKvlXAu/DEK62lvoGJn2vd+TV1v6XApavy2UNQJKWgi7JvVf2cjqpnQ7iO0KZc6HX5C75gYzWyD/OGWQs1RnQx34XQ4/3JeZAHfQP9WIty02nWGoIZX038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824368; c=relaxed/simple;
	bh=DfE31lfEgRnoFJg6fQzfDa/OyUkDiQn244MEDxgDLrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0k1jOevGNeBFFlQfs1a84aC75JAboizaiVZ9iEgLNWTIoNwAZ3GF2PvS8l/y0k3lWKNvXF9iBhODCuVK3glX4qTiGdgaFv5JfBdxR0xoV+K7h8QdTv18xEgvWr9yto+/r20k+9EpzqC7usky5OeUJpJG5uJ6jRmIxyJKr6RUMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gCuxPa7E; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719824366; x=1751360366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DfE31lfEgRnoFJg6fQzfDa/OyUkDiQn244MEDxgDLrs=;
  b=gCuxPa7EhC+Exb3skBfH1wXxr7+ZixGruiinOC4ntZCArs0eWaOXeBcJ
   VBE4x1Amk4G3wkllXjChUA+nlXGmZqkke1t/3e+NVtnFxhv7qZCznR2RQ
   v7+LkkJP2JJjMKQ28Kz050vXwBIreU0CIA+zZj7DD5bWAa3448QrVDYwk
   0vmIRInJLJOujOEpstuybc5GzQZ9mbRuV0C414wb1A50sEzw03Bxk8dWV
   7VchOQKYFu6YXWBPsJDFc1OVx/zvOjoc2BOQ5vIs7M+Ssba69RSKgWRs1
   pOzBGHuXCMQ9L30ssmt+UKkZKhWHKQXlBZCBn4xJ15zrSMCZPEz94QOCR
   Q==;
X-CSE-ConnectionGUID: 8eku2F0lT8uAGkGJJbQhew==
X-CSE-MsgGUID: HaoblIqpQPWoJzJh+lCk1A==
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="31278294"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2024 01:59:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jul 2024 01:58:52 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jul 2024 01:58:45 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <megi@xff.cz>, <javierm@redhat.com>, <neil.armstrong@linaro.org>,
	<quic_jesszhan@quicinc.com>, <sam@ravnborg.org>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: display: himax-hx8394: Add Microchip AC40T08A MIPI Display panel
Date: Mon, 1 Jul 2024 14:28:35 +0530
Message-ID: <20240701085837.50855-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701085837.50855-1-manikandan.m@microchip.com>
References: <20240701085837.50855-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add compatible string for the Microchip's AC40T08A MIPI Display
panel.This panel uses a Himax HX8394 display controller.
The reset line is not populated and leads to driver probe issues,
thus add conditional block to narrow reset-gpio property per variant.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
changes in v2:
- re-order compatible string alphabetically.
- Add conditional block to narrow reset-gpio property from required
list based on compatible string check
---
 .../bindings/display/panel/himax,hx8394.yaml    | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
index 644387e4fb6f..75ccabff308b 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -15,14 +15,12 @@ description:
   such as the HannStar HSD060BHW4 720x1440 TFT LCD panel connected with
   a MIPI-DSI video interface.
 
-allOf:
-  - $ref: panel-common.yaml#
-
 properties:
   compatible:
     items:
       - enum:
           - hannstar,hsd060bhw4
+          - microchip,ac40t08a-mipi-panel
           - powkiddy,x55-panel
       - const: himax,hx8394
 
@@ -46,7 +44,6 @@ properties:
 required:
   - compatible
   - reg
-  - reset-gpios
   - backlight
   - port
   - vcc-supply
@@ -54,6 +51,18 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - $ref: panel-common.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            enum:
+              - microchip,ac40t08a-mipi-panel
+    then:
+      required:
+        - reset-gpios
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-- 
2.25.1


