Return-Path: <linux-kernel+bounces-519433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA7A39CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290CE3B0E91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF9A268C44;
	Tue, 18 Feb 2025 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSQDzdy0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553004EB51;
	Tue, 18 Feb 2025 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883731; cv=none; b=cS+33zf18zd81i+VEprsWE2LoqwLcE00ktN5NhXFSV0a5OYmVa1rwPBbDMzmhWjQcsNW90P/2weJfVcnxR24OYjaT7fmixAHyC/xainkhycYzmMZ9oxr47hawKaIGvYEkoRdVD0hM/vvoxwrGsp7HgKh5XobBrJ9VWzKsKC+Ncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883731; c=relaxed/simple;
	bh=eee7hXn2WhCoXvDLpp0omx4YK+YJaZ/zUZ8CPI55We0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQIBP1XIa51+9ySPlldZ6mC4UZrF9SQWFWY028vt86WqQqmtjSDruU3BaqESAlmuZDdrQv1DviOpNfcRstULGkonsr00vCXzahsIyIwDVtDtazALfT3Mc3mNp+CYPkNQzmHWrT+JvNJdhaqeAice/Vl66l1tBBp6vbWgDKw+K1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSQDzdy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A874AC4CEE2;
	Tue, 18 Feb 2025 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739883731;
	bh=eee7hXn2WhCoXvDLpp0omx4YK+YJaZ/zUZ8CPI55We0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tSQDzdy0kRydnlk7NVeG9+KKvAWLFbbOLQSXWcg0NbuNwI76rFJxb5wV90iANAUVY
	 b0GuFqa3VRziOfl2oQXe97HZVDOPm6sBH+/2BLHeyLcl9hP9CNSnDhtIuV9kVvT+Yc
	 e8o7ZFyP4vt8M0iF8t0oi4oYYJ2KRoFgaLzAX9n49U1+8KCkEAR9WWpLzv2Fc0dy8l
	 zf4VBLV4M98jDssejTDo+cxFZxFdLiqufzdeleYJzhDsxyKeDZdQ3SpTRtuOVOxCE5
	 zLnLcUMRm/6fJpE8tfxXorJIaZKdA2xcrdPfaQ+Aw84m/ZrEvVtgFxTy1Je/p+ZSK0
	 GcG8d1fobYySw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 13:57:19 +0100
Subject: [PATCH v3 4/4] MAINTAINERS: add entry for configfs Rust
 abstractions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-configfs-v3-4-0e40c0778187@kernel.org>
References: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
In-Reply-To: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, 
 Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=eee7hXn2WhCoXvDLpp0omx4YK+YJaZ/zUZ8CPI55We0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIPB+tVfoINTe9ALXFlt+ep2lIqJcs4WhvK1u
 oz313TLX2yJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SDwQAKCRDhuBo+eShj
 d9eXEAC7cg4saFgFl+pDlE6qcrUJ5BgXkbxaIqoPgMOWwR09tiIM/JhZsOQitF3Nf3M1EVc+HI3
 /b1rQl4SUG2KlPBbRq0Vp4060+fPCgUvNFdpEhYYCDuKkrq7Uf5HnuUtdgToB81oT9c60hP2nth
 aofEeSl3RXQEsGOEXqC96TPutR76jWFY5xgqbSXAaa/Lf2Y6EGDczI8I1g5lEdqa3AntIHeclZu
 R34GEIOR/2rJH4fjoGwUkVJj6WU0FIY1YKw9N9qSkjMBWU8Td6tIYUhp2yZMhKILZoxtyeX6bWR
 6faTWIXfuEq4YPfAUBFS5HkEKenLmd+a2ZAgDLCklu+rmAtHuNeMSfFj0InZVCpwEJroF3n7GKT
 aZqrn2b3nMdU7NcnDGeIvU4dHgjQt53eI9xRjg2Xx7TSJ4qrttKWh0s1qbutOmB2MK/ulYF2nku
 usrcqovzG/ai113TR7qc8nCe9CgcDos0YQpnRkuiRpBSK8IuZFlF4h2HdR0PmYwHMYBMxUK37oc
 wHJLPzSD8uw6T/ynBlC7ouYdMaaWA4OxpP7gMz4NlmJxqrP6Vflr02djtFXy2eCxAhXUxiM4oOY
 d5N1gYoj8lEF2W8fDYevdzzIbple3Z6X0Bv04iOnXy9uHpDF7uwS2vSVmL5wS7y8VJ4+/2ZAkGp
 TgMroC1Q6N+e5Dw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Update MAINTAINERS with entry for Rust configfs abstractions.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa0654..9b4d5c12eb438 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5870,6 +5870,13 @@ F:	fs/configfs/
 F:	include/linux/configfs.h
 F:	samples/configfs/
 
+CONFIGFS [RUST]
+M:	Andreas Hindborg <a.hindborg@kernel.org>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+F:	rust/kernel/configfs.rs
+F:	samples/rust/rust_configfs.rs
+
 CONGATEC BOARD CONTROLLER MFD DRIVER
 M:	Thomas Richard <thomas.richard@bootlin.com>
 S:	Maintained

-- 
2.47.0



