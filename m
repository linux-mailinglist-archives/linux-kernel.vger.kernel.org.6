Return-Path: <linux-kernel+bounces-564575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38977A657A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACC83AAE9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41711953BB;
	Mon, 17 Mar 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QisJ52rf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E88974BE1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227779; cv=none; b=pBN4Cq4lubs+mvEVZPuJTQrwLcWi/BBhQoQ3T61/9//timktpAnpAgeIk2Ekgouwb6avK5a66F79STjwEH8zko4dgOiwYIL9UFrHE1YD99KUABDzfLWoHdb5KTijYAZ0JTZ7eG58F6p4n19ljnMdj0G+QkwsgCrMQVWenE+HqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227779; c=relaxed/simple;
	bh=2bfdXwnE6vaJ3D0copjw16cxVhNowa7WLH1I53nqz5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i0AWwn24+M64GhLvGIloTvpqP5LyEAgAEV9ukWr6lnVXonK4QI7EqZmIjRo3wcC43vQ8Q3FrggXMfEkiEtyuO4+V/OdnlkSWSnGWUnoL3yyZ1siiRYRcnNAwA+fklo5YWYK2kVTie0/znhld5JIkb4EGJpVH59URFscowK0rb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QisJ52rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D21BC4CEE3;
	Mon, 17 Mar 2025 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227778;
	bh=2bfdXwnE6vaJ3D0copjw16cxVhNowa7WLH1I53nqz5Q=;
	h=Date:From:To:Cc:Subject:From;
	b=QisJ52rfR03FpTG9gWaqF2ClWfLsnw0Rl/zPkXhEWPv7WlDsJz+x3vcATj1Bojtf2
	 dpb8wwlRmh46dzIUWy1oImewIW1BO+l4us/9cTnT/Bvi1JPQPyXVW967mJ6jP1tKrp
	 wJDALUzcHPGHCkGBV7gnxiJscW8kt0fgYbUNCJ450sIHcv8zp1HAp4Y3M0UU31FGfV
	 g09qjFK2OAaCOvrQaD+znyZxfPemfefsyHHHVLcxFDCK52TOjbwTBBaT9wiW+68dc5
	 RoQ4qL9AHL6LZezrTda0OShvd0QChkSu0xmsUphbHi7CVokYQLHc3YyFaUQ26RZPUI
	 k3mtncWcdovzQ==
Date: Mon, 17 Mar 2025 09:09:34 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [GIT PULL] seccomp updates for v6.15-rc1
Message-ID: <202503170909.7FBAC1E@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these seccomp updates for v6.15-rc1.

Thanks!

-Kees

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.15-rc1

for you to fetch changes up to 8f19331384e6ca816f5bea20ab45c4b72a5cd05f:

  seccomp: avoid the lock trip seccomp_filter_release in common case (2025-02-24 11:17:10 -0800)

----------------------------------------------------------------
seccomp updates for v6.15-rc1

- avoid the lock trip seccomp_filter_release in common case (Mateusz Guzik)

- remove unused 'sd' argument through-out (Oleg Nesterov)

- selftests/seccomp: Add hard-coded __NR_uretprobe for x86_64

----------------------------------------------------------------
Kees Cook (1):
      selftests/seccomp: Add hard-coded __NR_uretprobe for x86_64

Mateusz Guzik (1):
      seccomp: avoid the lock trip seccomp_filter_release in common case

Oleg Nesterov (4):
      seccomp/mips: change syscall_trace_enter() to use secure_computing()
      seccomp: fix the __secure_computing() stub for !HAVE_ARCH_SECCOMP_FILTER
      seccomp: remove the 'sd' argument from __secure_computing()
      seccomp: remove the 'sd' argument from __seccomp_filter()

 arch/mips/kernel/ptrace.c                     | 20 ++---------
 arch/powerpc/kernel/ptrace/ptrace.c           |  2 +-
 include/linux/seccomp.h                       | 12 +++----
 kernel/entry/common.c                         |  2 +-
 kernel/seccomp.c                              | 49 ++++++++++++++++-----------
 tools/testing/selftests/seccomp/seccomp_bpf.c |  6 ++++
 6 files changed, 43 insertions(+), 48 deletions(-)

-- 
Kees Cook

