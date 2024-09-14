Return-Path: <linux-kernel+bounces-329236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E7978F03
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43AA8B22284
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CA81422DD;
	Sat, 14 Sep 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0CIpRV5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B138B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301589; cv=none; b=tMsZNPc2UR1WfMrVrzv2gUvBXvc/KhaXdHkUBuIX19HihH5IZBuyA+i544HInq6HcDE9j7yYmSB/sEIjopJ63+CWGN55oqs33HV+vM47KJwQJJtEp0hvyP3fT5ocvLGt0udNk9Tso4Tlg9KO9vy3R0eS/vRqXTmMwOjUmBVdCSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301589; c=relaxed/simple;
	bh=atOTn57tJO3Z7a94bD4V7a3Ea/wzajO80ag5dk1D11I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LIw4dYINbY66+nthisaQdJAZgjgyNRBtNq9hg6Ejdd2ZgbhDTJl96K1XpYUpSxpAnXA0GXSQLRbQZmxxhERnagsSDA7b7ShSy1jEEiBR40zts+4DNk/m/z+82lYamloOkalL+o9nhEkI9xUz4/GnEUXuzdwWxjokNJJNuR9Sn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0CIpRV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7164C4CEC0;
	Sat, 14 Sep 2024 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726301588;
	bh=atOTn57tJO3Z7a94bD4V7a3Ea/wzajO80ag5dk1D11I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n0CIpRV5xsld0qkHuFruytPdc25QvCP2b+GchUkwgd035FslwPI5EBuKgpop9utYM
	 6lSNKm0RwLJ5BwKVSGqF3s0gpCevK8E8lQQzGwui4vbWyfnDQ28kAk5Eoj/053hVE2
	 8kuE/k+UFuJ+cCR80yN9sR3I4mikvQhhLZBMB6SrpW/eDz4qZubvADUh2MKDzwoHDv
	 PwOj21M1DDORXu6LfaFFeKuL5lXWq2/IOfmHx8ulqTBNSsPYp8JM7EgLIWuOxj33Zd
	 VjI5jE+E+5O3lhDzSP+2LVJiYXHBZFK7DbNfP7+xpXPGk4t3nS7TcBF04+0pXqErm3
	 HlQRvE25ChO5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E093806655;
	Sat, 14 Sep 2024 08:13:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/8] remove size limit on XIP kernel
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172630159029.2498524.2048412782900676166.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 08:13:10 +0000
References: <cover.1717789719.git.namcao@linutronix.de>
In-Reply-To: <cover.1717789719.git.namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  7 Jun 2024 22:22:05 +0200 you wrote:
> Hi,
> 
> For XIP kernel, the writable data section is always at offset specified in
> XIP_OFFSET, which is hard-coded to 32MB.
> 
> Unfortunately, this means the read-only section (placed before the
> writable section) is restricted in size. This causes build failure if the
> kernel gets too large.
> 
> [...]

Here is the summary with links:
  - [v2,1/8] riscv: cleanup XIP_FIXUP macro
    https://git.kernel.org/riscv/c/aa3457f22f00
  - [v2,2/8] riscv: don't export va_kernel_pa_offset in vmcoreinfo for XIP kernel
    https://git.kernel.org/riscv/c/f2df5b4fdd74
  - [v2,3/8] riscv: replace misleading va_kernel_pa_offset on XIP kernel
    https://git.kernel.org/riscv/c/5cf089672119
  - [v2,4/8] riscv: drop the use of XIP_OFFSET in XIP_FIXUP_OFFSET
    https://git.kernel.org/riscv/c/e4eac34feda4
  - [v2,5/8] riscv: drop the use of XIP_OFFSET in XIP_FIXUP_FLASH_OFFSET
    https://git.kernel.org/riscv/c/23311f57ee13
  - [v2,6/8] riscv: drop the use of XIP_OFFSET in kernel_mapping_va_to_pa()
    https://git.kernel.org/riscv/c/75fdf791dff0
  - [v2,7/8] riscv: drop the use of XIP_OFFSET in create_kernel_page_table()
    https://git.kernel.org/riscv/c/a7cfb999433a
  - [v2,8/8] riscv: remove limit on the size of read-only section for XIP kernel
    https://git.kernel.org/riscv/c/b635a84bde6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



