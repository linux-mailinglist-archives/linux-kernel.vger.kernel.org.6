Return-Path: <linux-kernel+bounces-552756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C7BA57DB9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7621891604
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B194D1E5218;
	Sat,  8 Mar 2025 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOhX7ObJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26B148857
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741461669; cv=none; b=HiuGXP39caRoBL8atqsYfixAM4aFYK61VkB5yMJOJS28w3WwEZFPpqL67MH8T1cqxuwb9FUeAJKEWJzTmbjaP2+GuBAKcoEWS/sW0vg4VvBmPJuj1sFqYY9vwWgS7qFrc+59SUAiuz88RyAMqyLz9f7rKEccTCYRFUed+/U3oXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741461669; c=relaxed/simple;
	bh=Y2T+xSWwSLa+bW4gLZFBgefmwcGZMj78Bac82C0Do10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HbFCnBuPWmeWDtDaJ+2/7A9tLZjpGJ1yBew9P7B59PQUW9sqiQ1TDV9MlD71CNFzc0QgCG76z210cGP3s4r2SaaS7hyk6KWyN4Ege/pqpB8pFo8/XHhdC/B5Z+bnWq7WqBwaS2HmUHIO2VHaBwy1H0E56C1csd8lxLtmILr76C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOhX7ObJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E5CC4CEE0;
	Sat,  8 Mar 2025 19:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741461669;
	bh=Y2T+xSWwSLa+bW4gLZFBgefmwcGZMj78Bac82C0Do10=;
	h=Date:From:To:Cc:Subject:From;
	b=hOhX7ObJvjaI/Vry0EJvpwCOwmfhXz6JYw3k4CEOx8Xyvb9bDN/Sqt/xP3OxakW9E
	 PLrKexMfg8XMNjrrvTDLN902dk3Lpvlkh+D/J3BiK/JvM5UVe5ShEx0NbLFlBnNPeL
	 mxGoZbENJFcVsAIMI07+TTcu6ab8oLN2mVi7Q1D/TY4JFt2h22bM3nl/bLuZfOi+um
	 dYwuq2vpgVtGPe1WJolRgXB1nEhb6BK6GOlNf+00xNNbJpI+AZ1AiNYPtzHWPqHDmA
	 +MN3WRlMjypQXKHPkvEG+Y4Lc+Yq40d3kTdq6NMFsYXh6oC386eSlZpdRLXmkb+Q78
	 PZBGiaueXksNA==
Date: Sat, 8 Mar 2025 20:21:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <Z8yYoNSdSgXf4AGj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 
Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-08

   # HEAD: 058a6bec37c6c3b826158f6d26b75de43816a880 x86/microcode/AMD: Add some forgotten models to the SHA check

( Merge note: these commits are a bit fresher than usual,
  but I didn't want to delay the x86 microcode fixes to
  after -rc6. )

Misc x86 fixes:

 - Add more model IDs to the AMD microcode version check,
   more people are hitting these checks

 - Fix a Xen guest boot warning related to AMD northbridge
   setup

 - Fix SEV guest bugs related to a recent changes in its
   locking logic

 - Fix a missing definition of PTRS_PER_PMD that assembly
   builds can hit

 Thanks,

	Ingo

------------------>
Alexey Kardashevskiy (1):
      virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex

Andrew Cooper (1):
      x86/amd_nb: Use rdmsr_safe() in amd_get_mmconfig_range()

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Add some forgotten models to the SHA check

Ingo Molnar (1):
      x86/mm: Define PTRS_PER_PMD for assembly code too

Nikunj A Dadhania (1):
      virt: sev-guest: Allocate request data dynamically


 arch/x86/coco/sev/core.c                    | 23 ++++--------
 arch/x86/include/asm/pgtable-2level_types.h |  8 ++--
 arch/x86/include/asm/sev.h                  |  6 +--
 arch/x86/kernel/amd_nb.c                    |  9 ++---
 arch/x86/kernel/cpu/microcode/amd.c         |  6 +++
 drivers/virt/coco/sev-guest/sev-guest.c     | 58 +++++++++++++++++++++--------
 6 files changed, 67 insertions(+), 43 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492efc5d94..96c7bc698e6b 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2853,19 +2853,8 @@ struct snp_msg_desc *snp_msg_alloc(void)
 	if (!mdesc->response)
 		goto e_free_request;
 
-	mdesc->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
-	if (!mdesc->certs_data)
-		goto e_free_response;
-
-	/* initial the input address for guest request */
-	mdesc->input.req_gpa = __pa(mdesc->request);
-	mdesc->input.resp_gpa = __pa(mdesc->response);
-	mdesc->input.data_gpa = __pa(mdesc->certs_data);
-
 	return mdesc;
 
