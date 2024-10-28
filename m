Return-Path: <linux-kernel+bounces-385279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3599B34F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9441C22F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6EC1DE2B9;
	Mon, 28 Oct 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ9iHDoP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C312F585
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129578; cv=none; b=D/oROVhT2SPjfa8oUpRWyFHPEoyV2ecukI1bZvvuq2uoD6ObKjh4iQJRAXD/drjrny9z+abb9lsO80P81Qn0qys3bmcGAPNMw6M1U0QnjEiG/+ZPgBnY/y6oSjS9MC/oGe1bnKcv/k00I4NOz/VtVHoKZJKchXLm2y/8vTrrMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129578; c=relaxed/simple;
	bh=upGzTPCRFBHkCqUdE2jPn6UJQdfuir8ajkUjTJPowWk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A6m8y2LnbwCnZtHkeYyWyTaxDbpLE9WKRjdCDmhI/dUDIMbOxHdFkXVMgMvLUayB1Q4XS1+f9dqtLnpzNmqq+Hc3xoPh2yHDspuL3Yn2k7D/Oxm1RqXAUf//e5Jao/7r01IlFTtGK/RXnuP6kdg3binnFycnKkv/onRLV83WbI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ9iHDoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B1EC4CEC3;
	Mon, 28 Oct 2024 15:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730129577;
	bh=upGzTPCRFBHkCqUdE2jPn6UJQdfuir8ajkUjTJPowWk=;
	h=Date:From:To:Cc:Subject:From;
	b=jJ9iHDoPSQnACREcCvxBttFb3oWYqgsbEXKQ9FTTXxGUqtygdVzLuRqW75I7eFBwC
	 rXnX+MJ6LEbdoQQHkzfI2Y/bT8+Ckov7JX/zTYEt76nEm2/Tmnn/7Nj/WDTTnHxEUo
	 OWW5LbzikwsvA72qUbH4h/CrH2yRl97eo8gbKsrrYoPFmEKBWWU4JL+iIVmWeZshsp
	 WAZ1sUpOBXI4vDyQmlr5cfYcctpkrBQNrrqUNh24VDkOTcCTUV1cNoZ2+1TBm8vab3
	 BlfA2a7UzyBKq69SJFt7UXCMpDwYayPz1pqaZ4bMUawNUlQKw17Wl9m2loIiORJpvv
	 XIeXRNDhn7DnQ==
Date: Mon, 28 Oct 2024 12:30:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Ian Rogers <irogers@google.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers: Update the linux/unaligned.h copy
 with the kernel sources
Message-ID: <Zx-uHvAbPAESofEN@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick up the changes in:

  7f053812dab3946c ("random: vDSO: minimize and simplify header includes")

That required adding a copy of include/vdso/unaligned.h and its checking
in tools/perf/check-headers.h.

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/unaligned.h include/linux/unaligned.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Ian Rogers <irogers@google.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/unaligned.h | 11 +----------
 tools/include/vdso/unaligned.h  | 15 +++++++++++++++
 tools/perf/check-headers.sh     |  1 +
 3 files changed, 17 insertions(+), 10 deletions(-)
 create mode 100644 tools/include/vdso/unaligned.h

diff --git a/tools/include/linux/unaligned.h b/tools/include/linux/unaligned.h
index bc0633bc4650bc8c..395a4464fe732e7a 100644
--- a/tools/include/linux/unaligned.h
+++ b/tools/include/linux/unaligned.h
@@ -9,16 +9,7 @@
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wpacked"
 #pragma GCC diagnostic ignored "-Wattributes"
-
-#define __get_unaligned_t(type, ptr) ({						\
-	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
-	__pptr->x;								\
-})
-
-#define __put_unaligned_t(type, val, ptr) do {					\
-	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
-	__pptr->x = (val);							\
-} while (0)
+#include <vdso/unaligned.h>
 
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
 #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
diff --git a/tools/include/vdso/unaligned.h b/tools/include/vdso/unaligned.h
new file mode 100644
index 0000000000000000..eee3d2a4dbe4d3df
--- /dev/null
+++ b/tools/include/vdso/unaligned.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_UNALIGNED_H
+#define __VDSO_UNALIGNED_H
+
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
+	__pptr->x;								\
+})
+
+#define __put_unaligned_t(type, val, ptr) do {					\
+	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
+	__pptr->x = (val);							\
+} while (0)
+
+#endif /* __VDSO_UNALIGNED_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 29adbb423327aa8d..a05c1c105c51bf1b 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -22,6 +22,7 @@ FILES=(
   "include/vdso/bits.h"
   "include/linux/const.h"
   "include/vdso/const.h"
+  "include/vdso/unaligned.h"
   "include/linux/hash.h"
   "include/linux/list-sort.h"
   "include/uapi/linux/hw_breakpoint.h"
-- 
2.47.0


