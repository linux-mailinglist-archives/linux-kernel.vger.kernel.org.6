Return-Path: <linux-kernel+bounces-575430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640B1A7027A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7333188D557
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582625B68D;
	Tue, 25 Mar 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="arhNAZxv"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBFB25A2D1;
	Tue, 25 Mar 2025 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909439; cv=none; b=Tdg5JmApMuDbTCd2NJMSJmJKYVTrA+H27WNWQDfd6KabDnCMqmj3l669CzVrBY7pXdV/igWimTF9eQLWs3itiaqVbGWeen/4zTI16gUIuvWE9C/Xg33O9bsDNsathvYc1OLBXuMpA0b79jDbdxY6O9GEXdW6r2+CxL8xOxsYX2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909439; c=relaxed/simple;
	bh=Onfwe7BIoo+XN6snqbku8zp5ci0I7j6pmqOlv7+LQTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGS4bE70B2vqFTVHXDsuS2AeecMaBDgjgHZk0RNIlgisZzP+P53yWjohrdONtfQgdYg6iAtjG3KdConcisEznjFfDm1K5NwTsZsEn59xAMU63DmEhq/IgEvco3uqXoHyDs+XE14zcbBwXhNoaqdQ98E+IOgiUgtzTB+DQUH89q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=arhNAZxv; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=R6TTX
	6i0XQxaEnW4x1mI+/13/Nh8Vd+xGWNS930sgHw=; b=arhNAZxvxgBjReAXbNFDD
	Fva9rgXgRJbS+4y7+UonVJo1dXpo8/tcFOu1XQuyevmlbRRcV9YdZOyXBZiOmssk
	tvY2S9+0BlpiqPO5M3UfmfTbqqaZjwSH5LGVJ5ljK6k93eSe88Mld+jaXoJomGeW
	4wQeZhQrnDh2XQ/6W9CtmA=
Received: from ProDesk.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnc2bLr+JnWNnrAA--.35530S4;
	Tue, 25 Mar 2025 21:29:52 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	hjc@rock-chips.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 2/6] dt-bindings: display: rockchip,inno-hdmi: Document GRF for RK3036 HDMI
Date: Tue, 25 Mar 2025 21:29:36 +0800
Message-ID: <20250325132944.171111-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325132944.171111-1-andyshrk@163.com>
References: <20250325132944.171111-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnc2bLr+JnWNnrAA--.35530S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryxJFW8ZF1kCrW8WFW8Crg_yoW8GF45pa
	s3C3srWFyxGF17X34ktF1kCrWYqF97Aa15GFW2qr17tF12gan5Ka1agwn8ZF4UAFs7ZFyS
	9F47GF98Aw1Ivr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2ZXrUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqAobXmfipyL8oQAAs6

From: Andy Yan <andy.yan@rock-chips.com>

HDMI on RK3036 use GRF control the HSYNC/VSYNC polarity, but this part
is missing when it first landing upstream.

Document that it is mandatory for RK3036 HDMI.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 .../bindings/display/rockchip/rockchip,inno-hdmi.yaml    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
index 9d1e7f894ea54..290376bec079a 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
@@ -56,6 +56,12 @@ properties:
       - port@0
       - port@1
 
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to GRF used for control the polarity of hsync/vsync of rk3036
+      HDMI.
+
 required:
   - compatible
   - reg
@@ -75,6 +81,8 @@ allOf:
             const: rockchip,rk3036-inno-hdmi
 
     then:
+      required:
+        - rockchip,grf
       properties:
         power-domains: false
 
@@ -103,6 +111,7 @@ examples:
       clock-names = "pclk", "ref";
       pinctrl-names = "default";
       pinctrl-0 = <&hdmi_ctl>;
+      rockchip,grf = <&grf>;
       #sound-dai-cells = <0>;
 
       ports {
-- 
2.43.0


