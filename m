Return-Path: <linux-kernel+bounces-370056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110B49A26AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B739A1F240D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A983B1DE4D3;
	Thu, 17 Oct 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+p4fgfg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647E1DD9AD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179253; cv=none; b=Ij7EPir9hSfkdoJqPx9OcX+f58jOcq47Rafs9QCowYd0uG+y/mtM01CuQmOsrlXvF/tZmU11HT/VqAGLuOM0enwt0BGn/PWJk1a3DzmQrb6iK0ZQfhL901hUb4BIfixu81oUGunRERuxxPeDq/RsWe58xSRd8nHwbBl5qNfYAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179253; c=relaxed/simple;
	bh=V1nvvkLpIs5sD2OFrJ2euHz95qyDMltWcmHdJi8Yxew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ecSPrmOaKtVJB2X5rmZmzZIKFsqLu3rfWYrEgwasCAmnk9++StxgBvozE9oeNyeX88NYu8BjhYDVX5Jcnpcp8gihFQbqK3iu2hI658WXh/Qnwc6PIyn7wr3C1z6tpJwGTUFaseM8flg8ZEC3v1YeXp9Y+ZKyt27QZbzkSGgyeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+p4fgfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89271C4CEC7;
	Thu, 17 Oct 2024 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179252;
	bh=V1nvvkLpIs5sD2OFrJ2euHz95qyDMltWcmHdJi8Yxew=;
	h=Date:From:To:Cc:Subject:From;
	b=N+p4fgfg8QbVlO0mXs4I+LGKT9ri0wD9wAaQMDGFTdhr0cAPRCDq2mkozxce/GB/c
	 K/4gtA7CqZsC0k2yK2dTAEj09Yrjg9Dw4n+nRGNmGtebcu6oGjOs6li1S491PwMFeU
	 uzGsbXFMXhkkcuC/yFwwGhVtSq7epmBX+CLSBCPcIcgjPW2ImzBAmxMiw7FjVX//3+
	 h2Rv1DaR/g+cuJcSYI9LGCegNm1kjJukJ+C9smPUPWuv2d1MRHYdRQ8Y44ZN6FEQFN
	 J22PE7TSSjcBqFmCzTtV5yV4/PJwDgh4wjNsfs9GY8loJHntG1pzkrCJfiDJRv7ZiM
	 td93Gj97K/QLQ==
Date: Thu, 17 Oct 2024 16:34:08 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc4
Message-ID: <20241017153407.GA22230@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull this crop of arm64 fixes for 6.12-rc4. The summary is in the
tag, but we will have some more POE fixes relating to signal delivery in
the next week or so.

Cheers,

Will

--->8

The following changes since commit 3eddb108abe3de6723cc4b77e8558ce1b3047987:

  arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386 (2024-10-04 12:38:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 7aed6a2c51ffc97a126e0ea0c270fab7af97ae18:

  kasan: Disable Software Tag-Based KASAN with GCC (2024-10-15 11:38:10 +0100)

----------------------------------------------------------------
arm64 fixes for -rc4

- Disable software tag-based KASAN when compiling with GCC, as functions
  are incorrectly instrumented leading to a crash early during boot.

- Fix pkey configuration for kernel threads when POE is enabled.

- Fix invalid memory accesses in uprobes when targetting load-literal
  instructions.

----------------------------------------------------------------
Joey Gouly (2):
      arm64: set POR_EL0 for kernel threads
      Documentation/protection-keys: add AArch64 to documentation

Mark Rutland (3):
      arm64: probes: Remove broken LDR (literal) uprobe support
      arm64: probes: Fix simulate_ldr*_literal()
      arm64: probes: Fix uprobes for big-endian kernels

Will Deacon (1):
      kasan: Disable Software Tag-Based KASAN with GCC

 Documentation/core-api/protection-keys.rst | 38 +++++++++++++++++++++++-------
 arch/arm64/include/asm/uprobes.h           |  8 +++----
 arch/arm64/kernel/probes/decode-insn.c     | 16 +++++++++----
 arch/arm64/kernel/probes/simulate-insn.c   | 18 ++++++--------
 arch/arm64/kernel/probes/uprobes.c         |  4 ++--
 arch/arm64/kernel/process.c                |  3 +++
 lib/Kconfig.kasan                          |  7 ++++--
 7 files changed, 61 insertions(+), 33 deletions(-)

