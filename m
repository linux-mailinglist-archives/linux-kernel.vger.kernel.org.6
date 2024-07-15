Return-Path: <linux-kernel+bounces-252817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC8C931869
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0760D1C20F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DA21C6B2;
	Mon, 15 Jul 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+0Qs+DN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9D200B7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060472; cv=none; b=iGZzStVtSncWWAY5y2fXg9qNDP3dVvf3kfpH9AP1PpkShyaYsZfuL3+u/s36XmX7JQ+E2axL1GX2/XIHAP+s96YAJYuP3fOV3d4jAohtJGjl/e1HW+YhGLraa0i8Rs71zj1b27y/QQ6OTJDa4W5bGR6RPIWq00eoUVz009TQStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060472; c=relaxed/simple;
	bh=WaNIu8zi/hbTQukb1lNSQ5JM/VLTjLLnZu21fPoMrwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lNgaXttjJVrTfPVAK4RSRfr83RE2L+QOqmsSuxR/GmMyuB8SgNGkosZWWeHqWJ1iqrgRBgY7//fbSpQKmFHLf0yFEWe0WO3y3vH6M1A7GAZ9xM9V9u3ddDwVKF4jWJ8XwPgkgIg1x1UfHXsUaWH0RH7Qcz7j8zI1ALM9APnR+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+0Qs+DN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E1DC4AF0A;
	Mon, 15 Jul 2024 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721060472;
	bh=WaNIu8zi/hbTQukb1lNSQ5JM/VLTjLLnZu21fPoMrwo=;
	h=Date:From:To:Cc:Subject:From;
	b=Q+0Qs+DN5Qb9KrUZxW+/LVBiXsD6+xec0v+kOX+9QHhgnYXgmDzYqgI2IdUjVTI5V
	 RAO7ZHmuZ+6f/moWqlfE452WbrprUcLmLNkqRUvwj9Ol+rgfYPUleauDjWuAsblYoa
	 QFYjA7E2eDey+0FGEUPzrOsOkyoakSB6/ZfvpEKNvkYXrsOOMTzckXHZp/PqLp6wOx
	 amve8bP7RQ4mBxo/y9ZXy09eKoPdReNo+GQS5R5F7xfgORyT/9NnRZuygjNK8pJPvT
	 0XUcCIDp6gC0afEruhrBlOWe9EWYOEMWwrM+RWBw7xBbmEHB8AfZsGeWx/vz/Grntt
	 +eKzCoz0Y6TQg==
Date: Mon, 15 Jul 2024 09:21:11 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	"H.J. Lu" <hjl.tools@gmail.com>, Kees Cook <kees@kernel.org>
Subject: [GIT PULL] execve updates for v6.11-rc1
Message-ID: <202407150921.BD2B798C6A@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve updates for v6.11-rc1.

Thanks!

-Kees

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc1

for you to fetch changes up to 21f93108306026b8066db31c24a097192c8c36c7:

  exec: Avoid pathological argc, envc, and bprm->p values (2024-07-13 21:31:58 -0700)

----------------------------------------------------------------
execve updates for v6.11-rc1

- Use value of kernel.randomize_va_space once per exec (Alexey Dobriyan)

- Honor PT_LOAD alignment for static PIE

- Make bprm->argmin only visible under CONFIG_MMU

- Add KUnit testing of bprm_stack_limits()

----------------------------------------------------------------
Alexey Dobriyan (1):
      ELF: fix kernel.randomize_va_space double read

Kees Cook (6):
      selftests/exec: Build both static and non-static load_address tests
      binfmt_elf: Calculate total_size earlier
      binfmt_elf: Honor PT_LOAD alignment for static PIE
      exec: Add KUnit test for bprm_stack_limits()
      execve: Keep bprm->argmin behind CONFIG_MMU
      exec: Avoid pathological argc, envc, and bprm->p values

 MAINTAINERS                                 |   2 +
 fs/Kconfig.binfmt                           |   8 ++
 fs/binfmt_elf.c                             |  99 ++++++++++++-------
 fs/exec.c                                   |  49 ++++++++--
 fs/exec_test.c                              | 141 ++++++++++++++++++++++++++++
 include/linux/binfmts.h                     |   2 +-
 tools/testing/selftests/exec/Makefile       |  19 ++--
 tools/testing/selftests/exec/load_address.c |  67 ++++++++++---
 8 files changed, 327 insertions(+), 60 deletions(-)
 create mode 100644 fs/exec_test.c

-- 
Kees Cook

