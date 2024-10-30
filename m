Return-Path: <linux-kernel+bounces-388046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7391C9B59CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9061C22574
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6E193075;
	Wed, 30 Oct 2024 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TnwBZnon"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC13398E;
	Wed, 30 Oct 2024 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254260; cv=none; b=Z8TkhV9zQE+H7fr9s3DTALJIQmJ+b7qKZBhdd2M5KspcM/xHJzuiVWfO5a9gUzOBsGR4oL5aC1/yNyz9rFPEKrtJsq40S+jF83JRKf+FNXogjhPzzgdCVSNFr1h0zhhqrMYhUrsjSL7rmUisSj+A5WqTMr/tgjACvhH+X9ALJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254260; c=relaxed/simple;
	bh=Tp7p9bw0nbn5UG+Dh4fqcVNN3VwcSQe5dBOAqyx1hmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pk7C9d5Rts6T3/INyTYQY9ZJk5zKRhl3hNhZ10kkRpu2EC1lRxfX+1Mn0Bl1VJvYF+456gr6aGZ9zB5BFqyNnWzWr88CsDKhWECePM63PxO+4M8FRfGGbkx0+fNL9ScEZMeQLSH3USS+q1eG8ZZkXCcUAbxztPt7cxESR2fJZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TnwBZnon; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730254253; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=df2OEQ9QZRRyJfgqE2G0UwgUL06fg4jkoq4ROUQvyDA=;
	b=TnwBZnonGHgWmnQnkqWExTzILb4HdcMb/sEUMLTgcbHnrWjTXj9XfahQFc0caM64s0vqsCB+BabhU0pR7VLAfdylYEOeINTGo1wYaJ6ffcV8KCCmL7qPuACMwbQQvJuBMjhk2Bd9FgIjgf+rLGEGT33/FyT6KWqmOqhpbrwcrik=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WIC47VE_1730254248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 10:10:53 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: david.rhodes@cirrus.com
Cc: rf@opensource.cirrus.com,
	povik+lin@cutebit.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: cs42l84: Remove unused including <linux/version.h>
Date: Wed, 30 Oct 2024 10:10:47 +0800
Message-Id: <20241030021047.70543-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./sound/soc/codecs/cs42l84.c: 15 linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11570
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/cs42l84.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l84.c b/sound/soc/codecs/cs42l84.c
index 47731cdc0e67..53a6cf6e445d 100644
--- a/sound/soc/codecs/cs42l84.c
+++ b/sound/soc/codecs/cs42l84.c
@@ -12,7 +12,6 @@
 #include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
2.32.0.3.g01195cf9f


