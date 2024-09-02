Return-Path: <linux-kernel+bounces-314394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AC496B2A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF3E1C20F96
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F77F83CDB;
	Wed,  4 Sep 2024 07:18:28 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453834A06
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434308; cv=none; b=MNouzMITopGz00p0TxTtayg+8rFuhX4hhNrN6XxonFfexg+Mx24Qfxws51lboaclxpT/SrA1BrMZi3NH+PfRyz3XgHGo2ggU7Q3NDMlr3DhSPCdm9iHGnfgUJcvvQosNMsJChkp7yuQzYImHGkJPxk4ZRrAL9YU3pcePxonrIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434308; c=relaxed/simple;
	bh=nYGSJ2r6RyEdPKWhAsFsHhrIDuaBlEau+e85/fB+RzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jq7mIop+EFv6HLKBbWAL75PuzfLAFAp6bKnImnmLe+Cg4NSv2ZMAvNcdfWmgiZkzvn6cdtCD+ZLNkq7fGQ/e906FZdcImDlImKfzZdMWX8QnsqxsyrN9lynVbC2enxtfLUytXOXZzF2UyAKwz80LbuZ5tj4v8BgfXG173piP+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466d809b8635-b3f29;
	Wed, 04 Sep 2024 15:18:21 +0800 (CST)
X-RM-TRANSID:2ee466d809b8635-b3f29
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766d809ae20c-1873c;
	Wed, 04 Sep 2024 15:18:21 +0800 (CST)
X-RM-TRANSID:2ee766d809ae20c-1873c
From: Ba Jing <bajing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: warthog9@eaglescrag.net,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] sample: correct grammatical errors
Date: Mon,  2 Sep 2024 15:07:20 +0800
Message-Id: <20240902070720.4274-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of the verb "are" is incorrect, so fix it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/ktest/sample.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index f43477a9b857..6d6565433ae8 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -374,7 +374,7 @@
 # title Test Kernel
 # kernel vmlinuz-test
 #
-# For grub2, a search of top level "menuentry"s are done. No
+# For grub2, a search of top level "menuentry" is done. No
 # submenu is searched. The menu is found by searching for the
 # contents of GRUB_MENU in the line that starts with "menuentry".
 # You may want to include the quotes around the option. For example:
-- 
2.33.0




