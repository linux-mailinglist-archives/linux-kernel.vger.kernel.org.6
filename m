Return-Path: <linux-kernel+bounces-329237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC9D978F04
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E0F2827B9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC92146D57;
	Sat, 14 Sep 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgpTdH3l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9F146013
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301590; cv=none; b=ZJkAp7fGx0zxxdTCBWHAbEWUuqd6TPjj4ZYm5yw8iznh6yrpwb2Rsc9kmamnx+KT7hqNv6l/Xwv/lxb3wl6dXX6YRlrqrp2GIWnsxMb/c31C+lfy4TVnytOg4i9n1lbG993mMVh6RJlmTl2FtbQaCbBN4olSrxh6uKilsJqxkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301590; c=relaxed/simple;
	bh=/2SevD51AcV5pVbvRLnt56xDTvHbzz40ZtLBxX4HJQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mPVwcD+Y+cAU81SFypoE3QKk0hyEYg6sAgQQGUjOiCnPO25LDktmEO1yKqYn6E2HnZbP11c9iMV97OAvTPnZNbkm9+lY10RzOlYmSqkI2jdgNBTmzyjMN1rg0M0+uJDgWzd3cubMTay76G5SBKoQfb9M3OAfjFUl2+8+L2pU+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgpTdH3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E34C4CEC0;
	Sat, 14 Sep 2024 08:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726301590;
	bh=/2SevD51AcV5pVbvRLnt56xDTvHbzz40ZtLBxX4HJQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GgpTdH3l75heIogZDa3tqbkaBULKvauLr8695+GhRAaE8oGLVk6GRi6NvGDfTyrBs
	 ZGMJLu5jB3XBys1IUGSC3RAcLwEQOcp6rwJs+c3c4i4PS+WkCjy9yB9fiD5NkHsd8z
	 900xT8f0d0pDfdh5XLcn+HeUTrJXLG/ReFpt2gabul7S2A3T06nmHJRoBww+LeZovn
	 rghF+p+35Wu4TbZueHtcCVCQT9oLKz3i31ozKLVL8PR1pyRTnXhyUQoI3tV2if3DUt
	 +89/Cx49Hj0quN6ouVWPqjenDe90njlwhuU2kxqG9gZEJ7FU/qH00pAr6fL0oZ0pRW
	 dqIf/aJ937mtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2E73806655;
	Sat, 14 Sep 2024 08:13:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv: Add missing licenses
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172630159149.2498524.12159135435898265005.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 08:13:11 +0000
References: <20240729-riscv_fence_license-v1-0-7d5648069640@rivosinc.com>
In-Reply-To: <20240729-riscv_fence_license-v1-0-7d5648069640@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 29 Jul 2024 14:00:01 -0700 you wrote:
> I was poking around some files and noticed that vmalloc.h and fence.h
> were missing licenses. This series simply adds in those licenses.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Charlie Jenkins (2):
>       riscv: Add license to fence.h
>       riscv: Add license to vmalloc.h
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: Add license to fence.h
    https://git.kernel.org/riscv/c/097c72e1f2b5
  - [2/2] riscv: Add license to vmalloc.h
    https://git.kernel.org/riscv/c/4ffc8a342298

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



