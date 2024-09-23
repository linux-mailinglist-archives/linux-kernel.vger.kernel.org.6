Return-Path: <linux-kernel+bounces-335598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779A97E7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C52C1F21E02
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93181946A2;
	Mon, 23 Sep 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QQJ8PJOm"
Received: from mail-m118115.qiye.163.com (mail-m118115.qiye.163.com [115.236.118.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD06A49649;
	Mon, 23 Sep 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081480; cv=none; b=pLVp/9vayokh88NivtPa8jCMXQBO5X8bqEZhBv1AHDJYaBvxNEXLlah58rWD1+31J07OLjGiaPrpcLYd16//52HzkCU4QMRVKAr9OP07P5Gi6Oq8t0CN5jLyUXgrAn+bCeykpbDQr0ylolaugP2zpXoJWUejHq449yJfpQpiTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081480; c=relaxed/simple;
	bh=j309E4N8PYPnK/xdrsEwEX7OmwoY9RWAXPmp4zF51qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VsHm1GQOGS1YtGosCBgOoHa8RSGP/+eOySXBUDLLu2MgEu/9OSYi1Yqlt1pKzfzlPZSligGR66BbgKoo3rMeLXn1oK1a+2MFf6+tvrFpKzkKdGySQagWDRyMF+Wear3dOS9c8wTp6bU+8UNrCTa8eEYEqx2PJDy0jwk21Byp04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QQJ8PJOm; arc=none smtp.client-ip=115.236.118.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=QQJ8PJOmvKb6nNEB/y0605QsUcJhZxXUHBgEUPaHTOGajLMOX3ZnQQcCzLqIZsuNItQaSik/AIG4EMOr0HI4+s6WMOUq74TTec8qdDvJGaSGpI+2QDD4CZyF2qQqRcstnWy+JPC6GYbWIrNtjzgMKfb4rCNzMeO+s7z7M5y7UUM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=QUs7XxDHY244jPem57N/f/UO7bRyUvOg8bFSehjW8tE=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 54FD29003C2;
	Mon, 23 Sep 2024 10:53:27 +0800 (CST)
From: Frank Wang <frank.wang@rock-chips.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com,
	tim.chen@rock-chips.com,
	wmc@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [RESEND PATCH 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
Date: Mon, 23 Sep 2024 10:53:25 +0800
Message-ID: <20240923025326.10467-1-frank.wang@rock-chips.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhJGlZMThgeThgYHRkZGRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a921ccc5cb503a3kunm54fd29003c2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRw6Kjo5DTIzM08oE0odLhMa
	FA4KCw5VSlVKTElMS01LS0tDTElCVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTE1CNwY+

Add compatible for the USB2 phy in the Rockchip RK3576 SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 .../devicetree/bindings/phy/rockchip,inno-usb2phy.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index 5254413137c64..214917e55c0b6 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -20,6 +20,7 @@ properties:
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
       - rockchip,rk3568-usb2phy
+      - rockchip,rk3576-usb2phy
       - rockchip,rk3588-usb2phy
       - rockchip,rv1108-usb2phy
 
@@ -34,10 +35,16 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: phyclk - PHY input reference clocks.
+      - description: aclk and aclk_slv are optional and used for USB MMU.
 
   clock-names:
+    minItems: 1
     const: phyclk
+    const: aclk
+    const: aclk_slv
 
   assigned-clocks:
     description:
@@ -144,6 +151,7 @@ allOf:
             enum:
               - rockchip,rk3568-usb2phy
               - rockchip,rk3588-usb2phy
+              - rockchip,rk3576-usb2phy
 
     then:
       properties:
-- 
2.45.2


