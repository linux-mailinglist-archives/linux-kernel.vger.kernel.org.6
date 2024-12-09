Return-Path: <linux-kernel+bounces-437510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC89E943E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85779166336
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B051122B8A4;
	Mon,  9 Dec 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Uwdyts3n"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395E022A1DA;
	Mon,  9 Dec 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747574; cv=none; b=acY4dhIZsjYnLSvur6s9gjT5/XHKH3cSJsX5BrzVDXGAKL7UDh11w+ExIdNf4hciJ/VP414yxjlKdTKJeZMPNhNze7afkZLzn7UnwZJq+k3esEXMepv9lT/W5UQXgC3eivWP/9IE/PfangzKQVTLSgTop3lB3phjiMagYXxgovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747574; c=relaxed/simple;
	bh=zY8U6jirt35+XUt86c/H4d/wQeTFbPhyAXQ0t/8nITU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhXFTcUXrtXZxDtZscam5L1Ynx9ARBdOWTUC8MjSqV6reDkSrid16z0TJOYnJ18TldcfvnmSsWfcDZ9bGn9zroG3iz0ixJA+X3xqw8qKH/Il97CRO7lIJ3PXgbMgz7gdkyWzxTxqK3YaKFm3bHRRpuEfNgc+PQNPPbjpAZEpHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Uwdyts3n; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=9crP3
	SREKkSxx736sa2oKsa+sVCJo5aVxepzxEFcojE=; b=Uwdyts3niBP+DoyyQUiON
	IyB9iWhjTwf0STLMebmZmXK4Mfs5safwqN5d0CQNgpJ+L7MRn7HsQyCBweAq/TOe
	8qxfPNuj7XjjKu7RNv+QACzoeFWyB2b9V7Po5L4OdL/HjgnZQTycCo9MIhDSu997
	0h7oiFFUgmNjqqPL17g5OU=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3fzdb41Znx6ziCA--.45968S2;
	Mon, 09 Dec 2024 20:32:30 +0800 (CST)
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
Subject: [PATCH v5 09/18] drm/rockchip: vop2: include rockchip_drm_drv.h
Date: Mon,  9 Dec 2024 20:32:24 +0800
Message-ID: <20241209123226.2781765-1-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3fzdb41Znx6ziCA--.45968S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyxKw45Wr48JrWfuF4fAFb_yoW8CFW5pF
	s8AFWUZrWxKayjqr1DAF9Iyr4Fy3ZrCayxG3Z3G3ZxZF12gF1DGwnrW3s5JrZrXr42vF42
	krsxJ34UCF42vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uu89_UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqR6wXmdW3c3pJwADs1

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
index 1f101a3c3942..106b164343ad 100644
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
index 0a3b22e8d14e..4cd4d17fe366 100644
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


