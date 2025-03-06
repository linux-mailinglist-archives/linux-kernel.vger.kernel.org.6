Return-Path: <linux-kernel+bounces-549918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B016A55895
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126187A2995
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DDF207E00;
	Thu,  6 Mar 2025 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InhWFPbl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DD206F2C;
	Thu,  6 Mar 2025 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295854; cv=none; b=JiwvjQ5in7DZFwyqYXErfwEiA3AtYBc886T3NzupTm7WWaYmorR8vfgkG1ybazVa441bKLQOaeyPB+fZ6dWtWcB1npsFzmSf97DpClI0vtI7CoF56wkaB+vqk4xfENCV4dzwhF04bn7IXTbsnJf7xT+WtgYwD+oFFlZgaAI8fpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295854; c=relaxed/simple;
	bh=rRaDvnjD4pecJxSu8yX8IcT3LMqjKK1F8RyUfAe3iyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IevA2z9rGYuD5RyDjB1lOJoYFxk2BaofSbzY3EeHlonwcOvmwvwRsz9cYC8h729J/3Qxe7rC1dFgu/UC1Gkq8flPJdRScao232mRnBmBaTJPe2yj7kvXPKosyAZG14O5s3ouUi5D5psAvmw6GHVanqJQbci6Siep6Xd3Gybf74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InhWFPbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0B3C4CEE0;
	Thu,  6 Mar 2025 21:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741295854;
	bh=rRaDvnjD4pecJxSu8yX8IcT3LMqjKK1F8RyUfAe3iyI=;
	h=From:To:Cc:Subject:Date:From;
	b=InhWFPblr82jjyHJkTe2sG5LNpe68o5GAIIdYAk6ltWBLe79UIdcoKZy5rQbww4Mv
	 nSPCn5MkKMC+dv6eVoz8BkBuH5CG8FQ4RMTtpx2IFs13+c6DDlkImou0iZ48TVZ4fo
	 UtNWvc7nmg0t8+9tREH1PuPXre7kWfwr29PbU9AzvpjzUrGox/qpmuw9d3TJuQOb9u
	 I1tS0VbN3qmdIrQWDZ+DQ/d7CKQwG94IbIdp2NSwoFRjPoq1p++DDmk5LTUQKXG+YB
	 K9rmkpUqBN4HkKJAhdwMqbpDlnDtr//+Sd3PAs6HrOAELNuKh/26/TaqPOfqEC9c0I
	 qq2RsCIiAkqew==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH] MAINTAINERS: TPM DEVICE DRIVER: linux-tpmdd-nixos
Date: Thu,  6 Mar 2025 23:17:16 +0200
Message-ID: <20250306211716.51120-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is my new testing tree for my kernel tree. It will over time replace
my previous BuildRoot based testing tree (but not just yet).

Depending on host `docker compose up --build` (or podman) will spit out
rootfs and OVMF/AAVMF image depending on host where it is compiled.

This allows a few new perks such as:

1. Trivial Aarch64 testing in QEMU and in macOS (without requiring dual
   boot to Asahi Linux necessarily).
2. Testing of more complex configurations such as Integrity Measurement
   Architecture (IMA).
3. Easier management of both GCC and Rust toolchains, thus enabling
   testing of Rust-enabled kernel.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..ea7c40b76181 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24033,6 +24033,7 @@ R:	Jason Gunthorpe <jgg@ziepe.ca>
 L:	linux-integrity@vger.kernel.org
 S:	Maintained
 W:	https://codeberg.org/jarkko/linux-tpmdd-test
+W:	https://gitlab.com/jarkkojs/linux-tpmdd-nixos
 Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
 F:	Documentation/devicetree/bindings/tpm/
-- 
2.48.1


