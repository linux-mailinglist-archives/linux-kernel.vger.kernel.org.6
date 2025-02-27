Return-Path: <linux-kernel+bounces-536294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A523A47DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2373B50ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D622E3F4;
	Thu, 27 Feb 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6rpBAE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100122DFFC;
	Thu, 27 Feb 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659788; cv=none; b=tb1vMHzk0AF6h2dZkgtISk1IVUHESAUQVEvLPLjZtZU22IMRrthh2tamIaEplQW/4aLutUugGpHhmbVJc8s68dGy6+8LFzAXhJJiAZZPOngO9DjdVHsEVOFn86nWMhpWCy/ozxV4Up5uFX2Jq/oOqbhJWZcOVn+g/+sGPdL1Bhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659788; c=relaxed/simple;
	bh=+z4Qntkcydw5p8gD+O/kjP+ApAlaMKoppAU6zXIFVBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDHWRhW/cTneDAaxuABDK0Gvr4Ce+DO1fa7GQgG7mhyDxpcD6q+qfUAYP5C5Z/uZWiBj95BjfJepk5MQWvQVwYAq47xfKevXBG2jwpu2q/+IweYKNihiixzU/OD1FDYSv6SZOtjXBYeaqkobeF/MgINwxXhEiOEtNzlMQzFXy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6rpBAE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089D6C4CEE6;
	Thu, 27 Feb 2025 12:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740659788;
	bh=+z4Qntkcydw5p8gD+O/kjP+ApAlaMKoppAU6zXIFVBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u6rpBAE+2KIOrzeWcCdK4fr6JhZSPKYI0hUoMtIZJ6SSLMSCEyOTNZUh24i8sScEd
	 aqg6+K5DUzqmytJiB7HGq6OwzLGRYU0m/NbjTgUXaMWrQmrQfTW9N7jCAtJPh2rdSH
	 2yRHzab+J1t+VlTF5hTPkC9TptOFwWnIi729DWnxBc2fNP3n5T4Zk+wIF7zsP+jSdx
	 irDgyuRHuXm6bBP6Y0r+Tv1HuITvCgn51d0wIzXWw27PTSO2ljxUBAi8uRd4aZAW9a
	 FyZkXbBH68xp2RhyUCt8UppukgysFroFhXcHqk01uIZasQHZi3/fL1tsgHsVmT48UI
	 bi5PC/EWDxOog==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 27 Feb 2025 13:35:13 +0100
Subject: [PATCH v5 4/4] MAINTAINERS: add entry for configfs Rust
 abstractions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-configfs-v5-4-c40e8dc3b9cd@kernel.org>
References: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
In-Reply-To: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=705; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=+z4Qntkcydw5p8gD+O/kjP+ApAlaMKoppAU6zXIFVBI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnwFwEauC8FqrreRLPv1qAV5f+nYg6HKSX6Q0RA
 2kv4JGf/MGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8BcBAAKCRDhuBo+eShj
 d0xGD/9BDCRSxecprmFSY+apngjAyzSG2AVfbPNZ4Utme6sn722yiglxdy+XnD2jLfrttj2kEPZ
 RlHJx25KpdAcuNJFDTOQ5jaYHlKeIve0BSrTc/GxjPYA0Ve0Cj8JSX+WroZ5FpLv1L8PqDGx6vG
 eBmlDPpt7fcPZKKc0gHdWogfyHS8Npf1BN3dRE0sf+t1apldQsOtPh5tlUZJaZnC346MTHrlsli
 oFL1jQRGdv3fh/yrgDdNrKUIM2fok6v+B0v22+/DH6fk5RZXES8R5w/UBI+CTJ56+E4K3LeKXbs
 5HDHc/QZEPH5/oteYriBDQFrgzWyCdpmsbGNvJxyrpPe6iqnwqKI54HfE6I8vssbuPcJdsQgsYe
 X/8cV4xjFw5bWf1+yW6ETkL5/I4L/g/9Wkdo9hCKxEqccspttXsqUvylsj9XXeRagjZhzf3Hxrb
 YqlEaMJmwTNif4gbm2FNtGmCxoTX96Iex0IB1cKmh+lLIfPlB3EyJjr0Bq1IgArMbfddu6jTp98
 H1JIc78lDcwPDZu4SWsxtaAE38sg3NXNTPjR3lfkz6IPeYt6Ob7RJmIZYDu6iyDYRjLzgSNfBEJ
 +sD1aUKYdkBUdY+2EbKeo0rhdHlC9cYYB2dgNEIVk8D9mn9Zx+fSqpbHu+9CeRg2+Ooa7WPBe3H
 rrBLkyaMG+wecQQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Update MAINTAINERS with entry for Rust configfs abstractions.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..9b4d5c12eb43 100644
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



