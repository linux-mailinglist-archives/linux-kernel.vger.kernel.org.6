Return-Path: <linux-kernel+bounces-408502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C939C7F97
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193DBB24E79
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916C43AD2;
	Thu, 14 Nov 2024 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="sLixs6T0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dEJs6JZQ"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826C42AB1;
	Thu, 14 Nov 2024 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545831; cv=none; b=hLYwrPvohuRDwEBSJW0CH5Vlv1i7BpTkCR3Ua0Ii336aaVowMUUAscNRCguhjg0RzwxSllxQiXyYK4xlrWIoJ1y4f8X1ObxwhGbGvcC1Xl3VLdVfbeIMwwCtbOCn9FUeS8vCFVwcuc4Bz+cX605PtZMlyYluT5j6BkXeNuXziNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545831; c=relaxed/simple;
	bh=vHXnakfFjhg1fCzLWGE2sHwz/+s+gpfJaYfgMui8rJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5TIJzZwGN8m8lo9ichEnnEjNWrUwRnZTTaU8Vq4NgIBzc/jMfPvhhZMIWaI08nvi8oDDIM+hptzfLXI/7Z/i5R4f71u63H8n7S2QuOBNaxemta0loBDdDIrR6qs+XxIOkEpgNexkkFTsfyJU5tLDYNfVqIrXzdXo/rEg2B4/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=sLixs6T0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dEJs6JZQ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 25AE5114020F;
	Wed, 13 Nov 2024 19:57:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 13 Nov 2024 19:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731545828; x=
	1731632228; bh=uWdpOcemEhndhcjPj0JJ7aMk2JcquAOu04zIrIsFvmU=; b=s
	Lixs6T0EA9s3c0axe1hjKTic9w6B0rQDIsEcCXO6v0pKAiSXtvX3DyouRGtaGAI6
	DgDKbPf0oJkNBjHP47d/jGU2saB8+Q3zgzY1I3V0Yp3dau3FZPBbr+XW7femSJ+x
	WPGgAo2KLx7h1RxKCCoUMj36qLOCmnOf3/Oidby9zrIk36Z2SzRMbgV2VwPcKXFH
	j7BMGppF2fx4VcREqQhpYtXVnmCG9+FQYAtLtjfFZasOF8IjTyzqvqw+iodZ0QbL
	Rm201KKxyod/Ue4xkrRbdk7ve8RhiUsrdAgbKpuNj44w95zq05qad2Sq4DOEBjfn
	Ni+o+K32IzJ9UG1bR4dag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731545828; x=1731632228; bh=u
	WdpOcemEhndhcjPj0JJ7aMk2JcquAOu04zIrIsFvmU=; b=dEJs6JZQfi+bVZe2a
	vEkszUebhoOEg6a9c8EZ2WLJb58SBoAnmoXoqJfLRiRhLbflBsiQ844vUZ8iH21Z
	o/6Ypr9DUdpvI9E8e7T/74yLetchVUSqsbWGDDe4cM4w1QMlZLoXF9JaPfXG3XBh
	KDywaHggT0YrBt0DwSgWDM6H8irPMHSFt1yh1iaewTfJMot1DK5zXf5Of38Eauad
	pBgAQl528bm+UEh2FdlqGifpFskyuxt+GINhm5VEq+OaAb81RUYSpB1gwXHyQzWn
	GcUG0j75OE3Xd9NHMBqwafUWsNxfSOyI//RPuOWFyhWUPX2ENU6S61Z9M+b+rJbg
	mG5eA==
X-ME-Sender: <xms:40o1Z8H06W3VNi_g8hw31RzrbcGze-8SKsAm0JcIjCSE9ZKwMIe9nQ>
    <xme:40o1Z1W4ZEaVR72dFlSLUshB4AD5ujjyg5hW8tuRnKQRjWhydSEuzLM062srNjBMY
    60Gl-ppRwjoFdbouRY>
X-ME-Received: <xmr:40o1Z2IyOxLLBEUgLH2Eoq0Z7qV0BM0lBBNin4AOr3PqI8Nik36vciBxq7DMwW-dr3zH-t24SNz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:40o1Z-Hrs6WvO-FE2t1mDK3CAWELVZhnFHlXadGjL_oVS_RQ6LYLDA>
    <xmx:40o1ZyVZNwEXR01qPo3LHhDTBZ1JcQEQlELTxjZX-WahHYGhstvwYw>
    <xmx:40o1ZxPPqgMeiv4Mw-NPBCycwcT2HDaI1VAFH22LHxbbasHpSREU2A>
    <xmx:40o1Z53O5teSGcnb0wQjjIdP6u09iu4B590Yj3K0nkVctEV8fH-J2A>
    <xmx:40o1Z-mkFXW65OpU00q4s6bUkwCqSpoJaXxtydYaaMqVnt9W9ZySuAFT>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:57:03 -0500 (EST)
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
Subject: [PATCH v4 05/11] rust: helpers: Remove some page helpers
Date: Thu, 14 Nov 2024 10:56:25 +1000
Message-ID: <20241114005631.818440-6-alistair@alistair23.me>
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

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 rust/bindgen_static_functions   | 2 ++
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/page.c             | 5 -----
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index b4032d277e72..ded5b816f304 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -11,3 +11,5 @@
 --allowlist-function PTR_ERR
 
 --allowlist-function kunit_get_current_test
+
+--allowlist-function kmap_local_page
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 00b1c1c3ab76..452f8afc9b09 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,6 +13,7 @@
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
+#include <linux/highmem.h>
 #include <linux/jiffies.h>
 #include <kunit/test-bug.h>
 #include <linux/mdio.h>
diff --git a/rust/helpers/page.c b/rust/helpers/page.c
index b3f2b8fbf87f..52ebec9d7186 100644
--- a/rust/helpers/page.c
+++ b/rust/helpers/page.c
@@ -8,11 +8,6 @@ struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
 	return alloc_pages(gfp_mask, order);
 }
 
-void *rust_helper_kmap_local_page(struct page *page)
-{
-	return kmap_local_page(page);
-}
-
 void rust_helper_kunmap_local(const void *addr)
 {
 	kunmap_local(addr);
-- 
2.47.0


