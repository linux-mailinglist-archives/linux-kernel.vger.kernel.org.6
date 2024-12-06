Return-Path: <linux-kernel+bounces-435020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8829E6E83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B1416D51F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A22066C3;
	Fri,  6 Dec 2024 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUWI8MlY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E1205AA4;
	Fri,  6 Dec 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488991; cv=none; b=uzaD8uO8Knb/eWMCQfD+jMvNg8grIc1H01ihjMuJYhfEi9BZP/+kO6EMmzjy5i/0zGO4zBRB6+i1LUKsYNzqx8gl6eUv7LEUAnVaxHygCLviYLrj/Jw2NtYs+VLc69VnjMMB1D/sI2lBx3gGwME1oWVAUc7M3hwlX+xq4fHn4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488991; c=relaxed/simple;
	bh=23hCTKG960bDy1N3PIz21oRrK0JViO+CB1Bwjy/jA8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhYvcbVFAZ2nSXCGhQPbHMnEsxEe1nx1mib+xNKGug6pqeufukMvTBCkL/eWt9fcsw9pP1DsZ2De1dWA2NIOSU7DHWUKm3fcnbL0HaYE5So/3Rt4XNHl3x7wKgIvg93XSFQ1qARP7TMC+GNfrZPJNQZsHMbc86inNyd08Fsn1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUWI8MlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60902C4CEDE;
	Fri,  6 Dec 2024 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733488990;
	bh=23hCTKG960bDy1N3PIz21oRrK0JViO+CB1Bwjy/jA8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUWI8MlYsFA0UXCwm8yUHYPTk3+YpBbhNl7Vh1wI/2pcqRpMPkgcJ/LSMno42pqiV
	 iXPCzmbWIPH7YmtbsUSvB9reopFyllrssS+2wA2oQgIzZz4BAA+s7AuXP2h8+IhO9P
	 nS0jNq06FYTejopL75f/4ehR5Cci6vTyvHG194Y/ug/sFwjvJW7181YyuX9TdmY35j
	 ljSSJwBqF0IuAK/bfaumxJ8HKmtNzLB6rtuXihknjiBT2S8s2XkxoYs7T0mMCooy5k
	 fZMCDbfh0EOMrHAOe50IXluSZRJ4+lXWkUogKo0Ux3FFpRUOMO/L0lipbOLVLcW/sI
	 qo5Ao3cM7MmnQ==
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
Subject: [PATCH v5 4/4] MAINTAINERS: Add Rust Misc Sample to MISC entry
Date: Fri,  6 Dec 2024 12:42:15 +0000
Message-ID: <20241206124218.165880-5-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206124218.165880-1-lee@kernel.org>
References: <20241206124218.165880-1-lee@kernel.org>
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


