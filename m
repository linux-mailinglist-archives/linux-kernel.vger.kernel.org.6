Return-Path: <linux-kernel+bounces-321037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECFC9713A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0971EB24551
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2B1B3F1E;
	Mon,  9 Sep 2024 09:28:43 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E8F1B5EC7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874122; cv=none; b=s2sEF5ehH2zjPwqK8iyst0ZBz4rU0+Qy0qXsEgXB8BLiKGoU5ni9FyfbW/Xy1CG68DDewoAJ2TCFlWZa/SIyyx1+CrBjLqvx/e4soOUto5zAMwj1cmekqcklvVDeXtFksM8oHYOUMCwC7+bT/sDxk4u5od8xKZxg9gSHCdG3rIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874122; c=relaxed/simple;
	bh=kANqmYKlR5Cb8+B3oknoVOEl6YSittlvl85Tc8p6Mcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tvdu6aePeeLIf0onRCLgrhTJLHEALr9e3IFcwNz26LnBnJ/wIugB/NbsL125iu4uC2rO7Ctk3YZrHuEh94Jc7tMZ56jW5SlMHASB+eD4KLQxlF2XA1zzUPYgZ8K5LHmfv+4vTiDde/Uk2lSQHGuMETnVzlhVGFN3dtCMnjGTOl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666debfbb602-d9ec4;
	Mon, 09 Sep 2024 17:28:30 +0800 (CST)
X-RM-TRANSID:2ee666debfbb602-d9ec4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166debfae3c6-446ca;
	Mon, 09 Sep 2024 17:28:30 +0800 (CST)
X-RM-TRANSID:2ee166debfae3c6-446ca
From: Ba Jing <bajing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: warthog9@eaglescrag.net,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] ktest: Fix cacography in ktest.pl
Date: Mon,  2 Sep 2024 20:46:45 +0800
Message-Id: <20240902124645.5674-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word "on of" is wrong, so fix it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index dacad94e2be4..87823a05a6b4 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1245,7 +1245,7 @@ sub __read_config {
 	    # Config variables are only active while reading the
 	    # config and can be defined anywhere. They also ignore
 	    # TEST_START and DEFAULTS, but are skipped if they are in
-	    # on of these sections that have SKIP defined.
+	    # one of these sections that have SKIP defined.
 	    # The save variable can be
 	    # defined multiple times and the new one simply overrides
 	    # the previous one.
-- 
2.33.0




