Return-Path: <linux-kernel+bounces-363214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFBA99BF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291561F22A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA3130E4A;
	Mon, 14 Oct 2024 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8MvshJs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA0231C9C;
	Mon, 14 Oct 2024 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728879721; cv=none; b=kTRmmf5fQCGGf/c7pVlvFuGfWSGsoeVUmfsaTJvgNhAIzqgvaXgAoxf0aEMZusmpjLenxI36ykP74pV4dHm1E7Secl7xhAM//Zghkb1064u2GLpYLTW3RhEav4HUghLkySDYcrYLrw02AEFwwn9de/MCaPjepzDyQG8fsQCNUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728879721; c=relaxed/simple;
	bh=7u6BhScJFESan00qiEx5aDqMPc4HPZs7ourjTOn24dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZcMc8JNl0Wsgh2uYLMTa9FBc6KNCvil3YzbkCwsWGsBlWgc0bQttWluPPk1R5hn8sZ9/C2FQRqhHzH4jrK18hL7p2iFwG4tgUXAR1TvWnXGNENf/bhBBdeouxxL4ieS7Nk858sRdBN4nsKUC3kWORLuTKLiNa8Q0bhQFjAN2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8MvshJs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728879720; x=1760415720;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7u6BhScJFESan00qiEx5aDqMPc4HPZs7ourjTOn24dE=;
  b=S8MvshJsfdjkmxjsVpCmuVL9M0+sGQVTBTnHaRg7gAOHf0bn92+c6VB6
   rXI65v/YBNgHEyG7RJb4ypxWbYfKChVwm+9Zd7KLVW+NoJhY4/Vdhk9B8
   sNJdr2BLSA5FYrvviv82iTiZIsU8R5dhodWZmdasmkVjwnSwWJkpzcA4R
   Quic9UYzbj+kCvzVHz3cfVCk5Pak2Cmqd9N+6ouym9YfXlFGTBSXobav8
   p1s4xTYz7vC+bpOJTaHZa7Jq6siSO4NicRB1iCgzylZ+KmX6c34w65DRp
   Sizvq6n3bdsw6dBnqLxTFccWsz0KoAiPb8LJdMzgJCkCDf7jTt5ecsexn
   g==;
X-CSE-ConnectionGUID: Uqp5JH6NSXy5aAeAsP26dg==
X-CSE-MsgGUID: D4pTa8y+Rg+dvqdQCPcW6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="15840801"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="15840801"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 21:21:59 -0700
X-CSE-ConnectionGUID: gx6nqTwuQEWJvHB5odwfcg==
X-CSE-MsgGUID: SnXW3sGiSaWA5KlY3W61Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77466454"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 21:21:57 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Yan Zhao <yan.y.zhao@intel.com>,
	Yuan Yao <yuan.yao@intel.com>
Subject: [PATCH] KVM: VMX: Remove the unused variable "gpa" in __invept()
Date: Mon, 14 Oct 2024 12:19:40 +0800
Message-ID: <20241014041941.579-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unused variable "gpa" in __invept().

The INVEPT instruction only supports two types: VMX_EPT_EXTENT_CONTEXT (1)
and VMX_EPT_EXTENT_GLOBAL (2). Neither of these types requires a third
variable "gpa".

The "gpa" variable for __invept() is always set to 0 and was originally
introduced for the old non-existent type VMX_EPT_EXTENT_INDIVIDUAL_ADDR
(0). This type was removed by commit 2b3c5cbc0d81 ("kvm: don't use bit24
for detecting address-specific invalidation capability") and
commit 63f3ac48133a ("KVM: VMX: clean up declaration of VPID/EPT
invalidation types").

Since this variable is not useful for error handling either, remove it to
avoid confusion.

No functional changes expected.

Cc: Yuan Yao <yuan.yao@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/vmx/vmx.c     |  5 ++---
 arch/x86/kvm/vmx/vmx_ops.h | 15 +++++++--------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 80883f43d4c4..f19686d55d42 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -480,10 +480,9 @@ noinline void invvpid_error(unsigned long ext, u16 vpid, gva_t gva)
 			ext, vpid, gva);
 }
 
-noinline void invept_error(unsigned long ext, u64 eptp, gpa_t gpa)
+noinline void invept_error(unsigned long ext, u64 eptp)
 {
-	vmx_insn_failed("invept failed: ext=0x%lx eptp=%llx gpa=0x%llx\n",
-			ext, eptp, gpa);
+	vmx_insn_failed("invept failed: ext=0x%lx eptp=%llx\n", ext, eptp);
 }
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 8060e5fc6dbd..4616f8d120bb 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -15,7 +15,7 @@ void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
 void invvpid_error(unsigned long ext, u16 vpid, gva_t gva);
-void invept_error(unsigned long ext, u64 eptp, gpa_t gpa);
+void invept_error(unsigned long ext, u64 eptp);
 
 #ifndef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 /*
@@ -312,13 +312,12 @@ static inline void __invvpid(unsigned long ext, u16 vpid, gva_t gva)
 	vmx_asm2(invvpid, "r"(ext), "m"(operand), ext, vpid, gva);
 }
 
-static inline void __invept(unsigned long ext, u64 eptp, gpa_t gpa)
+static inline void __invept(unsigned long ext, u64 eptp)
 {
 	struct {
-		u64 eptp, gpa;
-	} operand = {eptp, gpa};
-
-	vmx_asm2(invept, "r"(ext), "m"(operand), ext, eptp, gpa);
+		u64 eptp;
+	} operand = { eptp };
+	vmx_asm2(invept, "r"(ext), "m"(operand), ext, eptp);
 }
 
 static inline void vpid_sync_vcpu_single(int vpid)
@@ -355,13 +354,13 @@ static inline void vpid_sync_vcpu_addr(int vpid, gva_t addr)
 
 static inline void ept_sync_global(void)
 {
-	__invept(VMX_EPT_EXTENT_GLOBAL, 0, 0);
+	__invept(VMX_EPT_EXTENT_GLOBAL, 0);
 }
 
 static inline void ept_sync_context(u64 eptp)
 {
 	if (cpu_has_vmx_invept_context())
-		__invept(VMX_EPT_EXTENT_CONTEXT, eptp, 0);
+		__invept(VMX_EPT_EXTENT_CONTEXT, eptp);
 	else
 		ept_sync_global();
 }

base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.43.2


