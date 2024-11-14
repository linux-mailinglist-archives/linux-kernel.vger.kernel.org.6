Return-Path: <linux-kernel+bounces-408500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 991B99C7F95
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3572AB2546C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36C0219EB;
	Thu, 14 Nov 2024 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="D9zH3p4S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/X5st5Z"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C72C859;
	Thu, 14 Nov 2024 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545819; cv=none; b=J7H7JOsqQXmVMyWW5C6YiVwA5eVVfGczboG1EyimKyCTFHK+JVNQ5ZVV3/WjN1OH9RiND/rbuXiimFU0Yt9pvGG5hiYAhISMDgaReYojQtUTIDBl02UvtZD7/1qEz6phxJYXFayfjXujlpmdRDnMm/6mxVgY/GRt58wqSiplSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545819; c=relaxed/simple;
	bh=1q5Ejy87bZRBBVhsdPth3lT1FM3HlR4ejX4eZkdUDyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNEC0TMQ5NIWamT9YFM1lSlSKBro848ctGdzdSZ/hBT5WvUZxRMvIz2utWbQ0J5BjDKkLWtMkPSi3Vx3Ns182hbp1X/1tKmVm27txhijQBfnXKk53Gg95QiBYa6GdjNisRWyB3gk5OoaLwLYurUiOxOGKZymhOXxfbptDhPucqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=D9zH3p4S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/X5st5Z; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B6FF254022D;
	Wed, 13 Nov 2024 19:56:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 13 Nov 2024 19:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731545816; x=
	1731632216; bh=tZ8pFmHsuq6U6oemTG4oDG/xxrwAvllajiVqaE2wCNU=; b=D
	9zH3p4SOlWRJY7/077oZPjojy8NYh3WqtUWzxYcdj0W5o+P50L/16seBcUbRhcD8
	baYIfXmI0weL4w5eGO/psikBE7umjsPnNdPO+b3t4Lrd5NmOysyqhD8RTQQetdkp
	QJj//hzlj1QjYtiEVa0qvoCsZTB8vpe8JNioGM3SjNe0VShB8xmKQRULN7fS4PPe
	3KmVarmloUQNILM72A0Cxx2R6VwWuKt+rj442yLYqOqnoR0au5kOFhPHpL6cMuuJ
	faKmZZFwTLfKmN5cpsd/S1ARO8b623aa1VB155DYq5qCowS3dCusZcDRqMQ9GSMy
	v7QcbXv0ik0KueFDXRYqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731545816; x=1731632216; bh=t
	Z8pFmHsuq6U6oemTG4oDG/xxrwAvllajiVqaE2wCNU=; b=I/X5st5ZPwv5W6z5j
	4YdWtAEkEvMGt1C9QoSqVFGjewAH9x5TJGyg+K2Yiht4m9umhQgGs26CdY3CSSwk
	Ed/xaUMvn+2+2WO8PNMZIUMZ4FyjUoEK81oJPcnroiBFWmlt3ahPuAr9FrECw93v
	nCkIyEIgKbjfImK8EhEyxrt5nZOiwlv0aubDzWW56E5zeGVxDV6nbxw+RMScu6Yk
	6KOBfldP5UyU7Jjwjeb33qySH3jJhs5RQIOb6MTLolSWRoMm5Y0PvJzQ3Fmlp7u6
	TrZE9OrXDjamzyaRmVpnC+VWuIT7JXaRKGN6N2bz81Py8dp3XZPtj2yFtCqonSCB
	s5MWA==
X-ME-Sender: <xms:2Eo1ZzBCnwLeI7k9dC42ET31ZR99IlclU0AHx0gwop_Nbw3170dx3Q>
    <xme:2Eo1Z5hqfB_BD5L_qzUl7mTJr6hmbePxv54nex4GNGPR61zuqF91GOdKpPbIR3cym
    Ce7Gw3NOa83oPjSkvU>
X-ME-Received: <xmr:2Eo1Z-lKPjvgFoADbF-wrILBw2I3qWkog5xdKHb192mGPwC0OiynM4LITgpzR39S_TTCtQ32aB5P>
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
X-ME-Proxy: <xmx:2Eo1Z1yngpJC7tMAnO3p354R1CzRYbaLz-X-k1x0AEk59E_cEBoGtA>
    <xmx:2Eo1Z4SuERFQUvKMCiGa81EW86fIzQKRr6MFGxH021qvlyhkFcqAyw>
    <xmx:2Eo1Z4aC6AGfRm1vMQ3TEq4DsMvBWwHNM3ytSJF2_nZFALQqgQl0PA>
    <xmx:2Eo1Z5SIaa-C58X3MkLIS_3rVYstx2dkgyrsvf26KJrnZ2mPwsQK8Q>
    <xmx:2Eo1ZxAPLJl8nCVkgwZaRN8nLmp-dbRbOI0IfWC0RNpLYGdVYAi9P5uI>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:56:52 -0500 (EST)
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
Subject: [PATCH v4 03/11] rust: helpers: Remove err helper
Date: Thu, 14 Nov 2024 10:56:23 +1000
Message-ID: <20241114005631.818440-4-alistair@alistair23.me>
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
 rust/bindgen_static_functions |  4 ++++
 rust/helpers/err.c            | 18 ------------------
 rust/helpers/helpers.c        |  1 -
 3 files changed, 4 insertions(+), 19 deletions(-)
 delete mode 100644 rust/helpers/err.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 42e45ce34221..0269efa83c61 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -5,3 +5,7 @@
 
 --allowlist-function blk_mq_rq_to_pdu
 --allowlist-function blk_mq_rq_from_pdu
+
+--allowlist-function ERR_PTR
+--allowlist-function IS_ERR
+--allowlist-function PTR_ERR
diff --git a/rust/helpers/err.c b/rust/helpers/err.c
deleted file mode 100644
index 544c7cb86632..000000000000
--- a/rust/helpers/err.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/err.h>
-
-__force void *rust_helper_ERR_PTR(long err)
-{
-	return ERR_PTR(err);
-}
-
-bool rust_helper_IS_ERR(__force const void *ptr)
-{
-	return IS_ERR(ptr);
-}
-
-long rust_helper_PTR_ERR(__force const void *ptr)
-{
-	return PTR_ERR(ptr);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 426b0d7f6587..e089ecdf091f 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -10,7 +10,6 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
-#include "err.c"
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
-- 
2.47.0


