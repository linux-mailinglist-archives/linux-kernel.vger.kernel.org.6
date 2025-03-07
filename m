Return-Path: <linux-kernel+bounces-551994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88EA573D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD017AA7B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4F258CCD;
	Fri,  7 Mar 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcgGEGti"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9282580ED;
	Fri,  7 Mar 2025 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383658; cv=none; b=TB9S1/CNbA6qMLuv+WDC4O0NE9tUMLCjigFqwQeZCUmpWJa0IvQXwdR8pGbtPKgf05qQnXqwJE7RqjYsXcTfEdLFvkiJNu9DUnsABkWjBnXdwAbGQxog4SzXqJfvU+2VlFCCz4woznVOESaqfRUin850Vt2AR38n5RrBKHXL1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383658; c=relaxed/simple;
	bh=dIjGlvzNhHkBxSc0U14VbDDTWmgvVt6lr6a6kbU7+mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSzFF/3pKFM1oV+GmggL5pFqM77MtvIIH+9spjyFfkkBxuLYS+XSXh9aNUaULu9PY9WTzqTkbyVt4zWQ5SII0Ud6YW17a3QFvCizKtcH/xInh448kolpHSKWtSWeEgT7//8zO1hkSAzNp3HfH1mHLfKSqgcUl2y1B1rGs6b+4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcgGEGti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3108EC4CED1;
	Fri,  7 Mar 2025 21:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383657;
	bh=dIjGlvzNhHkBxSc0U14VbDDTWmgvVt6lr6a6kbU7+mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gcgGEGti906GxXQHFg2UnNItdm7fuBwHzBIkwmRO5drlIUkfa6wbcExGmdRcim9RP
	 F/e3bnWtaT74PoZYLJe7vKbDp+2U7YKeuWcoOyDDS5gsdXTED4Qr2kCyzkW066fq8F
	 Zsmdt5J8tmB7gZjw71HCzvOCL1a2Bk6K2Rq2EISYcURZXry8S6U3LVKmFm1Y83tk8J
	 dtX/RSWiIAGlH7X0FS0rciuK6n5v6MAMREMQCuRuvXzDtxA3tQrSdTLJUbUj9mEBuG
	 MVz3aFv8ZiVQdDL3IgyQR4iv3srkvsvL3P5pIuxT9IYeLw/hMlYbzrHfWp9HMXIAcU
	 6iidqY/bYNkgg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:54 +0100
Subject: [PATCH v11 13/13] rust: hrtimer: add maintainer entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-13-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2d1z03moddNvNr91OyadheiayqO0tyX83Tsz
 owja4GcqtiJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tndQAKCRDhuBo+eShj
 dwCEEADEjwlDNp6WoyGUOwHZaMHVYSdWawahVet7kCgBtIlwUR8UrnSIkEpp853DjnQmA2IkRp0
 F0EbCFcI6oWEYBqUs9WAZBkEtOufS4/7cbhAQj4yq2jO4ugg0JxjCFQiOWcbTmX5M37yX1fWmI/
 xh9AdA4VSoLhh6I5Ll+nlNB38trfC6kWVquAN9JzG34r6GsPwvY3VGwnKZowpVijCKtsDTiG1Gk
 IeMbIiyO7PKaMKt3J75FmXw45QSYpOy3uZq3dT+9cHPxupaDRcUyVrYDUjwJ4pJlGa5f4fOme1x
 jfzs8yKMXkz8R0KLo71hT2dqYsx8xWE1fvH2Unmx2xab9eTAo0aLKPmtYOnTvUpFWEOHXoNiXKP
 dNEa9+6sQ0ZqHnarSxHbbjOoOkgWsKCs3N/X4q4/cHDcTCJd4+xHw0cWR3pNiazA12AhWvFDjlI
 pIwPp6PremOdMz8mgm0ldeQ8M3TDWW/zi+P90yGbRY6tDLS/Emkoa9HkmSb8153N5QLkk3jSohE
 eg9nGoHts3sv7IWQDZG5xQoQxzeH8joUhuWrxLIgXxeovjtR6kkwyqkByTIKuHSvNQaU9zGlSgR
 Ftg6G3bJTqY4ArYbniJW66x4K18DbeKoegInXVucR7RyUYWDrfHK2rOHm3+bIfrktoVaDSGALaw
 cGyaVgwPDG6h8bA==
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



