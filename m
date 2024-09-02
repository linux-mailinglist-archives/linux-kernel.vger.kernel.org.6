Return-Path: <linux-kernel+bounces-314148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E696AF42
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7D81C24CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255E457CBC;
	Wed,  4 Sep 2024 03:25:33 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E06558A5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420332; cv=none; b=HF2vIxDx7WIRsh5n8My6rTTav7xOfxUvuRV8Kf/Q2EvZ3AdH1MOX57UQ4Tz2NFSu1lKRiy2RNLpU5wDgusmES7E4lMRwZPL11bJYpa6OltUNrjD6UeXSEiCAQhYZJBKyIwt8uUm7tGsLL39nnlm8FsP83DOZyFPgRC7ld4zyK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420332; c=relaxed/simple;
	bh=CuQaHNvYOgJ0mVTsiHbpRzX0urHKzefXljekeJq6Ezc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tF80gEUhAzc293fvQTSpU4QAlfuRqTc7kPaKrh4bpaXUMmB+cqSWr6rkjscUCGK1MEFAY6F0a2v7gMl2CUQ/C5BK1/DoqYAKWdsOBk+Yb0ANN8LcN/pKuEaUkFNaf9PsmY9cdtvLR2jeGhMhYUEqAp0bUbND7fopVqkf8GTYhhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566d7d326b31-e1b34;
	Wed, 04 Sep 2024 11:25:26 +0800 (CST)
X-RM-TRANSID:2ee566d7d326b31-e1b34
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366d7d3186f1-0ffce;
	Wed, 04 Sep 2024 11:25:26 +0800 (CST)
X-RM-TRANSID:2ee366d7d3186f1-0ffce
From: Ba Jing <bajing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: warthog9@eaglescrag.net,
	bajing@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vmware: remove the duplicate word
Date: Mon,  2 Sep 2024 14:16:44 +0800
Message-Id: <20240902061644.3790-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word "appropriate" is repeated twice, so remove one.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/ktest/examples/vmware.conf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/examples/vmware.conf b/tools/testing/ktest/examples/vmware.conf
index 61958163d242..81a696e1fa62 100644
--- a/tools/testing/ktest/examples/vmware.conf
+++ b/tools/testing/ktest/examples/vmware.conf
@@ -46,8 +46,8 @@ VMWARE_VM_BASE_DIR = /var/lib/vmware/${VMWARE_VM_DIR}
 CONSOLE = /usr/bin/ncat -U ${VMWARE_VM_BASE_DIR}/${VMWARE_SERIAL_NAME}
 
 # Define what version of Workstation you are using
-# This is used by vmrun to use the appropriate appripriate pieces to 
-# test this.  In all likelihood you want 'ws' or 'player' 
+# This is used by vmrun to use the appripriate pieces to test this.
+# In all likelihood you want 'ws' or 'player'
 # Valid options:
 # 	ws - Workstation (Windows or Linux host)
 # 	fusion - Fusion (Mac host)
-- 
2.33.0




