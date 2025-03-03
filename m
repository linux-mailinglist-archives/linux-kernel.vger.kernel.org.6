Return-Path: <linux-kernel+bounces-540956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EAFA4B6EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B02516C9B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618E91E3DC8;
	Mon,  3 Mar 2025 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YUwAPBZY"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEF219C54B;
	Mon,  3 Mar 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740973517; cv=none; b=q55JDO3SufzvwqvPn0CWNsbbr7/S+AnUF+wQtQ4GzpoKhjeDht+5NbltIbdMCqiNx3sea6MYc0C1CmYJ5KCekXibzmVu9kjUDaB8oFUBgOQ868HWN4ivfyALp5St7wokdeunpa3oephv0xIzTpzsn0n7+rO6XW+IX9+/Q6oywvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740973517; c=relaxed/simple;
	bh=V+BFJSU2AQm1RuVBzUR4w8BdrGCihfwPNBppLdotF/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHWbJtn9yPlM4GtKRDySQAkQkXHE6YulRs0lc9CXFQ+2Z7i4Adtn0WrF3KI7kF4UFbWsVW98ODPUIciuD5UyKfdFcu4OO+qKM/NPoU4gMwlwmli2vH10o1z60pc1dwYbnQ2pskmhOgSVLJ9GJZHF0N4F5WqYpOhl7WL9wrw4gWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YUwAPBZY; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=iEV3o
	ojg3U2eJSaxG1OETOyVCd9PZzwbh6RS1wsZRok=; b=YUwAPBZYlM6LOUi00Gxt2
	py8CzXmwSo6A7qIoSqqJHoYjglkXxycRLSsGcnvvHdoQrjums/nH67PFPDxh2FGL
	brAqs9z9uaGWg1bNxtEO0V303QfQzSWG41UAUmmT1uMd8WgdWZDGMbsv9APjTtgc
	oNVnWCjtoDYIRItjeoRw3U=
Received: from ProDesk.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3Oc2lJcVnaJliJg--.43523S8;
	Mon, 03 Mar 2025 11:44:49 +0800 (CST)
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
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v16 6/7] dt-bindings: display: vop2: Add rk3576 support
Date: Mon,  3 Mar 2025 11:44:20 +0800
Message-ID: <20250303034436.192400-7-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303034436.192400-1-andyshrk@163.com>
References: <20250303034436.192400-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3Oc2lJcVnaJliJg--.43523S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1kWFWUuF4UtFW5trWkZwb_yoW5tF4fpa
	93Cas8XrW8Gr1UWw1ktF1rCwnYq3Z3Aw1Ykrn7Ka13KrsxtF48Ww4agrn8Zr9xWFy2vayj
	9F4Fkw17G3sFvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UK_M-UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gMFXmfFIit2JAABsy

From: Andy Yan <andy.yan@rock-chips.com>

Add vop found on rk3576, the main difference between rk3576 and the
previous vop is that each VP has its own interrupt line.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v13)

Changes in v13:
- Use maxItems constraint for clocks in allOf block

Changes in v12:
- Split from patch 10/13

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

 .../display/rockchip/rockchip-vop2.yaml       | 61 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index 083eadcf0588..f546d481b7e5 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -21,6 +21,7 @@ properties:
     enum:
       - rockchip,rk3566-vop
       - rockchip,rk3568-vop
+      - rockchip,rk3576-vop
       - rockchip,rk3588-vop
 
   reg:
@@ -38,10 +39,21 @@ properties:
       - const: gamma-lut
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
     description:
-      The VOP interrupt is shared by several interrupt sources, such as
-      frame start (VSYNC), line flag and other status interrupts.
+      For VOP version under rk3576, the interrupt is shared by several interrupt
+      sources, such as frame start (VSYNC), line flag and other interrupt status.
+      For VOP version from rk3576 there is a system interrupt for bus error, and
+      every video port has it's independent interrupts for vsync and other video
+      port related error interrupts.
+
+  interrupt-names:
+    items:
+      - const: sys
+      - const: vp0
+      - const: vp1
+      - const: vp2
 
   # See compatible-specific constraints below.
   clocks:
@@ -136,6 +148,11 @@ allOf:
         clock-names:
           maxItems: 5
 
+        interrupts:
+          maxItems: 1
+
+        interrupt-names: false
+
         ports:
           required:
             - port@0
@@ -149,6 +166,39 @@ allOf:
       required:
         - rockchip,grf
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-vop
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+
+        clock-names:
+          maxItems: 5
+
+        interrupts:
+          minItems: 4
+
+        interrupt-names:
+          minItems: 4
+
+        ports:
+          required:
+            - port@0
+            - port@1
+            - port@2
+
+        rockchip,vo1-grf: false
+        rockchip,vop-grf: false
+
+      required:
+        - rockchip,grf
+        - rockchip,pmu
+
   - if:
       properties:
         compatible:
@@ -164,6 +214,11 @@ allOf:
           minItems: 7
           maxItems: 9
 
+        interrupts:
+          maxItems: 1
+
+        interrupt-names: false
+
         ports:
           required:
             - port@0
-- 
2.34.1


