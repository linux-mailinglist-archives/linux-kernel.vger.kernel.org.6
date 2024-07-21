Return-Path: <linux-kernel+bounces-258193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE569384DA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE61B281963
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808B916630E;
	Sun, 21 Jul 2024 13:44:04 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1EC166301;
	Sun, 21 Jul 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569444; cv=none; b=CGa/Nj3VUMp0pEfmy6ZXqwuP+O1rb9JsF6bKzwConszO4/SLhuIn733ZPgHynF4+Sdfk/r8NnksKOmb4DCv70IDZY61kXfEcEUMnLXr3on6+0N08EaP0p+aOQde0S/HltuROat2Js3De6an84UbXOjEGOhtXFHCCJLhJSMJdKj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569444; c=relaxed/simple;
	bh=8qs+a53yzMIcJ+Ereum6mH9ProY0V8sD4vafbkMd6yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RS/4CVJJ3OlQ5X5MCncl6PmTGdpHwsgrARCJYwaR4shkhYR9ZwXOSVuRlqxb6mBMC2Ov8V/z/ud77uh2zNnIq5+UgU4s0KwfREQynr878haCorYFRjvbKl0TReJERCapj02lU4VwUDQiA5/SuLrv7yNuVx4MEOFnzteoIIT26cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id 5A37142DE0;
	Sun, 21 Jul 2024 16:37:04 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkG-00000001SjJ-3vyK;
	Sun, 21 Jul 2024 16:37:04 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 05/16] xz: Fix kernel-doc formatting errors in xz.h
Date: Sun, 21 Jul 2024 16:36:20 +0300
Message-ID: <20240721133633.47721-6-lasse.collin@tukaani.org>
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

The opaque structs xz_dec and xz_dec_microlzma are declared in xz.h
but their definitions are in xz_dec_lzma2.c without kernel-doc comments.
Use regular comments for these structs in xz.h to avoid errors when
building the docs.

Add a few missing colons.

Cc: linux-doc@vger.kernel.org
Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 include/linux/xz.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/xz.h b/include/linux/xz.h
index 5728d57aecc0..af1e075d9add 100644
--- a/include/linux/xz.h
+++ b/include/linux/xz.h
@@ -142,7 +142,7 @@ struct xz_buf {
 	size_t out_size;
 };
 
-/**
+/*
  * struct xz_dec - Opaque type to hold the XZ decoder state
  */
 struct xz_dec;
@@ -240,15 +240,16 @@ XZ_EXTERN void xz_dec_end(struct xz_dec *s);
  * marked with XZ_EXTERN. This avoids warnings about static functions that
  * are never defined.
  */
-/**
+
+/*
  * struct xz_dec_microlzma - Opaque type to hold the MicroLZMA decoder state
  */
 struct xz_dec_microlzma;
 
 /**
  * xz_dec_microlzma_alloc() - Allocate memory for the MicroLZMA decoder
- * @mode        XZ_SINGLE or XZ_PREALLOC
- * @dict_size   LZMA dictionary size. This must be at least 4 KiB and
+ * @mode:       XZ_SINGLE or XZ_PREALLOC
+ * @dict_size:  LZMA dictionary size. This must be at least 4 KiB and
  *              at most 3 GiB.
  *
  * In contrast to xz_dec_init(), this function only allocates the memory
@@ -276,15 +277,15 @@ extern struct xz_dec_microlzma *xz_dec_microlzma_alloc(enum xz_mode mode,
 
 /**
  * xz_dec_microlzma_reset() - Reset the MicroLZMA decoder state
- * @s           Decoder state allocated using xz_dec_microlzma_alloc()
- * @comp_size   Compressed size of the input stream
- * @uncomp_size Uncompressed size of the input stream. A value smaller
+ * @s:          Decoder state allocated using xz_dec_microlzma_alloc()
+ * @comp_size:  Compressed size of the input stream
+ * @uncomp_size:  Uncompressed size of the input stream. A value smaller
  *              than the real uncompressed size of the input stream can
  *              be specified if uncomp_size_is_exact is set to false.
  *              uncomp_size can never be set to a value larger than the
  *              expected real uncompressed size because it would eventually
  *              result in XZ_DATA_ERROR.
- * @uncomp_size_is_exact  This is an int instead of bool to avoid
+ * @uncomp_size_is_exact:  This is an int instead of bool to avoid
  *              requiring stdbool.h. This should normally be set to true.
  *              When this is set to false, error detection is weaker.
  */
@@ -294,7 +295,7 @@ extern void xz_dec_microlzma_reset(struct xz_dec_microlzma *s,
 
 /**
  * xz_dec_microlzma_run() - Run the MicroLZMA decoder
- * @s           Decoder state initialized using xz_dec_microlzma_reset()
+ * @s:          Decoder state initialized using xz_dec_microlzma_reset()
  * @b:          Input and output buffers
  *
  * This works similarly to xz_dec_run() with a few important differences.
-- 
2.45.2


