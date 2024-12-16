Return-Path: <linux-kernel+bounces-447144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077369F2DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B52E1629F9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D54C202C43;
	Mon, 16 Dec 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hqhQggRh"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E31FF7D0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343883; cv=none; b=nLXmnu6cqgcodvDQgatArgv1Yg5VZ9xzsFu5dB7bgIhL3Jtb6oYnkPB7EPpdJQQ5AzFOpX+4clkyhh7Cwvpycc2M/rW0cNPMQ+j1rgc9veiSZHH9e2N2UepEjivQTbvsodRDSAEDdLXlsJkxTmVp/NCQRf39P3O3WHbAmF+Qq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343883; c=relaxed/simple;
	bh=YxYRH5KzCCtF9NHkeoZaI6a0mX9Vln/3CI5zSubYanA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cNH21IPCda02Zy7vsoefG5WaY6U6jt+dcJW+t5PlYLgfeO9cFaXlgTz0okOyguGFIBhqfdja41mdUZ/EWBOGdA6l0M0XGflM/0d34sQsSzQfTl0lOW4Fh86Q+BA8zCDuNwGDQ9j8jkzhEijLAqMQSNWVcN7CgchbUZhHl9MAy/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hqhQggRh; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=S6qnJ
	txja4ClILgX/c0Vlv2awsUTJDJB43+KIjN/jV0=; b=hqhQggRh/PstSiDGwP6pQ
	U7qflVUhOcvga1qWLv3r6x5NLtbTNUQvC8+YkOF/tajUc9hAvFOaheVAQqZFDwWF
	xJczq9RrxvcQZuXCLfG9T7yzgK/xdhTFgFm1bmRWjSI9GZBzbJp934OyKVqR/8Qr
	7EMAOSsIiAKESciSBgzL6w=
Received: from ProDesk.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAHs7KI_F9n2qUHBg--.10101S2;
	Mon, 16 Dec 2024 18:10:20 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: mripard@kernel.org,
	neil.armstrong@linaro.org,
	cristian.ciocaltea@collabora.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2] drm/bridge: synopsys: Fix Copyright Writing Style of dw-hdmi-qp
Date: Mon, 16 Dec 2024 18:10:03 +0800
Message-ID: <20241216101015.3726517-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAHs7KI_F9n2qUHBg--.10101S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw47ZrW7CF15Cr1xtF43Jrb_yoWfKFg_CF
	48tr1kX3y0kFnYvanxAF43Z3sFv34UuayxXF1kKrn5Ja1kZrn5W3sruF9rXFnxZF1xKFZr
	Jay5XF4jyFnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8hID7UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRa3Xmdf+hNAZgABsg

From: Andy Yan <andy.yan@rock-chips.com>

The standard writing style should be: Co., Ltd.
This fix the mail server warning:
DBL_SPAM(6.50)[co.ltd:url];

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

---

Changes in v2:
- Use uppercase (C) part for consistency.

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
index 2115b8ef0bd6..72987e6c4689 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) Rockchip Electronics Co.Ltd
+ * Copyright (C) Rockchip Electronics Co., Ltd.
  * Author:
  *      Algea Cao <algea.cao@rock-chips.com>
  */
-- 
2.34.1


