Return-Path: <linux-kernel+bounces-519277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B9DA39AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE76171C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1115A23C8A9;
	Tue, 18 Feb 2025 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mJppM8cL"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6709F23C8BA;
	Tue, 18 Feb 2025 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878230; cv=none; b=mmwd+F4n2urZhMTZIbgRYlYBx/kBKBMnO6trLtZbhPoU0J7BoA0eZuSGBp2NpxvMKll50bsY1JpsOJqTCFv8P8qLkdh11KQ6rYOshUHVm0mSpnT3JpsSnOvR0QPfv4DbmTInutw3NFz3ruqFGwX7h/rucZ9qKdDLUGt3SdkKG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878230; c=relaxed/simple;
	bh=BQB4o5upyiHwOrq1ELkOKKwsTrjMz8B0lfGnMRuyQ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dC3IIXITTUkLfRNPDsed13qnB5oAqZ/7sMdKFK91q2k3f5p8iq99z64/RXoCmzHPLYOA7sHU4Wy4CdKThcUSV6tZ+eGs0WMXaIwtrI9b8WtoZiSX2Qn1jfGbCwEW+wC5OE7jW0Z49xbxpG07N8D9HyqjtusEfuTrAM13hTaSyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mJppM8cL; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=hqUIo
	3mPnUIyqguQPvXUfr2S5iboamQqTtFzA4Iiu08=; b=mJppM8cLt0+DA2Jsg+tVP
	flDqpWrL6ovbdGrJBPtHNku9Ul8G2LzRQ0xs9YKnkvmdJY05i7/3yDLJewOiOntj
	8lteip9Fy4DiQE5YYkNb2ParTSFP9TmDcyOncpOk5qlmRniUDan1KH+5sFt1ywTM
	Z0t8CWfIXKyjjObqjKIWIM=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD333uybrRnLIPUMQ--.34107S12;
	Tue, 18 Feb 2025 19:27:59 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	daniel@fooishbar.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v15 10/13] dt-bindings: display: vop2: describe constraint SoC by SoC
Date: Tue, 18 Feb 2025 19:27:37 +0800
Message-ID: <20250218112744.34433-11-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218112744.34433-1-andyshrk@163.com>
References: <20250218112744.34433-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD333uybrRnLIPUMQ--.34107S12
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF4UWFyDtryDuw43JFyftFb_yoW5uryfpa
	97Cas8X3ykGr1UWw4ktF1fAw4SqF9xJw4UJrn7t3W7Ga1DKF4UGw4agw1DAr9xWFsFvaya
	9F45Cr15Jw42vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGzuZUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBz3Xme0aMptrAACsv

From: Andy Yan <andy.yan@rock-chips.com>

As more SoCs variants are introduced, each SoC brings its own
unique set of constraints, describe this constraints SoC by
SoC will make things easier.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v14)

Changes in v14:
- Set maxItems constraint of clocks for rk3588 to 9 as a recently
  merged patch added two optional clocks[0]:
  [0]https://patchwork.freedesktop.org/patch/msgid/20250204-vop2-hdmi0-disp-modes-v3-1-d71c6a196e58@collabora.com

Changes in v13:
- Add maxItems constraint for clocks
- Remove constraint for interrupts in allOf block, as the current
  maxItems is already 1.

Changes in v12:
- Only change the description method for existing SoC.

Changes in v11:
- Remove redundant min/maxItems constraint

Changes in v10:
- Move interrupt-names back to top level
- Add constraint of interrupts for all platform
- Add constraint for all grf phandles
- Reorder some properties

Changes in v9:
- Drop 'vop-' prefix of interrupt-names.
- Add blank line between DT properties
- Remove list interrupt-names in top level

Changes in v8:
- Fix dt_binding_check errors
- ordered by soc name
- Link to the previous version:
  https://lore.kernel.org/linux-rockchip/6pn3qjxotdtpzucpul24yro7ppddezwuizneovqvmgdwyv2j7p@ztg4mqyiqmjf/T/#u

Changes in v4:
- describe constraint SOC by SOC, as interrupts of rk3576 is very
  different from others
- Drop Krzysztof's Reviewed-by, as this version changed a lot.

Changes in v3:
- ordered by soc name
- Add description for newly added interrupt

Changes in v2:
- Add dt bindings

 .../display/rockchip/rockchip-vop2.yaml       | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index 46d956e63338..a5771edd83b5 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -14,6 +14,7 @@ description:
 maintainers:
   - Sandy Huang <hjc@rock-chips.com>
   - Heiko Stuebner <heiko@sntech.de>
+  - Andy Yan <andyshrk@163.com>
 
 properties:
   compatible:
@@ -124,43 +125,54 @@ allOf:
       properties:
         compatible:
           contains:
-            const: rockchip,rk3588-vop
+            enum:
+              - rockchip,rk3566-vop
+              - rockchip,rk3568-vop
     then:
       properties:
         clocks:
-          minItems: 7
+          maxItems: 5
+
         clock-names:
-          minItems: 7
+          maxItems: 5
 
         ports:
           required:
             - port@0
             - port@1
             - port@2
-            - port@3
 
-      required:
-        - rockchip,grf
-        - rockchip,vo1-grf
-        - rockchip,vop-grf
-        - rockchip,pmu
-
-    else:
-      properties:
         rockchip,vo1-grf: false
         rockchip,vop-grf: false
         rockchip,pmu: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-vop
+    then:
+      properties:
         clocks:
-          maxItems: 5
+          minItems: 7
+          maxItems: 9
+
         clock-names:
-          maxItems: 5
+          minItems: 7
+          maxItems: 9
 
         ports:
           required:
             - port@0
             - port@1
             - port@2
+            - port@3
+
+      required:
+        - rockchip,grf
+        - rockchip,vo1-grf
+        - rockchip,vop-grf
+        - rockchip,pmu
 
 additionalProperties: false
 
-- 
2.34.1


