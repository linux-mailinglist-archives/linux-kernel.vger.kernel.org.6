Return-Path: <linux-kernel+bounces-301251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4995EE36
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB04B21F57
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8B214830C;
	Mon, 26 Aug 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="OABeoI2l"
Received: from out0-193.mail.aliyun.com (out0-193.mail.aliyun.com [140.205.0.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E67146A6B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667231; cv=none; b=PiRpC+RmYRb2dDKoG3nZFPUVkTwWgIxXcM1aZ1qXcq+iDV0ojyTkl9A+njUipy0zlD+eWlDN+mxixo6/aXiq8aJjMg6dQQ9S9zSgs8B+gejGpRbrq1lbS5JQ+O2in6hR0LEWjw07BBPX6H4lcg6xOGDzpk5KF1B1w7FWgxTVd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667231; c=relaxed/simple;
	bh=PskH/Lp/rlV2dM17RByJrskCyl8CXN9BKwE+wbwjuyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1TPBJY5ThgrqV8NsYHz3xtjmB4rYZNOxLi8mpy7nMl5mXX2r2YD6DkiXVGxJTxG9q08X2hYcsyZxQk9qESgY02unoQTED4R7Tb0aQRd0kBI3k+pdXOe73UtViDrzHnVjQbNs+Lsfgks1ihhyMrMFhP8iSGQQkapjB/O+q3AG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=OABeoI2l; arc=none smtp.client-ip=140.205.0.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724667226; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ETHDtkvAR5yLwocf1NNAJDJIgmGgz2GYbC6AhVsHb1U=;
	b=OABeoI2lv4UEiP/G1Ii4d14APcmoXoMRJW8Cm2yIJBPi9GDShNoOQIxZd5oHAXx6WDBAyD2Whteq3TxdnsrKNSyJ9NwNCuuQhyXHHYz1tVnYhb9Z+TyxYoE0vblNm2F1yw9SAqT1SjlMY4Js4mOT/hhlSc5wtamWVNQKWWFqlSo=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRsdE_1724666908)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:28 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 6/7] um: Remove the declaration of user_thread function
Date: Mon, 26 Aug 2024 18:08:14 +0800
Message-Id: <20240826100815.904430-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826100815.904430-1-tiwei.btw@antgroup.com>
References: <20240826100815.904430-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function has never been defined since its declaration was
introduced by commit 1da177e4c3f4 ("Linux-2.6.12-rc2").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/skas/skas.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index ebaa116de30b..95f5d5d6389a 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -10,7 +10,6 @@
 
 extern int userspace_pid[];
 
-extern int user_thread(unsigned long stack, int flags);
 extern void new_thread_handler(void);
 extern void handle_syscall(struct uml_pt_regs *regs);
 extern long execute_syscall_skas(void *r);
-- 
2.34.1


