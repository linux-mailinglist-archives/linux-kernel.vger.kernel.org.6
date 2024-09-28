Return-Path: <linux-kernel+bounces-342624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C90989107
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 20:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F681F217D2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85F149C6A;
	Sat, 28 Sep 2024 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rR4xECf/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BDF2AEEE;
	Sat, 28 Sep 2024 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727547983; cv=none; b=JiKEMV4GY5yGInJeinQkbjR4/Dqqw+wMgNrC0F1kJAyYWM6Z/xkx0ZlswKCpBGRjVIFjLZdRsfuTMBu7OV7IeYWeVI1bdRzzAE12qHNpKblMkO+SriDjcCb7J1aD14MPuO9iS2mJVI8TurY/RJGiH45k3GDPQK9VHo5FSHdqpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727547983; c=relaxed/simple;
	bh=ZBCbT0CBGwPWw8Utcc1vTnpw4wt48tYWNtJEy7FSvTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mQQfbdiLU86sHOLm8EOuVJi8iUDABW72OG2Ki4LBckA2xJbYg7QoJqBYFExRCQKqCRljpQVJf5lC3zdmKQmGNIfMiktF2dhrxISKxcQNXPdnU1ubGaj8nw0OsbjB21kRYve/2fHool7apuWDxqWGAx5Yt2Ej6ZCjn+Xb0ue8qtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rR4xECf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1184FC4CEC3;
	Sat, 28 Sep 2024 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727547983;
	bh=ZBCbT0CBGwPWw8Utcc1vTnpw4wt48tYWNtJEy7FSvTY=;
	h=From:Date:Subject:To:Cc:From;
	b=rR4xECf/1t3NO8FvAReFkCvSdqT9mu5eUIIsqje0f++HNv1kll7sMm4h2V8IwBKiw
	 VHo8npoo8lFADpJTWXbGIsDONRpacXfKSP4+6srhhmnaUf5qnqN74TgrWwQTdHBl4X
	 bDQv/xagiG+0L+diFwyEkjHMqAg2MQHyeykZQ8M1BQU9sbNoUElzAz+xZMgHT/sPAk
	 rVz++HZo9KNeacaYE+FqCEkMKysYC+V0He32rJeBLaw/4wxeGAB2Z3sUoCjm3grh8p
	 PNUB62IlEi8F5vj+YZe+cLmZTjTYk6jMWpIvEIE04yj2n8kpyt2p6UZI83qKlgYFNy
	 7/zSG5H24SuyA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 28 Sep 2024 11:26:09 -0700
Subject: [PATCH] MAINTAINERS: Add security/Kconfig.hardening to hardening
 section
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240928-maintainers-security-kconfig-hardening-v1-1-c8c64071cc02@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEFK+GYC/x2NQQrCQAwAv1JyNrC7FVb9iniI23QbxFSSKpbSv
 7t4mMNcZjZwNmGHS7eB8UdcZm0SDx2UibQyytAcUkjHcE4nfJLo0mBzdC5vk2XFR5l1lIoT2cA
 qWjFzDkS5jzneocVexqN8/6Prbd9/l3a/83gAAAA=
X-Change-ID: 20240928-maintainers-security-kconfig-hardening-7e70aa73171b
To: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=nathan@kernel.org;
 h=from:subject:message-id; bh=ZBCbT0CBGwPWw8Utcc1vTnpw4wt48tYWNtJEy7FSvTY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGk/vPwu7tjBeuuA5e8bn34vnml+6p3lRTbXvCNerIJn7
 qnwT/H16ShlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATSTrLyHDFo7E0suhaxatX
 UnXl3+u7vzpKJr+4FL83/5jX8ZV/V0xg+B/5Q2ETm+WNWodze1ZOeDVbeFXL76Lb/R0Oj1eFtne
 dauEFAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When running get_maintainer.pl on security/Kconfig.hardening, only the
security subsystem folks show up, even though they have never taken
patches to this file:

  $ scripts/get_maintainer.pl security/Kconfig.hardening
  Paul Moore <...> (supporter:SECURITY SUBSYSTEM)
  James Morris <...> (supporter:SECURITY SUBSYSTEM)
  "Serge E. Hallyn" <...> (supporter:SECURITY SUBSYSTEM)
  linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
  linux-kernel@vger.kernel.org (open list)

  $ git log --format=%cn --no-merges security/Kconfig.hardening | sort | uniq -c
        3 Andrew Morton
        1 Greg Kroah-Hartman
       18 Kees Cook
        2 Linus Torvald

Add it to the hardening section so that the KSPP folks are also shown,
which matches reality over who should comment on and take said patches
if necessary.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36c0af94cf0861904ddb6922bb0405b353fd33b6..d117d06d385f4d51221c7302c39869911d270058 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12151,6 +12151,7 @@ F:	include/linux/randomize_kstack.h
 F:	kernel/configs/hardening.config
 F:	lib/usercopy_kunit.c
 F:	mm/usercopy.c
+F:	security/Kconfig.hardening
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
 K:	\b__counted_by\b

---
base-commit: c00ac1f9fd7bfe87ff17b7a85f23118f3a3f0af2
change-id: 20240928-maintainers-security-kconfig-hardening-7e70aa73171b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


