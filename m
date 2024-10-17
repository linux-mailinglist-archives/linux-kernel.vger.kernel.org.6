Return-Path: <linux-kernel+bounces-369187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF0E9A1A19
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98781283D35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D87A146013;
	Thu, 17 Oct 2024 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GrG2Pw1q"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABA339AC;
	Thu, 17 Oct 2024 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142357; cv=none; b=TRHDYiCH/teUeZypxkcmbcai+8MN4bQHxTW7Q485/CNfrGkXQKmGPG9vv44N33Eb7573aBbd2/Ha/dEZ6m/rVOU6QxCjHU1QBBjQPPAbtsXJk1o9uMR8w1wnxnmDazLpT/KvXmpPWRiB+W+66f1kOL9rT7Zdyu+J+jcTViwrRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142357; c=relaxed/simple;
	bh=SVrF9b9mtDQG/BX+lr7pFntbT74bXSFlVvAZBG34V30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHMeCEtEQPv/B753ZSN/2NxmlbJ1Vz56XFzY4Jn4kvZCHgoOYk98qj25fXxX4qDJqrExfioXNjgTc8ufxvyirlmDbMclW19TTKLZPBCgohYUG3aLtrQsAcHagqyyektFqrfZSu6vbmcvgdWoeqHSSXQ9y2GJidPPgjoGWFmWvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GrG2Pw1q; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729142351; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MXi1gJebnvlVRAS/v5Grm24bL98sPfzXgiClxlaoRZc=;
	b=GrG2Pw1qL2vn+DrICY3xy5eoSY1+/ywR75nTLqA8lAYZxOAu8HzvgyfleVcOcO+M1cuydek8PsuySLDThPzhgksRxGJTb2Fxmrao+V7GPkMcQE4YeFpsxE3QcA3jx3jzDRDB06jSgU/o+Wa8+x3+5lCX5UAgZEJ+YPbtXfAlBDY=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WHJgNDu_1729142350 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 13:19:11 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: codecs: Remove unneeded semicolon
Date: Thu, 17 Oct 2024 13:19:09 +0800
Message-Id: <20241017051909.4638-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes an unneeded semicolon after a switch statement.

./sound/soc/codecs/ntp8835.c:280:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11404
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/ntp8835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ntp8835.c b/sound/soc/codecs/ntp8835.c
index 97056d8de2bb..800bda6b49dd 100644
--- a/sound/soc/codecs/ntp8835.c
+++ b/sound/soc/codecs/ntp8835.c
@@ -277,7 +277,7 @@ static int ntp8835_set_component_sysclk(struct snd_soc_component *component,
 		ntp8835->mclk_rate = 0;
 		dev_err(component->dev, "Unsupported MCLK value: %u", freq);
 		return -EINVAL;
-	};
+	}
 
 	return 0;
 }
-- 
2.32.0.3.g01195cf9f


