Return-Path: <linux-kernel+bounces-536200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A913A47CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569BF7A2B96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B1B22D783;
	Thu, 27 Feb 2025 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="e+iDDjl/"
Received: from mail-m1973187.qiye.163.com (mail-m1973187.qiye.163.com [220.197.31.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE622B8A5;
	Thu, 27 Feb 2025 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657309; cv=none; b=JCWGYuAjnVRu9TarRNKtTS05aFmnDWNFJUqjhIxh+Zo132kVi2ZfY4xuzsn+62B9qhrTgFExfxNKhuW4BXRJ1EjKFjKYSzz754Dn3eqjjsHV/vv2pYetM354w13/dgBmGIkzqHmk9g3gEc5GDNgfWL2JeocausVvzKSC7pk9YOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657309; c=relaxed/simple;
	bh=+t8rTNducXDOmIEk+muLa7BrvKIgO1U0U3OhHhJ151U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5xYJpyy8mDG8WKwgGBgyd1JDwgylXX9aacdm7NEbf/7XhDrx+vafB/VXi9F+TLjQqDbLUFIzVpyecpQ/36BB+yurLWQ1Tg40lAaS0TgEROzR54NMphiMAvtnFeN2tCYivVThU/1hRs9G665dv7BF8ul0QgCk0HxqHGRKl9+7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=e+iDDjl/; arc=none smtp.client-ip=220.197.31.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f97e6;
	Thu, 27 Feb 2025 19:19:34 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 09/15] dt-bindings: usb: dwc3: Add support for rk3562
Date: Thu, 27 Feb 2025 19:19:07 +0800
Message-Id: <20250227111913.2344207-10-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227111913.2344207-1-kever.yang@rock-chips.com>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxMSVYZQxlMTBgdGEgYQ0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95472221ca03afkunmc65f97e6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Dww6AzIKAQ0dEkIUHkg8
	PQkKChxVSlVKTE9LTU5OSkxOT0tOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS05KNwY+
DKIM-Signature:a=rsa-sha256;
	b=e+iDDjl/x7ZbXubeWx1k4MgxsD6ndE8Nfe363mzseOFU6ybbxCcSFdet+kRoEGwGGRwG1KyXrXzNGRzlhuYNpP74UoFkxX9H4fJtFpbd4xNwwxEB+k1WjTUqkwn59t2BWG88fUmo9P1Iwy+B3CLwx8aDLlhw7ddd2c2vVH63rG4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=uBdOgROO7htXLJg3uHYGlDDd8v+5cdQZJyOdo4kszRw=;
	h=date:mime-version:subject:message-id:from;

The USB dwc3 core on Rockchip's RK3562 is the same as the one already
included in generic snps,dwc3. Extend the binding accordingly to allow

	compatible = "rockchip,rk3562-dwc3", "snps,dwc3";

There are 4 clocks with different name sequency, add schema for it.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- Update commit message and add per device schema for clock name change

Changes in v2: None

 .../bindings/usb/rockchip,dwc3.yaml           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index a21cc098542d..fba2cb05ecba 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -26,6 +26,7 @@ select:
       contains:
         enum:
           - rockchip,rk3328-dwc3
+          - rockchip,rk3562-dwc3
           - rockchip,rk3568-dwc3
           - rockchip,rk3576-dwc3
           - rockchip,rk3588-dwc3
@@ -37,6 +38,7 @@ properties:
     items:
       - enum:
           - rockchip,rk3328-dwc3
+          - rockchip,rk3562-dwc3
           - rockchip,rk3568-dwc3
           - rockchip,rk3576-dwc3
           - rockchip,rk3588-dwc3
@@ -72,6 +74,7 @@ properties:
       - enum:
           - grf_clk
           - utmi
+          - pipe
       - const: pipe
 
   power-domains:
@@ -111,6 +114,22 @@ allOf:
             - const: suspend_clk
             - const: bus_clk
             - const: grf_clk
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3562-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: ref_clk
+            - const: suspend_clk
+            - const: bus_clk
+            - const: pipe
   - if:
       properties:
         compatible:
-- 
2.25.1


