Return-Path: <linux-kernel+bounces-573915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8421A6DE05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B45188F7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3A261578;
	Mon, 24 Mar 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="My3I3Mp9"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0A7261396;
	Mon, 24 Mar 2025 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829297; cv=pass; b=KA+SeResZJgVTtZBYPwWcxipw0By3VNtqC0xRnV49AbRo87WN0DniUdopx/sa5X9f8fg6M/4zhqaTmaQKsWv/Alft+macSRoFj3ybRny/yFmH1czMMhIZ+ZMDrBqw1KVmKSfd/+oBlrj2w7j3tckSdRteDoZI0msqwCuM9+pBY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829297; c=relaxed/simple;
	bh=yyWBoVIdgM9yd55s/XqWCPB+EHlT41sHUz5jV+dNppk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sr24SyvIPzumxiGfDq23COO/mGjYSGKILayWr+wIfiN68h5/E9zHudIf44I7Oe2YOFuE4vC5L2fi0UjKc3BF4fyEgBj/6kSgFBfBTV8jFpMHsVz5PtstaqzDmV9yGjHiqKZNvQWHXBOUb+a/hdqGySYSSSgaYmZLaE9FPd6gKUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=My3I3Mp9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742829273; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FXPdAeI3f+wrKHfylHGK4lXWlXx1asWt6oTR6MWN+rR5EBKONwlGVzk0Ne6VXnSwW138eA8Uh33Dwwko3lXCJgXNOTRpGw7ihhj/+4FuWDa6OFRuW6CmnuwsOTOugYxPvvNZketVzPaDRlB/EugCvd9tfq0cmyaKWTCX2CQSiP4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742829273; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0GC8XAU9kSZizGu7pirgOvAlkT/SjNy72/DTHBMZsj8=; 
	b=bp+xEitzIzdPSgM7ciQCzhUyVZ4fojqWQGfAqBO3aAOk9eVXLFsbUEFHNkDj+Q0mM8PAVfqRWTmKSy0unQqOAAsBf5Minb0wyy1uehGadw+TOM+cpgDN61Shr1Rn7gH4D3kFKhcNB8nJ8l4VeP398L7B7aXCWgXaEicMo6qrTzE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742829273;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=0GC8XAU9kSZizGu7pirgOvAlkT/SjNy72/DTHBMZsj8=;
	b=My3I3Mp9qHOHIPnuXmVVMRivjE55FPuydbJuD5lBmm9xPwHDIxUiavN+N9SJBROk
	8aWEuPnmOJ7JZ7dNJK5Qta6C6fRsOCoxWyP5i1kVaVtJkgxwTSEFEtZfCvPEU5y0fnp
	8xsm/rwbKJZ+AO+OeBYP0r0xBo1gQalPIDN+S6aA=
Received: by mx.zohomail.com with SMTPS id 1742829270854331.91542821528924;
	Mon, 24 Mar 2025 08:14:30 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 24 Mar 2025 12:13:54 -0300
Subject: [PATCH 1/2] rust: helpers: Add bindings/wrappers for dma_resv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-gpuvm-v1-1-7f8213eebb56@collabora.com>
References: <20250324-gpuvm-v1-0-7f8213eebb56@collabora.com>
In-Reply-To: <20250324-gpuvm-v1-0-7f8213eebb56@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

From: Asahi Lina <lina@asahilina.net>

This is just for basic usage in the DRM shmem abstractions for implied
locking, not intended as a full DMA Reservation abstraction yet.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/bindings/bindings_helper.h |  4 +++-
 rust/helpers/dma-resv.c         | 13 +++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e6020ba5b00237a08402fbd609c7fba27b970dd9..53111b5b35588541eca05e574a8d24cdafbf1dd6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -18,6 +18,7 @@
 #include <linux/blkdev.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
+#include <linux/dma-resv.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
@@ -53,5 +54,6 @@ const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
 const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
-const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL =
+	BLK_FEAT_ROTATIONAL;
 const fop_flags_t RUST_CONST_HELPER_FOP_UNSIGNED_OFFSET = FOP_UNSIGNED_OFFSET;
diff --git a/rust/helpers/dma-resv.c b/rust/helpers/dma-resv.c
new file mode 100644
index 0000000000000000000000000000000000000000..05501cb814513b483afd0b7f220230d867863c2f
--- /dev/null
+++ b/rust/helpers/dma-resv.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-resv.h>
+
+int rust_helper_dma_resv_lock(struct dma_resv *obj, struct ww_acquire_ctx *ctx)
+{
+	return dma_resv_lock(obj, ctx);
+}
+
+void rust_helper_dma_resv_unlock(struct dma_resv *obj)
+{
+	dma_resv_unlock(obj);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7a06d6bc48537248c8a3ec4243b37d8fb2b1cb26..c5e536d688bc35c7b348daa61e868c91a7bdbd23 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -14,6 +14,7 @@
 #include "build_bug.c"
 #include "cred.c"
 #include "device.c"
+#include "dma-resv.c"
 #include "drm.c"
 #include "err.c"
 #include "fs.c"

-- 
2.48.1


