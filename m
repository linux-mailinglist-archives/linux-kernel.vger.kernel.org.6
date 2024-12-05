Return-Path: <linux-kernel+bounces-433663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42609E5B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08311285C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F70226EE5;
	Thu,  5 Dec 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rg3Md6Wq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D0222572;
	Thu,  5 Dec 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415957; cv=none; b=TgoBPUQ0F/vg7+0EZrmSYroliHdYAIKBT7UVlGJ58uJ9AXWvktQywXGf+rwBrscU5C9f/bF7gtmN3IRvcNwq9eWN/8vISLli7qbeKEStdGW0rCW8SWtcxBZ1Q3vyTi7GlYr8KTBE6FQxo0xvqtCKOuNUZVXg9uv5V4NhglTlQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415957; c=relaxed/simple;
	bh=23hCTKG960bDy1N3PIz21oRrK0JViO+CB1Bwjy/jA8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St+KMLeo4JaqogmEBHdc8ko5QQM16HJYxXG2cyky785FHfUgib/smQixCaFsbHWNOGg3V50+KicNsvrGh7KLlfU3qzADVF9caNfJtVmkHJaW5BTkx3mrKIRVoliJaJjDGqFF661HX+xsxpac/GLzlVbKgUuZyYbId8odRH11Fig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rg3Md6Wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76EEC4CED1;
	Thu,  5 Dec 2024 16:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733415956;
	bh=23hCTKG960bDy1N3PIz21oRrK0JViO+CB1Bwjy/jA8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rg3Md6Wqgrck2Aa0v0T/A2Y6HG5LMkNvckOQ1GlCU5vRr/0wQCL+MeNlpNfziLRPs
	 F+bJWqXGS4EQ3/7hTrvtZnZ2Mqw/imoSoXjMnWHJVrl474+6B9cDasQSHRalfWNYbo
	 Drghal833tzMVh01ByBtwp9ySKnAYNfUHmRNth29W+r58Wy79NuwUwZ5GuvuSqX0r+
	 etJNjHLCLLFSEuYooJk245TtZnU0NDePwH55I/4Z3QGVTOKPV7aTjM9ZNupJSYiOTA
	 THhJ5Oye1srBaG+4qtNmjIYw9lIbhZBsZT8m5k2BySoDm9hqvSN9iuPH5/fy/Tx3t/
	 ZAFgP++DjVFAA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 5/5] MAINTAINERS: Add Rust Misc Sample to MISC entry
Date: Thu,  5 Dec 2024 16:25:22 +0000
Message-ID: <20241205162531.1883859-6-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205162531.1883859-1-lee@kernel.org>
References: <20241205162531.1883859-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Lee Jones <lee@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21f855fe468b..ea5f7c628235 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5328,6 +5328,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 F:	drivers/char/
 F:	drivers/misc/
 F:	include/linux/miscdevice.h
+F:	samples/rust/rust_misc_device.rs
 X:	drivers/char/agp/
 X:	drivers/char/hw_random/
 X:	drivers/char/ipmi/
-- 
2.47.0.338.g60cca15819-goog


