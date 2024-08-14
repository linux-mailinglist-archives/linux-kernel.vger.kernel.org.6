Return-Path: <linux-kernel+bounces-285800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140B9512ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22AD286DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5635E339A0;
	Wed, 14 Aug 2024 03:10:42 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB71CAA2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605041; cv=none; b=hjuWv0UdqeWlCwyfjFnIsZlH8UP7mTIDjt+VSe2lDUy06ca0MF4c2m5bGJT/y+jOdcIBkAKvEM2IKRfn1GsWZO1dmAcnqG+nkFNTigKka1FeIRRVA87hwBdvvMI25l1QiB8ZljVmFLqeDUx/5HmKrsQJ6Jd2yz1jQ0JwVCb6B4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605041; c=relaxed/simple;
	bh=OTxT8T0qivJ9vX8SANxrZ/y/s8fwsAgbbxnKenve2Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D5HitduLaHmFeWC22gff67+1DN2NjhW84/yfKMxwHAt8GTwSvnpdG3zBQIN7h5ntpeaHxPjfbSaeuVakKuXaFdkSd8cteCF+oVEx8dF4+w63Q75stJ85YQuJ3Y1RqF2fHkAcBK/Y0nGzfM4IaUeeq8gli7F82UUHdH5v0XQm5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966bc1f71d3a-3fd3b;
	Wed, 14 Aug 2024 11:07:29 +0800 (CST)
X-RM-TRANSID:2ee966bc1f71d3a-3fd3b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566bc1f5bd63-21e67;
	Wed, 14 Aug 2024 11:07:29 +0800 (CST)
X-RM-TRANSID:2ee566bc1f5bd63-21e67
From: bajing <bajing@cmss.chinamobile.com>
To: w.d.hubbs@gmail.com
Cc: chris@the-brannons.com,
	kirk@reisers.ca,
	samuel.thibault@ens-lyon.org,
	speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org,
	bajing <bajing@cmss.chinamobile.com>
Subject: [PATCH] speakup: i18n: modify incorrect comments
Date: Wed, 14 Aug 2024 11:00:17 +0800
Message-Id: <20240814030017.2094-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regarding the text part, the comment was written incorrectly, so it needs to be modified.

Signed-off-by: bajing <bajing@cmss.chinamobile.com>
---
 drivers/accessibility/speakup/i18n.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/i18n.c b/drivers/accessibility/speakup/i18n.c
index d62079b1661f..10c7cdc685f7 100644
--- a/drivers/accessibility/speakup/i18n.c
+++ b/drivers/accessibility/speakup/i18n.c
@@ -541,7 +541,7 @@ static bool fmt_validate(char *template, char *user)
  * If the function fails, then user_messages is untouched.
  * Arguments:
  * - index: a message number, as found in i18n.h.
- * - text:  text of message.  Not NUL-terminated.
+ * - text:  text of message.  Not NULL-terminated.
  * - length: number of bytes in text.
  * Failure conditions:
  * -EINVAL -  Invalid format specifiers in formatted message or illegal index.
-- 
2.33.0




