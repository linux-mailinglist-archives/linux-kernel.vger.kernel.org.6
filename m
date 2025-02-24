Return-Path: <linux-kernel+bounces-528973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A5A41E85
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9ED188B8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BB723BCE6;
	Mon, 24 Feb 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G43zGPOZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA1233739;
	Mon, 24 Feb 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398762; cv=none; b=uj/odBD+duHtIk40y+2VpqZgti419phKZXXeLprtVJP8i4PTxloB9DcYtm1EhOqSc/hAvFcbFC9n60+4WjJBLfARHTRQsn6Trv6ohTnt5lOLS84AtakFC3weKbbGf6Utr4LYYXgBZNLVOe1S1z31uWBAiPjuSq9elTAcwgw91TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398762; c=relaxed/simple;
	bh=r22q6T3iTRPtwznESGgzBK1H2yg/6SOqkTHLXaFCMZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtGmBnSbNjYReOJwkweD1Z8iOYu+nXCKRg230hTMmDfpNBD2qVsBZ8IFIgSvDf1Fp+d9ScWPLWWTHpy+8tJXUGF0afYo4u2DzFCbzkNov1se8LJRoqbJiDOpkUhEem8+d4SDEe49aOjTUKKLkJ0qKrS6nJgxIYsY19oBG15KUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G43zGPOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF338C4CEE9;
	Mon, 24 Feb 2025 12:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398762;
	bh=r22q6T3iTRPtwznESGgzBK1H2yg/6SOqkTHLXaFCMZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G43zGPOZLKJL7CjAnhgTGwwQ1aFDZD601rLcEm/8xoaSGsUbBQrfNBWfbfVzD33jS
	 ghrbfh+ulg3c+DTWC4sJnStQ2RFezaxqjRDIy7D7zxnUjq2DyM7gXWtrAwWT8oPePn
	 +R1yvTErZVwDShmFamV9k3o7bO1T4IMdsqXc4aDSDYTcYrTinUlPWZgk3fEFn6DiOm
	 8/Woolj0EiMuMl23eaNwvL9mqjLOehIsFi2OiBlXCKj+dFe/rBfeAvwj/kXp1FwHnV
	 4fYu5zS5NrcyQVMC7R+wiAxQ3hXFqvBqJnooaPyFTpHNjeRgD73UKpRfhWcyrpFvkI
	 wFXZItYjM/X5w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:47 +0100
Subject: [PATCH v9 13/13] rust: hrtimer: add maintainer entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-13-5bd3bf0ce6cc@kernel.org>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=r22q6T3iTRPtwznESGgzBK1H2yg/6SOqkTHLXaFCMZ0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAnim0wmOoDxbgma7+5R5YqYhB9vpvyTzENt
 a6C5dHvGdWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgJwAKCRDhuBo+eShj
 dzNuEACYMCAkXcodBftvIU5ttxbYTan/TCeKQjhiNMzF732OmA3/+SeZ3x3KQ73PZ7M5gs2/aTE
 gnwQBDSTwI951ld18eiN1aezYvaBVW64omvj0m5QBf//sYTSgX0xmIEyHJ7M94wjLtPKbIAjIIg
 kAo1dKZ4wBySk1WPfMoWnc+jWA7te1f0aVu5odRmmfxPcgBRFPSFqRux463uifazf+xQy3HDHy0
 tTVgEd32ri0GXHLERHCiF5Dq4A3uJVvCYIJGwlKAGWGTx7SNu5ZsGiOyKp3X1goGYtUlSZ9nNH7
 mkPgtsZebQng+8xA9mPLx5ma7/AYdxyNRjGXcERKD4A38nl/OFgV1brQs5RQkZNxWNDGzwIxAtl
 NBkwtepiNYE59gCyJDlPUm3GRFu7Cnsj+ZRaBAjGZTNA9ojLEp1JJyN8GU6zthTOSeK+SNZjI98
 nu5Jt0feqvX8Dh2rIuhsn52vqjjjEeW+dFa7hiSvJ39oYauhGWRaah7elZKTABrQXA8G4NgqBRD
 YABZD/oEEYaaeHCQYHeEkMDJG5jOrsKOtaJTjVwGzm/hp7/Szk22AfSd4n3lbmV2EYjqAYU6JOe
 HJrGUYciRRWSOE4OgB1/CbNbT9PGHRy4poUCr3+tdKbL4jfvsZDIXGRcGP2FK+GmUFc7nJkjGVG
 s6l2l47gTJyMlew==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
add Boqun Feng as reviewer.

Acked-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..60fa77c41b3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10355,6 +10355,16 @@ F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
 F:	tools/testing/selftests/timers/
 
+HIGH-RESOLUTION TIMERS [RUST]
+M:	Andreas Hindborg <a.hindborg@kernel.org>
+R:	Boqun Feng <boqun.feng@gmail.com>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+B:	https://github.com/Rust-for-Linux/linux/issues
+F:	rust/kernel/time/hrtimer.rs
+F:	rust/kernel/time/hrtimer/
+
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
 S:	Orphan

-- 
2.47.0



