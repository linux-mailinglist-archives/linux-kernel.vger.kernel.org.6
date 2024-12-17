Return-Path: <linux-kernel+bounces-449458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6693A9F4F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B437A177E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FB81F9420;
	Tue, 17 Dec 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTd3TOFs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3871482E7;
	Tue, 17 Dec 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448829; cv=none; b=UysSFOBm5SkKov5aVseHhVOhiYGTpkFwbfIg9OCOt254k8xkw6HWbHXV3aefHwe1mjQWtiXvmUELjiXJozPlMfDshdDkWwV3+iugAxXYFTvb+k4qlmDioyP7OjDgp1tdV4LRZVJ3lPJIhTwY/vYRRGOvbqKVipxgL/QIqugqtlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448829; c=relaxed/simple;
	bh=HwVmaywQBF6mBbxl3xTMhNO72JJrVBJuegIGTS0ciAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLEDMlZolya6huM55lCiNSuqb7N7Qqdx0s812tJgpY9Ejbo31ogpkd4kSxRfV1hZ1ehzVARqhfFdq+PJpz7sS2ylxR9VJaPedSWApPhClFwCMgXQfcbLEQOpfBmCx834tRm5rH7f1gv0YEb9CaHyPDPbZNig8YZ+ztQq71DjPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTd3TOFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A592C4CED3;
	Tue, 17 Dec 2024 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448828;
	bh=HwVmaywQBF6mBbxl3xTMhNO72JJrVBJuegIGTS0ciAE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kTd3TOFsUafSgKyHjpD0bBazSzhL3nYj7AzVOSboMxeKj5k+xjwIRFYiwhhfYtLqI
	 Lpdk50i3LbPCdUpx/V9uocuGAGIOUaHMiiqj9HF00Sfngv3OCpqRiie7o/d1RoWlye
	 ymAlUTUhefEYI4fHhumK77ZsJsWFfaIBXaW6vI3ZhWqU/PeHwNxVta6g1j9Iy0Vmz9
	 owmI4aH9ugx6xhNoqjhMmNS23CVVzALhAOuPTV2Dd4HeoWIfBa9cistO5K4o3oQq6j
	 HRmtSpe37OBKqlb082aE5wJf+yKYOmkmWfwIi0wsCvSRldTEp17wrmrt/6ie7NRMVM
	 KXRLCYjdPbCbw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:45 +0100
Subject: [PATCH v5 14/14] rust: hrtimer: add maintainer entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-14-b34c20ac2cb7@kernel.org>
References: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
In-Reply-To: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=HwVmaywQBF6mBbxl3xTMhNO72JJrVBJuegIGTS0ciAE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYeH5A1KHEcLUqMC28Fe/fPpBzACBJswt7Qh
 Mdkw08wLTGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWHgAKCRDhuBo+eShj
 d6u1D/9XbLghAUxQYvgL4IIHukVZR/jwrAjtbXBi4EQ1jVAz9g2GShKJUujtfVEvHaV08n1/Da3
 HtHeuf6r3k8Afemer7qWh4J9+/og2W6YESBERpV88bn/R5dhcBh+erObT98nrrjnnx2dvCUb5gr
 WqbyiIBKAW8HysaYP1AhTzz4JXsFlVuHVG93h8shuXR77V/LziuYo8Lu6AoVFnuW06Di1LIBIB7
 MDb1tQ7J+Vb/DKJ1iyR+gvWfZhf4SjzbRDWLcuAYaT78gBKAmxU9SA6Ryj3+UCmFYkkpRzDm5VB
 kisa+NmlGW7z5UdPVMB46xWAdTF4NjQjtTPvkR6iJobdk/S2rVJmomBiCidFmI9FwQZcsmZxzCD
 X93HJTVY/brpeH7wI4SIq4s+INR/Yv8s/RR6Z1tkalXBVBTy0U6bx6pQJEIQEiM57JeicK8NJNT
 6cqd/7c79QWMHt3eum0qKxOGGbeFMd2GMT5mZArXfKd6ujpVP2rmcrIFHWWp8NF8dBJggd4rQTi
 aQE8LxcCeWWbq2h3iHLN0ZdjswTkHuWku3Jff5GpdgcNpKKdSA+QoDFDZU16bMaXOXUAycAsm/3
 e2YxzNBoDk1j0wh9jFRQTMimSHBsFwYT5m+E/KnruuXY/zWewgk7XHwPqlB646U2QbnjiUXQR9x
 1bFySwMoDtEf/cw==
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
index 1e930c7a58b13d8bbe6bf133ba7b36aa24c2b5e0..335ef0807516f047b5c84727f0276c4e88141c49 100644
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
+F:	rust/kernel/time/hrtimer.rs
+F:	rust/kernel/time/hrtimer/
+
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
 S:	Orphan

-- 
2.47.0



