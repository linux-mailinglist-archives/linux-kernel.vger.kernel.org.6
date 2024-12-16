Return-Path: <linux-kernel+bounces-447140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F19F2DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD61B1888958
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556F5202C2D;
	Mon, 16 Dec 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hzyq0Oh5"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F07202C4F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343700; cv=none; b=s+vHPgcYujkLbL8RzqEPxUByeKn6rawJUkc7ICIU+Zop/QEgSzLJVZCUJldAYcedwUnWSly1l1qqfDWTzLV2MQj92/eXez3Y834qTOIoPVg5eVEEurKfUF+ctgQCq22EJF52SAgcCFgHKtb6PLXrVOR5f/Ql4rCW5tE5FgF7/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343700; c=relaxed/simple;
	bh=mgCNpCWyAwdq2LpeJX81AtExmp/v8YsfFzgHrS+rTsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubYF9HfrIK95rRSl7rDk+dQhUfxyWZPZ1TmVB0vGFPh6EZCLWGm1XYQmNwKajD5Urdwq298tIlcp3stRnPfMOYuFDkeG66hut3RmUrp9OS6WYNjEeBXsPuS6wx3QqdW+6ox+Ioa7eYDlFVMG00U/J2DccatTt+oWdEQqRLxWH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hzyq0Oh5; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Hu/Hk
	WJsufjsnAhs5V/fCrWR+2p7iuXYpq5tnEE/SaU=; b=Hzyq0Oh5DOBCd7GfrhB6G
	VgQgwbfTRNadhG6UQY+e2GSCAlUx3aQKhsuIoPeznMyPkgI+4sxLngq7OgRsWCR2
	BCgZ05X+zY2vP8k2SrU8HQ1J2vDd1r6ZJmJSWgvQIUOBmkPcHmVzECsdc2eBI//m
	VC3+Hlxzo9OwZ2p0eEslMU=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3NzDs+19nesfFAw--.35836S2;
	Mon, 16 Dec 2024 18:07:43 +0800 (CST)
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
Subject: [PATCH v2] phy: rockchip: phy-rockchip-typec: Fix Copyright description
Date: Mon, 16 Dec 2024 18:07:24 +0800
Message-ID: <20241216100739.3726293-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NzDs+19nesfFAw--.35836S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1UCrW8uw4rZF1rCw1kGrg_yoWDtFX_K3
	WSvw1UXr4ktFZ5Aw1DJayxW34qya4j9a1kuFsayF98J3WDt34vqrykXr12qF15GF4SkrZ7
	Cas0vFy7AFyaqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1LFxUUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwa3Xmdf8wjfLAACsu

From: Andy Yan <andy.yan@rock-chips.com>

The company name has update to Rockchip Electronics Co., Ltd.
since 2021.
And change Co.Ltd to Co., Ltd. to fix mail server warning:
DBL_SPAM(6.50)[co.ltd:url];

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>

---

Changes in v2:
-  Use uppercase (C) part for consistency.

 drivers/phy/rockchip/phy-rockchip-typec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 122ae0fdc785..d9701b6106d5 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author: Chris Zhong <zyw@rock-chips.com>
  *         Kever Yang <kever.yang@rock-chips.com>
  *
-- 
2.34.1


