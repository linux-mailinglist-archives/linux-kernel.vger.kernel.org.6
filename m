Return-Path: <linux-kernel+bounces-386647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66699B4650
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43264B22762
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF98205AC0;
	Tue, 29 Oct 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DSpswal2"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEAE205144;
	Tue, 29 Oct 2024 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195892; cv=none; b=shMnPpPvDyFR0XQUCtIMZzJDd3NsON/AjgGGN+24ab8HTN6S9a4nnxxm37rbpBdgxdbVl8xOe8IjwolEIiuQhzHOojrqIDN7SPHbghOSNOXSrua5dhH3vSm0lCreEGEt+dHrz6pl/qVBgi7yVOfMLp3mXf9BgULzVkAT7CAy6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195892; c=relaxed/simple;
	bh=g9AipgMPRIIJtbfEoY2YF9MBzfiAchMPzwuYj0aKuy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifdlAYDLfybLZIRExIP1trzbEm+WFfpt1GOwaWrG2w5SqdhrrmQBdVIiRSGpb0Hd3Qq0h1bIt+KT2mNsuHuyqAiaIkcwGgosGXEG24N/lH3WNZl3itb1vJ/z5RW3iTxCJ6rsvSA/7MRjk3F0XcDQ98nOqOblqT07IG2wxOXU3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DSpswal2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=yxux1
	By2rnGvzR/PFyyiJzKm2Pk7omvqYG5lZ9tl4rk=; b=DSpswal2Zm/aheRuKJx2V
	fS5U4Lryow77QLGUaBTOAcI1SHQp6riOHVMLGgrN8osMeNTcNMaBwWwq7T9Nq/G2
	EyMAgoR+c65Ip0C86iOfkU+wW4r7wGuvbHmmWjUfzAwgnHNe+ux3BUGBrSL+qk+N
	h69hCruroxFw6KM2BtVfgA=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBn7OKZsSBncgm2Bg--.53474S2;
	Tue, 29 Oct 2024 17:57:49 +0800 (CST)
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
	minhuadotchen@gmail.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 13/14] dt-bindings: display: vop2: Add rk3576 support
Date: Tue, 29 Oct 2024 17:57:42 +0800
Message-ID: <20241029095744.391134-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029095513.391006-1-andyshrk@163.com>
References: <20241029095513.391006-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBn7OKZsSBncgm2Bg--.53474S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWrKFW5try7CFWkWw17Wrg_yoW8WF4Upa
	93CF9rXry8GF17X34kGF1rCrs8XF97Aa13GF4ktw1xtrsxKrsYgw4agrn8Zr45GFyxZaya
	9F4ak34UJ392vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBMKtUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQqHXmcgr44lkQAAso

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
index 2531726af306b..a44964b6c36a0 100644
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


