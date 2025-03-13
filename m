Return-Path: <linux-kernel+bounces-558963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52053A5EDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFC83B08A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4CE26036A;
	Thu, 13 Mar 2025 08:10:17 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16039260363
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853416; cv=none; b=S6Ig2HfG2mmXAegnBgVgSBN1vKdHTNEFjtEX30OgYjzFEZIxuUMJAYsXlfRYz7T6pfW/dSWsRv06V4RB3yeujcDU6vGForq3aZRq9zYZ5CFbeza96QdjJWfhIPOfqyxguasx6e19K4NmB0R/zwZmyC82pZSKLr2rDow5dvBaHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853416; c=relaxed/simple;
	bh=Gx27QfC5MaFYN7WNYOHNmQnuZwilXKzKa7X85E4GdOw=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=p1Y6iLSECFeCkL0XgHoHV+vulxQb6QeBToBkkjIcpM4Fe9dQYcZwmnuyiU4gbBSkPwkPouXQJJsiqttjOuoGSnrLP1IAckB/0XLvlrHYISTvMET0Ibp6tGDVtkNs25Xf1jkEVZJTif0JvIoS3AVH1VY18JFvibva0k/9POtaqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZD0Xs2ykDz5B1Gq;
	Thu, 13 Mar 2025 16:10:05 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 52D89ufZ028904;
	Thu, 13 Mar 2025 16:09:56 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 13 Mar 2025 16:09:59 +0800 (CST)
Date: Thu, 13 Mar 2025 16:09:59 +0800 (CST)
X-Zmail-TransId: 2afa67d292d7ffffffff969-132a8
X-Mailer: Zmail v1.0
Message-ID: <20250313160959132rMOoPpNjSNTlB-E6rMOuj@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <brauner@kernel.org>
Cc: <jack@suse.cz>, <jeff.johnson@oss.qualcomm.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBubHM6IEZpeCB1dGY4c190b191dGYxNnMgcGFyYW1ldGVyIHR5cGUgaW4gZGVjbGFyYXRpb24gYW5kwqBkZWZpbml0aW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52D89ufZ028904
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D292DD.000/4ZD0Xs2ykDz5B1Gq

From: YeXingchen <ye.xingchen@zte.com.cn>

The declaration of utf8s_to_utf16s in the header file uses
bool maxlen as the parameter type, while the definition uses bool maxout.

This patch aligns the parameter name in the definition with the
declaration,changing inlen to len,maxout to maxlen to ensure consistency.

Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
---
 fs/nls/nls_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 18d597e49a19..547227669348 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -129,8 +129,8 @@ static inline void put_utf16(wchar_t *s, unsigned c, enum utf16_endian endian)
 	}
 }

-int utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
-		wchar_t *pwcs, int maxout)
+int utf8s_to_utf16s(const u8 *s, int len, enum utf16_endian endian,
+		wchar_t *pwcs, int maxlen)
 {
 	u16 *op;
 	int size;
-- 
2.25.1

