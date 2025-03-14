Return-Path: <linux-kernel+bounces-562291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB78A62208
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439BF188FBFB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20901F4619;
	Fri, 14 Mar 2025 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="Hzt0lAI1";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DfOCjulF"
Received: from a48-101.smtp-out.amazonses.com (a48-101.smtp-out.amazonses.com [54.240.48.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC751DF242;
	Fri, 14 Mar 2025 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995716; cv=none; b=Pylyh5Cwz1W71ynkAoUyt2Z6rOE2CuPYGyAhXbcjfaaud20ugIpGRQbwBNK6NnudhHf2dolk4mkjwXOwyJ8g5uL1ZCKBoAcBuKGB55+YbjG1EKGBg3hrBBsyP/uSynZ9IsWeFXQorqNVMg5qHbMw0QfhX9iLiM+AN09vICD0BkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995716; c=relaxed/simple;
	bh=pGAmHt1A0XVfvDb4N9bxWXrqvUUkgSgamEy0ARiJ4Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdYkhbEuwaZz98M/lfgPn15N+YwhwVFdBYPjCnnCLafgqDhlZ3WOAUX5mYsSpZShVuGId3cYKr6SFQz7Eryi0ZyIc7AX55lzxp7DP+BYy/uCuigCZLsh5RFk8Oe7d7JzBKWDcObEyrA9A9BB4YB2cbPIc5YrD7Tdc5GsNP3dFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=Hzt0lAI1; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=DfOCjulF; arc=none smtp.client-ip=54.240.48.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741995712;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pGAmHt1A0XVfvDb4N9bxWXrqvUUkgSgamEy0ARiJ4Ww=;
	b=Hzt0lAI1CUJXQ6/lS1e53zX+aVPsU0fcCjmjYxeVDONqCajf0A1BDG23JqLE2AOF
	sx28gfzAXMv6Zq+lwGXc71mL3WkmrlXZKPhmucKXNPwi61drXZglM2UDl/qbakhlsZM
	vF8EY50Pjd7LugTf4gKhgB6rFB9u/0rt4x7x3KNXMu7lFdDFkT5bZ4u7BYZOHeOEEC3
	mqo+EYWIwELjCWsJ8UyDzZPzAemItz3eWTlszWUWBHPb6SRHWgymypUwGtLmr6XaqWg
	F5td8YUiCGedDWTmVN9MKKnGpFgTJqfRFIWlLfjhxO8MSJmy2askLZtSix+gpHgvcCW
	StFCVHq3cw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741995712;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=pGAmHt1A0XVfvDb4N9bxWXrqvUUkgSgamEy0ARiJ4Ww=;
	b=DfOCjulFxhdS7nWQPm4srJeWA3r/Z8ZL4HcRCwS+3/SGIAvktqwWt89TB7ApvYVE
	j810zu31tn4HBvHmCiyKPOME5PPrGETP2RfjYA3Ke95ZO6YTbww04Y3NhmgUK2Imr0Q
	J+As7EzVaufe0JdrAw83B4/w2TpRVQ0UEr5vDtps=
From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>, 
	Benno Lossin <y86-dev@protonmai.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] rust: enable `raw_ref_op` feature
Date: Fri, 14 Mar 2025 23:41:52 +0000
Message-ID: <0100019597091f92-cb55b6cd-4d06-4d14-8d9c-1a1314949a00-000000@email.amazonses.com>
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

Since Rust 1.82.0 the `raw_ref_op` feature is stable.

By enabling this feature we can use `&raw place` and `&raw mut place`
instead of using `addr_of!(place)` and `addr_of_mut!(place)` macros.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw`, `&raw mut` is very similar to
`&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <y86-dev@protonmai.com>
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


