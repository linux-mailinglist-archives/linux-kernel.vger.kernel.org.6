Return-Path: <linux-kernel+bounces-331919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8397B2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B241F23224
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBF0186E51;
	Tue, 17 Sep 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgyNJbBc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2017D377
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590632; cv=none; b=C4eR/UZNVmHoKc5XbasVaBkL2taIwFzAy8cehFUyi4p5tAMQmsYDK/y8iM6rygu4BOdRxNLyyBK5V3fIkjSTJNP/WajkHBM09lsXP92d0JXDyFeKEqHlNDjpOTVfaYREjg+r+KuejFm3pW6TWT17kEgqCpvZmBxpxXVakxxmulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590632; c=relaxed/simple;
	bh=Qp1EeX8xGUd5kQiQXNESKgJ0EV0UH4Y/iy7zxMn1Lvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tgwsNCqBkQ4NGxSgRHdfBp1A7GS8ucM3kJ7YrVuINd6xNEvfQWr7YLkcMkWa776VfiHtalwITCgmdr3harjU/O8+qgVxhw00OyDjfF8rgnoKKKg87bRa9bjuFG0+f0SpvIPhuYaTdfj7bf1MRflWLOllXmkoa1ZJpFIeZb2MWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgyNJbBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161B3C4CEC5;
	Tue, 17 Sep 2024 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726590630;
	bh=Qp1EeX8xGUd5kQiQXNESKgJ0EV0UH4Y/iy7zxMn1Lvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TgyNJbBcw2xzv5RloeoYcrEkX6Whx/GkckMJuCATs3ROis2LX0WZ81THmXk13YR7T
	 whRNNBfxHCq6MLvpgl/5cUBsWCf/NPcPbQQcE90hj521BJLZNqXpmmyzz8xb7sGo4I
	 zBRkhZpdB/ZTIpivUhNz4aR/ErqdSUpo+xH0xnDea8KeZzz+U5Tqjc8XN60AOxfrfB
	 KwOBoV6b6pKrGVP1bx+J4OEIEALrVfLUSHVzCe97LUeiZ0lVQ4ROn6Z3tG6tIPhzyW
	 1fPEoIU+a3gamopndP1zJEM/eZ1VPsq5RM1QhBq3554uXUwwLUJwHurOjl54XqPjwH
	 E8yoj1Klm5K+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBBAE3809A80;
	Tue, 17 Sep 2024 16:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Make riscv_isa_vendor_ext_andes array static
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172659063180.214459.6745282493523135362.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 16:30:31 +0000
References: <20240807-make_andes_static-v1-1-b64bf4c3d941@rivosinc.com>
In-Reply-To: <20240807-make_andes_static-v1-1-b64bf4c3d941@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 lkp@intel.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 07 Aug 2024 17:27:42 -0700 you wrote:
> Since this array is only used in this file, it should be static.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407241530.ej5SVgX1-lkp@intel.com/
> ---
>  arch/riscv/kernel/vendor_extensions/andes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - riscv: Make riscv_isa_vendor_ext_andes array static
    https://git.kernel.org/riscv/c/594ffcf4efe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



