Return-Path: <linux-kernel+bounces-334094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A7097D28C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447FCB22760
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE9811F7;
	Fri, 20 Sep 2024 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W2T7HbBL"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0729770ED;
	Fri, 20 Sep 2024 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820522; cv=none; b=bZmzI04GQpJ9MxxpFE2McnDcgHWRqp+FUevxANOLx6mRQhVLVp+luiO6N6sgBkegbKrZLTn8wH2ZZ+yg2RAD4wnu2mcI+FLVJORePql4hgyA1IQXleII5B05cODOuWpozbF4GCk58AlD54yFPUrISZGTFy7ObQnVJG/lzbA4qMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820522; c=relaxed/simple;
	bh=uV7PUiyIYsNO0DHtNqE/2KADFoDucxgrHHpWDPxEEkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDKuOYfQZX6LM0y06I2yBl926iOoimyWdq89gV4L7xXmZBlWmeO6WJtrdz67dz8nPj9xAMFK7ZHNc2an8sEAr7vNrukGo+LvHvGtkJkSwW3BKV7SniSto6kca06pm+ciCwQNiAuIfBb2b6HQjVSnNhwGZzmA3fpr756L84WrE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W2T7HbBL; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=bxwDJ
	AkXvK8AdSR7veh+eMKRy+rJ61dS+tkTSOb3PvE=; b=W2T7HbBLhfMxj+T45i8BB
	X+sfflFZsdpik4Yj/CfQu00Nz2Tu4GUIvPK0r+tOhvNoQwN6Q0P1ij/YUxoYX4wb
	/RXFhkoDvGwGvYQvLkTLZSiab1h/xa0jBrKaL11u/r+SFq4VWTmAdLzfJTAGM6CG
	NIYDfuyJHevDCwP5n8GVhY=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wD3X7mDMO1m_7DTEw--.2482S2;
	Fri, 20 Sep 2024 16:21:26 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	minhuadotchen@gmail.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 06/15] drm/rockchip: vop2: include rockchip_drm_drv.h
Date: Fri, 20 Sep 2024 16:21:21 +0800
Message-ID: <20240920082122.6742-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081626.6433-1-andyshrk@163.com>
References: <20240920081626.6433-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7mDMO1m_7DTEw--.2482S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw15AryUXr1xtry5JF43KFg_yoW8CF4UpF
	s8AFWUZrWxKFWjqr1DAF9xCr4Fy3ZrCayxGFn7G3ZxZF17KFyDGwnru3s8JrZrXr47ZF42
	krs3J34UAF42vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZIDcUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMw5gXmbtL08mhAAAsK

From: Andy Yan <andy.yan@rock-chips.com>

Move rockchip_drm_drv.h in rockchip_drm_vop2.h to fix the follow
sparse warning:

ARCH=arm64 LLVM=1 make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
mrproper defconfig all  -j12

drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:502:24: sparse:
warning: symbol 'vop2_platform_driver' was not declared. Should it
be static?

It is also beneficial for the upcoming support for rk3576.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

---

Changes in v3:
- Split it from 10/15, as it fix a exiting compile warning.

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 1 -
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 4776a227e62c..a7f9f88869a6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -35,7 +35,6 @@
 #include <uapi/linux/videodev2.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
 
-#include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
 #include "rockchip_drm_vop2.h"
 #include "rockchip_rgb.h"
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 59cd6b933bfb..bc001f715847 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -9,6 +9,7 @@
 
 #include <linux/regmap.h>
 #include <drm/drm_modes.h>
+#include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
 
 #define VOP2_VP_FEATURE_OUTPUT_10BIT        BIT(0)
-- 
2.34.1


