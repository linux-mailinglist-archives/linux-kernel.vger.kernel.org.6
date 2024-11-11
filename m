Return-Path: <linux-kernel+bounces-403961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED839C3D29
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDBA1F21FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B63198A30;
	Mon, 11 Nov 2024 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="WfQjU9JN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CW0qdJ1z"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9A1957FD;
	Mon, 11 Nov 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324399; cv=none; b=BR3PPjZy6vrjP/v1AdtjdEe9lC8r3nAwW/A0MFvFTCW53EYs/cmP32KQZPmQ4aUh3wwi0adUSTJV2EWMAnwWUdqbkqFXWakjOYvkm7KcshVNKKlk3BNjcxjgPheuO930alMqNStNCECWZ0vAcad2/xIG/XQVvCD2yIequWHtsUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324399; c=relaxed/simple;
	bh=SON/JaleK4TchWRnzi6oNY1AHrpCXsraiEov7uOkBEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdSiP1S7INCawSLPUzlFwTCNhy3cLogX+PqOx+1QcXufVEbSoSnUyvpSIm5Od9Sl9X9ey5FKhHfHBNSeVDOghUEMeyHS2zd4dB1P4CaKBYyBtnGfqrYU1tmwGT/nDn4p2ZNnsbZz4v8OsixhL86Zs/XxzBLuEXblCQEglCxGKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=WfQjU9JN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CW0qdJ1z; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5789A13805E7;
	Mon, 11 Nov 2024 06:26:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 11 Nov 2024 06:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731324397; x=
	1731410797; bh=WZkv48fIwhGDB8Z0aFKd/GZqPV/8yRyGz1OEJ6pPV4Y=; b=W
	fQjU9JNEcKPohFs6GV1Qo8LMBWSNRqBJhWIKX/df28jx2VPGFYWrwngwGasVZ16H
	7GQW5sHggo+TCXXAMC/6mUXShv1VObUZH9xj1iHrEfxpg+A3UAM/7vZtS3+9PuP+
	5Jx9AEADI6HQCaLhUdwPyFAnE0dgWUI2gIsH/BWw2mP1KrvWCszU2NK5VOntVqLe
	zR05rgpKgjFn7jLEa00m9CyeN+6N4oczloOTUqK6fTgIATVTAiu274EEnL57AfrP
	hYErBck5q1kcZFoXj5RZkBcWNBm05o2X26kP2s1mGkY40b8QtVcblKXQYj4fPTXB
	pUXDeaUJ/MNaQRnbgn8Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731324397; x=1731410797; bh=W
	Zkv48fIwhGDB8Z0aFKd/GZqPV/8yRyGz1OEJ6pPV4Y=; b=CW0qdJ1zegEKmDJUt
	SDWWPeJHXN9ftf2rZ/xL60cw0iMGDWMFNsbEgHRqHWTWXqWBGvtOipbu+QDzQT3n
	5M1ZOZtMy3XhqA24oT1KtSlgq+K5fFdJBSDK6rCz3yPBZSc40L56YMmdpQtIW5yb
	kbKdPhNPOrcYo0YewLuTEZqEJIIaOUmHz5COnJhOT8t6DkPeLHngSTexs5g8/1h7
	UHuPwY61qlpGMfNlAFHlTMV1QTg9z7Uq4q1OKMI/wfFQdevZYtUurErTQvQ6q/ii
	EPJo/FHu/S84HZ4CI+XBlz08D7GVi/Daoc8zX7hvxtz7oD9CJoOhCOUSUy7ZjxaW
	B6+SQ==
X-ME-Sender: <xms:7ekxZ1izVI1HQORsjnMXdfX-f0lbyUFRWLT_2LaXAOQK96dQEnWxSQ>
    <xme:7ekxZ6CIRzPWfS5IsecT48QgYSqRbb4Ug-I1T9FkyOG4ED4jAjWOHqAA_RqURbXB7
    LTsu06KffUQvHvn5CM>
X-ME-Received: <xmr:7ekxZ1FEFcVKAjrVHqbdzm7a7IV7SXIe-eVhQVhEqZkDLtbeQ27RC7hnJf4D-XDWT20CVJWOxQ5R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegsvghnnhhordhl
    ohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehtmhhgrhhoshhssehumhhitg
    hhrdgvughupdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7ekxZ6RI_oJR6E4qcgTMZSN9SFUfQOQvSuH11MJGaFsi802De-1DCg>
    <xmx:7ekxZywK_KYa00OTUnjTeCD3V54gS5gm_bTyuA9zEg71cRB0YNtfiA>
    <xmx:7ekxZw556pMejUUpQqjrpBEVvQz8TUGwv5d6mH9MQ04F-GEHMzB5dg>
    <xmx:7ekxZ3ywHdM5xeH4DOYqIfd2YQgMLlF5zURvRNCEhWdbJ5JdYV82LQ>
    <xmx:7ekxZ2CGrGl2PWVAcPC3z4aVJ-lKUH6La-SobRwLFkDtfX8q-hzbBNyJ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:26:32 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	aliceryhl@google.com,
	gary@garyguo.net,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	alex.gaynor@gmail.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 03/11] rust: helpers: Remove err helper
Date: Mon, 11 Nov 2024 21:26:07 +1000
Message-ID: <20241111112615.179133-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111112615.179133-1-alistair@alistair23.me>
References: <20241111112615.179133-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
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


