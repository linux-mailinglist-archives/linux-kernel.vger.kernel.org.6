Return-Path: <linux-kernel+bounces-241866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE05D92806E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB91C230CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E8317995;
	Fri,  5 Jul 2024 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lgi3PM2D"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B883233;
	Fri,  5 Jul 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146538; cv=none; b=b7Omf7dUZb6Uz3ItWM930digG5GI4gZzsvBIrNdZHDssjBkDiMQZMXBk6Wo5EfqkKlvrDq91ZOl2UR38JIeDWmhQShFf+WkPT/sxI/lhE4FX8KDM+RCNy7027coLbwk1DVA9vPYL5Wy7hKowHOzDbLDFVM3AO7V8BVMtX3EK+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146538; c=relaxed/simple;
	bh=yEAwiDifltp4+CfLq5oQvdbDHPwMoz5Qf7jeWGu+ZjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jiWQzqADbUN/M3YnoFIBvdlvivjtacHsxscespJT9PPGfG1lCkq0GjxS2sT8GbNkuDjVICmDMTZZOtzzQc4fAm7FiajidNhi+BT/CCAVPytqXchdhVY5LhKo2jpoLX98oKUlEVzEco8bwVfv/aGTam7WMROn8PGoL7K5IFLQyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lgi3PM2D; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720146526; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=yezpDgfalefPHn3TMzBR/EZX/+s15HPSuCQzMIVwVuw=;
	b=lgi3PM2DbLBYjdLWVbAbpSjDr/2Nwii7DzL2mpRCQOERoM+XS/iUWhk42TWP9rQVsUaJ4I0cAuv3/G0m6n9BnUIM8VwvTo0TLQbiMzkv3t5OY9NJL0jgkhKjiMiOYA4DoH/oTTUwIDqOEu3pBTRZueJBmxphxmHEwh1jAdB6qtA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=wodemia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W9t-z9._1720146524;
Received: from localhost.localdomain(mailfrom:wodemia@linux.alibaba.com fp:SMTPD_---0W9t-z9._1720146524)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 10:28:46 +0800
From: Tao Zou <wodemia@linux.alibaba.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Tao Zou <wodemia@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] zh_CN/admin-guide: one typo fix
Date: Fri,  5 Jul 2024 10:28:41 +0800
Message-Id: <20240705022842.51451-1-wodemia@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix one chinese typo error.

Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
---
The previous translation patch v4 has already been appied, and the changes from v4 to v5 were missed.
This patch is one typofix, and includes the changes from v4 to v5.
 
 Documentation/translations/zh_CN/admin-guide/numastat.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/admin-guide/numastat.rst b/Documentation/translations/zh_CN/admin-guide/numastat.rst
index c0f54d9a6b05..4d9817b91870 100644
--- a/Documentation/translations/zh_CN/admin-guide/numastat.rst
+++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
@@ -13,7 +13,7 @@ Numa策略命中/未命中统计
 
 所有数据的单位都是页面。巨页有独立的计数器。
 
-numa_hit、numa_miss和numa_foreign计数器反应了进程是否能够在他们偏好的节点上分配内存。
+numa_hit、numa_miss和numa_foreign计数器反映了进程是否能够在他们偏好的节点上分配内存。
 如果进程成功在偏好的节点上分配内存则在偏好的节点上增加numa_hit计数，否则在偏好的节点上增
 加numa_foreign计数同时在实际内存分配的节点上增加numa_miss计数。
 
-- 
2.39.3 (Apple Git-146)


