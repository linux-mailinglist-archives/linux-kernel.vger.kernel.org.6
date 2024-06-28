Return-Path: <linux-kernel+bounces-233363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B303891B616
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E0C1C22707
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F037165;
	Fri, 28 Jun 2024 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zf22Ee/j"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F728DBC;
	Fri, 28 Jun 2024 05:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719552259; cv=none; b=rfE8SjYu2EXPysGvWIDRnfcQFonOZ2uTADI8bIY9N/kqEpoyAlVyx3+sT6QKqdpLyIVXc/E1RwuBt45ZCbQ6P1U7Im+Ot6Wky9PFy4omtCAklUcdzkm6cjVv2HH9RVEc8+o8va/QvO5qMmn0z5Y0/wTndEX9HfK1GSzPtvGhhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719552259; c=relaxed/simple;
	bh=KAI9AScrTRHCr6QdrKTyuj7IOPB8d078ZRqKTQhd9hI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mFXc9icp3XXB2qRHievCJA2l3gGWv/lb1RwHZ0IwPx/2ND2nycc4i3Kk6C20C9Y+hlUxOjJ2CrLJnoPgI+scF7ZSABPcL7hc7AAFW5pr1Vch5EVDKFmR980HFPgZwzDCheaCoXUFtd8v2jc/2FG+ksXFASpiDXqrSrLdG96ixCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zf22Ee/j; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719552248; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5YG+Vtf9lpCwJoLbN/w6X/g6VhzIpD3Fm9Xobi8vOfE=;
	b=Zf22Ee/js2pl+9nT5SKTf5PHxlFSm6yS7CzTjQUD0mB8t6vlqy2ea589K17KULmJ7HXsvqSBdUJ2/8l9VuJaAPD+BuFvY7nfo0Vyej5rRHFEdvTKXbdl13BgD/vTAsWgakmv3/uTuVQ7bMpXNGxHxdI1AOqr1cWTIaK41z6GhTQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W9P5uGv_1719552247;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W9P5uGv_1719552247)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 13:24:08 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: Remove unneeded semicolon
Date: Fri, 28 Jun 2024 13:24:06 +0800
Message-Id: <20240628052406.36644-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./sound/soc/codecs/ak4619.c:757:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9442
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/ak4619.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4619.c b/sound/soc/codecs/ak4619.c
index cbe27abe1f50..8f2442482f72 100644
--- a/sound/soc/codecs/ak4619.c
+++ b/sound/soc/codecs/ak4619.c
@@ -754,7 +754,7 @@ static void ak4619_hw_constraints(struct ak4619_priv *ak4619,
 		default:
 			break;
 		}
-	};
+	}
 
 	constraint->list	= ak4619_sr;
 	constraint->mask	= ak4619_rate_mask;
-- 
2.20.1.7.g153144c


