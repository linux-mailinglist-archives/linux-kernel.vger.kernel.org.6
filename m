Return-Path: <linux-kernel+bounces-560661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7CA607D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995838805F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98382145B3E;
	Fri, 14 Mar 2025 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b="eU6wvbIK";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="BgwayS0N"
Received: from a8-71.smtp-out.amazonses.com (a8-71.smtp-out.amazonses.com [54.240.8.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717822A1BF;
	Fri, 14 Mar 2025 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741923971; cv=none; b=KqfU248b+pz6nMprdOV9aw2Hia2zhnCeJWYXsCR7diYECLuh1Y06KCtzLAY5cQxnMfG+1LzmRgqIC2Ngf+SdPE5A8qb+BvZV3EnOGakXlN2KRvHq60wUQ2SnZZVEEU3Ky1aKS5J/rRcP2AE+l5DqAOWAYzHgW2nQmUGcus7PZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741923971; c=relaxed/simple;
	bh=BZsxbOv11+gtP8gKLucWQhlfuchqb01i3Ny90m4JiRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEfHbcFmTg10msOa6rOH2KTZJsW8nQGnh+ub7xs3bGIs18t+hClVwJbxYW5X9keEIgW2pKuMztEOlZpTjY1F7IvyQvYwyv4moqX6uFnC5HyMhiZ2kDVgZofwXRmKqDet/3k8BEE0jK0MtQvs4e7fGGJ5VYv7/cfuQjU8hUJeMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=antoniohickey.com header.i=@antoniohickey.com header.b=eU6wvbIK; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=BgwayS0N; arc=none smtp.client-ip=54.240.8.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=cgcwyxycg75iw36cao5ku2ksreqpjkvc; d=antoniohickey.com;
	t=1741923968;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BZsxbOv11+gtP8gKLucWQhlfuchqb01i3Ny90m4JiRg=;
	b=eU6wvbIKKe4irY4Ge9CZFS0v1Ak7HtwkdDCyKYzA5yx0zhTarrRiHWei9Q8l9NuV
	rqhpZ8tbYvM2HKQPHleNoi71e4zfiHVhpQRfrG9PEHHjrVXC9GBoFCmrSG06zlJ4TwQ
	04EDESUe+j7GkCfNIzCnLDGeV7EKIqzAOFrqNiAmrGnXAu+fICk51R7Yg1GJNeHflmU
	djR6Pb1yxFmoF2IiF0qdDYnSavJ+7ZkIDFxTBKTlNLSkFO9z/RWROkq+sCRZXrzQFyq
	JWThBkBlmmIWft/k4kNzed7BnvrTcbCgjaP25TVv7Gr3z76PPaTw7kwT3cfpQ7DlXgz
	RHz2hTyMHA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1741923968;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=BZsxbOv11+gtP8gKLucWQhlfuchqb01i3Ny90m4JiRg=;
	b=BgwayS0Nz97NkoMduLV5fztWpww6kKMEHztUaAtYHfL/a1hukeESuxpnpNFvZBN6
	xe9hqopl3GLsGr14kHBVPdCcdZ3s+bIkJbJeRGTtRf2NCHLly7QAZjZ22I/qT038Idu
	AFiXA2b8zIuohS1uRmZuUtauyH8ohqnWveprqRe4=
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
Subject: [PATCH v2 2/3] rust: clippy: disable `addr_of!`, `addr_of_mut!` macros
Date: Fri, 14 Mar 2025 03:46:08 +0000
Message-ID: <0100019592c26506-b2399cba-7bdb-4c0b-9888-393a0576a127-000000@email.amazonses.com>
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
X-SES-Outgoing: 2025.03.14-54.240.8.71

With the `raw_ref_op` feature enabled we no longer want to
allow use of `addr_of!` and `addr_of_mut!` macros.

We instead want to use `&raw const` and `&raw mut` to get raw
pointers to a place.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
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


