Return-Path: <linux-kernel+bounces-425252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B03479DBF68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B902D164648
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 06:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B90156C74;
	Fri, 29 Nov 2024 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K3syNlT7"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C398184F;
	Fri, 29 Nov 2024 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732860723; cv=none; b=q9x1fKsyjUtkR1WsjqX6pmD9qPBBONQslo+Yfy6vOS34cjU0XlxjHcQfVIhLU9rG8EENFMEe8jsl9o4jukF6V/X0tCVEjoWVSoVvo42qF5SOes0M37mF8Wzr2xr4/FV1+J/XhvuYEXOyyAAQF6MKLZfvPaDoMU1rrGe9z4Q8DZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732860723; c=relaxed/simple;
	bh=K6WlBoWeGPmm2tsSpEPFp7kUB90lkxlWy/QI9C2co/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G/1sSasnmcbQXAFC8FrjuZDyNC/CwV8DLC61KJCeO07f93/Cghh25qUxk+QM89KFYmcY4Rrsc4+VPvTalcvLSerRKM7VJKAstFBJ3otCn1/fioRUUgDL8irvtf64wRwrnawJlPfBR+FG4HnXnULoGSgXqoZOw9Pu4ZTZUtpJuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K3syNlT7; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732860718; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QBxTC0OTZtLnjf64m0c0V5UiHQaS+QjTyzS/suaFSNk=;
	b=K3syNlT7ISuDFLc2PgXftoP+HIYH3RUpQk5qyxqyT3Y6Kd0VDlUkWpLSDksQJcPRJEVHqzXnasEfjhbVS/F6IDUwkOicUitUJhx5BgYVSL9Ij9aHh26a4uZypOQEjl1+ReWxE7bJTd5/dRZHnRn/6B2sj6Yu7z76KmfEtC3clpI=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WKSsNXL_1732860717 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 Nov 2024 14:11:57 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: robh@kernel.org,
	saravanak@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] of: base: Add missing parameter description to of_get_next_child_with_prefix()
Date: Fri, 29 Nov 2024 14:11:55 +0800
Message-Id: <20241129061155.52874-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function of_get_next_child_with_prefix() lacked a description for
the prefix parameter in its documentation. This patch adds the missing
description to ensure all parameters are properly documented.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=12178
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 4cba021c89d3..600236abb5d6 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -648,6 +648,7 @@ EXPORT_SYMBOL(of_get_next_child);
  * of_get_next_child_with_prefix - Find the next child node with prefix
  * @node:	parent node
  * @prev:	previous child of the parent node, or NULL to get first
+ * @prefix:     prefix string to match in child node names
  *
  * This function is like of_get_next_child(), except that it automatically
  * skips any nodes whose name doesn't have the given prefix.
-- 
2.32.0.3.g01195cf9f


