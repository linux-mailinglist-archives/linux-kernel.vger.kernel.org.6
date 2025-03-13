Return-Path: <linux-kernel+bounces-559003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B5CA5EE38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494AD3B2597
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1122620C1;
	Thu, 13 Mar 2025 08:40:42 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412F1EA7FC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855241; cv=none; b=C6UNrBcgbpElrFjcvaMk3PAzlIfDnsLr8x2yqd/yW26TW7I3KMSX7Q31MKhiMMRYlXaXutrZyU6duKI1jM6r9QSYVE+fI5/qNo3DE43gWyraVCPgtY2+nzjyrLiWdWZ0eoXhNH8OkPtI4TQComw6fPlEL+J+jh0dRo1zkbY1TxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855241; c=relaxed/simple;
	bh=5hofGVLuvv5HvKXqqs/LTfujpXCIvanrxTC9zjxAsRA=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=jafbkze8dX6bPSaOhyko1o6KDhQwqYWpC8dt+oLq81ol45CZctVIZl/rOpsCQR0Tl1nUs0EzEzZ0iHBru8dAXFIyxFvVIRfIHRlywGLEwxEW+DYe2GhG7OEkExXJBls2eY053hb8kIqAXNHg1+xvfmyTMJebbx/xgXOlMCTP0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZD1D10pS8z8R044;
	Thu, 13 Mar 2025 16:40:33 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 52D8eNQF021947;
	Thu, 13 Mar 2025 16:40:23 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 13 Mar 2025 16:40:25 +0800 (CST)
Date: Thu, 13 Mar 2025 16:40:25 +0800 (CST)
X-Zmail-TransId: 2afa67d299f9ffffffffb85-46491
X-Mailer: Zmail v1.0
Message-ID: <20250313164025540bRPvAP8qt5DGLTl-W2R_K@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHYyXSBubHM6IEZpeCB1dGYzMl90b191dGY4IHBhcmFtZXRlciB0eXBlIGluIGRlY2xhcmF0aW9uIGFuZMKgZGVmaW5pdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52D8eNQF021947
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D29A01.000/4ZD1D10pS8z8R044

From: YeXingchen <ye.xingchen@zte.com.cn>

The declaration of utf32_to_utf8 in the header file uses
bool maxlen as the parameter type, while the definition uses bool maxout.

This patch aligns the parameter name in the definition with the
declaration,changing maxout to maxlen to ensure consistency.

Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
fix the parameter
 fs/nls/nls_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 18d597e49a19..3bae9c201139 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -83,7 +83,7 @@ int utf8_to_utf32(const u8 *s, int inlen, unicode_t *pu)
 }
 EXPORT_SYMBOL(utf8_to_utf32);

-int utf32_to_utf8(unicode_t u, u8 *s, int maxout)
+int utf32_to_utf8(unicode_t u, u8 *s, int maxlen)
 {
 	unsigned long l;
 	int c, nc;
@@ -97,7 +97,7 @@ int utf32_to_utf8(unicode_t u, u8 *s, int maxout)
 		return -1;

 	nc = 0;
-	for (t = utf8_table; t->cmask && maxout; t++, maxout--) {
+	for (t = utf8_table; t->cmask && maxlen; t++, maxlen--) {
 		nc++;
 		if (l <= t->lmask) {
 			c = t->shift;
-- 
2.25.1

