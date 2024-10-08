Return-Path: <linux-kernel+bounces-354951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70588994515
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF5B27D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492FC18FDC9;
	Tue,  8 Oct 2024 10:04:51 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9D4178CE4;
	Tue,  8 Oct 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381890; cv=none; b=fwuEFpdukLcRsPojhoFnlrXYb6LWJ3dp7atkC1763MlZOLcKueBsVjnTd4nLl8aLygkiwQALgUweH9vIIiUPRXdyoeTopScur8k6qQMAVEKumYF7tsjMno61tx6fm1rSAMnBVic4pRTYaAFpJMRotRQXdfTob02/gu4n58ayFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381890; c=relaxed/simple;
	bh=p9GZ/1L2OsQG0k4LQQzKeRc0YZ27pOx8JzcGN6YWccw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ldVMn3j+IEL0nsQRK7Q5PDHVQR6M45Ul/bZa7jt6mEI9m9RKu9ENjpmrdSbv9nUTCqQzYMCzv/gTB3xVY92fESE5U/hj2j22sPWf9IwmcmOV3Uf/6EDpMlztnB+rKk28DnZt4YdcqqHdxVOdRf5J0YmXWnAKjUcUXvEcd8LEw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7670503b9f28-e3f3b;
	Tue, 08 Oct 2024 18:04:44 +0800 (CST)
X-RM-TRANSID:2ee7670503b9f28-e3f3b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9670503ab996-9cffb;
	Tue, 08 Oct 2024 18:04:44 +0800 (CST)
X-RM-TRANSID:2ee9670503ab996-9cffb
From: Ba Jing <bajing@cmss.chinamobile.com>
To: robh@kernel.org
Cc: saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] of:of_numa: remove unused macro
Date: Tue,  8 Oct 2024 14:06:45 +0800
Message-Id: <20241008060645.36071-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reading the code, I found the marco DEFAULT_NODE is never
referenced in the code. Just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/of/of_numa.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 2ec20886d176..230d5f628c1b 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -14,9 +14,6 @@
 
 #include <asm/numa.h>
 
-/* define default numa node to 0 */
-#define DEFAULT_NODE 0
-
 /*
  * Even though we connect cpus to numa domains later in SMP
  * init, we need to know the node ids now for all cpus.
-- 
2.33.0