-e_free_response:
-	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
 e_free_request:
 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
 e_unmap:
@@ -2885,7 +2874,6 @@ void snp_msg_free(struct snp_msg_desc *mdesc)
 	kfree(mdesc->ctx);
 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
-	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	iounmap((__force void __iomem *)mdesc->secrets);
 
 	memset(mdesc, 0, sizeof(*mdesc));
@@ -3054,7 +3042,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(req, &mdesc->input, rio);
+	rc = snp_issue_guest_request(req, &req->input, rio);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -3064,7 +3052,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 		 * order to increment the sequence number and thus avoid
 		 * IV reuse.
 		 */
-		override_npages = mdesc->input.data_npages;
+		override_npages = req->input.data_npages;
 		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
@@ -3120,7 +3108,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 	}
 
 	if (override_npages)
-		mdesc->input.data_npages = override_npages;
+		req->input.data_npages = override_npages;
 
 	return rc;
 }
@@ -3158,6 +3146,11 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 	 */
 	memcpy(mdesc->request, &mdesc->secret_request, sizeof(mdesc->secret_request));
 
+	/* Initialize the input address for guest request */
+	req->input.req_gpa = __pa(mdesc->request);
+	req->input.resp_gpa = __pa(mdesc->response);
+	req->input.data_gpa = req->certs_data ? __pa(req->certs_data) : 0;
+
 	rc = __handle_guest_request(mdesc, req, rio);
 	if (rc) {
 		if (rc == -EIO &&
diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index 7f6ccff0ba72..4a12c276b181 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -23,17 +23,17 @@ typedef union {
 #define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
 
 /*
- * traditional i386 two-level paging structure:
+ * Traditional i386 two-level paging structure:
  */
 
 #define PGDIR_SHIFT	22
 #define PTRS_PER_PGD	1024
 
-
 /*
- * the i386 is two-level, so we don't really have any
- * PMD directory physically.
+ * The i386 is two-level, so we don't really have any
+ * PMD directory physically:
  */
+#define PTRS_PER_PMD	1
 
 #define PTRS_PER_PTE	1024
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 1581246491b5..ba7999f66abe 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -203,6 +203,9 @@ struct snp_guest_req {
 	unsigned int vmpck_id;
 	u8 msg_version;
 	u8 msg_type;
+
+	struct snp_req_data input;
+	void *certs_data;
 };
 
 /*
@@ -263,9 +266,6 @@ struct snp_msg_desc {
 	struct snp_guest_msg secret_request, secret_response;
 
 	struct snp_secrets_page *secrets;
-	struct snp_req_data input;
-
-	void *certs_data;
 
 	struct aesgcm_ctx *ctx;
 
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 11fac09e3a8c..67e773744edb 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -143,7 +143,6 @@ bool __init early_is_amd_nb(u32 device)
 
 struct resource *amd_get_mmconfig_range(struct resource *res)
 {
-	u32 address;
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
@@ -151,13 +150,11 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
-	/* assume all cpus from fam10h have mmconfig */
-	if (boot_cpu_data.x86 < 0x10)
+	/* Assume CPUs from Fam10h have mmconfig, although not all VMs do */
+	if (boot_cpu_data.x86 < 0x10 ||
+	    rdmsrl_safe(MSR_FAM10H_MMIO_CONF_BASE, &msr))
 		return NULL;
 
-	address = MSR_FAM10H_MMIO_CONF_BASE;
-	rdmsrl(address, msr);
-
 	/* mmconfig is not enabled */
 	if (!(msr & FAM10H_MMIO_CONF_ENABLE))
 		return NULL;
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 95ac1c6a84fb..c69b1bc45483 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -175,23 +175,29 @@ static bool need_sha_check(u32 cur_rev)
 {
 	switch (cur_rev >> 8) {
 	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x80082: return cur_rev <= 0x800820f; break;
 	case 0x83010: return cur_rev <= 0x830107c; break;
 	case 0x86001: return cur_rev <= 0x860010e; break;
 	case 0x86081: return cur_rev <= 0x8608108; break;
 	case 0x87010: return cur_rev <= 0x8701034; break;
 	case 0x8a000: return cur_rev <= 0x8a0000a; break;
+	case 0xa0010: return cur_rev <= 0xa00107a; break;
 	case 0xa0011: return cur_rev <= 0xa0011da; break;
 	case 0xa0012: return cur_rev <= 0xa001243; break;
+	case 0xa0082: return cur_rev <= 0xa00820e; break;
 	case 0xa1011: return cur_rev <= 0xa101153; break;
 	case 0xa1012: return cur_rev <= 0xa10124e; break;
 	case 0xa1081: return cur_rev <= 0xa108109; break;
 	case 0xa2010: return cur_rev <= 0xa20102f; break;
 	case 0xa2012: return cur_rev <= 0xa201212; break;
+	case 0xa4041: return cur_rev <= 0xa404109; break;
+	case 0xa5000: return cur_rev <= 0xa500013; break;
 	case 0xa6012: return cur_rev <= 0xa60120a; break;
 	case 0xa7041: return cur_rev <= 0xa704109; break;
 	case 0xa7052: return cur_rev <= 0xa705208; break;
 	case 0xa7080: return cur_rev <= 0xa708009; break;
 	case 0xa70c0: return cur_rev <= 0xa70C009; break;
+	case 0xaa001: return cur_rev <= 0xaa00116; break;
 	case 0xaa002: return cur_rev <= 0xaa00218; break;
 	default: break;
 	}
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 264b6523fe52..70fbc9a3e703 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -38,12 +38,6 @@ struct snp_guest_dev {
 	struct miscdevice misc;
 
 	struct snp_msg_desc *msg_desc;
-
-	union {
-		struct snp_report_req report;
-		struct snp_derived_key_req derived_key;
-		struct snp_ext_report_req ext_report;
-	} req;
 };
 
 /*
@@ -71,7 +65,7 @@ struct snp_req_resp {
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_report_req *report_req = &snp_dev->req.report;
+	struct snp_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -80,6 +74,10 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_user(report_req, (void __user *)arg->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
@@ -116,7 +114,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
+	struct snp_derived_key_req *derived_key_req __free(kfree) = NULL;
 	struct snp_derived_key_resp derived_key_resp = {0};
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_guest_req req = {};
@@ -136,6 +134,10 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
+	derived_key_req = kzalloc(sizeof(*derived_key_req), GFP_KERNEL_ACCOUNT);
+	if (!derived_key_req)
+		return -ENOMEM;
+
 	if (copy_from_user(derived_key_req, (void __user *)arg->req_data,
 			   sizeof(*derived_key_req)))
 		return -EFAULT;
@@ -168,16 +170,21 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 			  struct snp_req_resp *io)
 
 {
-	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
+	struct snp_ext_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
 	int ret, npages = 0, resp_len;
 	sockptr_t certs_address;
+	struct page *page;
 
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_sockptr(report_req, io->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
@@ -203,8 +210,20 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	 * the host. If host does not supply any certs in it, then copy
 	 * zeros to indicate that certificate data was not provided.
 	 */
-	memset(mdesc->certs_data, 0, report_req->certs_len);
 	npages = report_req->certs_len >> PAGE_SHIFT;
+	page = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
+			   get_order(report_req->certs_len));
+	if (!page)
+		return -ENOMEM;
+
+	req.certs_data = page_address(page);
+	ret = set_memory_decrypted((unsigned long)req.certs_data, npages);
+	if (ret) {
+		pr_err("failed to mark page shared, ret=%d\n", ret);
+		__free_pages(page, get_order(report_req->certs_len));
+		return -EFAULT;
+	}
+
 cmd:
 	/*
 	 * The intermediate response buffer is used while decrypting the
@@ -213,10 +232,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	 */
 	resp_len = sizeof(report_resp->data) + mdesc->ctx->authsize;
 	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
-	if (!report_resp)
-		return -ENOMEM;
+	if (!report_resp) {
+		ret = -ENOMEM;
+		goto e_free_data;
+	}
 
-	mdesc->input.data_npages = npages;
+	req.input.data_npages = npages;
 
 	req.msg_version = arg->msg_version;
 	req.msg_type = SNP_MSG_REPORT_REQ;
@@ -231,7 +252,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		report_req->certs_len = mdesc->input.data_npages << PAGE_SHIFT;
+		report_req->certs_len = req.input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_sockptr(io->req_data, report_req, sizeof(*report_req)))
 			ret = -EFAULT;
@@ -240,7 +261,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (ret)
 		goto e_free;
 
-	if (npages && copy_to_sockptr(certs_address, mdesc->certs_data, report_req->certs_len)) {
+	if (npages && copy_to_sockptr(certs_address, req.certs_data, report_req->certs_len)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
@@ -250,6 +271,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
 e_free:
 	kfree(report_resp);
+e_free_data:
+	if (npages) {
+		if (set_memory_encrypted((unsigned long)req.certs_data, npages))
+			WARN_ONCE(ret, "failed to restore encryption mask (leak it)\n");
+		else
+			__free_pages(page, get_order(report_req->certs_len));
+	}
 	return ret;
 }
 

