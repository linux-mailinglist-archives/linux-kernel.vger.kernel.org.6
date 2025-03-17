Return-Path: <linux-kernel+bounces-563539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06E6A643C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4ACD189378D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9F21ABC3;
	Mon, 17 Mar 2025 07:32:44 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3A21A428
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196764; cv=none; b=ktxzKMsNcv0vj2TBQLZdDYkDyf85qcGI3mt6PkFAyXoxlJU6Zuu23oZ4ioraPCpwENRgzbKAt42JcNf74jnbH2FDUtHoll5rj7x/Yu+piWW3xa+MC/XijZU+SIAjCml2Dt5jrir0nTQ6ll7jA15xdqH073MPMfSuhm+lx1ppbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196764; c=relaxed/simple;
	bh=yxBJY9hn0PbgZwmLt5tNJjUe+0sd8eIglr1zrxbKBak=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=bEzQL4GxNTXg1fS6C8opxuBW/kahkn0wJeSJ6yS6yusLjqqdV2If9hzsQ+ESUmJvbYCE9gSlSX8W0ACbwgNdTEdkGogFTuoTTsK5wvxcESRL54cXKwIB7VJrB/BRY3QtkbA4ADeSf5Vao+OfDRvCrQc8zTblij+82vW0paE7lIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZGRWm1D0Xz4x5rs;
	Mon, 17 Mar 2025 15:32:36 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52H7WMag001719;
	Mon, 17 Mar 2025 15:32:22 +0800 (+08)
	(envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 15:32:24 +0800 (CST)
Date: Mon, 17 Mar 2025 15:32:24 +0800 (CST)
X-Zmail-TransId: 2af967d7d008ffffffffa00-71df4
X-Mailer: Zmail v1.0
Message-ID: <20250317153224647OjWUNNAviyd634961gnCh@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <tglx@linutronix.de>
Cc: <darwi@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0b29scy94ODYva2NwdWlkOiBSZXBsYWNlIGRlcHJlY2F0ZWQgc3RybmNweSgpIHdpdGggc3Ryc2NweSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H7WMag001719
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7D014.000/4ZGRWm1D0Xz4x5rs

From: FengWei <feng.wei8@zte.com.cn>

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

Signed-off-by: FengWei <feng.wei8@zte.com.cn>
---
 tools/arch/x86/kcpuid/kcpuid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1b25c0a95d3f..23a8fde2e203 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -312,8 +312,7 @@ static int parse_line(char *line)
 	if (line[0] == '#' || line[0] == '\n')
 		return 0;

-	strncpy(buffer, line, 511);
-	buffer[511] = 0;
+	strscpy(buffer, line, 511);
 	str = buffer;
 	for (i = 0; i < 5; i++) {
 		tokens[i] = strtok(str, ",");
-- 
2.25.1

