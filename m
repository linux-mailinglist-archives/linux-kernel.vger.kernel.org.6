Return-Path: <linux-kernel+bounces-386634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E299B462E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9EFB22078
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17A204F6B;
	Tue, 29 Oct 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WPlyYo5K"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDA5204085;
	Tue, 29 Oct 2024 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195760; cv=none; b=HjULB4GZKLG48FPv7ZbUgjTpbqgZc2MQE2g7VjwB3yJEX2/mDrwESLVUM5aXQdsXma5AqhpjGUsneRWUxU4Qt87tYC74Re1aQU7Pyi0uOLPNB2D39IonaGWTKlm6BEia+DuMBhWRQM7Gxqn41tM6c362Q/U4z7jxRY/Yb3n1OAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195760; c=relaxed/simple;
	bh=s3po9lkVh/27l1qvO5K/Xafsb99DX6/mAs+lO0mHOpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1mbVcw2Xa9CuP0uSlzNkKH0AaS7McVYkZnmvJOX7YMiryMNGNgeIXd+4D+cTnhti78IYK2YP/zboIEj1FDSKj5noO0p6gcJ0YXAu0uukABz0mvbWZxOth6PJHrALIKs1hhnLxGWpLiOBZV+wOk7f/9amzCiK1QVAYArYlvwvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WPlyYo5K; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=UeECk
	2NNGiU4afGhFyL6WxYiXpnwwPdwR71UMoipH+k=; b=WPlyYo5KbueiL+n/e+PkV
	zjiLcAhhcKb74u/uFHcjbpieA/BqZ7jgEG7yUIs2yC0xcD5EvEsWUT9Q523BKm/K
	NYxTY49pMfXqpu7bR/nnT/A9bLaUNoAvC7MEFNAx1A+M2YNLu3izSADppKzy03vs
	NirC1Z/BqWdmKjnppAzVq4=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3nxoCsSBn8+3dEA--.3291S7;
	Tue, 29 Oct 2024 17:55:24 +0800 (CST)
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
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v4 05/14] drm/rockchip: vop2: include rockchip_drm_drv.h
Date: Tue, 29 Oct 2024 17:54:58 +0800
Message-ID: <20241029095513.391006-6-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3nxoCsSBn8+3dEA--.3291S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyxKw45Wr48JrWfuF4fAFb_yoW8CFW3pF
	s8AFWUZrWxKFWjqr1DAF9Ikr4Fy3ZrCayxG3Z7G3W3ZF12gF1DGwnrW3s8JrZrXr42vF42
	krs3J34UCF42vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZVysUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwqHXmcgqJmjwgADs0

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
index 4776a227e62c8..a7f9f88869a6d 100644
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
index 59cd6b933bfba..bc001f7158476 100644
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


