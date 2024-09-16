Return-Path: <linux-kernel+bounces-330168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82400979A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DD61F237F0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51276F30E;
	Mon, 16 Sep 2024 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="ynWKEDUB"
Received: from out0-214.mail.aliyun.com (out0-214.mail.aliyun.com [140.205.0.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789938F83
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462827; cv=none; b=u202mfFsipIcq5cBydaiBVXbiErIFq5vdl3wbyDN16iZ2jTX2PQO7pA5AV2bLm0bGw4jI7Q5wEZIIsi7632f9i4T6Mf6yltAw/zBC5594MmcX+w37o9i2fCgQ0RFBN8aVpgF3TsKzQtK+Qa15ze3dYAABw/3Xxgj0qZYsxjEVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462827; c=relaxed/simple;
	bh=mSH6M9cARGi/4U8gWkJ/5L0xMNj6Gr5rXJEMqQfsui4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6YvBcbqSMhCBB0nHX1g4TMO+uEylEGHuCoDDh9jS0P/Md+YWr68ycwME16bIMjbk8Gkd9vc+dm4ndZOW7F0mGn2WaGu8gumr5ANfeXQViLhkyyJemL5MZoQXJkRwoedw34vVD4YI0OVP7LMiyp4B3yJ/kecew36kurhDa0/rXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=ynWKEDUB; arc=none smtp.client-ip=140.205.0.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726462805; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ICwDMhjJ7dbADtxlBSbI8KnsxD7naRbiR1HvDVegF5k=;
	b=ynWKEDUBCMpclAFcP1leXS2SCvQz47YGrhlk7T6e0e0cSmZPJ1wId60qaJO90PdSxCwcg2EgdLWN+AUdOKY/7Dg3b9KiLPYbgiwMBiSZzYtCfoF77Bx2k9LxjEfvObiXqGMBTLiOCDN1Hz42hbZB4HVL/2bfjN6zPYOQ6pikH8g=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZKOkLRT_1726462802)
          by smtp.aliyun-inc.com;
          Mon, 16 Sep 2024 13:00:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 1/4] um: Remove the redundant declaration of high_physmem
Date: Mon, 16 Sep 2024 12:59:47 +0800
Message-Id: <20240916045950.508910-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916045950.508910-1-tiwei.btw@antgroup.com>
References: <20240916045950.508910-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

high_physmem has already been declared in as-layout.h, so there is
no need to declare it explicitly in the .c file again.

While at it, group the declarations of __real_malloc and __real_free
together to make the code slightly more readable.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index f98ff79cdbf7..cf1179ed1aec 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -182,6 +182,7 @@ int __init main(int argc, char **argv, char **envp)
 }
 
 extern void *__real_malloc(int);
+extern void __real_free(void *);
 
 /* workaround for -Wmissing-prototypes warnings */
 void *__wrap_malloc(int size);
@@ -219,10 +220,6 @@ void *__wrap_calloc(int n, int size)
 	return ptr;
 }
 
-extern void __real_free(void *);
-
-extern unsigned long high_physmem;
-
 void __wrap_free(void *ptr)
 {
 	unsigned long addr = (unsigned long) ptr;
-- 
2.34.1


