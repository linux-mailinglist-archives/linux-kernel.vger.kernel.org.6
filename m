Return-Path: <linux-kernel+bounces-575693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624A9A705EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E24E1744D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C909C2571DB;
	Tue, 25 Mar 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gExSObNV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9691FAC45
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918449; cv=none; b=rfA7BOuNJDV1n/FF0ODqTaqv4sy07n21L3qFHjTw+S62s+U0+m0C9FxjRKRHwffbdBskcIZbYSs0r2vHVqcsiXuNh131eaa4uOLmnQ0gQUAs2fjeBfL0427DRXi3E3kVaop/EtQeOjoIRqMy4H3XqiE6MhmFAJvwNE0Biyoo/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918449; c=relaxed/simple;
	bh=TjiHYCpNQphi1tE+0DL9muw8Pf7OfDUpMtLAFTcJtqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+QPxD+2W53vIlWjT/rLMnUNuwWxEZ1j4JFIRPVViq6K3fDxe3bGve3beCW/QUUPfjaBK3531hGWoN4BSW7ZRFicG/ZcJ1HllhmsHImFG1C0n5w+29DozN7Tx1W7O8dhVijzZh98LuEh+66DGsR99n8AQHO3NbeVulN38ldGCqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gExSObNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBD7EC4CEED;
	Tue, 25 Mar 2025 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742918448;
	bh=TjiHYCpNQphi1tE+0DL9muw8Pf7OfDUpMtLAFTcJtqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gExSObNVNUTCOeWV6gSIlTeNmstu3+4Vk1ZJbnxrNZkdiTPiMrZZDFZWEApwx96+j
	 0d0Bb0/eHNOOkrRzPoo/Iq3e4DPllkFJC4mMJgPmqBH2z3YkKMi0iZbWl/seHTOiFJ
	 aj8g8vB9NFsCVivmOQVmUE3v9CXpTROUFk6/niGm1wtDPIxXNdMarA+KCINUwrcpbH
	 srZvZ7X/UGfZLaRZ3tCYjAYRk4p23ML9wFOTiFxCfIZpG8UxNQXirCCmYskuBPORnM
	 ++0jRXgmFZ9IhHW4HQBDrngAdm+jgQInmrQNEpQM9P12tDMEOlzjplytaJFnuF44k3
	 P0qZg7UobNLHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC3FC3600C;
	Tue, 25 Mar 2025 16:00:48 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Wed, 26 Mar 2025 00:59:56 +0900
Subject: [PATCH v8 1/6] bits: add comments and newlines to #if, #else and
 #endif directives
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-fixed-type-genmasks-v8-1-24afed16ca00@wanadoo.fr>
References: <20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr>
In-Reply-To: <20250326-fixed-type-genmasks-v8-0-24afed16ca00@wanadoo.fr>
To: Yury Norov <yury.norov@gmail.com>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>, 
 David Laight <David.Laight@ACULAB.COM>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=Ogw/eQvEVmEiIvULs2D8+i7sug2mLu6AIl3BoTH0U+o=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOmPLss+er5p5/8bRxLjOl1Ftl3iT34zv3ml1X4/6V7Dr
 1oKOg/NO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEzk6g9Ghjd/rmjMnnfwn2Zr
 8dlgbceNMdY9nQHp+zVvpRf4SP6vmsHwP085q5nvqPz3U3lTDTSPrZNc9mNTjwenT0PA3z1Tj/+
 RZwYA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

This is a preparation for the upcoming GENMASK_U*() and BIT_U*()
changes. After introducing those new macros, there will be a lot of
scrolling between the #if, #else and #endif.

Add a comment to the #else and #endif preprocessor macros to help keep
track of which context we are in. Also, add new lines to better
visually separate the non-asm and asm sections.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

  v7 -> v8:

    - new patch
---
 include/linux/bits.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 14fd0ca9a6cd17339dd2f69e449558312a8a001b..e1e5177691406919ba4f5bbc875bd230414fd117 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -19,16 +19,21 @@
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
 #if !defined(__ASSEMBLY__)
+
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
+
 #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
-#else
+
+#else /* defined(__ASSEMBLY__) */
+
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
  * disable the input check if that is the case.
  */
 #define GENMASK_INPUT_CHECK(h, l) 0
-#endif
+
+#endif /* !defined(__ASSEMBLY__) */
 
 #define GENMASK(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))

-- 
2.48.1



