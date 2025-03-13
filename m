Return-Path: <linux-kernel+bounces-558792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6F1A5EB30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F27179B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303951F91C8;
	Thu, 13 Mar 2025 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="tgRBnUEP";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="do9hnm13"
Received: from a48-101.smtp-out.amazonses.com (a48-101.smtp-out.amazonses.com [54.240.48.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411E2E3366;
	Thu, 13 Mar 2025 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741844035; cv=none; b=lFZarlrNZTtiTejF1e+K3GfPbRvUHUuYFmEwkyJjFeB7YMK1tqu1UShVTnPgcUqDs6mj0JQIVnPrEjN+xjRqAVa9Z76eN/82KivBlbTNX1RwBcWnjS4Vs22rFzsCcnRDCH6IYYd+WIGjzb8OJco6oy7RmnhDhPOitl/rYFAIZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741844035; c=relaxed/simple;
	bh=pGAmHt1A0XVfvDb4N9bxWXrqvUUkgSgamEy0ARiJ4Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5bHUf2eF3QqloeJJoE1XPsdOoBZ2TD3hmmgyHOqwMPwOhamMtFXYvZxmpE5LuXjuUK17U0R+aqLyuwFihQ5holo/lue9n8OiXTrO1eXHi0nVcgz2EcWxNplhwrfSGYdIKkQgL/UbkaUF3s4yD69Frnn3N4SgXwpFu3XjIL1xGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=tgRBnUEP; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=do9hnm13; arc=none smtp.client-ip=54.240.48.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741844032;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pGAmHt1A0XVfvDb4N9bxWXrqvUUkgSgamEy0ARiJ4Ww=;
	b=tgRBnUEP+mD4CRulx1qEiBxEMY1yuNgzEABXyuVAUFxazNwVrQRmbPGd94JWm1gG
	PXNXR4NxHuQ/jYBAtyOdZtzJmImHszIqG61cBaaLS7xblIFZj4cHl6Vqxy0f67VnvD4
	hMab+uDoVyD4OyZ1KxQLBTrYqXpceubJTomBApAL8S6VPldmiriG23c1N7+18vrmpjt
	2hz7zyL+IoW7eCfoNbrZNmZMGqIyoyeC0PleeaNkrTNeEgBXP7AtY1SuqZnLuG31+If
	qn7whoOighpp2M8nSrKhldp7FVn/a6wfXDDXFkjzoL+50OVHumThBRbpvu973yh81bD
	1AQnMuuSrQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741844032;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=pGAmHt1A0XVfvDb4N9bxWXrqvUUkgSgamEy0ARiJ4Ww=;
	b=do9hnm13s/8U7+3f+Kfd8+Ev5wHWXuVvMStqDkdBKMd8DQ3XyHry80y7f71YhShi
	Ab6mqVCbXNS+Mgecwawigdkm/mSblgeB+j5juq+YOLObGbxUXVpRNyBc1KVh3tke3VA
	m+HNuijTBkdygJXMtGanWMg8hIdb/StK1jn7FPkE=
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
Subject: [PATCH 1/3] rust: enable `raw_ref_op` feature
Date: Thu, 13 Mar 2025 05:33:52 +0000
Message-ID: <010001958dfeacb5-9039aaab-6114-494a-9f1d-f13982091169-000000@email.amazonses.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313053340.405979-1-contact@antoniohickey.com>
References: <20250313053340.405979-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.3SHHfi5Rh4c+NdtIv+pxNWeqDT0J3zAhYZLMebdhE9o=:AmazonSES
X-SES-Outgoing: 2025.03.13-54.240.48.101

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


