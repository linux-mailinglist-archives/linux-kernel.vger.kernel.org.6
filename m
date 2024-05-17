Return-Path: <linux-kernel+bounces-181866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D868C828C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570E4B21624
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15D23773;
	Fri, 17 May 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eRh03gnc"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDD22EE8
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715934410; cv=none; b=f/xwXnhRh95kkBCFfqMVwz3SBBXAECKItSkA21KkpE6qjhsk28bqZhhj9p9Ilcm2vsKUPpYaDiqLg6LdU+B8IpccGVj+6tPrEXSOt1WrkJ6+8NQsWZXntSjleONk7kbws5+iWzx3wZm8i0pNaMByLM+V3Nk5ykzFfq7eN1JgbHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715934410; c=relaxed/simple;
	bh=5C3Hp81s4s3ZpACNgAGSPMv8yBGEjdyfD4nTybsIhFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YpQpma39bTluoIRoqwNggr+yRIn+oaxpOYMBypJEWu+8GVEKoGGn4n6wCval68zmHlA3eI549vY+6muBHEL3yt6WVK+e8VVyG+R7kU8DNG32a8fPJeQXoOlI4EdF48mvgmCQbxLOxowFYsSaDMbtSv5v6UjB1qy159OQmcl2/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eRh03gnc; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715934399; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ok07d1vK/JMG0IYRwczMvV9yC90WTaW4HZWyrpjc2fM=;
	b=eRh03gnceOrWV+sH0VCUQulVd1SCRt5vv5dFdknWaezf02t55AYhpfZlmB4A+5Yt0SXG8/oGB6aQg6V8Wwg0aCaiMv8PLJz5TIy3LaSLIe9Bsq88P1vxVPjSjLrRbwCWfRkqTiMI+6WlCGUiOFBLxk5P2eU5xMaFzRPENxadTyE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W6e1kO8_1715934397;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W6e1kO8_1715934397)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 16:26:38 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: Update optc35_set_odm_combine doc to match kernel-doc spec
Date: Fri, 17 May 2024 16:26:37 +0800
Message-Id: <20240517082637.69928-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the function documentation comment for
optc35_set_odm_combine to conform to the kernel-doc specification.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 7c9faa507ec2..1f8516e5ce68 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -50,7 +50,9 @@
  * @optc: Output Pipe Timing Combine instance reference.
  * @opp_id: Output Plane Processor instance ID.
  * @opp_cnt: Output Plane Processor count.
- * @timing: Timing parameters used to configure DCN blocks.
+ * @segment_width: Width in pixels of each segment in a horizontal direction.
+ * @last_segment_width: Width in pixels of the last segment if it differs from
+ *			other segments.
  *
  * Return: void.
  */
-- 
2.20.1.7.g153144c


