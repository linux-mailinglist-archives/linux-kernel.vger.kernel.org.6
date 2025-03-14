Return-Path: <linux-kernel+bounces-562293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6A7A6220D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0221F7A78E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692D71F6696;
	Fri, 14 Mar 2025 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="J2DufiO5";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="RUE02b7l"
Received: from a48-101.smtp-out.amazonses.com (a48-101.smtp-out.amazonses.com [54.240.48.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1D31F5408;
	Fri, 14 Mar 2025 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995720; cv=none; b=obifR8dHmSnN/rDt4Wagey+bdYYeDFIeabSyNB4/eCuFibodaNqDuwkwc6ayuUE1hpy8W4F0i2923Fn2ViHPrsk3eKvQm8zSUMSVizzqId5SpA5OuXzCaTnzMt69rDaQU89oaMzxxJtGKXio0adzs6RXYhsfqzZzllMohq0XHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995720; c=relaxed/simple;
	bh=9k3CP8F8FIGEr5s1RUwf4PO/nKB0CSwUEwxI/IwfBK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcPgyeqSKTyAPyuP8R87teZGfcP7g3+qRPBtVhXja35t58xfTL0DH2JA/9+XrtkH8rKs1wCs0cZxOrVXqSWEDUCh2DxkGdUlI3MUS0KtxCVEUZhurNMScl9hQ8AaDyHLzPf0XOEaZqNi2IoOLv73yYPWM7glK+rt15L8Jy0gbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=J2DufiO5; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=RUE02b7l; arc=none smtp.client-ip=54.240.48.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741995718;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9k3CP8F8FIGEr5s1RUwf4PO/nKB0CSwUEwxI/IwfBK4=;
	b=J2DufiO5i0XN9i+U6XKp36VKK8bEEFu/fjvLTPAncUX8X+brjaw+hzIFP9wUsnct
	QUkXWdYPpYf5lpApc2xjdGZsw5avOrJYYpkJvPpLpCOqkSWhg9NXVm50prlxbXd0oz+
	lLR27g046XKTJ8iIxXX1FelbewU2Eo35n96C2rNfBB0AorIRvzUYuxHDRniY9ii/mIt
	h2LPCcmH1aNMPfGoZjoxSwXSDfDqLAdEiQJs+r5EHNnHHxEmsgljshxWu2z9KztWmSr
	NpNQjgo2vs3WTOwLVKiWVeJdE9blKESplCBjvuAl4M7swlB/Vvh4iP12K23rLBjeEOL
	UKI/uXHdGg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741995718;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=9k3CP8F8FIGEr5s1RUwf4PO/nKB0CSwUEwxI/IwfBK4=;
	b=RUE02b7lBbBXftylV/N+sm24L41xC7Cx+kDPao7ml/EH5MTbWPPIxmsQAUbsc1u6
	wnEGnXDcM6MhU5zTlUntvELH3bW85qTU5+h2PxCODdYxg6LvJfF13EP1s0qs9AAHatI
	+7t5dpPiSmRQGSrF4cbPfSaDISsdrHVjo7X7GShU=
From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>, 
	Benno Lossin <y86-dev@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] rust: clippy: disable `addr_of!` and `addr_of_mut` macros
Date: Fri, 14 Mar 2025 23:41:57 +0000
Message-ID: <01000195970934b9-547adc6b-3f35-4a44-90b4-c5c51fe58a5e-000000@email.amazonses.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314234148.599196-1-contact@antoniohickey.com>
References: <20250314234148.599196-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.3SHHfi5Rh4c+NdtIv+pxNWeqDT0J3zAhYZLMebdhE9o=:AmazonSES
X-SES-Outgoing: 2025.03.14-54.240.48.101

With the `raw_ref_op` feature enabled we no longer want to
allow use of `addr_of!` and `addr_of_mut!` macros.

We instead want to use `&raw` and `&raw mut` to get raw
pointers to a place.

Suggested-by: Benno Lossin <y86-dev@protonmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 .clippy.toml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.clippy.toml b/.clippy.toml
index 815c94732ed7..95c73959f039 100644
--- a/.clippy.toml
+++ b/.clippy.toml
@@ -8,4 +8,8 @@ disallowed-macros = [
     # The `clippy::dbg_macro` lint only works with `std::dbg!`, thus we simulate
     # it here, see: https://github.com/rust-lang/rust-clippy/issues/11303.
     { path = "kernel::dbg", reason = "the `dbg!` macro is intended as a debugging tool" },
+    # With `raw_ref_op` feature enabled we no longer want to allow use of `addr_of!`
+    # and `addr_of_mut!` macros, but instead use `&raw` or `&raw mut`.
+    { path = "core::ptr::addr_of_mut", reason = "use `&raw mut` instead `addr_of_mut!`" },
+    { path = "core::ptr::addr_of", reason = "use `&raw` instead `addr_of!`" },
 ]
-- 
2.48.1


