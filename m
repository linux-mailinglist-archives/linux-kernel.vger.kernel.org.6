Return-Path: <linux-kernel+bounces-408501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CFB9C7F96
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6552F1F2305C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08B3C466;
	Thu, 14 Nov 2024 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="zqyDSvp1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmPyIP5o"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03103BB48;
	Thu, 14 Nov 2024 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545825; cv=none; b=T80hyNuS31KC5bOyWvhFAi95BNExtc0FrrHOyg7HGwoirZfDoHSb00kt5D2daGPaF0YJJoMJk2u5YnpEFnhlW8MiztyH5IX+5clgVHykQV+N71oEJdDWrICn8rVwm8I/XsQ35/TtqdYvFnfDMzRsRk0bwghzA7oX5stEBiUjnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545825; c=relaxed/simple;
	bh=52dEVd6ieui/hgDILxz6PiV9KN4P39vTK1VY9+/EgTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOOZWxtQ1JAtEwERjSgQ5bvPd0AMTq7OJsNkXr/PzROMD+A0UFtEbta7XglUFLHkN8+KzCR8sTfFGJZe/Yjwg+tFvqg1DouzinaZap5fGjcij4fObnNJ5c656pxp3t8b3byQKv1Lyc4X3+auamrIMBg2MkvCO1obWBE5X0ZNDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=zqyDSvp1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EmPyIP5o; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE4EC2540245;
	Wed, 13 Nov 2024 19:57:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 19:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731545822; x=
	1731632222; bh=I6BKnKD2q7G5Z5xhABHswk5DPT3rlGXx+hkakcGtDYY=; b=z
	qyDSvp1gxjMXkd64weBqpSS98h7elYOeirEjvbCzTjgMMb3Cit+GZ6nMzuISbJQW
	skRoYqTwAFTxp8/tmliUDbXPLKylcyqpDPbdQCHIJIUdxNXnp0ZBDFus13Pwc+UY
	BI795WE8Li9ZjTg2ETjq9XYcMbQ2beFuERz71L5Zr8YOSpt098q1MuDVMWiiyxm6
	P2GdDLsGfVN0aNvaG6XXGcmdH6VciX2mKnMXlPfaH/dafsnHLb7zX8R2LGmLELp2
	M60cKD9G50ZoQSZMzB+SZji8wyjItlnXg3h4iiH8poMjeogwq92SFJArtEOhFs1D
	s01Ac1ggdJ8voGFzUXvWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731545822; x=1731632222; bh=I
	6BKnKD2q7G5Z5xhABHswk5DPT3rlGXx+hkakcGtDYY=; b=EmPyIP5oYLsKuaXTz
	5MaiZIJBAD99n/iNJjltTuPCJgvGMeStUvQb9IZnr7JjfANs2mgB3KQeESTggbG/
	YB400xkG0ypib4Fas/iLfNqutHndOQZ9F4eFOqNgLa58PuILwnwzeAM4pcD+5doN
	hcsNoCBlA2GJoG1f68PX6AmxQqFAkgJ2Ab/pyLZc3AsC9DPF0PyX9SDcaeOUao0S
	x+jPyNjpszWNC7zy9FqYJYOXusu6m0dJyn/TZDLGtgUyLTKeMNV0Xgt9T+8z2oeE
	hObC2Cd0BCTBpLdnDEQPOjhluARxW/apL8ptJYKYg8Xz8C76sSqfzZ2Efn1C5w+y
	OpoEw==
X-ME-Sender: <xms:3ko1Z7SdPlgdX7F7JLKltSuhsYpQDadUnyuZ3XFAimEtHJy5B6mk8A>
    <xme:3ko1Z8z5PpYZyyVsHrS4Jeq3Ki-dYSgfEoy9I9i1vKHX9hTs-yEZpCLOFdICACw5B
    iGr4zTiI3oXfiA3UFk>
X-ME-Received: <xmr:3ko1Zw38rbQ1ILXFnZjT_tJYWruFJ-Ty87TL1fRwAPap7vNvdt5-sL45N4UsA_XyI6yndUH5iBdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekteelvdelveevueeu
    jeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdv
    fedrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsg
    hoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehklhhovghn
    khdruggvvhdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishes
    figutgdrtghomh
X-ME-Proxy: <xmx:3ko1Z7BrZyWeY_A0eeuQPb79tGM-Stvh8au_Id1yjF2oX1ImKht4Og>
    <xmx:3ko1Z0i-TPozGqXcNa2_8HJ7Ty7lk4TdvQStBx85aHwZqbzuZzwOGg>
    <xmx:3ko1Z_pQ6OBwg04wdZ0EAZ3SHkXyQJLSaZ0a_4rgMHgjLRij7lJ7Kg>
    <xmx:3ko1Z_inwGAvnC7PLgFyHo3-rB8fZW3P5S_lBXEw0DPAyibiH2bxGw>
    <xmx:3ko1Z7TxSvq5jqw2BAeorN2_wYyJNRcnXLjJfQo3AIHgBkiDvfrMlJbG>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:56:57 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	me@kloenk.dev,
	alex.gaynor@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v4 04/11] rust: helpers: Remove kunit helper
Date: Thu, 14 Nov 2024 10:56:24 +1000
Message-ID: <20241114005631.818440-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114005631.818440-1-alistair@alistair23.me>
References: <20241114005631.818440-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 rust/bindgen_static_functions   | 2 ++
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/helpers.c          | 1 -
 rust/helpers/kunit.c            | 8 --------
 4 files changed, 3 insertions(+), 9 deletions(-)
 delete mode 100644 rust/helpers/kunit.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 0269efa83c61..b4032d277e72 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -9,3 +9,5 @@
 --allowlist-function ERR_PTR
 --allowlist-function IS_ERR
 --allowlist-function PTR_ERR
+
+--allowlist-function kunit_get_current_test
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a80783fcbe04..00b1c1c3ab76 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -14,6 +14,7 @@
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
+#include <kunit/test-bug.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index e089ecdf091f..60b3fdc5c2de 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -10,7 +10,6 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
-#include "kunit.c"
 #include "mutex.c"
 #include "page.c"
 #include "rbtree.c"
diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
deleted file mode 100644
index b85a4d394c11..000000000000
--- a/rust/helpers/kunit.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <kunit/test-bug.h>
-
-struct kunit *rust_helper_kunit_get_current_test(void)
-{
-	return kunit_get_current_test();
-}
-- 
2.47.0


