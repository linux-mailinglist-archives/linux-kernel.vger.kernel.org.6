Return-Path: <linux-kernel+bounces-446331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC289F22F3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 10:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF86165714
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EBF145B22;
	Sun, 15 Dec 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ohA3nqr9"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D79C28FD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734254428; cv=none; b=HcH/SxqbTGjqxBZ8jH2v2Nb6WL2qvDG4pEEJf598lpLIHs+uhplsDLcBFkRrZgiNRkxVQYDwv7kjDorg1LfuPD0I5BU77CSXiebnlFAb+wuOB0/VdlG6A/5XTcNgsJIpuiwpVUA2b5gMGK0XndyoTdeg0AobPrYSo4BIsjMK0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734254428; c=relaxed/simple;
	bh=V/4pINK9w59CVTrNc4wVSxVlbF1WH8ap1SoMaEMTf8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwvlHv4UFovzHmNdp0rPimRhojEglzI1sPKUQjTTMOPUrA+PfRDueUv0WIQm2x+LPAimgQG+RM+/Ck+khJWH2lfd1zHbIf5QZoMSQsRyCpoFnFeEkFw54i3A4Jhm+z+kweVM/heFKtu+5NK25S1SEs9Au6tD30Sbn0zxy1Rb2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ohA3nqr9; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=oadAC
	AsbvOl2AeR1k5LHO8GtmYMaw6HBWzUdLwJQTp0=; b=ohA3nqr96KikZ1YWkZ7n1
	HZ3OYFCe+vozwvMcWZWrZnimeEwTOuwKthkNuiVeQ7vstn8jFdiUYc5pLpQ6KdZ5
	4/Y8DqVs4Xu6kb5QWrIFtF5ws3XW6B5m7QQfHSNcB7fjymq44WkOw2xfNlKK57cq
	L6tFH/+aBq62wq+q8P7X7M=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3v+oQn15nIwqaHA--.23673S2;
	Sun, 15 Dec 2024 17:19:16 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: mripard@kernel.org,
	neil.armstrong@linaro.org,
	cristian.ciocaltea@collabora.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/bridge: synopsys: Fix Copyright Writing Style of dw-hdmi-qp
Date: Sun, 15 Dec 2024 17:19:06 +0800
Message-ID: <20241215091911.3446653-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3v+oQn15nIwqaHA--.23673S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw47ZrW7CF15Cr1xtF43Jrb_yoW3tFg_CF
	4xJr1DXrW0kFnYvanxAr43X3sFvw15uFWxWF18K3sxJa18Zrs5W3sxuFyUXrn8Zr1xtFZr
	Ja45WF45AFnIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1ZmR5UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0ha2Xmdek2W6JAAAs9

From: Andy Yan <andy.yan@rock-chips.com>

The standard writing style should be: Co., Ltd.
This fix the mail server warning:
DBL_SPAM(6.50)[co.ltd:url];

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
index 2115b8ef0bd6..74088e0d1d87 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) Rockchip Electronics Co.Ltd
+ * Copyright (c) Rockchip Electronics Co., Ltd.
  * Author:
  *      Algea Cao <algea.cao@rock-chips.com>
  */
-- 
2.34.1


