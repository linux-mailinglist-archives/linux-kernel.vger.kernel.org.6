Return-Path: <linux-kernel+bounces-414686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C69D2C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A177B2C54F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAE41CF7C2;
	Tue, 19 Nov 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADHDQQwI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685643179
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035754; cv=none; b=sYWRf/GHabCaY5vzDeNrOYPyCK0mnTqLkVn2r/a1k3+B5df1O2GCaPcOfzhn+NmbOOnDSGNK2TBkA2ANbMRCPQbQNEqAjhgFY7EUYuL9xpJg/WLS1goa70+sLa2cRze/Y76R1ugpQFxmYCfuKUWNsWRA6nBZilO5qZE6qoA2+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035754; c=relaxed/simple;
	bh=2ohtly6BIO1DlMCB8i0EV6x0fzVrCeecQV3KvtYE8d0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=evpIJYzcJikxsnLGpkFcKPRzOPwB1amLXWcimAly1yast3UPpg1AyCPQY0sINFTm+Uss09PjwA905ZvIayBXIl9wUhhh313a0WWw+H6fLzXU2eNKrIc3JvwBNQURAO46wjldMq2yc7U/hXx7lGWBoB9kxtxiz9bDi4aCKnGqw0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADHDQQwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5FAC4CECF;
	Tue, 19 Nov 2024 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732035753;
	bh=2ohtly6BIO1DlMCB8i0EV6x0fzVrCeecQV3KvtYE8d0=;
	h=Date:From:To:Cc:Subject:From;
	b=ADHDQQwIkCfMSPmgIrmZUyNe0E3BVzx8wO/4MpKryUPcsCUoSeNr1kjmiH9gxxmJA
	 upEnShaofuS0tGFdYzwBiwxv7G/w1lTj/lF1vey7lNgonc/AhZIwTBJvpnEQlTLXUL
	 hbdZvoWiuANpODDeAv0oJLdSr4xeG6ZwvOmcp4GU0gPKYyQ8Jg/OUe9vZVtorXijH0
	 DrjRaW6v9edUoOzkBRlb6D7JeffJ1zRH9A1wU44EMqWgR32vcINWibFH6AkGceHQCt
	 u9rDiMT2sxNAQMlrso5IBBTndDglAMN9QE0XbtqLjQz+EuOo9kNSdaJOlOtmBrsYak
	 ZqHLWJ2by+9AQ==
Date: Tue, 19 Nov 2024 09:02:29 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [GIT PULL] seccomp update for v6.13-rc1
Message-ID: <202411190902.3C7A23F38@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Linus,

Please pull this seccomp update for v6.13-rc1, which will make it easier
to port arm32 to the generic entry code.

Thanks!

-Kees

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.13-rc1

for you to fetch changes up to 8cf8dfceebdaf282da8a836b2bb578808a12698c:

  seccomp: Stub for !HAVE_ARCH_SECCOMP_FILTER (2024-10-22 12:35:14 -0700)

----------------------------------------------------------------
seccomp update for v6.13-rc1

- Provide stub for !HAVE_ARCH_SECCOMP_FILTER (Linus Walleij)

----------------------------------------------------------------
Linus Walleij (1):
      seccomp: Stub for !HAVE_ARCH_SECCOMP_FILTER

 include/linux/seccomp.h | 5 +++++
 1 file changed, 5 insertions(+)

-- 
Kees Cook

