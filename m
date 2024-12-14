Return-Path: <linux-kernel+bounces-445914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A569F1D79
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A12161C98
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A68F1A8F86;
	Sat, 14 Dec 2024 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E1lbLAjv"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191FB18FDDB;
	Sat, 14 Dec 2024 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734164276; cv=none; b=pajfFBzwhRvw4n2k0ul3jAfLb8N1cCgBlkhPNEzZw2pJI5U2OX1ho1c/KvIoPTCvb+gguYaw3g6byOgYqB290eupCrHkboRIyxDPUT0OMkVe+DrBUvLPGbheNHfeWMJh6b2y4zJuKPhIjGGM+nvJUxPM8yibWgaDSwgCtJk8hpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734164276; c=relaxed/simple;
	bh=HOP5kRF5NKo7MOsQrCPiKx9lrd8Lqs4kcS5osp5H25Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLktIifmp5KBqsBYSprJ0Zsv9dNUJUahsRjjSDRH+FU6PAN7KlONpDWig3ojjUu9JRpNGxhb/Rgu6JICoxQ1A5Rdw/HPVVfM+EOFKGRFwzzOnY7JHmCclTnjFoBqMtQaEQX5rRSYWdm6WLOeGzehyGqOM4ySwo2CiYVWl2loHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E1lbLAjv; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=w1t+Y
	xVGo3C7adso2ew9kchvYon/DvfCqltU1uP0Uy4=; b=E1lbLAjvTEGdE190FigXq
	Biw9iHFhsYzkDwr54hu3651KhnEVEJmN6rjSIS12wn2Ot71ghVV5I4Lv9zvWTAK4
	IGwYx75Refz3yrqr0ForKVX9QFiTYC/N/c5Gwlj27iT6x6h1lcR87RI00+FD/xlG
	N5pEoifcZg4I6WcJWodepM=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3fwEQP11ntNLtAQ--.5686S9;
	Sat, 14 Dec 2024 16:17:30 +0800 (CST)
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
	Min-Hua Chen <minhuadotchen@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v6 07/16] drm/rockchip: vop2: include rockchip_drm_drv.h
Date: Sat, 14 Dec 2024 16:17:06 +0800
Message-ID: <20241214081719.3330518-8-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214081719.3330518-1-andyshrk@163.com>
References: <20241214081719.3330518-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fwEQP11ntNLtAQ--.5686S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyxKw45Wr48JrWfuF4fAFb_yoW8CFW5pF
	s8AFWUZrWxKFWjqr1DAF9xCr4Fy3ZFkayxGas7G3ZxZF12gF1DGwnrW3s5JrZrXr47ZF42
	krs3J34UCF42vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjXdbUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMx21XmddNByuUAAAsp

From: Min-Hua Chen <minhuadotchen@gmail.com>

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

(no changes since v3)

Changes in v3:
- Split it from 10/15, as it fix a exiting compile warning.

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 1 -
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 85d281edfbfe..b5f35839d5e8 100644
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
index f4724a402ac2..29cc7fb8f6d8 100644
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


