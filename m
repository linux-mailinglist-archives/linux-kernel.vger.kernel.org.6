Return-Path: <linux-kernel+bounces-380480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A229AEF3C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736811F21100
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8061D3195;
	Thu, 24 Oct 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL9Lffux"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD92003DC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793431; cv=none; b=h8iM6/Ig9Sdl9GSktVduwRRW2SLu/nd71Kql+0gJd4BHVGQsYvgn77n7ULp8cGlMxIIAB/A2FvsyknqnqoOj4+VYAH5AcFVQtS0Pi5B0TG+G/3rcgCbrZbtc9XKlfKM7VrEif9ebN0dEObYTWpZOt4FmtN+tjicEd+MQCK2EZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793431; c=relaxed/simple;
	bh=w4fySPJv5uZgQTL4WgE6qIKYoEG3b2iK1oDC1gKHTKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vpzye3DIPx3dvCy58Q0rI/DR7VzuReGKQD+mWA5E5wtqdad1SniEzY88BbZsU0KSkikseZOlrCuZ6uYFoXalciCbZAPPOcKKWXg4N3VUBYlXbmV459AeMQtK8EcUx5bzaGUi3gEnEPC/16Q62oDMDm6WspoijMlo0klk8ZQ8Xr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL9Lffux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51998C4CEE3;
	Thu, 24 Oct 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729793431;
	bh=w4fySPJv5uZgQTL4WgE6qIKYoEG3b2iK1oDC1gKHTKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vL9Lffux6p9r7X+GSwc51QMR8ZLde4iL2RgiyjnsMLWOCsGDRa+CWu5n84RpRgRg+
	 n4KdiWLuw3RYPwogHSYon8iLAFtPTtPP5/lr52hJXKJLHeoSbYGvoes2mWpkT8AATD
	 6kkinmgyx3ulWdb21xlVGKx2i6B/YBkB/BCLiNY05jeHpTQ53WprWJnfn7sgBzjV4z
	 dens357CWvEzLpnwsTTXx3th8Pu5wH5Z95b5vapFG3/VmpQs4s7F6eMxoru5SQrkBd
	 iBpL/alUxJi6oZVsiIglkB6rRWU4gmWUC5fbFXTUjNeVP2D9oMF7r4lTccqUe7E8Lo
	 XG0M193/rrbjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD8380DBDC;
	Thu, 24 Oct 2024 18:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Remove unused GENERATING_ASM_OFFSETS
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172979343775.2335128.952260572481503482.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 18:10:37 +0000
References: <20240816101912.1049329-1-zhangchunyan@iscas.ac.cn>
In-Reply-To: <20240816101912.1049329-1-zhangchunyan@iscas.ac.cn>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 zhang.lyra@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 16 Aug 2024 18:19:12 +0800 you wrote:
> The macro is not used in the current version of kernel, it looks like
> can be removed to avoid a build warning:
> 
> ../arch/riscv/kernel/asm-offsets.c: At top level:
> ../arch/riscv/kernel/asm-offsets.c:7: warning: macro "GENERATING_ASM_OFFSETS" is not used [-Wunused-macros]
>     7 | #define GENERATING_ASM_OFFSETS
> 
> [...]

Here is the summary with links:
  - riscv: Remove unused GENERATING_ASM_OFFSETS
    https://git.kernel.org/riscv/c/cb873b28bc2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



