Return-Path: <linux-kernel+bounces-553485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31836A58A55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693F2188CFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7102F1922FB;
	Mon, 10 Mar 2025 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="e3SCGore"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C80C17A2E8;
	Mon, 10 Mar 2025 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572895; cv=none; b=NKQLpxf0Pm0NSnCKAWUBGH3okxYEuHwXg9Zdrub6ANGvJLdvUoxDb1TjOIefQT9RLvX1CPCxcR/x6WpBrMiMf0ASDnyPwOK+uB2Asfi1ai52g3GAEiEPUIfyaC4Gifr1orh0TkIBwMrj9xYjD0sFXp5h41guKf/yXVeDszAT+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572895; c=relaxed/simple;
	bh=P1T3On3tQTNTqqVq7iaUH7NJxNTY4cbFFUUGfn6kpVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RWJ4VQd5OGeAhdNm4xRsHf9wnm3k0D1cbxLFAjF1hTDXGzTT8wG99xMyy7orfgmf5xiTpish5MXV+ktjtuZZ27nW6Cog1tw8P13Hejm9DfkOys5mpiPtiadvMR3dKuw5PAXTtymBTlNsZKYXYuL/9n4nC7/Mh8oR0evzcMvq/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=e3SCGore; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZB0pC6YMYz9sQX;
	Mon, 10 Mar 2025 03:14:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741572884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PgClmaMdMd5lNbUr6yZ8zi6Q3ctl2WTDB68s025YeDo=;
	b=e3SCGorePYw2i0g46qGpLBJi/BH4Kcf88f/Zm9Izi0ERBGOhnkpMxHfhHkUbuDRl/S1jts
	j7jqeKvRw5BDPCrNpSK0DSmF8FOg7HKn7J4Mel9uKnGReOvfH+DsAw4SG+XV0rPyh5vEzA
	iVLppE17RudH/xZCEFq8K7DqBzlMxKV5ldeEo+wOtXS/WxktjKNojRX3DsjyUtkxWIv8Ec
	swRy5QaJwI0j8Ibsasu1bKhBXfief2WUBekCay5ulknSYmiI9oVH6iOznFTSnXoaOAWMWT
	vxob/lcl4cJwVwpRXZmqBgTcaUCXgFfvpLyhmxwuMh0ucOCWf81UrssjRQfQpg==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sun, 09 Mar 2025 22:14:36 -0400
Subject: [PATCH] rust/kernel/faux: mark Registration methods inline
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-faux-inline-v1-1-c1b692862433@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAAtLzmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNL3bTE0grdzLyczLxUXbNki9TUxBTDpOQUAyWgjoKi1LTMCrBp0bG
 1tQAfoO5lXQAAAA==
X-Change-ID: 20250309-faux-inline-6c8eead1bcd0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=P1T3On3tQTNTqqVq7iaUH7NJxNTY4cbFFUUGfn6kpVA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBKL3o1dHRXazNpcTJaOTc5N0kzUXZ6T2RobXM3REc5ClgydmZMODJxdi9PZlg5WWw0
 bDVIS1F1REdCZURySmdpeS84YzViU0htak1VZHY1MWFZS1p3OG9FTW9TQmkxTUEKSnJLR25aRmg
 4cXgrcmR5Y1hSekxib3F0ZWIwMHRrNVJjR29UZDVPQlp2VHZpWlVSczdjYk16S2NVZHA0UGVxdA
 poVlFXeHpOVjQzbnAyd1Q3anRXeC9Ybys0ZUR5dU04Y0Z3N3hBZ0FuYlVuSwo9MUxKbgotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

When building the kernel on Arch Linux using on x86_64 with tools:
$ rustc --version
rustc 1.84.0 (9fc6b4312 2025-01-07)
$ cargo --version
cargo 1.84.0 (66221abde 2024-11-19)
$ clang --version
clang version 19.1.7
Target: x86_64-pc-linux-gnu

The following symbols are generated:
$ nm vmlinux | rg ' _R' | rustfilt | rg faux
ffffffff81959ae0 T <kernel::faux::Registration>::new
ffffffff81959b40 T <kernel::faux::Registration as core::ops::drop::Drop>::drop

However, these Rust symbols are wrappers around bindings in the C faux
code. Inlining these functions removes the middle-man wrapper function
After applying this patch, the above function signatures disappear.

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 rust/kernel/faux.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 5acc0c02d451f6d5a26b837d509374d508f26368..5fdd85ea64398130066d38e42f7c7485673f290c 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -24,6 +24,7 @@
 
 impl Registration {
     /// Create and register a new faux device with the given name.
+    #[inline]
     pub fn new(name: &CStr) -> Result<Self> {
         // SAFETY:
         // - `name` is copied by this function into its own storage
@@ -50,6 +51,7 @@ fn as_ref(&self) -> &device::Device {
 }
 
 impl Drop for Registration {
+    #[inline]
     fn drop(&mut self) {
         // SAFETY: `self.0` is a valid registered faux_device via our type invariants.
         unsafe { bindings::faux_device_destroy(self.as_raw()) }

---
base-commit: fc2f191f850d9a2fb1b78c51d49076e60fb42c49
change-id: 20250309-faux-inline-6c8eead1bcd0

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


