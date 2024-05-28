Return-Path: <linux-kernel+bounces-192559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1378D1F19
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2081C2214E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821FA16FF5F;
	Tue, 28 May 2024 14:43:49 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83D17164B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907428; cv=none; b=ZDNZbmFOP2rALUTsGhkS4et/qKqxNBPDE7Q+wDaQVtnLv//JY2HHuGadcDIxh6/PciIL8l1R/gvr0YnSC6dYz7K3SS42YZahcKMaHLY7LfDy1/KX8Q4TxzniGKL0grc2EsA9bAB3kTzmW934GF2EIG2jt9iwYjLcZJ+TQevZCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907428; c=relaxed/simple;
	bh=AUR+iHLSJz7WIunMyEoTeS9mQ7LXiUsbjhruGQV4tvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I07StLFnKZZ3do8BZ+n3liemPkUvK3pSpR/htScv0UOB0OaCgBeLTclF9Bj4Am8MRFLRu0gwyfY+tnhUBYl/xY1Pkhzqwx7iQdvsjqbEjfIns/0DlIH/jqYWmcaAVnZNysxKxeS9AiCsWi/uQfAY3pVRHi0LSb7LYbJ1yFAdkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBnWf9020052;
	Tue, 28 May 2024 14:43:40 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3DeluNYeGl4O6XY2ECjLhF19aKMqY+wnGu0PSE4LuplXc=3D;_b=3DKRCohi+p?=
 =?UTF-8?Q?qMkGoD89dky/BiXewf7htX8jYPanDyDXoBeDYtTZFOo2Ehjz46LeG/0de7RW_kG?=
 =?UTF-8?Q?bxiSv8bx89YAurEObv+NUxWUiVh7Z13Z2BtuQOy4geMr624pRlQV/QlVYYY8Z5U?=
 =?UTF-8?Q?m5f_m3+Btj5Q1M89RAe/x2DHZCEmdR3ex6Xolz455Nt03XMrbs2JKii3tA7hdy7?=
 =?UTF-8?Q?DZHLz39ge_1SNwU1bzS5qUxXn8s8HrrKRHjKvCFLBOLh72XnpPU9Z8yfKmfjI2k?=
 =?UTF-8?Q?lwABTJ4MwW65Csn_joPVBHLqlkNlerz7RfRleyU0ZZhrCC6bSkUwEg57R2sdZx1?=
 =?UTF-8?Q?c0udZAZ6u7Y8Jbk4JZnjz_Pg=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j84esb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 14:43:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SDlPS6025792;
	Tue, 28 May 2024 14:43:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50py1p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 14:43:38 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SEhW81035350;
	Tue, 28 May 2024 14:43:38 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yc50py1g5-6;
	Tue, 28 May 2024 14:43:37 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH  v4 5/5] selftests/mm: Add new testcases for pkeys
Date: Tue, 28 May 2024 14:43:31 +0000
Message-Id: <20240528144331.2758104-6-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240528144331.2758104-1-aruna.ramakrishna@oracle.com>
References: <20240528144331.2758104-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_10,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280111
X-Proofpoint-ORIG-GUID: I7OxgCNN7PT_qDPuTDr_JNEptap_ALnB
X-Proofpoint-GUID: I7OxgCNN7PT_qDPuTDr_JNEptap_ALnB

From: Keith Lucas <keith.lucas@oracle.com>

This commit adds a few new tests to exercise the signal handler flow,
especially with pkey 0 disabled.

[ Aruna: Adapted to upstream ]

Signed-off-by: Keith Lucas <keith.lucas@oracle.com>
Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 tools/testing/selftests/mm/Makefile           |   5 +-
 tools/testing/selftests/mm/pkey-helpers.h     |  11 +-
 .../selftests/mm/pkey_sighandler_tests.c      | 480 ++++++++++++++++++
 tools/testing/selftests/mm/protection_keys.c  |  10 -
 4 files changed, 494 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 410495e0a611..1bb95960d28b 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -2,6 +2,7 @@
 # Makefile for mm selftests
 
 LOCAL_HDRS += $(selfdir)/mm/local_config.h $(top_srcdir)/mm/gup_test.h
+LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
 
 include local_config.mk
 
@@ -32,7 +33,7 @@ endif
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules
 
-CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
+CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) -I$(LINUX_TOOL_INCLUDE) $(KHDR_INCLUDES)
 LDLIBS = -lrt -lpthread -lm
 
 TEST_GEN_FILES = cow
@@ -82,6 +83,7 @@ CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_pr
 CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
 
 VMTARGETS := protection_keys
+VMTARGETS := pkey_sighandler_tests
 BINARIES_32 := $(VMTARGETS:%=%_32)
 BINARIES_64 := $(VMTARGETS:%=%_64)
 
