Return-Path: <linux-kernel+bounces-428998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1D19E16A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB629B30425
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29D1DE3A7;
	Tue,  3 Dec 2024 08:42:17 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7A186284
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215336; cv=none; b=cpX2dEAsY2P79r5iw6l9bKo3puhebIKsOMw+BfVLzzex8pvlKWw+imXiSLR20fZPfYLLd5EEtY0oIJWehXjgGW1WzA5cYNKwGoR7ZNiZMxL0aMrxrCet+RTjnGu5/h8XNmFYJA3016GbQtO2oqatFimAyqZm370ZvZ2E8aMggR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215336; c=relaxed/simple;
	bh=Rk1yRnp4ZmebIHn/c6UGvY0Tpybf6YqolRBTyqRfDYU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rf9D22GRxPWlYKFN4ad9LQ2l69ZT27cfYbFrqFjQkl8vKoAMtR1KZsyH4Uy9kS7fwHO4/WwQdKalKWo/xI4QBGrguj/h++a01aGLxAZoj3fuUwdkmTHkVEnmBqUtsmgR6NhieVr4cwEKHfnRAAZxgwrRlQKCr68UfxIg9phO91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1674ec45a214-91b2c;
	Tue, 03 Dec 2024 16:42:02 +0800 (CST)
X-RM-TRANSID:2ee1674ec45a214-91b2c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2674ec459674-27820;
	Tue, 03 Dec 2024 16:42:02 +0800 (CST)
X-RM-TRANSID:2ee2674ec459674-27820
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [RESEND] macintosh: Fix spelling mistake "toogle" to "toggle"
Date: Tue,  3 Dec 2024 00:42:00 -0800
Message-Id: <20241203084200.7350-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There is a spelling mistake, Please fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/macintosh/adbhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index b2fe7a3dc471..943a7123786a 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -604,7 +604,7 @@ adbhid_buttons_input(unsigned char *data, int nb, int autopoll)
 
 			case 0x7f:
 			case 0xff:
-				/* keypad overlay toogle */
+				/* keypad overlay toggle */
 				break;
 
 			default:
-- 
2.17.1




