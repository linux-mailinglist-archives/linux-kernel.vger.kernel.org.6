Return-Path: <linux-kernel+bounces-434677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C6B9E69B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852EB282A31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4D41FAC56;
	Fri,  6 Dec 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A62aXE+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131F1FAC43;
	Fri,  6 Dec 2024 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475953; cv=none; b=SPpG6CCaTozli9/6pic7lhuvlj+YQk6b902ZhpieHZ2wVCxg+Eu7s6FKdwTlfNwg0oFY7mQJnCcunI6B7dF5RzjP2XY4o8WrNOsLcgSvWZtH7TPKedg6oXaCGrCb8PDwmqKNKSA3JR42pC97LYlsNIIX62xgv+NADPTywJ1wspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475953; c=relaxed/simple;
	bh=23hCTKG960bDy1N3PIz21oRrK0JViO+CB1Bwjy/jA8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaHHIydpYAKqF92SUo1Z3EHk3LEBfVmXFZMilY9AmUyHkSbMZvrLUBsQOk8mxlPIibUzbCA5KUMiY3p/VY8LzZ2TEuZN7+x+p3WUKrMnXPp4dFNI4AY09u4E7vTMeBT69KT9L8tdxHBPF6Bw9T3zIgfETm2B8NPMOlH7f/3QIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A62aXE+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2D5C4CEDD;
	Fri,  6 Dec 2024 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733475953;
	bh=23hCTKG960bDy1N3PIz21oRrK0JViO+CB1Bwjy/jA8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A62aXE+B80Z0Viqf+w93a8HrV+vnBLw+y9iTBXifCB3CxbmNi/4/yzI6zAH+OONUU
	 zW0H5uhlD3tBEopUB4fFWUaxgriM4DDtbAjffhK6OuK3EsIPPPnSLhBjHdNoboC8wp
	 hCWKyYWB2DcJikwVPNQLGrO81DOiHR8U26Cs29ZKwEfQvxs+hUfjvtOQGN2kEK4Zh2
	 UqTqz+DMmFD2W/H9rE6RUk+JG+dhXj0/BIk6Td+fnVVqTxlRgFvL5niWdododbe7a1
	 0TZZI2qoGNHfy3lzKoMPrczC21ow5eK35YP6Z7KTeXpopuf2p0GduGZkNVmmoSLW1l
	 1v01Izkt3RLpg==
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
Subject: [PATCH v4 4/4] MAINTAINERS: Add Rust Misc Sample to MISC entry
Date: Fri,  6 Dec 2024 09:05:09 +0000
Message-ID: <20241206090515.752267-8-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206090515.752267-1-lee@kernel.org>
References: <20241206090515.752267-1-lee@kernel.org>
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