@@ -100,6 +102,7 @@ else
 
 ifneq (,$(findstring $(ARCH),powerpc))
 TEST_GEN_FILES += protection_keys
+TEST_GEN_FILES += pkey_sighandler_tests
 endif
 
 endif
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 1af3156a9db8..2b1189c27167 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <ucontext.h>
 #include <sys/mman.h>
+#include <linux/compiler.h>
 
 #include "../kselftest.h"
 
@@ -79,7 +80,15 @@ extern void abort_hooks(void);
 	}					\
 } while (0)
 
-__attribute__((noinline)) int read_ptr(int *ptr);
+noinline int read_ptr(int *ptr)
+{
+	/*
+	 * Keep GCC from optimizing this away somehow
+	 */
+	barrier();
+	return *ptr;
+}
+
 void expected_pkey_fault(int pkey);
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
new file mode 100644
index 000000000000..8a8dc284b40d
--- /dev/null
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
+ *
+ * The testcases in this file exercise various flows related to signal handling,
+ * using an alternate signal stack, with the default pkey (pkey 0) disabled.
+ *
+ * Compile with:
+ * gcc -mxsave      -o pkey_sighandler_tests -O2 -g -std=gnu99 -pthread -Wall pkey_sighandler_tests.c -I../../../../tools/include -lrt -ldl -lm
+ * gcc -mxsave -m32 -o pkey_sighandler_tests -O2 -g -std=gnu99 -pthread -Wall pkey_sighandler_tests.c -I../../../../tools/include -lrt -ldl -lm
+ */
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+#include <errno.h>
+#include <sys/syscall.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <limits.h>
+
+#include "pkey-helpers.h"
+
+#define STACK_SIZE PTHREAD_STACK_MIN
+
+void expected_pkey_fault(int pkey) {}
+
+pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
+pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+siginfo_t siginfo = {0};
+
+/*
+ * We need to use inline assembly instead of glibc's syscall because glibc's
+ * syscall will attempt to access the PLT in order to call a library function
+ * which is protected by MPK 0 which we don't have access to.
+ */
+static inline __always_inline
+long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
+{
+	unsigned long ret;
+#ifdef __x86_64__
+	register long r10 asm("r10") = a4;
+	register long r8 asm("r8") = a5;
+	register long r9 asm("r9") = a6;
+	asm volatile ("syscall"
+		      : "=a"(ret)
+		      : "a"(n), "D"(a1), "S"(a2), "d"(a3), "r"(r10), "r"(r8), "r"(r9)
+		      : "rcx", "r11", "memory");
+#elif defined __i386__
+	asm volatile ("int $0x80"
+		      : "=a"(ret)
+		      : "a"(n), "b"(a1), "c"(a2), "d"(a3), "S"(a4), "D"(a5)
+		      : "memory");
+#endif
+	return ret;
+}
+
+static void sigsegv_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	pthread_mutex_lock(&mutex);
+
+	memcpy(&siginfo, info, sizeof(siginfo_t));
+
+	pthread_cond_signal(&cond);
+	pthread_mutex_unlock(&mutex);
+
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+}
+
+static void sigusr1_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	pthread_mutex_lock(&mutex);
+
+	memcpy(&siginfo, info, sizeof(siginfo_t));
+
+	pthread_cond_signal(&cond);
+	pthread_mutex_unlock(&mutex);
+}
+
+static void sigusr2_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	/*
+	 * pkru should be the init_pkru value which enabled MPK 0 so
+	 * we can use library functions.
+	 */
+	printf("%s invoked.\n", __func__);
+}
+
+static void raise_sigusr2(void)
+{
+	pid_t tid = 0;
+
+	tid = syscall_raw(SYS_gettid, 0, 0, 0, 0, 0, 0);
+
+	syscall_raw(SYS_tkill, tid, SIGUSR2, 0, 0, 0, 0);
+
+	/*
+	 * We should return from the signal handler here and be able to
+	 * return to the interrupted thread.
+	 */
+}
+
+static void *thread_segv_with_pkey0_disabled(void *ptr)
+{
+	/* Disable MPK 0 (and all others too) */
+	__write_pkey_reg(0x55555555);
+
+	/* Segfault (with SEGV_MAPERR) */
+	*(int *) (0x1) = 1;
+	return NULL;
+}
+
+static void *thread_segv_pkuerr_stack(void *ptr)
+{
+	/* Disable MPK 0 (and all others too) */
+	__write_pkey_reg(0x55555555);
+
+	/* After we disable MPK 0, we can't access the stack to return */
+	return NULL;
+}
+
+static void *thread_segv_maperr_ptr(void *ptr)
+{
+	stack_t *stack = ptr;
+	int *bad = (int *)1;
+
+	/*
+	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
+	 * MPK 0. The thread's stack cannot be used for signals because it is
+	 * not accessible by the default init_pkru value of 0x55555554.
+	 */
+	syscall_raw(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
+
+	/* Disable MPK 0.  Only MPK 1 is enabled. */
+	__write_pkey_reg(0x55555551);
+
+	/* Segfault */
+	*bad = 1;
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	return NULL;
+}
+
+/*
+ * Verify that the sigsegv handler is invoked when pkey 0 is disabled.
+ * Note that the new thread stack and the alternate signal stack is
+ * protected by MPK 0.
+ */
+static void test_sigsegv_handler_with_pkey0_disabled(void)
+{
+	struct sigaction sa;
+	pthread_attr_t attr;
+	pthread_t thr;
+
+	sa.sa_flags = SA_SIGINFO;
+
+	sa.sa_sigaction = sigsegv_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	pthread_attr_init(&attr);
+	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+	pthread_create(&thr, &attr, thread_segv_with_pkey0_disabled, NULL);
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	ksft_test_result(siginfo.si_signo == SIGSEGV &&
+			 siginfo.si_code == SEGV_MAPERR &&
+			 siginfo.si_addr == (void *)1,
+			 "%s\n", __func__);
+}
+
+/*
+ * Verify that the sigsegv handler is invoked when pkey 0 is disabled.
+ * Note that the new thread stack and the alternate signal stack is
+ * protected by MPK 0, which renders them inaccessible when MPK 0
+ * is disabled. So just the return from the thread should cause a
+ * segfault with SEGV_PKUERR.
+ */
+static void test_sigsegv_handler_cannot_access_stack(void)
+{
+	struct sigaction sa;
+	pthread_attr_t attr;
+	pthread_t thr;
+
+	sa.sa_flags = SA_SIGINFO;
+
+	sa.sa_sigaction = sigsegv_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	pthread_attr_init(&attr);
+	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+	pthread_create(&thr, &attr, thread_segv_pkuerr_stack, NULL);
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	ksft_test_result(siginfo.si_signo == SIGSEGV &&
+			 siginfo.si_code == SEGV_PKUERR,
+			 "%s\n", __func__);
+}
+
+/*
+ * Verify that the sigsegv handler that uses an alternate signal stack
+ * is correctly invoked for a thread which uses a non-zero MPK to protect
+ * its own stack, and disables all other MPKs (including 0).
+ */
+static void test_sigsegv_handler_with_different_pkey_for_stack(void)
+{
+	struct sigaction sa;
+	static stack_t sigstack;
+	void *stack;
+	int pkey;
+	int parent_pid = 0;
+	int child_pid = 0;
+
+	sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
+
+	sa.sa_sigaction = sigsegv_handler;
+
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	stack = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	assert(stack != MAP_FAILED);
+
+	/* Allow access to MPK 0 and MPK 1 */
+	__write_pkey_reg(0x55555550);
+
+	/* Protect the new stack with MPK 1 */
+	pkey = pkey_alloc(0, 0);
+	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+
+	/* Set up alternate signal stack that will use the default MPK */
+	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	sigstack.ss_flags = 0;
+	sigstack.ss_size = STACK_SIZE;
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	/* Use clone to avoid newer glibcs using rseq on new threads */
+	long ret = syscall_raw(SYS_clone,
+			       CLONE_VM | CLONE_FS | CLONE_FILES |
+			       CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
+			       CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
+			       CLONE_DETACHED,
+			       (long) ((char *)(stack) + STACK_SIZE),
+			       (long) &parent_pid,
+			       (long) &child_pid, 0, 0);
+
+	if (ret < 0) {
+		errno = -ret;
+		perror("clone");
+	} else if (ret == 0) {
+		thread_segv_maperr_ptr(&sigstack);
+		syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	}
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	ksft_test_result(siginfo.si_signo == SIGSEGV &&
+			 siginfo.si_code == SEGV_MAPERR &&
+			 siginfo.si_addr == (void *)1,
+			 "%s\n", __func__);
+}
+
+/*
+ * Verify that the PKRU value set by the application is correctly
+ * restored upon return from signal handling.
+ */
+static void test_pkru_preserved_after_sigusr1(void)
+{
+	struct sigaction sa;
+	unsigned long pkru = 0x45454544;
+
+	sa.sa_flags = SA_SIGINFO;
+
+	sa.sa_sigaction = sigusr1_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	__write_pkey_reg(pkru);
+
+	raise(SIGUSR1);
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	/* Ensure the pkru value is the same after returning from signal. */
+	ksft_test_result(pkru == __read_pkey_reg() &&
+			 siginfo.si_signo == SIGUSR1,
+			 "%s\n", __func__);
+}
+
+static noinline void *thread_sigusr2_self(void *ptr)
+{
+	/*
+	 * A const char array like "Resuming after SIGUSR2" won't be stored on
+	 * the stack and the code could access it via an offset from the program
+	 * counter. This makes sure it's on the function's stack frame
+	 * so we know where it is even when the code is copied.
+	 */
+	char str[] = {'R', 'e', 's', 'u', 'm', 'i', 'n', 'g', ' ',
+		'a', 'f', 't', 'e', 'r', ' ',
+		'S', 'I', 'G', 'U', 'S', 'R', '2',
+		'.', '.', '.', '\n', '\0'};
+	stack_t *stack = ptr;
+
+	/*
+	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
+	 * MPK 0. The thread's stack cannot be used for signals because it is
+	 * not accessible by the default init_pkru value of 0x55555554.
+	 */
+	syscall(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
+
+	/* Disable MPK 0.  Only MPK 2 is enabled. */
+	__write_pkey_reg(0x55555545);
+
+	raise_sigusr2();
+
+	/* Do something, to show the thread resumed execution after the signal */
+	syscall_raw(SYS_write, 1, (long) str, sizeof(str) - 1, 0, 0, 0);
+
+	/*
+	 * We can't return to test_pkru_sigreturn because it
+	 * will attempt to use a %rbp value which is on the stack
+	 * of the main thread.
+	 */
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	return NULL;
+}
+
+/*
+ * Verify that sigreturn is able to restore altstack even if the thread had
+ * disabled pkey 0.
+ */
+static void test_pkru_sigreturn(void)
+{
+	struct sigaction sa = {0};
+	static stack_t sigstack;
+	void *stack;
+	int pkey;
+	int parent_pid = 0;
+	int child_pid = 0;
+
+	sa.sa_handler = SIG_DFL;
+	sa.sa_flags = 0;
+	sigemptyset(&sa.sa_mask);
+
+	/*
+	 * For this testcase, we do not want to handle SIGSEGV. Reset handler
+	 * to default so that the application can crash if it receives SIGSEGV.
+	 */
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
+	sa.sa_sigaction = sigusr2_handler;
+	sigemptyset(&sa.sa_mask);
+
+	if (sigaction(SIGUSR2, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	stack = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	assert(stack != MAP_FAILED);
+
+	/*
+	 * Allow access to MPK 0 and MPK 2. The child thread (to be created
+	 * later in this flow) will have its stack protected by MPK 2, whereas
+	 * the current thread's stack is protected by the default MPK 0. Hence
+	 * both need to be enabled.
+	 */
+	__write_pkey_reg(0x55555544);
+
+	/* Protect the stack with MPK 2 */
+	pkey = pkey_alloc(0, 0);
+	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+
+	/* Set up alternate signal stack that will use the default MPK */
+	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	sigstack.ss_flags = 0;
+	sigstack.ss_size = STACK_SIZE;
+
+	/* Use clone to avoid newer glibcs using rseq on new threads */
+	long ret = syscall_raw(SYS_clone,
+			       CLONE_VM | CLONE_FS | CLONE_FILES |
+			       CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
+			       CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
+			       CLONE_DETACHED,
+			       (long) ((char *)(stack) + STACK_SIZE),
+			       (long) &parent_pid,
+			       (long) &child_pid, 0, 0);
+
+	if (ret < 0) {
+		errno = -ret;
+		perror("clone");
+	}  else if (ret == 0) {
+		thread_sigusr2_self(&sigstack);
+		syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	}
+
+	child_pid =  ret;
+	/* Check that thread exited */
+	do {
+		sched_yield();
+		ret = syscall_raw(SYS_tkill, child_pid, 0, 0, 0, 0, 0);
+	} while (ret != -ESRCH && ret != -EINVAL);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+void (*pkey_tests[])(void) = {
+	test_sigsegv_handler_with_pkey0_disabled,
+	test_sigsegv_handler_cannot_access_stack,
+	test_sigsegv_handler_with_different_pkey_for_stack,
+	test_pkru_preserved_after_sigusr1,
+	test_pkru_sigreturn
+};
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(pkey_tests));
+
+	for (i = 0; i < ARRAY_SIZE(pkey_tests); i++)
+		(*pkey_tests[i])();
+
+	ksft_finished();
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 48dc151f8fca..2af344e55d37 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -950,16 +950,6 @@ void close_test_fds(void)
 	nr_test_fds = 0;
 }
 
-#define barrier() __asm__ __volatile__("": : :"memory")
-__attribute__((noinline)) int read_ptr(int *ptr)
-{
-	/*
-	 * Keep GCC from optimizing this away somehow
-	 */
-	barrier();
-	return *ptr;
-}
-
 void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
 {
 	int i, err;
-- 
2.39.3


