Return-Path: <linux-kernel+bounces-369817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CA49A2327
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA18B23359
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB71DE3B3;
	Thu, 17 Oct 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxvkNKhf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC31DE3A5;
	Thu, 17 Oct 2024 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170552; cv=none; b=ES1zdgWYSgYqeSdrObQD6EKykCdVRcUESW78GH//gcsq6dYsAqNIRgJeCZXvpDIhd8nLy+TOcv4DmpUIWc5xafGTQaaYT8k7i4lDxiQ7abHOorFOArzM6XH/iHNbhOKh7hJdyIswr9p3bVDCvlP0ENIY9a8Pyf8JvXABiDtq6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170552; c=relaxed/simple;
	bh=qzP2YzXKrnzveGOYctsIdkN4dNpi8dNyWJklUYxTXUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FyG2efFq5vGjwWt+GbZoDhhNAA299Yq+wQMuKpSJ3xE3T0O7D6lfLOnJRrCX4ElZeqym9pca2pAP6QfwfQeq7vVZZr0kOXAZqX9U7+bMjFaVeHQLEbP5DOX0KE1kHD7TEja7BIWBLQlxF4aP0ZV9tT0YPVlmI6DmMCeD8u64KGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxvkNKhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B3DC4CEC3;
	Thu, 17 Oct 2024 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170552;
	bh=qzP2YzXKrnzveGOYctsIdkN4dNpi8dNyWJklUYxTXUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GxvkNKhfbtfeXcI2mlIYqAxmVcE6N2cDcNqQ8Qr5j15NjN/n+CQCE4sKJf3kEUH4Q
	 JOwTbHbwObja2/FaHFH61Vc0lXd+9Km6zWkbC+YMY+75xx1Uk1b6xru/XLvtShpJz4
	 VhbFFlp8EoY94V7kFp2QjboDadaQB8ZkCiA1VBUvUstDtS7Hhsyvtyif2YdohtV1ox
	 oEfm/a5VV6d5GgvqWhXUEYVeZZ9nCwYvL0s6j0Ech/DtwJw0mjm5fMwPUBjCgDxc+m
	 16X+Py/vxaqrPpX3Qhc6rV3Ywtm4H+PwQb+hu0Loe2X0Mx2uJjNeq18UZS7ThiU1PE
	 KPhDwqiIlq6Mg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:40 +0200
Subject: [PATCH v3 13/13] rust: hrtimer: add maintainer entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-13-59a75cbb44da@kernel.org>
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
In-Reply-To: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2

Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
add Boqun Feng as reviewer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded46ca7adf7a3538ad83643ad6b756..d7313743b723b385b53c0228683d212eb49bd633 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10174,6 +10174,16 @@ F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
 F:	tools/testing/selftests/timers/
 
+HIGH-RESOLUTION TIMERS [RUST]
+M:	Andreas Hindborg <a.hindborg@kernel.org>
+R:	Boqun Feng <boqun.feng@gmail.com>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+B:	https://github.com/Rust-for-Linux/linux/issues
+F:	rust/kernel/hrtimer.rs
+F:	rust/kernel/hrtimer/
+
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
 S:	Orphan

-- 
2.46.0



