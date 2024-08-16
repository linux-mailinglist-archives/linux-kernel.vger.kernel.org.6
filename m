Return-Path: <linux-kernel+bounces-289448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B795465A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746581C20B09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A252F171E43;
	Fri, 16 Aug 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="NBttyKJ1"
Received: from out0-196.mail.aliyun.com (out0-196.mail.aliyun.com [140.205.0.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E916F0D2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802410; cv=none; b=eXD9pM/kV+PxzbllrMV7ir+wu71kU1OMXlemVuCDCjIqRm513CijhgO+l7D14Et478ijgaUnK9FPeaUOlDtfPwsxUZ/py/FmP4nhjrgy4tbkmMJs29kOdOlzw2UUOVCkbnwG5WZlQj5f6B7PrL+00Am4XMtICoONuVhNLJY7h84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802410; c=relaxed/simple;
	bh=h3ektH89VgKUm1hFQf4tNGITO8lwB8WYpEAS6FRb3Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z7YbsNM2doNSR5TTuPuCtnPwj1AhqXkn004E5uwBMuD5qK98mQlBDFju210D85dxua+V81DIu4UgKr0+6z6K2jSucJSEfkBSEbvO+YvGbAhCLjhftAFNocekcZhypOD772+7uId45axN8BhO9K8Mr55bZVMxneI9SGRtMRp2k8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=NBttyKJ1; arc=none smtp.client-ip=140.205.0.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802406; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LTmj84zcrMSG/7oxdcFgD9iQDmdedlra1IBnqpPooqs=;
	b=NBttyKJ1BavOjmjIQ1VUsKyz5Jd4UBWGodsMgwNLktP0YLyjmTEeA+eNexQ9YBmvBbat7YGjV7mDolCf5AWSa9CQNWMsRlue6MQYj6aPhNnqF2jNg3RrumzSb4afdOOuPy18OnyVuWTkrYzAbqqkpRerAA8YPNN0DDlSCysSws0=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE9t_1723802405)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:05 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 6/6] um: Remove declarations of undefined functions
Date: Fri, 16 Aug 2024 17:59:53 +0800
Message-Id: <20240816095953.638401-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816095953.638401-1-tiwei.btw@antgroup.com>
References: <20240816095953.638401-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definitions of these functions do not exist anymore.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/skas/skas.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index ebaa116de30b..85c50122ab98 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -10,10 +10,8 @@
 
 extern int userspace_pid[];
 
-extern int user_thread(unsigned long stack, int flags);
 extern void new_thread_handler(void);
 extern void handle_syscall(struct uml_pt_regs *regs);
-extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
 extern struct mm_id *current_mm_id(void);
 extern void current_mm_sync(void);
-- 
2.34.1


