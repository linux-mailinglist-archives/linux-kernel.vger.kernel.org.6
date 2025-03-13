Return-Path: <linux-kernel+bounces-558793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C66A5EB31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134C73BBE15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2D1FAC40;
	Thu, 13 Mar 2025 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="rKgRYTIL";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Sqh38mfl"
Received: from a48-100.smtp-out.amazonses.com (a48-100.smtp-out.amazonses.com [54.240.48.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876A1F8EFE;
	Thu, 13 Mar 2025 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741844037; cv=none; b=Cth7TGeVJHUEZmZ3LM1houkPwF33KuIUxIDaULwQc2tGcvMBTbrunqrPlAIHX0zCo197Di7kvfxzGKvpFJ2Q7c4rUTijE3YB9tfmyByDVJ6SkGe+ZbR1mfnWeKAtnilrX4qy5F1VFq3VXDpmVZWc6bkRi7+pxU+B+tKGQNJjzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741844037; c=relaxed/simple;
	bh=9k3CP8F8FIGEr5s1RUwf4PO/nKB0CSwUEwxI/IwfBK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTG2eNgghtyApl6AFC5QzWX+s2mCNJ4xl55/pxSlZTIOz1hJsG16BCDgjmO/IngWV8hpXoWUPmJEwthogm/UJMtJRs2ly3MYk6+0sAUj3NeqhdYDrlY79kdh2340Qo2VovCeUQQA2uBTxiAuyRQWUJO2PRwqJ6HDbv/LIA5MOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=rKgRYTIL; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Sqh38mfl; arc=none smtp.client-ip=54.240.48.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741844034;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9k3CP8F8FIGEr5s1RUwf4PO/nKB0CSwUEwxI/IwfBK4=;
	b=rKgRYTILi76ZgwRjCK/sw6csp0di3EkDHl4iUpKGMPlFgJdrVs7qFZcOyPX1zTYG
	lesMbKalSGtvGFirYFV6vIAMIGasjSR24hCN5wad9k305T4qrXTKR4JoHNwjXqiJCMn
	aMWhvM3H40Ml7TRDla+Fy97bOWFZZP/nkQqCHk07ooi5ovCRxksGiQmCrbH6Gplfm/i
	ShVZ3myFVQNnGY3YgpJUklmDx4/v2v5Mg5cqUqniFnnq6MIPEWh2bSbQdxOPYY9kq9O
	NZsGcab2paF1hMj5Dc7dCF4sA9qUyqXx/Jw6vrOA+EW50ztyaKEdTbV9OLpeNTBPV8b
	O8vcuT5HFQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741844034;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=9k3CP8F8FIGEr5s1RUwf4PO/nKB0CSwUEwxI/IwfBK4=;
	b=Sqh38mfl3vpqbmyfEmYPUvuneyKEMgWONO1xZ0P2ZE56kyNITZxwoRIkWvUBLQT4
	MTB0ugAv8WIU4pLXF9QIZ2NWwvQce4VeFH+n87bjYNLdbMUzWUMZH1IgIUD6Mq2znkr
	I7E32I2/hp2ch4YutABv0+XiiU1dpd/XurgXglHg=
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
Subject: [PATCH 2/3] rust: clippy: disable `addr_of!` and `addr_of_mut` macros
Date: Thu, 13 Mar 2025 05:33:54 +0000
Message-ID: <010001958dfeb4c7-0ed042d2-613b-4023-bb91-0c64f8a84fc9-000000@email.amazonses.com>
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
X-SES-Outgoing: 2025.03.13-54.240.48.100

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


