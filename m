Return-Path: <linux-kernel+bounces-435526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED6A9E7906
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B3F161FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB852063E1;
	Fri,  6 Dec 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goxFHOQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257BC192B76;
	Fri,  6 Dec 2024 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513719; cv=none; b=AusVU1nEHpFDqOSJYCI1SRK8WxAIFryOQU05pmXlT/VZwKwWo+HXcQt9cSGQw3bUlllP/BRjOrgvNPF4QpZcBM5UEitLSXI/s5bh2OrM1rMMWNT1MxYtRiqdQA3OhBTuG92a79sDfu/+skbaR0RkH0bEHnZYfMgPnJKESTKWKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513719; c=relaxed/simple;
	bh=3cmQwvQmcHFuleBZ0JcLoMCUVXuHR5HSrNoO4gZjqeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZjSfcG1UK9sVFiSyM7J1k8NpjJ0t0eIooMvNMSp8pwBLf0HLvuhoNVnd72IpiITTkGTsAWsUi55J8u7p5di+fn2KIkTKKiMY5qBx9rzu7bW1CLIMBrzkwi0RKHNbB4zWxqC9vZXGNNHbt2Kem2vZB1h1LeJ0OuSzFH0egkAAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goxFHOQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A71C4CEDD;
	Fri,  6 Dec 2024 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513718;
	bh=3cmQwvQmcHFuleBZ0JcLoMCUVXuHR5HSrNoO4gZjqeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=goxFHOQ5bauugRte1mV+UzgamMX0/6GN0K0qFgLeyhlYB8TwrhowAQhxnHGertMie
	 /nJ286ZjYn5T/XfAUndGYjXanvbc61l9O/KGQl9rcI7PTPkOzG6HZVYCsVMkJBci8I
	 euZonUCYAKMEbEiaa0xNjDd0Wh4+qM0Wv5N+yy1FBfZmJLGag6ZbW6rKDFfmbXNzW2
	 bclKbGc+kM59ybRFGzSsqUQbKZs0t8SRpjPSmxoRxQ1McbY6LapfLZnpt5mA+DeCGh
	 dlhF/3rebGrLwXVnQKy6dtwVtXw0Cov7YAxWfxTkF1ezPiQmT7SlHUj/3uMmjG81zn
	 tVhef9QEM7L8w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:33:06 +0100
Subject: [PATCH v4 14/14] rust: hrtimer: add maintainer entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-14-6cb8c3673682@kernel.org>
References: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
In-Reply-To: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=3cmQwvQmcHFuleBZ0JcLoMCUVXuHR5HSrNoO4gZjqeY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVhYWFJpdGFvRFZJWXROb2YyYmxySzN1CkhhYyt4REZyQnh1ZzN3Mnhh
 QUt0YjRrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRjF
 BQW9KRU9HNEdqNTVLR04zQlU4UC9pYVpsdXY3RW5JQ2QwN1BESmtWT3RITTVRSDdVc2tuWm5ycA
 pWZ2tXOGRPZEF2U1FSTVJ2bmY3eElMSk0zd2swRXEvNld6eWRnRHhqTjJjMkVYWWE3MWxjWllwM
 DhGeHRDMGd4CjhpRkEzdkRybitLUDB5RXNnWXFEQk5USllaQ2tJSDRmQStWMktEalMrNzN1T2lK
 RTR5TE8vYlBEWUFNQ3lteFQKR0l6bzJIY0dRV2dXWWxOYzRFanVaSWpCSnhCWmlsdXAySjY4akN
 zWW8xYmVMZXkxYnhXNkpGV20vYmxlSVlycApwYk1najd1MERMR0o4Yng4Z3dUNFo2d1VCU1ZkQU
 YySnVvbzVEaGFxR2RpcmFld0FpYlRCMWkyeTdwT0VEeHlCCkVxY05kUVZnV1N2NHEzUytTZ2VMc
 HNvd3ZOMW9nMW1ycE9YK1lPc2xwY05ERlFqcGxIemtpL1pveWhNTmF1SEQKTFVuS040cmFQcTZs
 ZXc5UnFXS09rbnV5WStDUklJZVdzd2JYVWd5SjVKbm93SFpjQ2FHWEJxZlluMlV1d2djSApVYVl
 JYUt3TXlmNzVoNHVYcmQycVhXQzZxQXNEcmk0SE1DRUtZTFZWQlQyU09hWURHMkRNeG9ncDFieD
 lVZDFPCk9teklsaG5EYzBoT28zR2ZxbER4M24wSFZEeG9OR2ZBR1hQaXBwU0JTQ0ZkYjVQK0UrK
 1ZjU2dyTDdkNGFhN0MKZ25kWFZRTXNKK3U2QTZMUjZmc1BvTEtmRDVTVVAraWFjTzNRZ3YzdG9D
 VHNHZk5SbTZNZVZNWFV1UUl1MzcyeQpMMXRQdGlweEtMakViS0tJaHcxSUNNQTFqUHJQMUdGMWF
 iRm9pMFBvb09BTXpJUEQ3OHNETWZtSTFuK0ovMG0xCnFycjhnMmxWZFRvaDBRPT0KPWp5S2IKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
add Boqun Feng as reviewer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b13d8bbe6bf133ba7b36aa24c2b5e0..4b29b00f740bcb24d25dbcf45f265eea6b4cd980 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10251,6 +10251,16 @@ F:	kernel/time/timer_list.c
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



