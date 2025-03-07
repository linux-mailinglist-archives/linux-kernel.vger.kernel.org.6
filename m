Return-Path: <linux-kernel+bounces-550842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ECEA564F4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F713AB8ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47F2116F9;
	Fri,  7 Mar 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOchJ7w0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0CC20E00D;
	Fri,  7 Mar 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342671; cv=none; b=GZ+OIGpUW0MSvT+A9AJe4DiTGIrQu3QQSDFZGjOtEIzEfqAW2CsZIj0IN72690fq3bE9NG6gxGHc8ZU7Nwa6H1R+Pi7JMzDDltZTXY5Rufg0wstHvYyz6meituVDwzO2ZRqMTTBvE/SiJjNR9FgxQUjcf4BO5Kc0li6je9WpzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342671; c=relaxed/simple;
	bh=BJkzz/6LH7LHbTACq9l3gKZL684NeJl1h8pvaFEsh+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jiTDPEqtJ+oU7orxKVTNZatRZwGm7p15mRrZgxMSb9YpyzvO8XIAx2vtjYwv+IVqo71GfhwAVO5KFlj0SINfG20CLOCoPKO1pMErtnK5t2wvpFQxqKZKqNuDGIP9BxcNN54eOCONUjky2kiJE9lsk5LAs0ku/BN1VjTGesSUxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOchJ7w0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD9FC4CED1;
	Fri,  7 Mar 2025 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342671;
	bh=BJkzz/6LH7LHbTACq9l3gKZL684NeJl1h8pvaFEsh+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sOchJ7w0bv+s2p/W2myPZh7914APR/rrfcD8zvxMB8yJ6mrjTbfjGNMWGJTWUcg2F
	 q8dyhTQ4rljqWufu/rOiTnKEfkm72K/PhvC8Pdf87t4Vm7MAqLkSbqgFJWj2bU+Nt1
	 INsgrf6rSiZDRCRTVo8psuOqUBZkJTv/FIyRs1gXhnigciJdTL6QA0PNwTwyA/bQOE
	 UG5fTTN64l7V9gMe3MUmaXKpMDOLfi12pinCTdECYxnqw6vzP+T4UuozZKR25ZjyQY
	 7BEHB4AvPRBwwixMzhfbceNt7hN10Qqa2TuXN3aywqtoL3aNbpRQxKy8xFHH8578Md
	 twI2Chx4ck7Bg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:58 +0100
Subject: [PATCH v10 13/13] rust: hrtimer: add maintainer entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-13-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=BJkzz/6LH7LHbTACq9l3gKZL684NeJl1h8pvaFEsh+4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysaC5pob4womdYn7QK3zaItUC/xE1PBZwTHT6
 5Rp4ABbh6WJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGggAKCRDhuBo+eShj
 d8XGD/9B3nBYvJ+a8XeHVnWzrmYWfB2HxGVCiBPLPDrZzMk+o5XjS2HhX3CB/7VjzjO/9C5mFFc
 fYet3sT9OzUGaEoamsJAV+JrhwUfFWO66b/BnSIGtE/ZkLQhx0QFinOGBrX8VcIWjRw/fU4iD9g
 DiKo4GiTgfK9ivcsv+qntctveIXMez4cs8gLkEpLz7Z+1bH4aTzU7OYofowMj+Y/bzJM2NKRlXM
 N7Z/VLlB0sbD757OZnOMy1CUmLiOgwdQrgFSNh8mDmuKzTeXeJp32IioRSrx9+JkulmQJEPwrwq
 9AJVzN3449ekdRLyQCIp9ki+AFUc6gudNjSkI4G7wGL8tcEA/oeb6NK8+qhtdDeGiS7PNW+WVMi
 zBj8ZgdrUAIFCkv5BpP22MPmbWcgPTfbLWvtk6gPKy8N1dtsbXVG78K9z+lnZk2y5qX+a+p+2G9
 Y8SkG5RAuINiphIvTtJTkXxTJ7qAqXQyCYQc/BQE6znbCfXPhyo9RP2bCWoNYbwQcuPsqWXLoc1
 kkODW5RHTHJNZETzcyF+CfgVRELoA7FsHBh4yATi7UhVuDSLYih7HjhOTzwoCNyP+KYiufKUurF
 A7YyGdR+mMpMuCnqBiovdo0lVoUVNEK+riUiPvKuwy3VTMTvT5ZgkJl7lyjkeUTgDtqshzIqV9Q
 qlGUiuJ16WueyMA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
add Boqun Feng as reviewer.

Acked-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
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



