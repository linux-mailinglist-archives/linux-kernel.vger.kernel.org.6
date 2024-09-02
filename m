Return-Path: <linux-kernel+bounces-314108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7796AEEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299331C215C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8126B47796;
	Wed,  4 Sep 2024 03:14:05 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E694317B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725419645; cv=none; b=pP2mQMdyCrwVZABBoeQUu+IgU9KAlo2dUhsc+S2Qf0dTZSlPgIV8jyW2yGKPeA3dKqZxWqGPEswG0EqTW+pvXl21t7DHaIHwcY9RIjDMpENRNsi0xuzkF/ykATTbFqbNzlofLh9geu8F2GJJBmQsMGvSllVAGWNaokPrsfMXvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725419645; c=relaxed/simple;
	bh=ZAO+EtNkjk1NlWwOOzjHI/DUTXVLTDt8Bs9dOxLlxjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JtKBP2n5JOCPpQ+iYOtKXTh2ohyMVa++lI1Hdv0aJGwoto8zOUiNZzmMHyXDTePXM4rpnOCwPfQdPSS4yp92VC22HMQDt8I+VEIPG2Igl5l0uXtjTqDWaEXIxmOQBEPEhi1gNiY/fADH4MR5UpyNmSejc0hq4k5Qm8tkMW2uHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866d7d074949-1c97d;
	Wed, 04 Sep 2024 11:13:57 +0800 (CST)
X-RM-TRANSID:2ee866d7d074949-1c97d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766d7d068dcc-0c27e;
	Wed, 04 Sep 2024 11:13:57 +0800 (CST)
X-RM-TRANSID:2ee766d7d068dcc-0c27e
From: Ba Jing <bajing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: warthog9@eaglescrag.net,
	bajing@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vmware: Correct the improper use in vmware.conf
Date: Mon,  2 Sep 2024 14:04:19 +0800
Message-Id: <20240902060419.3360-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word 'it's' is not used correctly in the sentence,
so it should be changed to 'its'.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/ktest/examples/vmware.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/examples/vmware.conf b/tools/testing/ktest/examples/vmware.conf
index 61958163d242..091f74ef1850 100644
--- a/tools/testing/ktest/examples/vmware.conf
+++ b/tools/testing/ktest/examples/vmware.conf
@@ -42,7 +42,7 @@ VMWARE_VM_DIR = ${VMWARE_VM_NAME}
 VMWARE_VM_BASE_DIR = /var/lib/vmware/${VMWARE_VM_DIR}
 
 # Use ncat to read the unix pipe.  Anything that can read the Unix Pipe
-# and output it's contents to stdout will work
+# and output its contents to stdout will work
 CONSOLE = /usr/bin/ncat -U ${VMWARE_VM_BASE_DIR}/${VMWARE_SERIAL_NAME}
 
 # Define what version of Workstation you are using
-- 
2.33.0




