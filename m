Return-Path: <linux-kernel+bounces-569272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0AA6A0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97168189AAC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3439A1F8739;
	Thu, 20 Mar 2025 07:53:27 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420381DE2C2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457206; cv=none; b=QzrXZNpSshEcKBid5/LaxU5iWUYgI8gP99zJLkz5YVcsLFumpxq0XoFA3ko4zD8sxUDUHsK3+1XWWzweG501tm9SChEh8F18COhP/8uN8IBYNL6I7g4wcQWfHgFnNNvUImjA8VoaMUi9tilntDoeaTP2YvJKBFEn43lM3IZcXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457206; c=relaxed/simple;
	bh=suy89rMcu040FEhcNBI1goNpZNOfv1uLfrVKm9V8kIE=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=t2xKDjJm9V6BaGBqg55lHiyX4a2wD3swnP21mBWJAUkLLKi2tSDK7mcc3hxZ8frei0w0Y1C0az61cDfLH4v00iqerGEREduc07b8i+bETkBztSckkruB1+q37kUflQhMKPTssmHdT6fI3jqRpItZ4yspA4/bpQUMbdeJ+wp2bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZJHr804CBz50FXg;
	Thu, 20 Mar 2025 15:53:12 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 52K7qwbN070824;
	Thu, 20 Mar 2025 15:52:58 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 20 Mar 2025 15:53:00 +0800 (CST)
Date: Thu, 20 Mar 2025 15:53:00 +0800 (CST)
X-Zmail-TransId: 2af967dbc95c35f-2e3a9
X-Mailer: Zmail v1.0
Message-ID: <20250320155300346qoM6J3iYhvw5QD7AfBiqo@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHYyXSBudm1ldDogcmVwbGFjZSBtYXgoYSwgbWluKGIsIGMpKSBieSBjbGFtcCh2YWwsIGxvLCBoaSk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52K7qwbN070824
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67DBC968.000/4ZJHr804CBz50FXg

From: Li Haoran <li.haoran7@zte.com.cn>

This patch replaces max(a, min(b, c)) by clamp(val, lo, hi) in the nvme
driver. The clamp() macro explicitly expresses the intent of constraining
a value within bounds, improving code readability.

Signed-off-by: Li Haoran <li.haoran7@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v1->v2
Swap the arguments into a sane order.
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index fcf4f460dc9a..7b8a1483da2d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -819,7 +819,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 /* Convert a 32-bit number to a 16-bit 0's based number */
 static inline __le16 to0based(u32 a)
 {
-	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
+	return cpu_to_le16(clamp(a, 1U, 1U << 16) - 1);
 }

 static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
-- 
2.25.1

