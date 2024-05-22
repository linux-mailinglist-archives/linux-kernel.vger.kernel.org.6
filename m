Return-Path: <linux-kernel+bounces-186841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ACF8CC9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E283A1C21269
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB81514D456;
	Wed, 22 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gdnzibck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96C146D4D
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421908; cv=none; b=siybXCgFW0+7nijls1pp+RWkyBFvwakarwCdaQoignREKDQXZ8WGa4PgPQz9olqHAVcXeCJUjGE6DLen6mnjYKabuJ3/GtzJzeTSnFRAUiExbXwv6f5dzDEHjE9S0KZy9E/OowtGqSy2zw1OrDnEGjRLTWxxG6J06aLhMPp1fqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421908; c=relaxed/simple;
	bh=Wz6FwdvgNhDesiVH6dQghRM42TWv9+GR59lUb5hn/E4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X9zSqQl5jirqf1B617yfJwtdrJA3mcdEBCWtJWMeCgg2x1xHTq0RBh39kiU1w2U06jZcGmTy8JTUFO/RlaR6bg4c+XLnEtMibokhSrf024guaF/5fCZjMShob6lr7DSjqgtMdOd/EEhiqNdIqhQXKa5hzjOtaM7wwxy2UljFfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gdnzibck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AF56C3277B;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716421907;
	bh=Wz6FwdvgNhDesiVH6dQghRM42TWv9+GR59lUb5hn/E4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gdnzibckaz5cwwTCArZbF5NHieAhZNuBW55C4Js2e7xiejIwL1qDzPUSCJRA4neAJ
	 R08Kl7qzp/aMwumDYHWADsnV8sFbMKL2utt/IIN9SvaZBQUDDzAuJZJifx1iMAa7lb
	 OTyv2Mq5oKDHRbPaEru6GeIswqmkq+AY/hSGT260paQ6aCExrNfGryanLlU6WpMXRm
	 pEiU5H76wmMz/sSi2UBS6xN0g/vNjklDR8ZLGCNfniWGvLWVnHUOrfbkY0bxQQSB3b
	 W7IAGQzqvYTYLyZ6fnCfqo0rx3QvB4ROYjNYfvIZF31Pzf7bAfou3CRVq98rsM9p2d
	 ced3spMHDRqmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 837C7C43618;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
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
 <171642190753.9409.11050201174881713187.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:51:47 +0000
References: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
In-Reply-To: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (for-next)
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



