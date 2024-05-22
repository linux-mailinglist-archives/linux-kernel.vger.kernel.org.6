Return-Path: <linux-kernel+bounces-186819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDD68CC9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF891F222DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765114D70B;
	Wed, 22 May 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX2P1k1P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B4824B1
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420743; cv=none; b=Tqlj2UIw9UK8eQpmeztzCf4gZ+XaaaZgcYsNZQULZR9fLANndkySJwn0aYQDmfj8ztDAyHANuIDRSU8BitCx1DDtrDhPG0Z/YnCcDvM3S2TyulqWdW8b+Dt0/JOBcO3zFXh+21C8R5benBTrHWB1LPIxgdiAltQKqKXXIReClO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420743; c=relaxed/simple;
	bh=dk9pVUnyAXEkAZ3CS3QWH3/LfWwm2NEOko5OfoNSiqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WVSVL+w+h4GVj5BGo1ybHbjFRS3xaDaEHWuRTQlC7mJSMgon7DQTLfuvr0RbWN1rHJhnW3C43x1RHNRxyqbYXWx97X763thePX3jSoJVMD9pybbnsNAp47Ef7U/JRbpzRzZl4wb2w8GMjEykJnvcabZTVb8zuLeCNiPXDFQSsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX2P1k1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 912A8C32781;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716420743;
	bh=dk9pVUnyAXEkAZ3CS3QWH3/LfWwm2NEOko5OfoNSiqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gX2P1k1Pt7ouqmvIokRlYaaKhrLTzlp5byzhP8JFki7MIS/WW6fAeKLc6Kte/q5Ur
	 EBvlEIEqRyZmCj8USgKhZBF/G/RcUkNVumFTp2KFzao2Vr79mjCNbcTugUhOMpzvuj
	 gujUZv17sahQDPdcOOxx4nw/VsLaU8VgRPcRIynyffaMgrt+KnB6yjA0DIMx/KPFBo
	 ChFViNFrLRsHpmFn2zo32YEVBa9JbeMKS06Xlf/5ku7aQCUgHnM02/WNxicJx/OOVg
	 G892RztcXP3LYCInz+DMGWOAhPCG/H2FvKWnhXh5HsSIitkjwmlkAAzieGZFm741dK
	 5Gs9XwpVJT6Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84E9EC43618;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.10 Merge Window, Part 1
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642074353.9409.8682770780548365463.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:32:23 +0000
References: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
In-Reply-To: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Wed, 22 May 2024 09:13:28 -0700 (PDT) you wrote:
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-mw1
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.10 Merge Window, Part 1
    https://git.kernel.org/riscv/c/0bfbc914d943

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



