Return-Path: <linux-kernel+bounces-445890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 424A29F1D23
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA994162855
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F6D158DD9;
	Sat, 14 Dec 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X7ZSK6Fx"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59AF14D43D
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734160449; cv=none; b=pEdILqDPl4WaD+XXPJf6jpsyD+a2ElgY+MfIETTwY6X6Z2+mclsJchGh5MQTKqLN+teXcJuYqvPxzuoW66L2IbKoGnwSeHabJnVWUygFPLFcRrcTp6BQw3RZjAxqrdgpZ4Vzv2iEAFZ5j7cVLFZafLJI9CeTOQL/PP188s0la7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734160449; c=relaxed/simple;
	bh=R82UPU6jGSoP17pIGR8LE7Fc+pa1nakZHWObqvHcuiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5lvdItoBEagq3quhcnVy03f/hWCfp10qLfwwBmGVxL3IYjGayRS7UXQPcAoVoA39ZO4TuM5o08UG5M78DjeU97tFQGJir+sebu0lWuuELDFmBnbcFTiXlIgTL8DgxXH+qpnlZ2qUoPZ9ev+pxusxBpqc/B1WQFZUJg6bnXr7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X7ZSK6Fx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=/jr6j
	nLL8cAX9H3cWT2KiyjVLKxAcx77tgmPEs2DRJA=; b=X7ZSK6Fx3ChBL9LdY6DxY
	3EM9szbF8ApuTdcdTNdDfQwCtlQLk+49+zFUhGuzwchdMOpad8Yaq89V5rcuClvs
	EWz8gHXQfH1QYnCaPTNYwOsk0NyHnq47akRMdqOALJVV4cIDK1n/ImovQlBkEyTQ
	OQim8Q68Krv5uPqy5Ey8ng=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnl80hMF1ngrXcAQ--.46811S2;
	Sat, 14 Dec 2024 15:13:40 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: sebastian.reichel@collabora.com,
	kever.yang@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2] drm/rockchip: Fix Copyright description
Date: Sat, 14 Dec 2024 15:13:33 +0800
Message-ID: <20241214071333.3325308-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnl80hMF1ngrXcAQ--.46811S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3uFy7GFWDWw4rtF48XFWkWFg_yoW8XFW3Co
	WvkF15Ja4rCFs3C34YyF1IqF1fuwnrtas3Cw4FkFsFvryUC3yUJrs0vrZ5CF1YvryUAF4x
	Aa10vrn8Ar1xAa48n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUceT5DUUUU
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQ+1XmddI4HI6gAAs3

From: Andy Yan <andy.yan@rock-chips.com>

The company name has update to Rockchip Electronics Co., Ltd.
since 2021.
And change Co.Ltd to Co., Ltd. to fix mail server warning:
DBL_SPAM(6.50)[co.ltd:url];

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---

Changes in v2:
- Fix an omitted file cdn-dp-core.h

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c          | 2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.h          | 2 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c           | 2 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.h           | 2 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c     | 2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c            | 2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.h            | 2 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c          | 2 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.h          | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c     | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c      | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.h      | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c     | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h     | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h     | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h    | 2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c        | 2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.h        | 2 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c         | 2 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.h         | 2 +-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c    | 2 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c     | 2 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h     | 2 +-
 27 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 546d13f19f9b..02876eb66e94 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -2,7 +2,7 @@
 /*
  * Rockchip SoC DP (Display Port) interface driver.
  *
- * Copyright (C) Fuzhou Rockchip Electronics Co., Ltd.
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author: Andy Yan <andy.yan@rock-chips.com>
  *         Yakir Yang <ykk@rock-chips.com>
  *         Jeff Chen <jeff.chen@rock-chips.com>
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index ff9d95e2c4d4..4b28121ffa42 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author: Chris Zhong <zyw@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index 8e6e95d269da..17498f576ce7 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2016 Chris Zhong <zyw@rock-chips.com>
- * Copyright (C) 2016 ROCKCHIP, Inc.
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  */
 
 #ifndef _CDN_DP_CORE_H
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 33fb4d05c506..924fb1d3ece2 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author: Chris Zhong <zyw@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index c7780ae3272a..13ed8cbdbafa 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author: Chris Zhong <zyw@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 1b64b6e39cc8..3398160ad75e 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:
  *      Chris Zhong <zyw@rock-chips.com>
  *      Nickey Yang <nickey.yang@rock-chips.com>
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 42bda4ffbbbd..e7a6669c46b0 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2014, Rockchip Electronics Co., Ltd.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index b58e2a29294b..898d90155057 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  *    Zheng Yang <zhengyang@rock-chips.com>
  *    Yakir Yang <ykk@rock-chips.com>
  */
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.h b/drivers/gpu/drm/rockchip/inno_hdmi.h
index a7edf3559e60..8b7ef3fac485 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.h
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  *    Zheng Yang <zhengyang@rock-chips.com>
  *    Yakir Yang <ykk@rock-chips.com>
  */
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index b0fc8ace2e41..403336397214 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  *    Zheng Yang <zhengyang@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.h b/drivers/gpu/drm/rockchip/rk3066_hdmi.h
index 39a31c62a428..c3598ba7428c 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.h
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  *    Zheng Yang <zhengyang@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 3e9f590c734e..bf1d4c5599fa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  *
  * based on exynos_drm_drv.c
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 24b4ce5ceaf1..8bcce08a34d9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  *
  * based on exynos_drm_drv.h
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index cfe8b793d344..dcc1f07632c3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.h b/drivers/gpu/drm/rockchip/rockchip_drm_fb.h
index bae4e079dfb1..5179026b12d6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 93ed841f5dce..6330b883efc3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
index 72f59ac6d258..cdeae36b91a1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 69900138295b..57747f1cff26 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 0cf512cc1614..f04c9731ae7b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 2995988ef559..ca3f1613d51c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index aba733736ff7..385cf6881504 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:
  *      Mark Yao <mark.yao@rock-chips.com>
  *      Sandy Huang <hjc@rock-chips.com>
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.h b/drivers/gpu/drm/rockchip/rockchip_lvds.h
index 4ce967d23813..ca83d7b6bea7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.h
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:
  *      Sandy Huang <hjc@rock-chips.com>
  *      Mark Yao <mark.yao@rock-chips.com>
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index dbfbde24698e..811020665120 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:
  *      Sandy Huang <hjc@rock-chips.com>
  */
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.h b/drivers/gpu/drm/rockchip/rockchip_rgb.h
index 1bd4e20e91eb..116f958b894d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.h
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:
  *      Sandy Huang <hjc@rock-chips.com>
  */
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 4ee56ad7b811..cbabec73685b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author: Andy Yan <andy.yan@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 8998967f0c00..4e2099d86517 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  */
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index fbf1bcc68625..addf8ca085f6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:Mark Yao <mark.yao@rock-chips.com>
  */
 
-- 
2.34.1


