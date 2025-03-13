Return-Path: <linux-kernel+bounces-559027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ADFA5EE86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D50519C0420
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC2F262D16;
	Thu, 13 Mar 2025 08:52:57 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C21EFF98
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855977; cv=none; b=C/n6upju/WG1Zjqv51i19c6cJlLg+MbatFtbPuUkhp+5uKbYV5blneGeUlzCWfxYkngt4rQrk9MYB5CcFDgQRWh+6aYyglUBsV2PDyPkrG6CfrqqgkThVgscIaoJaS8Qr0KSdVbSsuVYHyYrlAg/qcp97R5pfMqmY0CMyIy+E2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855977; c=relaxed/simple;
	bh=Aj37OrVDyo0VAV9ndPxxRLEZSEuDHPou2KW6wZslDK4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=RoEwJ29c4MrE24UzxlFvuUx1YTuaPd/x+14ZVgvLXkkeI1A44naVB3ZQ9LjMjMDGlTPF7574aLvLsGIAcZ9IdRRFLRB9PbDmLNkUbF9b4SS85sNZLRUo3XSkk4Tz07rgwFFWmMIRPJ0+tR045su0cclN1gUF/lnk1lxwwsNDo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZD1V94qrSz4x5pd;
	Thu, 13 Mar 2025 16:52:49 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 52D8qRE5086854;
	Thu, 13 Mar 2025 16:52:27 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 13 Mar 2025 16:52:30 +0800 (CST)
Date: Thu, 13 Mar 2025 16:52:30 +0800 (CST)
X-Zmail-TransId: 2af967d29cceffffffff9e4-c826e
X-Mailer: Zmail v1.0
Message-ID: <20250313165230561l6bijg5xALudLL3FN303g@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIXSBubHM6IEZpeCB1dGYxNnNfdG9fdXRmOHMgcGFyYW1ldGVyIHR5cGUgaW4gZGVjbGFyYXRpb24gYW5kwqBkZWZpbml0aW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52D8qRE5086854
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D29CE1.000/4ZD1V94qrSz4x5pd

From: YeXingchen <ye.xingchen@zte.com.cn>

The declaration of utf16s_to_utf8s in the header file uses
different parameter type with definition.

This patch aligns the parameter name in the definition with the
declaration,changing maxout to maxlen, inlen to len to ensure consistency.

Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
---
 fs/nls/nls_base.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 18d597e49a19..09b6dbc599c9 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -183,27 +183,27 @@ static inline unsigned long get_utf16(unsigned c, enum utf16_endian endian)
 	}
 }

-int utf16s_to_utf8s(const wchar_t *pwcs, int inlen, enum utf16_endian endian,
-		u8 *s, int maxout)
+int utf16s_to_utf8s(const wchar_t *pwcs, int len, enum utf16_endian endian,
+		u8 *s, int maxlen)
 {
 	u8 *op;
 	int size;
 	unsigned long u, v;

 	op = s;
-	while (inlen > 0 && maxout > 0) {
+	while (len > 0 && maxlen > 0) {
 		u = get_utf16(*pwcs, endian);
 		if (!u)
 			break;
 		pwcs++;
-		inlen--;
+		len--;
 		if (u > 0x7f) {
 			if ((u & SURROGATE_MASK) == SURROGATE_PAIR) {
 				if (u & SURROGATE_LOW) {
 					/* Ignore character and move on */
 					continue;
 				}
-				if (inlen <= 0)
+				if (len <= 0)
 					break;
 				v = get_utf16(*pwcs, endian);
 				if ((v & SURROGATE_MASK) != SURROGATE_PAIR ||
@@ -214,18 +214,18 @@ int utf16s_to_utf8s(const wchar_t *pwcs, int inlen, enum utf16_endian endian,
 				u = PLANE_SIZE + ((u & SURROGATE_BITS) << 10)
 						+ (v & SURROGATE_BITS);
 				pwcs++;
-				inlen--;
+				len--;
 			}
-			size = utf32_to_utf8(u, op, maxout);
+			size = utf32_to_utf8(u, op, maxlen);
 			if (size == -1) {
 				/* Ignore character and move on */
 			} else {
 				op += size;
-				maxout -= size;
+				maxlen -= size;
 			}
 		} else {
 			*op++ = (u8) u;
-			maxout--;
+			maxlen--;
 		}
 	}
 	return op - s;
-- 
2.25.1

