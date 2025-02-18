Return-Path: <linux-kernel+bounces-519274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0182A39ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C613A534E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4B523ED47;
	Tue, 18 Feb 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EXZjpSdC"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E65F22D7BB;
	Tue, 18 Feb 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878162; cv=none; b=gZl8xK3vb0GQimFqNMrl2lNq1qy38QSKpFWxPBnY0sdkD3/U6xDMG1yE7p48S/NTRfQpu1poIbcMA6TzYb430iZmBPQ6Dau8jm5MiXghxIV/W32FCbCmUVbdgMNw+LkLaB0EOepuPwcCHwn/XoNNPZkXC5bIpvsMUeG5nAbE0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878162; c=relaxed/simple;
	bh=V+BFJSU2AQm1RuVBzUR4w8BdrGCihfwPNBppLdotF/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9/LdkA+I3B/iWbZhsQEJSk9fwaalRgdqQ3fy9M0bcpsGTPYjIftHWdUK9W0qoUmChDqFj4TV6qVQlWJ1e7DsvHrJUIus34s48AFm77rT5D4kDSyPEWERak77ssslhE8nWYIT5XRzjFL4AoDyS8BCf5wz/4STzAVqYZbdhbxx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EXZjpSdC; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=iEV3o
	ojg3U2eJSaxG1OETOyVCd9PZzwbh6RS1wsZRok=; b=EXZjpSdCYRCRKL2V2JeHL
	Ez9ep+6M6w0cCqmmnZFO38FEQMBq0KT7JH6FjmOmIFDIoD8AryCnwOYAe1Xr99Gu
	go2Lu3E329WytaZKZ7xhw7sQWL/53j4vfd5vdMFzyeztkfNKfEQNC9t3ekf3pnBZ
	mfJk+EFTSNVrmGIE3r0zgA=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCncwzxbrRnw_zOMw--.32912S2;
	Tue, 18 Feb 2025 19:28:53 +0800 (CST)
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
Subject: [PATCH v15 12/13] dt-bindings: display: vop2: Add rk3576 support
Date: Tue, 18 Feb 2025 19:28:46 +0800
Message-ID: <20250218112848.34535-1-andyshrk@163.com>
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
X-CM-TRANSID:_____wCncwzxbrRnw_zOMw--.32912S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1kWFWUuF4UtFW5trWkZwb_yoW5tF4fpa
	93Cas8XrW8Gr1UWw1ktF1rCwnYq3Z3Aw1Ykrn7Ka13KrsxtF48Ww4agrn8Zr9xWFy2vayj
	9F4Fkw17G3sFvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UypBfUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBD3Xme0aMpw7AAAs8

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


