Return-Path: <linux-kernel+bounces-444865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48619F0DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BBF16AA45
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B21E1C26;
	Fri, 13 Dec 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owNrjFry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC61E1C07;
	Fri, 13 Dec 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097672; cv=none; b=IoYa8HN3/WdZEjdTisbY77Udvvc+denNtThsx2YIbJxctxsRqdtEsWEWTzO2J9Hnsa+rtlzl+ZMjL8AfnObsYoQSZWGHYSJfPNgUyNjY5UCpJzuC+WQbr6oQlEpxU/v+DvMcON+MJujMWDC6kWZ256rsjwO8yiwabiTB6km2/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097672; c=relaxed/simple;
	bh=AkmQzt/HTDug1i0Rek37N4DXQKlYX4XxoSJ0WPd9308=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCrpcYPMOgs42MF92yFsE6nCZtdpHAPCQe0JBOdR16mfZkNzSiSVuqn6YO7Le1bQ+2lgMqO+fwpQpMKqCEKddSfReWpUwL5JllLDLt50HNiewCQtMSaLYeGJQlb1756oNtdQn0x6YzF4Pky1lxNutagIha9erxjXXOdLh9zULb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owNrjFry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9357AC4CEDF;
	Fri, 13 Dec 2024 13:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734097672;
	bh=AkmQzt/HTDug1i0Rek37N4DXQKlYX4XxoSJ0WPd9308=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owNrjFry+lFTn+lM0m1lttmGKjXIS4O9yPAwrnT6DGLwl+5A642fqqdVxEPJDXhqV
	 R/9/i+kZo6MrIk6aiifD+nKVAHM3pzwmcNZi8R9zXrWQ223eSW9OrzItbUOKxE6y9n
	 qkKA+XQ6Ot09ub4VmUL4dc0HI1vRruCXkm4zkBmrUd0ne0a9cBsXt6xJk1EJyiiLHP
	 gPFyKYHtTjmaKTgZXHrYLpkNoWxc4uEOB9P1yTY3nQCci3lQNGWpwkq+HR/gI8LCy/
	 J2p2qY+nP499nrqgcfBRMsgCP7P1kLwjyrB8Ub3c31m2/sBr/r3pTCQiezd32TyUNu
	 IGNKuet3eHAxA==
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
Subject: [PATCH v6 4/5] MAINTAINERS: Add Rust Misc Sample to MISC entry
Date: Fri, 13 Dec 2024 13:47:09 +0000
Message-ID: <20241213134715.601415-5-lee@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241213134715.601415-1-lee@kernel.org>
References: <20241213134715.601415-1-lee@kernel.org>
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
index 81348dbce8ca..d3e3b20e0376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5346,6 +5346,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 F:	drivers/char/
 F:	drivers/misc/
 F:	include/linux/miscdevice.h
+F:	samples/rust/rust_misc_device.rs
 X:	drivers/char/agp/
 X:	drivers/char/hw_random/
 X:	drivers/char/ipmi/
-- 
2.47.1.613.gc27f4b7a9f-goog


