Return-Path: <linux-kernel+bounces-289454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D77954661
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65785286689
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB66178CEC;
	Fri, 16 Aug 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="hNA7I8vK"
Received: from out187-6.us.a.mail.aliyun.com (out187-6.us.a.mail.aliyun.com [47.90.187.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4895685270
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802419; cv=none; b=p8/YdT8stvfmsBMTyGeMRbK1mamd+H6J9paDGfXPlY3kwsMmDVIyaX890EwXiSVqA3eOXeR0Aipc5LIfa0UAuzNJBfYOUCESd8C7Pecc2l19RsMBkP7iyGdAEnYm3PFlKHFLripNy6e8EVBsF6HoEaUDNPIQam/ErUSuXc3xK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802419; c=relaxed/simple;
	bh=jstzTDlVaFc14MBs6+5CAn8bhr/f8VdzKJOixZsHUjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSSAOGp671hm3NH9xkjcaR7tK6JMwpe04g6h+r8LKCEnXC8hG51Y/SuLlEgZn7gT8g0mo/xxjCqz+OmLoJJLspCbFiDOuBaUjcsvFISzlze1Q471D3+FXX5njF5xqysSLInEQ9gDc5Jl7XqfOn1pFpskxGquQ30uGcq+Qg6s5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=hNA7I8vK; arc=none smtp.client-ip=47.90.187.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802404; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EEFoEIJSD/Xa9nH/fAD+A50RNInexen/VIJS9zUQYhU=;
	b=hNA7I8vK5vzaWQXnqeoFkuScnm48iGc8xMyBB0gfSpks7fPkyMxrgaQK8KVRhblXirA2gArEgYRt3c1aK0CLezMCPfA7HvHiNUdHfp4MShlcNK19RiPyi14kdQEvMHNF3hd6EpmdhevwcxNetarSiUb+3jdWON9Mn47F7pYUAiw=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE7M_1723802403)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 3/6] um: Remove unused fields from thread_struct
Date: Fri, 16 Aug 2024 17:59:50 +0800
Message-Id: <20240816095953.638401-4-tiwei.btw@antgroup.com>
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

These fields are no longer used since the removal of tt mode.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/processor-generic.h | 20 +++++---------------
 arch/um/kernel/process.c                |  8 ++++----
 arch/um/kernel/skas/process.c           |  4 ++--
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 5a7c05275aa7..bce4595798da 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -28,20 +28,10 @@ struct thread_struct {
 	struct arch_thread arch;
 	jmp_buf switch_buf;
 	struct {
-		int op;
-		union {
-			struct {
-				int pid;
-			} fork, exec;
-			struct {
-				int (*proc)(void *);
-				void *arg;
-			} thread;
-			struct {
-				void (*proc)(void *);
-				void *arg;
-			} cb;
-		} u;
+		struct {
+			int (*proc)(void *);
+			void *arg;
+		} thread;
 	} request;
 };
 
@@ -51,7 +41,7 @@ struct thread_struct {
 	.fault_addr		= NULL, \
 	.prev_sched		= NULL, \
 	.arch			= INIT_ARCH_THREAD, \
-	.request		= { 0 } \
+	.request		= { } \
 }
 
 /*
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index f36b63f53bab..be2856af6d4c 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -109,8 +109,8 @@ void new_thread_handler(void)
 		schedule_tail(current->thread.prev_sched);
 	current->thread.prev_sched = NULL;
 
-	fn = current->thread.request.u.thread.proc;
-	arg = current->thread.request.u.thread.arg;
+	fn = current->thread.request.thread.proc;
+	arg = current->thread.request.thread.arg;
 
 	/*
 	 * callback returns only if the kernel thread execs a process
@@ -158,8 +158,8 @@ int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 		arch_copy_thread(&current->thread.arch, &p->thread.arch);
 	} else {
 		get_safe_registers(p->thread.regs.regs.gp, p->thread.regs.regs.fp);
-		p->thread.request.u.thread.proc = args->fn;
-		p->thread.request.u.thread.arg = args->fn_arg;
+		p->thread.request.thread.proc = args->fn;
+		p->thread.request.thread.arg = args->fn_arg;
 		handler = new_thread_handler;
 	}
 
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 5f9c1c5f36e2..68657988c8d1 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -39,8 +39,8 @@ int __init start_uml(void)
 
 	init_new_thread_signals();
 
-	init_task.thread.request.u.thread.proc = start_kernel_proc;
-	init_task.thread.request.u.thread.arg = NULL;
+	init_task.thread.request.thread.proc = start_kernel_proc;
+	init_task.thread.request.thread.arg = NULL;
 	return start_idle_thread(task_stack_page(&init_task),
 				 &init_task.thread.switch_buf);
 }
-- 
2.34.1


