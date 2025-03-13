Return-Path: <linux-kernel+bounces-558951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944AA5ED75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F167A30B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4451D63C2;
	Thu, 13 Mar 2025 08:02:02 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852C2E3391
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852922; cv=none; b=i9pcs80UGLiVSg22RRRnJIfGmtfPqc1+1Tpk5WeZgrElW1RK6MnWLJQ3c0x/RgF63JuQG68DZg7wqULpLdrvlElFKfuef1Nhs7rRKc0xZoj+vyeeAzgUdEBqSXfe4oWr+4+75CfvuWk4QDPNHPGCOHJa4Z8RZWiAwPK83fDwwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852922; c=relaxed/simple;
	bh=81NE1tzJhmPFRrYpB9Bhj1MdMf5ZTyJLVw86l8UtWkw=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=h0qQ4VX5C/ijaH5rmEv57Wb2bgc0KWFuvVZIcep4RhN7g+oTauQYQEJzXOYvSBK9E039+Dma35QKZi0HCLmtQyBVSHVeidDyRUIt9KHTTHX9s8a7Zb2j551hF4Qp41aLfSBKqwBsRAmxhHxcSIrt+PhPlmlfOWZCY2bfD6/bWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZD0ML6Q7xz50FXX;
	Thu, 13 Mar 2025 16:01:50 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 52D81OQ4061308;
	Thu, 13 Mar 2025 16:01:24 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 13 Mar 2025 16:01:26 +0800 (CST)
Date: Thu, 13 Mar 2025 16:01:26 +0800 (CST)
X-Zmail-TransId: 2af967d290d6ffffffffc1c-704fe
X-Mailer: Zmail v1.0
Message-ID: <202503131601265834sSbkAuqH0NUydxGXf-Fa@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIXSBubHM6IEZpeCB1dGYzMl90b191dGY4IHBhcmFtZXRlciB0eXBlIGluIGRlY2xhcmF0aW9uIGFuZMKgZGVmaW5pdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52D81OQ4061308
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D290EE.004/4ZD0ML6Q7xz50FXX

From: YeXingchen <ye.xingchen@zte.com.cn>

The declaration of utf32_to_utf8 in the header file uses
bool maxlen as the parameter type, while the definition uses bool maxout.

This patch aligns the parameter name in the definition with the
declaration,changing maxout to maxlen to ensure consistency.

Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
---
 fs/nls/nls_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 18d597e49a19..1dc2f8c8916e 100644
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
-- 
2.25.1

