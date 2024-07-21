Return-Path: <linux-kernel+bounces-258197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADC99384E1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C337FB21EC3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3B1662EF;
	Sun, 21 Jul 2024 13:44:37 +0000 (UTC)
Received: from mailscanner10.zoner.fi (mailscanner10.zoner.fi [5.44.246.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264831662E2;
	Sun, 21 Jul 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569476; cv=none; b=YHW3Px1nCd0t5T/MqwklMuZ/9D0asPTU6he0Pl0ASVOTanY6PRXJL4yBfRK8wzB55YbUVq74bt3J86URjUWNYkbpDgfQjoQ0wnfHN2AYBkWbqZ9FloTXTvFGbPLzxC0pLHg+gNn2OWhrPXPnVkplbqufg/j1TZ6MosGXTpGiBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569476; c=relaxed/simple;
	bh=MMet8czUuOzwspGkn6S3dF5TRTqLP7o4KW7IkI9gcx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rt9eFjh9EKA5aDpPI9kqiPY2g9u7vjJdXwUar8nCBxnnD2iT/xRqPA6GVGJF3APD85lPsk19dY+gyQd5jVearNYjrgfHeY1eZyE8l6xyRd68tncaZCFDo3TOYHUvTi7IJowFFZDMmdU44j/vtQOHDSsoSSIhicqm2/4NLRsRKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner10.zoner.fi (Postfix) with ESMTPS id 759A121312;
	Sun, 21 Jul 2024 16:37:04 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkH-00000001SjJ-0Gsx;
	Sun, 21 Jul 2024 16:37:04 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 06/16] xz: Improve the MicroLZMA kernel-doc in xz.h
Date: Sun, 21 Jul 2024 16:36:21 +0300
Message-ID: <20240721133633.47721-7-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721133633.47721-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the description of the format into a "DOC:" comment. Emphasize that
MicroLZMA functions aren't usually needed.

Cc: linux-doc@vger.kernel.org
Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 include/linux/xz.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/xz.h b/include/linux/xz.h
index af1e075d9add..701d62c02b9a 100644
--- a/include/linux/xz.h
+++ b/include/linux/xz.h
@@ -232,9 +232,18 @@ XZ_EXTERN void xz_dec_reset(struct xz_dec *s);
  */
 XZ_EXTERN void xz_dec_end(struct xz_dec *s);
 
-/*
- * Decompressor for MicroLZMA, an LZMA variant with a very minimal header.
- * See xz_dec_microlzma_alloc() below for details.
+/**
+ * DOC: MicroLZMA decompressor
+ *
+ * This MicroLZMA header format was created for use in EROFS but may be used
+ * by others too. **In most cases one needs the XZ APIs above instead.**
+ *
+ * The compressed format supported by this decoder is a raw LZMA stream
+ * whose first byte (always 0x00) has been replaced with bitwise-negation
+ * of the LZMA properties (lc/lp/pb) byte. For example, if lc/lp/pb is
+ * 3/0/2, the first byte is 0xA2. This way the first byte can never be 0x00.
+ * Just like with LZMA2, lc + lp <= 4 must be true. The LZMA end-of-stream
+ * marker must not be used. The unused values are reserved for future use.
  *
  * These functions aren't used or available in preboot code and thus aren't
  * marked with XZ_EXTERN. This avoids warnings about static functions that
@@ -262,15 +271,6 @@ struct xz_dec_microlzma;
  * On success, xz_dec_microlzma_alloc() returns a pointer to
  * struct xz_dec_microlzma. If memory allocation fails or
  * dict_size is invalid, NULL is returned.
- *
- * The compressed format supported by this decoder is a raw LZMA stream
- * whose first byte (always 0x00) has been replaced with bitwise-negation
- * of the LZMA properties (lc/lp/pb) byte. For example, if lc/lp/pb is
- * 3/0/2, the first byte is 0xA2. This way the first byte can never be 0x00.
- * Just like with LZMA2, lc + lp <= 4 must be true. The LZMA end-of-stream
- * marker must not be used. The unused values are reserved for future use.
- * This MicroLZMA header format was created for use in EROFS but may be used
- * by others too.
  */
 extern struct xz_dec_microlzma *xz_dec_microlzma_alloc(enum xz_mode mode,
 						       uint32_t dict_size);
-- 
2.45.2


