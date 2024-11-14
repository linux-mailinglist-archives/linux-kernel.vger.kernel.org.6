Return-Path: <linux-kernel+bounces-408507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E669C7F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F75E284367
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17813D531;
	Thu, 14 Nov 2024 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="NTXVOaca";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4tdh+xq"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6613B59B;
	Thu, 14 Nov 2024 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545859; cv=none; b=NQJymHwCcHJhAWuQMmdkugIJnTWQq5R6KCJliWANg6TBdpauZWoXFVbpHDKuAHLT5hWdu8043aLq1OR/KQD+sJLf6N1G73NoH1m7RnxdJ/RQAKICHVAANPMvB4RFgxHUstboyuDLYjg3gj1wzsY1BaYXTOR21DqBQulLr2r6FJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545859; c=relaxed/simple;
	bh=EFr6PSSkhe2tY7BjjykFUQ+OKuO0BW9ygo44emPlaNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwZJUvK/M5Bp9yYbuoj+6J8i/ZrpvaKg8tBpsuAI3jWKoC81ixImqD8UyO0zakjPuX5trbPQLeZ5AuHnBHPHG08enINawLxZ/1rdVDM1EhByJEO/eyfXuTIv2a1ZAfApkh4fH+cyZNojchqVCMJlk0XJ55v4Gmb1qBS5JQhnZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=NTXVOaca; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4tdh+xq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C0072540240;
	Wed, 13 Nov 2024 19:57:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 13 Nov 2024 19:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731545856; x=
	1731632256; bh=64HM+hPNGJXCLJGNoMucCmP8UDaNeqv7QWdlGBPWino=; b=N
	TXVOacamQtQIhLk5EZX+9Q6lGfKriZWtadi7lbT/rZMzAGXVpgLUswUECiRqdreE
	vaTBdT6hU+v8gI6uFuggRqx8NQEWc5FVleaogSNMwEfaIExbZ8zbVFd80ytLhUo4
	2xFDH2xpg/7H8Z99/qznpmUPamYtBXMcsiCicbqEFjs5rfxLGKuaGJF5sHV7u0Z/
	Hu3+iW7ECrArbkk3P/THKeAO/hp0Ceuuaplmolp+uMNtZlXeKCuJZUJd2/khPD8i
	iPopRnXsczWHfS2jOt0o58k7ZYfs8/scpwJ0/JN9zlTHDTScq07DwNd8Ovmg9SZb
	GubQJU/dTD3OCMGHJrG9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731545856; x=1731632256; bh=6
	4HM+hPNGJXCLJGNoMucCmP8UDaNeqv7QWdlGBPWino=; b=E4tdh+xqS8JniL1+V
	lQ9WyWh6Mh5V2pbQGPS7HjNZe7LZPxqLZbElxsOKJSeuwCif6GM8vOcJNnarSbOJ
	r1QAkjIsYEDM3pgFDuYs0o/5WKPvYg2tqmyWeFCfZbHMHCAvQknI3+0mZQ5iHj2F
	2xIkc5hdqXzu50sYb2fnvdlmoKcqnoSfOGett8mn6/BRSnUG+kWGR93LrLgNA8TP
	mIdW3AkQxBGpyR5zpcOK96RSd0ntwrPzFP3a6nVh9LnrfZQ+w/RQlee9Ly5M1Ayc
	qjljr0xtaZVlWrpl259/V3km3d+/7q3/5W7O8Hdx63vyF1WmSaXQmzAmhuKaHbrs
	ChLsw==
X-ME-Sender: <xms:_0o1Z3Fodhku-vvOfKunUfQWOGwmFc6mO6EViqvNvQ0yBAzfksOrtg>
    <xme:_0o1Z0UaYsfiNoMMEHfFC3LOJ5lIUl5dMw4YBoxG0aSe0cBQ-cb-glmfaPuknldO-
    HY0WfUoX8Tb2mSrxUA>
X-ME-Received: <xmr:_0o1Z5KFWw0leBe7m3hqL5sbA4A2-6TxITDHNqstw2zZ97u7w7b7AzlNGDOehI6oxPMDZ7JvTAWo>
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
X-ME-Proxy: <xmx:AEs1Z1F3dO1RYHdWG0r2LeSbtRAoH_UFpewJW6LA3GeVqU-h-NyUVw>
    <xmx:AEs1Z9VXuTaUnDDKnyDtMhfu9N1IDlZN3kFLmGL6EqjjlDOA_Xr5HQ>
    <xmx:AEs1ZwNgFgER-d1lM_cOC0LMB6ws3BqpEILmmS7nPw6BbIHX-QUU8A>
    <xmx:AEs1Z80kKyAcT6hqPnA0hUF7KPxfw159kN6Ekqaua1B3yvIqqJotog>
    <xmx:AEs1Z3ZgqEOQEnrna3GuHMtZbC5d5W4FTRk8nhZWCXmTmhnTyv9lMig4>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:57:31 -0500 (EST)
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
Subject: [PATCH v4 10/11] rust: helpers: Remove some task helpers
Date: Thu, 14 Nov 2024 10:56:30 +1000
Message-ID: <20241114005631.818440-11-alistair@alistair23.me>
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
 rust/bindgen_static_functions   |  3 +++
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/task.c             | 10 ----------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 9d6c44e277b5..8bc291a7a799 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -24,3 +24,6 @@
 --allowlist-function spin_lock
 --allowlist-function spin_unlock
 --allowlist-function spin_trylock
+
+--allowlist-function get_task_struct
+--allowlist-function put_task_struct
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e21a5f260e3c..63b78a833303 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -22,6 +22,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/task.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index 190fdb2c8e2f..788865464134 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -6,13 +6,3 @@ struct task_struct *rust_helper_get_current(void)
 {
 	return current;
 }
-
-void rust_helper_get_task_struct(struct task_struct *t)
-{
-	get_task_struct(t);
-}
-
-void rust_helper_put_task_struct(struct task_struct *t)
-{
-	put_task_struct(t);
-}
-- 
2.47.0


