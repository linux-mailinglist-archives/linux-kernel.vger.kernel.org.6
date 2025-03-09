Return-Path: <linux-kernel+bounces-553195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E3A5855E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281771887583
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CBB1E51FD;
	Sun,  9 Mar 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZrixR+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB551DED5D;
	Sun,  9 Mar 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533818; cv=none; b=aaytlHqLRGLMKZ2B/uLbtn9CUjhiqFG6wXtBg/YVc1xoxsJiL9rLPLNrf1Z0dPjV/+AYNIOgaajL8vxvDpUmJXMQ0SnrDIY28P6t1Wl9lYO5Klug4hdvputF+3AGtlbeu0NcWqYE+ztp9NJgNEsh3W2Upw2c3J2fY/ZtpzTKSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533818; c=relaxed/simple;
	bh=dIjGlvzNhHkBxSc0U14VbDDTWmgvVt6lr6a6kbU7+mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V8+qAK8TdI3lujQeCaycWt/xdUaiEiAo4oRw+lfm2QTzD34IYvwlSDqUKBAegd98zvlMSnYgiEYP/rmwHkTtVjFncJf/hUHmKjV5G5YGl7ASkVdDnS5AXeC2AB6+k/9VCPZ88jiIOn+A4vkyqdWIjrrLx6dvbpwCHpw+Oc2wLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZrixR+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E632BC4CEF0;
	Sun,  9 Mar 2025 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533818;
	bh=dIjGlvzNhHkBxSc0U14VbDDTWmgvVt6lr6a6kbU7+mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PZrixR+Oy4TaJHR9aupSCHmGGRCwwODcDO9I8m96Z2rr8WBa1jdwljgBapARWfyrl
	 1e/5SNj/jSo31PQwuxy95uphLGk3zobn1V+iInX9ParvfIkURjbhM+AXNVQlBDJ8b/
	 m4Cz0Rx7BpRIMKt+HAWuRCBUgodD8urxrZSgSUP/iqVOK3AaNaTMNOFkHuQkAUG6pt
	 XiMuWY+GbI7iurYj9qU1BA589ZTAYd6tx2w4DoOWTbpwjqa3q1EbAoXpV2x/aYMWWM
	 gTPIS/xF1P9boIU372dm6BE4byAH9k5/egrXkZZW2YcZGcn1ZI8fdoBDlJL4HyEmK/
	 Iv4M/cvtcBp5A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:19:04 +0100
Subject: [PATCH v12 13/13] rust: hrtimer: add maintainer entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-13-73586e2bd5f1@kernel.org>
References: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
In-Reply-To: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
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
 Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=dIjGlvzNhHkBxSc0U14VbDDTWmgvVt6lr6a6kbU7+mg=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFzTyoN2/cdZriiqf8WvA1cLfj4GB+lRsVWn
 qyt9owqkQyJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xcwAKCRDhuBo+eShj
 d10fD/sENM1jxlfijjWmHsafxDcO7fBUgTHMkBhxLKXvDEmkl41NFRL7NpfP2ZtudbzoqrS++iG
 QI5XIpQfIeADVRmGiddTT2STzU/vhjzm2xuAR3OdDznvHxJN1a/cp6rsxRi+KUXBxqoLK0N9DG1
 URdkzflZWz/zGSskHr0//FtDb4b7M4iu4SxTBWDvNOEgPFwKZ9ao0XdCH3XllKbcgaAFi453vTS
 ZwtzJIIsD6D79zO5/S+ySORv6wSLojbf8PqvXQFUZ7YLfZmAlXeM/ZnkBlHE9PjILb4X46KQ8GD
 5/WslqzVlQW0jqrlfe6+M5kQIPCHurgXUmX5ifJxzwhnOUg7lckFaxeZTEYBqXMi3GOTsC1/nyb
 xJsWzOXo/ovxXvkMt8sm5ENvF5+5A7iq8zojidrjt0rOp7ienFr9rvzrQgVFM8r20Kz5MbvyQR+
 ETZwB5zNUBScW9BYV59v8HUyNMQkNzotvOEl6MgupXSWPmhHK6mGmNRnb/oe4kcOf6YPJvsLUJR
 jTM1fjw1aO78y+ZYJIlMqSUqQed96JuPxqGc694eBDLpQPXlYapmxvJkxXqX/YqoBgZg/aUX/MG
 FBkykHsq5BW0rlcXSWYOg871aP/nQCTopBqJQs12fB+mf7c7eo7QT6EcPLml0K4e0HCMBgLdUch
 4Fhwc4AXNb0SrRw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
add Boqun Feng as reviewer.

Acked-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..ba8e802faabf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10355,6 +10355,21 @@ F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
 F:	tools/testing/selftests/timers/
 
+HIGH-RESOLUTION TIMERS [RUST]
+M:	Andreas Hindborg <a.hindborg@kernel.org>
+R:	Boqun Feng <boqun.feng@gmail.com>
+R:	Frederic Weisbecker <frederic@kernel.org>
+R:	Lyude Paul <lyude@redhat.com>
+R:	Thomas Gleixner <tglx@linutronix.de>
+R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+B:	https://github.com/Rust-for-Linux/linux/issues
+T:	git https://github.com/Rust-for-Linux/linux.git hrtimer-next
+F:	rust/kernel/time/hrtimer.rs
+F:	rust/kernel/time/hrtimer/
+
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
 S:	Orphan

-- 
2.47.0



