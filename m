Return-Path: <linux-kernel+bounces-554131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B5A59351
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E63316D4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9992288F9;
	Mon, 10 Mar 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NNscdC8x"
Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com [101.71.155.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8C2222A2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607977; cv=none; b=PlSby384lz3u5JIkVGu3PSe8YzVqbpB9gNSUXh96NzJRFCTsw3WZZXILZvKAyxj9Is4plymPF63Vpt57lTo93r0xQo3/2j0n949Xxz0r3bo5dWxyDKBoRJCt9dxAK3OXBRiL8imKBBWhVFLTLVKfxpSgL0Qn/Z+KaQIcYOtOuPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607977; c=relaxed/simple;
	bh=QMts34dWgeBsar09qndDB7RHQBSnc6dPuZ36AI/LkOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/FoDytq1vCP/xrwdxwWw51qLoUYeMJZZ0ktHleZimc9ySTmzBQlTsW0oWlZc7qTBXfDtyEVzCv6Ix0zDvy8r8roYWN9ti2YPaUWezKVSD1Es8wetpHiP5Ekw4NGWafn1X0pDSMSbe+bEXSBPKDCx6CzuSYaFL7Nb3Z4JU7l5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NNscdC8x; arc=none smtp.client-ip=101.71.155.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id dc188291;
	Mon, 10 Mar 2025 18:42:19 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	boris.brezillon@collabora.com,
	l.stach@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v8 09/13] dt-bindings: display: rockchip: analogix-dp: Add support for RK3588
Date: Mon, 10 Mar 2025 18:41:10 +0800
Message-Id: <20250310104114.2608063-10-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310104114.2608063-1-damon.ding@rock-chips.com>
References: <20250310104114.2608063-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwYTFYdSUgfTUsZTB8YTUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
	NVSktLVUpCWQY+
X-HM-Tid: 0a957fa5fdee03a3kunmdc188291
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6DTo6ETJLIiMrFTkuPQhJ
	NQ0KCUxVSlVKTE9KTUtISE9KQ0tPVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0pJNwY+
DKIM-Signature:a=rsa-sha256;
	b=NNscdC8xikclEGPAktF8uBbNr11WnR49azaZjkIjKxnQvF12Dr7n5mTfCjVOPTe6atmJgNzd5G386uxsakqDx1RMVMPjibDiSEQGOiAe6VnUxMpEZ5OlZwlRXhtkWQ7hI8sif7nBpcrsF91EFNhZ7Atn/Vy/gJsnf2nnW3D0VKM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=v/jgEld0YWuyA8ypQD6vc8cECMQ47VIivyHQrVFzLW8=;
	h=date:mime-version:subject:message-id:from;

Compared with RK3288/RK3399, the HBR2 link rate support is the main
improvement of RK3588 eDP TX controller, and there are also two
independent eDP display interfaces on RK3588 Soc.

The newly added 'apb' reset is to ensure the APB bus of eDP controller
works well on the RK3588 SoC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Add the main defferences of the RK3588 eDP and the previous versions
  in commit message

Changes in v3:
- Expand the property clock-names, resets and reset-names

Changes in v4:
- Remove 'spdif' clock which added in v3
- Add the comment of newly added 'apb' reset in commit message

Changes in v5:
- Put the differences between RK3288/RK3399 and RK3588 into 'allOf'

Changes in v6:
- Keep the widest constraints and add only RK3588 related constraints
  into 'allOf'

Changes in v7:
- Fix the errors related to 'reset-names'
- Remove unnecessary 'maxItems' under 'reset-names'
---
 .../rockchip/rockchip,analogix-dp.yaml        | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
index eaf4e67e232e..d99b23b88cc5 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
@@ -15,6 +15,7 @@ properties:
     enum:
       - rockchip,rk3288-dp
       - rockchip,rk3399-edp
+      - rockchip,rk3588-edp
 
   clocks:
     minItems: 2
@@ -31,10 +32,14 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reset-names:
-    const: dp
+    minItems: 1
+    items:
+      - const: dp
+      - const: apb
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -55,6 +60,19 @@ required:
 allOf:
   - $ref: /schemas/display/bridge/analogix,dp.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3588-edp
+    then:
+      properties:
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


