Return-Path: <linux-kernel+bounces-314086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76996AEAF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058CB1C237E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E653BB30;
	Wed,  4 Sep 2024 02:36:27 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AA91EB21
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417387; cv=none; b=bsWD7pqmuX0EqRHJBq+ame4e67ud0dGuke5wy/DBZKDzo5L4v4/GJnB39Q4PklwHo+ihSp2RrI2TuFJxpF/pNiNTsJhC+KdZgnw1qD1GAkrVyWd5ds7O4WcNFPhtSXMsZ5D5mXjqORSHfYnkO14Vs/DHOEe811hoMzLpJR5J2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417387; c=relaxed/simple;
	bh=LZ1Ubc+8sBk2csQxZKriz3OPoNJFDm97DcWu7DeSHyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9GClodPbHupqXi5ahoS/dc8X4JwZzaTY6hsvxy9g7x7yoCRQ9hSgLa9QrJL2OBTlmso7Jj3J8b8r/feS9KDeuAGfiGAElZ7BABdvZZayYuUNvyEQoY1lesfIrpy4S8hy619zZv0yY/9nFQifsQ8MKio2s0TtmUY2tGnI16MmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166d7c7a552d-b0e2f;
	Wed, 04 Sep 2024 10:36:21 +0800 (CST)
X-RM-TRANSID:2ee166d7c7a552d-b0e2f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566d7c794fe1-0a9bb;
	Wed, 04 Sep 2024 10:36:20 +0800 (CST)
X-RM-TRANSID:2ee566d7c794fe1-0a9bb
From: Ba Jing <bajing@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org
Cc: arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH v5] binder: modify the comment for binder_proc_unlock
Date: Mon,  2 Sep 2024 13:23:30 +0800
Message-Id: <20240902052330.3115-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the comment for binder_proc_unlock() to clearly indicate which 
spinlock it releases and to better match the acquire comment block 
in binder_proc_lock().

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
Notes:
v1: https://lore.kernel.org/all/20240830073743.2052-1-bajing@cmss.chinamobile.com/

v2: Reword commit log per suggestions from cmllamas@
https://lore.kernel.org/all/20240902013636.1739-1-bajing@cmss.chinamobile.com/

v3: Wrap commit message. Add version history.
https://lore.kernel.org/all/20240902025720.2334-1-bajing@cmss.chinamobile.com/

v4: Modify the commit information.
https://lore.kernel.org/all/20240902033754.2708-1-bajing@cmss.chinamobile.com/

v5: Change the format and wrap the changelog text at 72 columns.

 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index fc55b5d0e4f3..578861d57045 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -277,7 +277,7 @@ _binder_proc_lock(struct binder_proc *proc, int line)
 }
 
 /**
- * binder_proc_unlock() - Release spinlock for given binder_proc
+ * binder_proc_unlock() - Release outer lock for given binder_proc
  * @proc:                struct binder_proc to acquire
  *
  * Release lock acquired via binder_proc_lock()
-- 
2.33.0




