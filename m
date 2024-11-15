Return-Path: <linux-kernel+bounces-410523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA019CDCC5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E27B1F237E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8C1B6CF9;
	Fri, 15 Nov 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSVQ41T+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125818FDCE;
	Fri, 15 Nov 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667131; cv=none; b=jGoMUGfHjUUCb8d4GUO/WiNSLezLpDVtGg6BHDy+Ze5GFOA9QrjjGXDQ9UlzUvW4F7LlfO6zyHnt9kg/i2ht549SFh3Lx184aIw9LPj4Anhg42w9YP0ct8Eh3Xgd+/l5lyJWbXeT2hVgvm9oAOyo3Za6n2nzk8WkEb7+KDU7ri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667131; c=relaxed/simple;
	bh=shVHcw3WNIa3pbYlKTq7wOJKs+PhQDB4a8mCLOg2BaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ewrqPegETMzdiCevapJ8QNEVnrFEIKavFG00pzN32LbCK5/U57LftxUQ7zCB17D/g1/OnHx2yLFjmt2QKHb2njf9zxUNxfN6mLEWZlIPsYm4gurSbRnl+WrJgXOCixIWZulK/pV1X33SLc30A5md50g4NuWY2hHADhJmzn1XfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSVQ41T+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98440C4CECF;
	Fri, 15 Nov 2024 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731667131;
	bh=shVHcw3WNIa3pbYlKTq7wOJKs+PhQDB4a8mCLOg2BaY=;
	h=From:To:Cc:Subject:Date:From;
	b=SSVQ41T+CC4JUHAGFK2hW1yUmu3t+OJ4Os7//NeOkhAFeM76XpvDPPpfl2ZmRztwi
	 s7RN5YmYuZp6gUBXQyq81PDHEDIX8CwwnwGtSbYDdIiomFBwwpNCXvT1q5SMrPP2rK
	 sdy/qqYPyfJ52+zLTxG0pMdHrwNqwHbAncoRAnZ10TMAb6kJHEPh/fnt1UDG6AGMRe
	 XfOfQvQmD70XNZFjV1W64ZmFX97ruBIGwS1z1vOVBWZlFJkzqVL6Zp3xgeTOiOvjmS
	 sw4Dp3kaRnXCQ0H3WGaLUnphGT9JnKaF76b0s8CfSIt+fmktInwNIix3+iT8Jw5rbK
	 W7jkgtbwvixiA==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spdx@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH] docs/licensing: Clarify wording about "GPL" and "Proprietary"
Date: Fri, 15 Nov 2024 11:38:41 +0100
Message-ID: <20241115103842.585207-2-ukleinek@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3724; i=ukleinek@kernel.org; h=from:subject; bh=shVHcw3WNIa3pbYlKTq7wOJKs+PhQDB4a8mCLOg2BaY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnNySyhNbpd9jNbMictTcNY8WBTJ5+Z3udDEZqi 0KaVRgcvzuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZzcksgAKCRCPgPtYfRL+ TrUeB/9Vlim6gusugJu/VZJG8BKbQUqk3EzSXlFWscPwPby6BU1/P5mdWh/hL3gMGX51efnhtA4 AewxlPJS2gY+Jh/r8kPpq/8VkNB8ndtcjSSHxxzSJ/J9aSVFdxvpNQZFmkG7mjs4kCVYJpSVGKd Q/Ms1HFovOe+wBBsV8U9SsFkc6o8QCT6hWEI9ANm3qExjCBkXrSY+nJStaLLmsTF4bzIcyTp5xD i/HTkGeLUOfltaBgjEwXqhHLURc/f7ne/zL59mAMpgxQSnH9JrRGu3RleS047GPmjrMeCv4MeVG nGf1c2EBkMM7p4o3cj2IyzS3bh6Tjraw6QutHVugVmP4toJO
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There are currently some doubts about out-of-tree kernel modules licensed
under GPLv3 and if they are supposed to be able to use symbols exported
using EXPORT_SYMBOL_GPL.

Clarify that "Proprietary" means anything non-GPL2 even though the
license might be an open source license. Also disambiguate "GPL
compatible" to "GPLv2 compatible".

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
Hello,

these are the locations that I found by a quick grep. If you spot a
document that needs similar updating, please tell.

The change in license-rules.rst looks bigger than it actually is due to
changing where the line wrappings occur. With `git diff --word-diff` it
reduces to:

    "Proprietary"                 The module is under a proprietary license.
                                  {+"Proprietary" is to be understood only as+}
{+                                "The license is not compatible to GPLv2".+}
                                  This string is solely for [-proprietary-]{+non-GPL2 compatible+}
                                  third party modules and cannot be used for

Best regards
Uwe

 Documentation/kernel-hacking/hacking.rst |  2 +-
 Documentation/process/license-rules.rst  | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index 1717348a4404..0042776a9e17 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -587,7 +587,7 @@ Defined in ``include/linux/export.h``
 
 Similar to :c:func:`EXPORT_SYMBOL()` except that the symbols
 exported by :c:func:`EXPORT_SYMBOL_GPL()` can only be seen by
-modules with a :c:func:`MODULE_LICENSE()` that specifies a GPL
+modules with a :c:func:`MODULE_LICENSE()` that specifies a GPLv2
 compatible license. It implies that the function is considered an
 internal implementation issue, and not really an interface. Some
 maintainers and developers may however require EXPORT_SYMBOL_GPL()
diff --git a/Documentation/process/license-rules.rst b/Documentation/process/license-rules.rst
index 2ef44ada3f11..59a7832df7d0 100644
--- a/Documentation/process/license-rules.rst
+++ b/Documentation/process/license-rules.rst
@@ -471,14 +471,16 @@ _`MODULE_LICENSE`
 				  source files.
 
     "Proprietary"		  The module is under a proprietary license.
-				  This string is solely for proprietary third
-				  party modules and cannot be used for modules
-				  which have their source code in the kernel
-				  tree. Modules tagged that way are tainting
-				  the kernel with the 'P' flag when loaded and
-				  the kernel module loader refuses to link such
-				  modules against symbols which are exported
-				  with EXPORT_SYMBOL_GPL().
+				  "Proprietary" is to be understood only as
+				  "The license is not compatible to GPLv2".
+                                  This string is solely for non-GPL2 compatible
+                                  third party modules and cannot be used for
+                                  modules which have their source code in the
+                                  kernel tree. Modules tagged that way are
+                                  tainting the kernel with the 'P' flag when
+                                  loaded and the kernel module loader refuses
+                                  to link such modules against symbols which
+                                  are exported with EXPORT_SYMBOL_GPL().
     ============================= =============================================
 
 

base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc
-- 
2.45.2


