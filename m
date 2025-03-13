Return-Path: <linux-kernel+bounces-558994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55152A5EE20
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802FB17B8C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC91260360;
	Thu, 13 Mar 2025 08:36:19 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A31F9A86
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854979; cv=none; b=q8HPaWnIHCq0bst9Q1a3P5KJ4GbS6mmjEVGcVIlJx7h/OPbzEoBnGX0Cxkw0f339NqF0E6vIiKEYtlHdY0LRbh7xcQOp4+g0eKM4kHO5xZds7Cwyxk6QN2CJCum3xcbYG9NutDfexhvKegJ/OJuoevtq6FHmwvHOp6+uF8UwaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854979; c=relaxed/simple;
	bh=dmlN4JUiD9wMEg2qdzgPhDxOT3/tp0H5J+YHmxyj5lM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=scLZQbc3dID80S4zSYXisgssDjRVuwseueKC4ETcERTPkEgZQs9PSY9dwna5eLu3PV1sDmYq5R1qu6GpqBVHCbb4a/IrqaoJsi4iuADXL6bcbY4816UbXgSUTQXXRozs84GCAyE/blKEwEvt1vh6RVUYkE25MJFtTec24Z0uJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZD17205bDz5B1Hg;
	Thu, 13 Mar 2025 16:36:14 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52D8ZweF063484;
	Thu, 13 Mar 2025 16:35:58 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 13 Mar 2025 16:36:01 +0800 (CST)
Date: Thu, 13 Mar 2025 16:36:01 +0800 (CST)
X-Zmail-TransId: 2afc67d298f1ffffffffe6d-39786
X-Mailer: Zmail v1.0
Message-ID: <20250313163601139fRqick9X3NNePcVQzW3na@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <brauner@kernel.org>
Cc: <jeff.johnson@oss.qualcomm.com>, <jack@suse.cz>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBubHM6IEZpeCB1dGY4c190b191dGYxNnMgcGFyYW1ldGVyIHR5cGUgaW4gZGVjbGFyYXRpb24gYW5kwqBkZWZpbml0aW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52D8ZweF063484
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D298FD.004/4ZD17205bDz5B1Hg

From: YeXingchen <ye.xingchen@zte.com.cn>

The declaration of utf8s_to_utf16s in the header file uses
bool maxlen as the parameter type, while the definition uses bool maxout.

This patch aligns the parameter name in the definition with the
declaration,changing inlen to len,maxout to maxlen to ensure consistency.

Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
---
v1->v2
fix the parameter
 fs/nls/nls_base.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 18d597e49a19..fcce6ff1380a 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -129,24 +129,24 @@ static inline void put_utf16(wchar_t *s, unsigned c, enum utf16_endian endian)
 	}
 }

-int utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
-		wchar_t *pwcs, int maxout)
+int utf8s_to_utf16s(const u8 *s, int len, enum utf16_endian endian,
+		wchar_t *pwcs, int maxlen)
 {
 	u16 *op;
 	int size;
 	unicode_t u;

 	op = pwcs;
-	while (inlen > 0 && maxout > 0 && *s) {
+	while (len > 0 && maxlen > 0 && *s) {
 		if (*s & 0x80) {
-			size = utf8_to_utf32(s, inlen, &u);
+			size = utf8_to_utf32(s, len, &u);
 			if (size < 0)
 				return -EINVAL;
 			s += size;
-			inlen -= size;
+			len -= size;

 			if (u >= PLANE_SIZE) {
-				if (maxout < 2)
+				if (maxlen < 2)
 					break;
 				u -= PLANE_SIZE;
 				put_utf16(op++, SURROGATE_PAIR |
@@ -156,15 +156,15 @@ int utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
 						SURROGATE_LOW |
 						(u & SURROGATE_BITS),
 						endian);
-				maxout -= 2;
+				maxlen -= 2;
 			} else {
 				put_utf16(op++, u, endian);
-				maxout--;
+				maxlen--;
 			}
 		} else {
 			put_utf16(op++, *s++, endian);
-			inlen--;
-			maxout--;
+			len--;
+			maxlen--;
 		}
 	}
 	return op - pwcs;
-- 
2.25.1

