Return-Path: <linux-kernel+bounces-380478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90F9AEF39
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD11F1C21599
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2A1FF02F;
	Thu, 24 Oct 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNcngO4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE71D3195
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793429; cv=none; b=Cd89Cq81gMkMpGpGSZxLusJaL8uHlbfLioPW7l5KRRlKUNnUyXq/m9N/vrrwXieN6mGlO17vEX3vyngd+teJopOdLxPHwKMOIL6RJe/F4Fh1Ld+mzBwt40NUetklasjAFfg8PrLOWoUXGjHJ3jLW8KtMnQK4+t5yb7yK3zcr0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793429; c=relaxed/simple;
	bh=MWfNVrpzwXzo2CIL4VVcsh4vT0Qh9sgLfzlAUK6Aa3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jxqVD2c5WoqBjVKZXs/UnXZzHNGZ56qDatoJXHUkAVSOWrwS5cfGYweCEnqeG3qwDsYuogrcObGbjn5FmW8aFRt3cD/8qVCrfmxMYTp05wP8tyRME381QzmVBwVL+vqOf2F9Xsxy0CKRkLO7OO3ia/T6qoub+N+swz+LlFZYigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNcngO4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE1EC4CEC7;
	Thu, 24 Oct 2024 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729793428;
	bh=MWfNVrpzwXzo2CIL4VVcsh4vT0Qh9sgLfzlAUK6Aa3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tNcngO4HvjgVwaapR49Z66jJT4tR5uX4rCHxJoJN4OLFN4oRBgGThdz0962CgvSzk
	 7QKWm/3a6rQkAWvERXp819PxdU8dMgERlJpKJM4UtaCSyDdJs11WGtI2q84VjpnrdT
	 D4X80tXuXQBFhHsq4NanXy6wVGcxqAvPYllrOlAbRsoo8mQNbkiBtS1eZZ6zQxx/S3
	 SsJE2dqgY1XkdNFCA1AJxEJxyqUA9StNYa9b0Z90Q0YR6M8Mb837kk0aHhWHAb3S5i
	 XrfmIfYffZ46QXRzkhr0fkNufBSJu2ckFpAw1bv1jnfoDz6GxF2c0KuhkGtICInybL
	 m9hf0Fs04hnMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711B3380DBDC;
	Thu, 24 Oct 2024 18:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Remove duplicated GET_RM
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172979343526.2335128.9298316535095984372.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 18:10:35 +0000
References: <20240909095557.446745-1-zhangchunyan@iscas.ac.cn>
In-Reply-To: <20240909095557.446745-1-zhangchunyan@iscas.ac.cn>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org,
 alex@ghiti.fr, linux-kernel@vger.kernel.org, zhang.lyra@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  9 Sep 2024 17:55:57 +0800 you wrote:
> The macro GET_RM defined twice in this file, one can be removed.
> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>  arch/riscv/kernel/traps_misaligned.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - riscv: Remove duplicated GET_RM
    https://git.kernel.org/riscv/c/4c6b61b5d35e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



