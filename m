Return-Path: <linux-kernel+bounces-560660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F5EA607D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572B817C34E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212C8136327;
	Fri, 14 Mar 2025 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="ZKMJNy9m";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="f7UyPLhJ"
Received: from a48-105.smtp-out.amazonses.com (a48-105.smtp-out.amazonses.com [54.240.48.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684A2A1BF;
	Fri, 14 Mar 2025 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741923965; cv=none; b=WPK7+82jOV66EDzXOyDAoMs5uOaK2z+fDvFYjpdmwO7h7587HSyZeV3icaeyEpNMsPLCiUEKkiBg3krhvKfXUuoNcmEnBNQpbgX9YKw/aasLzmsCV8ytGpcES1rXFejFsrqkO/imEfyimK2LdCyoDFeZL6ognaUQ8WBAfY/0Vvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741923965; c=relaxed/simple;
	bh=JMRugZggJ2ThMqml4c6bp2KzWmuB2zfRsMGqPrTwaxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVxVoUvzamwYp/gFCBbI+O0M3p8RfSpgaufGQaPvfo1+IY8tf3xBIKI+eqC08WUTPklwOVELzEYy4BhfywXZo12s1EpGvzKXtoYTqejnaE26rxiE+VoYcvRCzUxywvy/4CJnYTxd/CGHiuec/pdIBszHsKbXRhZyvwe7X9agJE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=ZKMJNy9m; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=f7UyPLhJ; arc=none smtp.client-ip=54.240.48.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741923961;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JMRugZggJ2ThMqml4c6bp2KzWmuB2zfRsMGqPrTwaxo=;
	b=ZKMJNy9ma4CXwMuLgTNiT1nrvyKd/NEQByA1VHKDZXCgzSFxwBbtkHkaU3GXvh5E
	loI6M+t7BOQBblXHNVP9vMlkhkQ6Ru2KYL5geSmesvstCo0mG4BCZaJuLFWJFmTkZCn
	7Lv5GssDi1GobRzjlxy0+S4BS6xv2gdVdab4tS7ZZzPyxritkExp5SYlYUb3r0Q6ZTM
	qmDotyvUwRk279F+RVch+dMrG1wicrF7OTmVjM6Os0GGmUz+BqH86M+o6yiI4l6++c1
	LwweMOl7fUTy14g5NKxL7N8P+pBSwOnlZ/QYp6HgoYtOoOVYWWP2fFv36l99eEZvrRi
	/eZ+dkdRtg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741923961;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=JMRugZggJ2ThMqml4c6bp2KzWmuB2zfRsMGqPrTwaxo=;
	b=f7UyPLhJ5+zymfnnNY0ahcq36HUrykISgNgHe80FQp7IBXVbBTNbZVBRlUfNh+NC
	FU5xG/I/BcXBcW8aTn9Tim+5p6JkqXA/DhS6WpMLY85HPQGG5IgfjT12JvFzUEeWsqn
	rk5U/Mv6hNtSkUMnCPb72eraB34FpBY+bN4my7VE=
From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] rust: enable `raw_ref_op` feature
Date: Fri, 14 Mar 2025 03:46:01 +0000
Message-ID: <0100019592c24b7d-d6988aab-2a3f-4d9e-a8d8-fc524d8d25c2-000000@email.amazonses.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <010001958dfeacb5-9039aaab-6114-494a-9f1d-f13982091169-000000@email.amazonses.com>
References: <010001958dfeacb5-9039aaab-6114-494a-9f1d-f13982091169-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.3SHHfi5Rh4c+NdtIv+pxNWeqDT0J3zAhYZLMebdhE9o=:AmazonSES
X-SES-Outgoing: 2025.03.14-54.240.48.105

Since Rust 1.82.0 the `raw_ref_op` feature is stable.

By enabling this feature we can use `&raw const place` and `&raw mut place`
instead of using `addr_of!(place)` and `addr_of_mut!(place)` macros.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` is very similar to
`&`, `&mut` making it fit more naturally with other existing code than
the previously used macros.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/lib.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a96..1d078f69bb19 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -19,6 +19,8 @@
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
 #![feature(inline_const)]
 #![feature(lint_reasons)]
+// Stable in Rust 1.82
+#![feature(raw_ref_op)]
 // Stable in Rust 1.83
 #![feature(const_maybe_uninit_as_mut_ptr)]
 #![feature(const_mut_refs)]
-- 
2.48.1


