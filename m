Return-Path: <linux-kernel+bounces-519511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0869A39DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468C13B61F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22D26BD91;
	Tue, 18 Feb 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCuZ/Yyo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4A269CE2;
	Tue, 18 Feb 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885298; cv=none; b=TNflHzADui5W6V5pO6Qqcg1BZ7Lo5kZdNXrZQxTi6DRE5f+D+cr1mwDKhGpRIc6HwnIFunMpTR+lKX2HYRzgMwWibvGvQ4ZfKbvQktcRlE6yIjLaB+gYB2AABkVXBUBn2beIL7EKrTSrkSwOMaAWQ6H78Eoc9yCq4VO0n4tPOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885298; c=relaxed/simple;
	bh=ROEeOJKEp/vl6zYT9awrPNL+gZGZt1QW/GbDdFhlY5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLeqg4etG6thvAR3f6DcknjZ5QzLQ5MMR40IP9CR/dI/TdCE7nwizPaGp3Kd9P2Nw5v4RP+HzqfKeNe2bhu6v5IYpEy3DtJ+fj82TMwFIAAXpNepI/B+owy707Y5kc1IRm3AnROvC7cgnsaFJIkL85BC/ov5Fy+HGfDtdPoCmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCuZ/Yyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74997C4CEE2;
	Tue, 18 Feb 2025 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885297;
	bh=ROEeOJKEp/vl6zYT9awrPNL+gZGZt1QW/GbDdFhlY5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TCuZ/Yyo4F1StrSNGFI6vYgUjFSiZ6G5J2/jvPN0Y1oAkaiEuWLM8eVJdtZJGfynr
	 2bro+jcsi7dc+QAqqeLr9FigdB38DM459TIS0q+blW9kuMOgrLyi/QbGqsNAl/xNqx
	 AdTDnR81aJ+LRi2ByV9UZjoMJZvsxUvPxQkks5RwBBQ90rOPbiKmvtCUjphci0ntXS
	 isFMYn6YdKnhVOFYMgAh3W+8KLFc9DSMLoQGS+Foq4POPWpTI1dcfxy40+aPQC6JPb
	 ZVT5O25Q0H5+m6UhRLweJqMyj7JLzi0SvAoAzXUxP0JUAU/y2fsSdNW+ZNWK3c4pYW
	 cJjug/phqEblw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:19 +0100
Subject: [PATCH v8 14/14] rust: hrtimer: add maintainer entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-14-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ROEeOJKEp/vl6zYT9awrPNL+gZGZt1QW/GbDdFhlY5g=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIq8VlMF5pCTBVJzMb9uAqKb9vLeY9xbRZk2y
 RAZM1TR1b+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKvAAKCRDhuBo+eShj
 d+OOEACswkOIH7Rxy/sQgKUNHkHQilMWXxyBxWIyu8Uxz9oEY3O49b/NZnojP3xsUMgBrpNeQUg
 TtKk2bxfLepdZ08/HJhPPQV3BVXm9ITWHblU855Z/5C5mS3k7p+2XZGx3N7lJ4OM5JI/wbpMG8i
 Im6oYotBYKmU0ZgpScNF2Iq4cvqGQv8vbmDVFiVL0luwI/bIcf2YaK+iwwiUYcL7YVCdoxRYNI7
 mpQfe5ZedKEm1oOotUto/gEQP76T/CNxJTkBwVV1dJInnkhVJ5nlMVarWIirwj4oriv8lMk0Oaz
 X00hbleDGdyCyG6sX+nnnSJF7PlzY8lwb653toSE0QB5V5ArXoHGZrNDUCrAqBfOwSeOiLRjeBs
 aymbE55AxVGDD29bqq8J0Cus5Sgje54BaEWNyAU0TzVsQROkEyVPqAUfEp6iBui7ghmbe9KqHIO
 VuJgIUTPt7/ivVAM5i/1xs/cTg65ZPPg49ExJcxwwDEqa41NeP5JwTiA3wYKGATG4g1fU7iTlly
 3+9zQI8eYzMBCA/BLnj/4wNvz/OlrZZ4Xt06EC2TrBEJXx43fGmEA5qg1FfbrXEzohdbVJ+W/s+
 sP2me97AkMFN7ay93mOiwfHuqJkRPfHyIHK/2amiEWAw/HSPi2Ax6QUDy1Z5G1qbeY5pJFljUQU
 ZBfoNtjr/Y62rPQ==
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
index 896a307fa0654..60fa77c41b3fb 100644
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



