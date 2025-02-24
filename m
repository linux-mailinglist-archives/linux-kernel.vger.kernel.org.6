Return-Path: <linux-kernel+bounces-529157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04174A42080
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0613A67C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E068D24BBFC;
	Mon, 24 Feb 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh8uZrz8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502C248865;
	Mon, 24 Feb 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403388; cv=none; b=bHNiqEqOtBxdNYCyCqWZ2pbEY/CVDCABuZhLwuCe66gLLqMNXTCAbQfCtBT5YT4j0sB4a4lzNJr2nhy5F/7KRDy4NE77vGpS/rgdyU+pvMitje6NBTutRY6FDZfoV7ngPQ9XCKZ8OmQhaKNnPtE3E+iUn6EUFZh7lxbzY+/CzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403388; c=relaxed/simple;
	bh=+z4Qntkcydw5p8gD+O/kjP+ApAlaMKoppAU6zXIFVBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkrfB1gQlZgMwAc8uUn0Rf/4abYxBAS/QD5i2u83yo3IYkBkh0LTVjrjfJ+Zkvj3hWVTtOmK/ZL8UAEC2ezt1ge0h6vwTvJpOIW+cJrwK5mbjZxl0jw3i+KR8xjYTx3f4kmUAlS9wfVaVnKWZjwccQ+acUyyRMIVErB5SO5/lQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh8uZrz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E18C4CED6;
	Mon, 24 Feb 2025 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740403387;
	bh=+z4Qntkcydw5p8gD+O/kjP+ApAlaMKoppAU6zXIFVBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oh8uZrz8vTBOP80tEzohCsQvGzdSkN6JbWv7HUiAGzh3XWaET19DjC+95usJOdmDn
	 jYa9CmCPHR/siSNRonMY2yuqTVqfUPrLCNwAtq/oV2aKLKtFx4wQA8hKJfuUL9Swzb
	 d3LnTlk8fJ7zhbvIMBr4HWHOc/nr1rE4qoMkpFY2bd4tZ4KUpwzjE20FqA0r9E292x
	 dQ0z6K6FF1RnqTZ71ynKeTrzA/U43gAVEZZllcJnqM+1HvOdPNkgP7+QBmN6fTuVWB
	 sdj3df/ppHkdNtRGlSxhasS5Mjv4PF93MyF5FFfGn+/XbsB5bmMHSKzvdNKmq7p+w5
	 yZXhYcezPQkrQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 14:21:54 +0100
Subject: [PATCH v4 4/4] MAINTAINERS: add entry for configfs Rust
 abstractions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-configfs-v4-4-9af9b5e611f6@kernel.org>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
In-Reply-To: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
 Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=705; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=+z4Qntkcydw5p8gD+O/kjP+ApAlaMKoppAU6zXIFVBI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvHJ4wlau95nGdwpOnToMKvuyFYPqy7rzfoJ+4
 n65timRYTyJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xyeAAKCRDhuBo+eShj
 d4+zEACRptyLeLIfcnZAR8wJ808Y8vhaiezLsy2elgxRivoKbUEVoeg6aauggApT37nw8/32o8W
 10J7D27KQVvK2Mvo6oUZV04amrkQFFWCFmWKF8TzyLnF9vbBl/vUBZrHwO+wpw6ycX7kanVW+1b
 2nbuqgA283NxY/p8VcPq6feQKjcIW2RWvAUxhLFcyZhzbhe2LYg63u0k0oYzYMlimTLvDrvnFNI
 NSB8NDWGk5D4R3rQX6P6+bjwzuB8X20QJrVyEE50I1uW8B+txJCblyHIPokxVK/W9qQXdnkeihO
 wE01uaX1+2xYVP+RpkmhmUYmD0mQCAOztw/Aq1/sSwnJabWNr6qto1gJvJ5yhgGWUedJLBoOxWQ
 Povh0Tl1Iae/qfdNAtS7hzeB1ghxjsi/f/9lYbRjX6eaCDLsB/lkUVMR9dxs913y48ClyxYGfNf
 eeDSzXAdpTJQpEW9K8OFZ/D6nD3bkvt9DOcLig+tBRWO537GykojsdiXYTBI/qoHFN2ba4LY1ge
 dOtcb20WgQtjYw0TNQq+9VZQEroaMu0+5imPWauLKUIwylLlSpmw+gdnKfmSDKbfZRLto8yfiLk
 4OUO4u11GfJAUwJ7PlNPIxPORrIkr5sLOgh2TFmx2SDcgWqTvrIJMUQ6CVoz9qm3ftgds7bz80m
 edHufPI+0de+sAA==
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



