Return-Path: <linux-kernel+bounces-563549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF12A643EA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9BA188F970
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A321ADD3;
	Mon, 17 Mar 2025 07:39:28 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D221ADB2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197167; cv=none; b=jxN2c9L62yZtaQLhXJV+d3+FuO5t9mLvR/LnX2xGGEeS5b1JTSELrr4iJULf0AjFomNyHEem4HotcBtSM0OlFipGBJ/Iri+7Kz6NbmPvYnrL7WA+kbtygLsj8NcRxgvb2GAcBqS/BSzLAgtcc5XlVPrO0NNG/cDsiEuki5lDPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197167; c=relaxed/simple;
	bh=lcNMaQoQX8zIG7AUlA3EMfuLCOfwqcPfI5+Zs+vDfFg=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Q8FEeLHPRxtTilHXVKsUmkhAlGKX58oodxIP5RN1qWnHBSGjvX22fBMFDQj2dm9TQojLj1ZAX3Pa3muoo8PjfngN6ngYnmxN7TTiRNjZnXVo0bbS1Rnua7SeTJxjPG4q5mxmJLDDWgxuMdXvJBUI4lZ8GPkFYpe1eaydtzN031o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGRgb1jRbz5B1Dq;
	Mon, 17 Mar 2025 15:39:23 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 52H7d7qA050121;
	Mon, 17 Mar 2025 15:39:07 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 15:39:09 +0800 (CST)
Date: Mon, 17 Mar 2025 15:39:09 +0800 (CST)
X-Zmail-TransId: 2af967d7d19dffffffffea4-7e28c
X-Mailer: Zmail v1.0
Message-ID: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <sagi@grimberg.me>, <kch@nvidia.com>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yang.tao172@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBudm1lOiByZXBsYWNlIG1heChhLCBtaW4oYiwgYykpIGJ5IGNsYW1wKGIsIGEsIGMp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52H7d7qA050121
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7D1AB.001/4ZGRgb1jRbz5B1Dq

From: LiHaoran <li.haoran7@zte.com.cn>

This patch replaces max(a, min(b, c)) by clamp(b, a, c) in the nvme
driver. This improves the readability.

Signed-off-by: LiHaoran <li.haoran7@zte.com.cn>
Cc: ShaoMingyin <shao.mingyin@zte.com.cn>
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index fcf4f460dc9a..30804b0ca66e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -819,7 +819,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 /* Convert a 32-bit number to a 16-bit 0's based number */
 static inline __le16 to0based(u32 a)
 {
-	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
+	return cpu_to_le16(clamp(1U << 16, 1U, a) - 1);
 }

 static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
-- 
2.25.1

