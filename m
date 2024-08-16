Return-Path: <linux-kernel+bounces-288829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9052A953F35
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21551C2251A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BF629CFE;
	Fri, 16 Aug 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="nzTK8B9y"
Received: from out187-13.us.a.mail.aliyun.com (out187-13.us.a.mail.aliyun.com [47.90.187.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22506BE4E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773628; cv=none; b=M543auuj6Dt3aznrr2/n4oNlvLsavdnVf5JS57ZgtvR/z3Axe4eURR9a6GsdujDVefmkYLjhdS666FXzAUQIU7+jx6iBQqmQodPy5dyJ/fPUXBlgtDgklMQeQPfPs3MwPFtPU1wTorpmH2EuG5W+qunnjDBh+A3Do12Qw+zIiak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773628; c=relaxed/simple;
	bh=h3ektH89VgKUm1hFQf4tNGITO8lwB8WYpEAS6FRb3Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJa50NdWkc8RNmDtTRMqvjpQiCdGN7zGU4YI0ppNoA06qZxEv9sGo/EJu45jmW7nmSX5RpmdtcHBbmUya3eUZ3tdgQuJgV31YXRt4ByEgs4Kdj63BVBxBRl1x753X2mIAPZcN7KGEn2TUzsKnYDZ48HhzkGzLEnWYtwkh32/pKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=nzTK8B9y; arc=none smtp.client-ip=47.90.187.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723773614; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LTmj84zcrMSG/7oxdcFgD9iQDmdedlra1IBnqpPooqs=;
	b=nzTK8B9yz9GZXmJ6gCBhMUeO2GYm2/obI399ESkjXuq24ZCOTfnXfQVqL/im9XzlVEzr3Y/J2eiaIWob3nP/BvY1ZI/LtO856bBYsXRZiU4B5xCFVPEXrIZC00IwCUKCMJsbmTqy5ZI1W+tVRwfpc+EvCv9dbOTDrHpjBTEeIRw=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBokR_1723773297)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:57 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 6/6] um: Remove declarations of undefined functions
Date: Fri, 16 Aug 2024 09:54:47 +0800
Message-Id: <20240816015447.320394-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816015447.320394-1-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
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


