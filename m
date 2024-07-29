Return-Path: <linux-kernel+bounces-266127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876BB93FB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833E21C219A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251B186E36;
	Mon, 29 Jul 2024 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSj2CWn+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770E1553A2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271180; cv=none; b=sBqbtb2hcjrJ18XRBQ+q4IVUXuh/O7uKuaLNzvn1s4BpfcHyA9wht4L6na5SWPw7nBKJ90xTYh/ZUSvirL5cslhvx21mJ0KkFqlqZW1SuQXfHeii+jfeAJjm6HhTZLOmE6O+HjEzkfpdL+1ZagTPkZ2TIH4XBlkp9iKFZ6DmGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271180; c=relaxed/simple;
	bh=m90q8tD1m4s7iECDYk9EUq95K3zb56APHXrZaj71gMc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O9t50I4nnyL9wFF/GpgKRGBMyOivcp3bGcHwDytJTgrGGafKnUbjRjTWwXXAWmkLsPphcziagvGKlD/fEvdCVEG5O1tQOLPhx/GcAmlY0nv8Xu84bEeiJoURyimhGfKoVxzkOpToIvxRrVMPWMiUB+9FkePaGg0h0qyV3CfPhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSj2CWn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA6D3C4AF09;
	Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722271179;
	bh=m90q8tD1m4s7iECDYk9EUq95K3zb56APHXrZaj71gMc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rSj2CWn+vMWoodkNt86xJEMMXGGky5NUYZaRGcazMUnSyTSMXrjTvqOG9NbQjtzti
	 m+/rYibOABDs37AHkzaS+0753kwsOsyGxoEbkmJ0C/F+hZtZ7VoqQ6zfgyAP+Lc/yA
	 i4p/IUQtFoZvCap4pMydSOVcRN9VF0JxKwgM8vVpDhK8wqWEjbJdgmCZx5/6fxllpK
	 RDjtZ4rwnDVqcT3SETiTSPVgMWIpkFKaGbdv5qKz0pYLFiinGL+HKiViyW4YTx9POV
	 12jgw0utzjJmn2gmTBlmm4nSFSY/JmK8lttp/ZruMbjtZdNOoi7LHKQto7mvrka2qI
	 eB7pckuWcYZjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0D97C43445;
	Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.11 Merge Window, Part 2
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172227117971.3603.11962630794224395786.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 16:39:39 +0000
References: <mhng-d1533559-79a3-401a-8eee-a743b80b3bb2@palmer-ri-x1c9>
In-Reply-To: <mhng-d1533559-79a3-401a-8eee-a743b80b3bb2@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Sat, 27 Jul 2024 06:29:14 -0700 (PDT) you wrote:
> merged tag 'riscv-for-linus-6.11-mw1'
> The following changes since commit f557af081de6b45a25e27d633b4d8d2dbc2f428e:
> 
>   Merge tag 'riscv-for-linus-6.11-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2024-07-20 09:11:27 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.11 Merge Window, Part 2
    https://git.kernel.org/riscv/c/c9f33436d85b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



