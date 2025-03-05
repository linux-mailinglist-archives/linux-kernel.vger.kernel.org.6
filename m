Return-Path: <linux-kernel+bounces-547108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE388A50302
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A117A54EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2A24E4AD;
	Wed,  5 Mar 2025 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fUNemUP7"
Received: from out.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5F24BBF7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186880; cv=none; b=FO2g5bgNxjgi07Sjq1MzsLeWCAwpzTAZil8dfgW4IIW1tSxdasGv5saapkmmYwkXe6EZKN+6i/l27sGafi/zwzt7E2C1l0k0c0VknoQY+I/LYJjMqUH3WLwnNCPm9rCxAukfAk3vMKiZDX7UodWbSzuMoQxcSk2gKMjRcvWURGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186880; c=relaxed/simple;
	bh=W+tboB6IgFEjPGx3WkSzqgQIUHHEdFH9Cj4qkUkDilM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W44PL9MQ3o3o2Xnvo3r4RgU/Nfjm/Wbx9+6ReME/DOr4hmhImIvPqf3xGjR/bK7wxgccuadKoT6vhLMqOfsl+v2TxJ/638NLAyTpzA67xr0CF+v6o3OskEGRcE8S9WaytvfKu6KorDpbaLUykS8T3lFG4AUKGrdpASCCYLMA24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fUNemUP7; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id pqDptJzz8mAhYpqE8tuPKl; Wed, 05 Mar 2025 16:00:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741186807;
	bh=aZ1JmONzMcP89ngQ1BiwOhPd9zDte7irRWei57QsOWo=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=fUNemUP7GZeBHer6ykuQ2XeX0p5tS3qcFd5LH+i/IshFTPxC/f9ZmEm8zPxT/PHzY
	 wR9fmOyO5nY71RHxLioTcs7Que6kWJp8P14vigbKKgfiz1Xs3AM08lRJHMIiArSmVu
	 nMjaCjUYTuRtZJbgS7CZCGsGUESjBFTU5CjHOEeSIGxc0dv+LZr7yWEP42nIdFD+v8
	 HTVbrWXwk10Wjmor+QexdjIdBRNjEYcTEgjBxIANVUEPk+bgtqRFBxWZP9+gkmgTZ8
	 E8hcsHfW5yFsx1//hKXFyM/VOyv3S42rsErCzr2FSWisov+AJtBY5n1R4LhVrLwNxT
	 h7ykJr4oO2v2A==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 05 Mar 2025 16:00:07 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Wed, 05 Mar 2025 23:59:32 +0900
Subject: [PATCH] treewide: fix typo 'unsigned __init128' -> 'unsigned
 __int128'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-fix_init128_typo-v1-1-cbe5b8e54e7d@wanadoo.fr>
X-B4-Tracking: v=1; b=H4sIANNmyGcC/x2MQQqAIBAAvyJ7TnCVIPtKhERutRcTlSikvycdB
 2amQqbElGEUFRJdnPkMDbATsB5L2Emybwxa6V4Z1cuNb8eBC+rBlSee0i7KE6K31qzQspioOf9
 ymt/3A+xiBChiAAAA
X-Change-ID: 20250305-fix_init128_typo-9a0de11d993c
To: Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3058;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=W+tboB6IgFEjPGx3WkSzqgQIUHHEdFH9Cj4qkUkDilM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkn0t4+X8GqmZ8jH2S+eoZr51tDm9SNW+6dNXsVs5bX2
 OtS+8P1HaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZy4gYjQ0/HPYHSFv0rBg3f
 Gd6kP7PiLMiKlMx3EA/qO+y/rNwwn5HhcXskw49PsUdyNr8Sm6u979Z0oa8nn8vf3hL0Qfo9X4A
 2JwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

"int" was misspelled as "init" the code comments in the bits.h and
const.h files. Fix the typo.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/bits.h             | 2 +-
 include/uapi/linux/const.h       | 2 +-
 tools/include/linux/bits.h       | 2 +-
 tools/include/uapi/linux/const.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 61a75d3f294bfa96267383b5e2fd2a5d4593fcee..14fd0ca9a6cd17339dd2f69e449558312a8a001b 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -40,7 +40,7 @@
  * Missing asm support
  *
  * __GENMASK_U128() depends on _BIT128() which would not work
- * in the asm code, as it shifts an 'unsigned __init128' data
+ * in the asm code, as it shifts an 'unsigned __int128' data
  * type instead of direct representation of 128 bit constants
  * such as long and unsigned long. The fundamental problem is
  * that a 128 bit constant will get silently truncated by the
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index e16be0d37746e14b9eedcdb38be7d11f29b5113a..b8f629ef135f356f552b9aa9dd73356167503134 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -33,7 +33,7 @@
  * Missing asm support
  *
  * __BIT128() would not work in the asm code, as it shifts an
- * 'unsigned __init128' data type as direct representation of
+ * 'unsigned __int128' data type as direct representation of
  * 128 bit constants is not supported in the gcc compiler, as
  * they get silently truncated.
  *
diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 60044b6088172b3f26aa3f17cdaede9786863dae..8de2914e65101463667de45db7ade17c4a72ff40 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -41,7 +41,7 @@
  * Missing asm support
  *
  * __GENMASK_U128() depends on _BIT128() which would not work
- * in the asm code, as it shifts an 'unsigned __init128' data
+ * in the asm code, as it shifts an 'unsigned __int128' data
  * type instead of direct representation of 128 bit constants
  * such as long and unsigned long. The fundamental problem is
  * that a 128 bit constant will get silently truncated by the
diff --git a/tools/include/uapi/linux/const.h b/tools/include/uapi/linux/const.h
index e16be0d37746e14b9eedcdb38be7d11f29b5113a..b8f629ef135f356f552b9aa9dd73356167503134 100644
--- a/tools/include/uapi/linux/const.h
+++ b/tools/include/uapi/linux/const.h
@@ -33,7 +33,7 @@
  * Missing asm support
  *
  * __BIT128() would not work in the asm code, as it shifts an
- * 'unsigned __init128' data type as direct representation of
+ * 'unsigned __int128' data type as direct representation of
  * 128 bit constants is not supported in the gcc compiler, as
  * they get silently truncated.
  *

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250305-fix_init128_typo-9a0de11d993c

Best regards,
-- 
Vincent Mailhol <mailhol.vincent@wanadoo.fr>


