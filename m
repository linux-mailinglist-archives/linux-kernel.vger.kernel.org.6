Return-Path: <linux-kernel+bounces-437523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 885389E945E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E77818818C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8522B8DD;
	Mon,  9 Dec 2024 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JN46gX4E"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2672322A1C9;
	Mon,  9 Dec 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747691; cv=none; b=UoW/olk19hnvzPORvn6AtY3eUFjmRX6Jj+HhOfyN7eM3COAEGro3/OQapAoZ0o6f31f4USvHvBXtEr4gKRTD0cLhm1PZBiaTInahTcjFGhw/yqggNOrFuqoFHlZtkP4xaGlOADGNBBrdxq3c6i1jiBvpwedczZCu0hqAfYOGzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747691; c=relaxed/simple;
	bh=c1adDffuuYyRNPWXtM5Mul+do9W4JVpNf0B2sFFs8WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNmm0js0v3vpis4b8gFK3ZX7SbVP8fbbaeCfKMqZLHfK0Zd6T3y4WRddFickbFOU3G9CaiD0pnc7CIHwmK7OYpk4fxEYUOxiINldrZpqqWEKzM0xOPK92+MfEu1FzGRh/Ap0qr19VnTh3S4IvKIBMN10fB5BhBSv9GaeAtqeRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JN46gX4E; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=d76oW
	+hJ02vk47g5jJkDC6wrHjePHlmxkDGSNxOrV/c=; b=JN46gX4EZm++x12IfZThB
	9F13bFE9h7hJKoSaR5PG42H8CxQ4JAPFQ7iFsnv+zsecRI0cMID7nVSKNYiA9H5S
	Q7d4xgYjQ6C5qu0unxSTaUzDXDMs+wUHaMtSnXK5bVGEWMwR8iVmSLmB0latttCg
	xCC/UF009CEOSZyFqDKAXY=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3ZvLI41ZnB5_9GQ--.40223S2;
	Mon, 09 Dec 2024 20:34:19 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v5 17/18] dt-bindings: display: vop2: Add rk3576 support
Date: Mon,  9 Dec 2024 20:34:14 +0800
Message-ID: <20241209123415.2782172-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209122943.2781431-1-andyshrk@163.com>
References: <20241209122943.2781431-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB3ZvLI41ZnB5_9GQ--.40223S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWrKFW5try7CFWkWw17Wrg_yoW8WF1Dpa
	93CF9rXry8GF17X34DGF1rCrs8XFn7Aa13GF4ktw1xtrsxKrsYgw4agrn8Zr45GFyxZaya
	9F4ak34UJ392vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URHqcUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gawXmdW4xoePwABsS

From: Andy Yan <andy.yan@rock-chips.com>

Add vop found on rk3576, the main difference between rk3576 and the
previous vop is that each VP has its own interrupt line.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

---

(no changes since v3)

Changes in v3:
- ordered by soc name
- Add description for newly added interrupt

Changes in v2:
- Add dt bindings

 .../bindings/display/rockchip/rockchip-vop2.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index 2531726af306..a44964b6c36a 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -20,6 +20,7 @@ properties:
     enum:
       - rockchip,rk3566-vop
       - rockchip,rk3568-vop
+      - rockchip,rk3576-vop
       - rockchip,rk3588-vop
 
   reg:
@@ -37,10 +38,14 @@ properties:
       - const: gamma-lut
 
   interrupts:
-    maxItems: 1
-    description:
-      The VOP interrupt is shared by several interrupt sources, such as
-      frame start (VSYNC), line flag and other status interrupts.
+    minItems: 1
+    items:
+      - description:
+          vop system interrupt, such as bus error, and vsync for vop version under
+          rk3576.
+      - description:
+          independent interrupts for each video port, such as vsync and other video
+          port related error interrupts.
 
   # See compatible-specific constraints below.
   clocks:
-- 
2.34.1


