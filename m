Return-Path: <linux-kernel+bounces-446332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 374149F22F6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 10:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45E91886771
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB21145B22;
	Sun, 15 Dec 2024 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bT+tKCqe"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648F017BD6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734254726; cv=none; b=bnJS9QVE6DGlVdkK8fKaupO+DnFJFSOo1YkYVSbVNT4yVE2LTfihr9bs5xTNcBHILxnhwPq91L0fc0NtoaHcCwOhrMq2qbNLzG17okqaveYHcCuQ9lk42Eh7FQjUyRLoNlOYua6U0gg6JrFb3TqUH6D/Kk3kidt5vBK00qLABAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734254726; c=relaxed/simple;
	bh=FH5+OMWG2bu2kihVoaSgH+PZFGr0u+Y3tsqgpvDMGHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBOeCWfgXWHqcxuraTaRHEBaNAsBEjeP80otbqnT2Cyh8CQykgpnXfUIxK7/zCWZEpP2t8B47dm06zdVA9n1isEqqwcj7NzGCoy9g2y+iToab/98/UuoIbzO62FI8Ml146TBTKNdHHEFO58H5cM6njuc95xqkg5qoTXfhGxkbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bT+tKCqe; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=45LQY
	2ea5U3KK7KhJhTWTw1zr3MzGiWN++5h6tRZ1mU=; b=bT+tKCqeZRo5HDW1HyKw2
	Gl+cWLScRIJzvoh4tgA9Fp8xW1gRarYDW1gBnFVKuliQj5mRlBhYG+8G4/yiZnKK
	h/sstLTlx32k4Jyb+1engQZ9zfC/iPiK6e9s24X+FkkOoEi7ExPyCHVWydVHj9ep
	qM4p9KoyxY7YDCiGKMMBvM=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCXjkZaoF5nGQvMAg--.20181S2;
	Sun, 15 Dec 2024 17:24:45 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: kishon@kernel.org,
	linux-phy@lists.infradead.org,
	vkoul@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kever.yang@rock-chips.com,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] phy: rockchip: phy-rockchip-typec: Fix Copyright description
Date: Sun, 15 Dec 2024 17:24:40 +0800
Message-ID: <20241215092441.3447155-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXjkZaoF5nGQvMAg--.20181S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1UCrW8uw4rZF1rCw1kGrg_yoWfCrXEkw
	1Sqw1UXw4vqFn5Jw1DJa47W34qyw1jga1kuFsakF98J3WDtwnYqryrZr17XF15Gr4SkrZ7
	Cas0vFy7AFyaqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbhZ2DUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQu2XmdemAWFmgAAsx

From: Andy Yan <andy.yan@rock-chips.com>

The company name has update to Rockchip Electronics Co., Ltd.
since 2021.
And change Co.Ltd to Co., Ltd. to fix mail server warning:
DBL_SPAM(6.50)[co.ltd:url];

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/phy/rockchip/phy-rockchip-typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 122ae0fdc785..7b1dba252ce9 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (c) Rockchip Electronics Co., Ltd.
  * Author: Chris Zhong <zyw@rock-chips.com>
  *         Kever Yang <kever.yang@rock-chips.com>
  *
-- 
2.34.1


