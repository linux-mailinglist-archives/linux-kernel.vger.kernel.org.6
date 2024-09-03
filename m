Return-Path: <linux-kernel+bounces-313570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B75596A722
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9241C212C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CF51D5CDE;
	Tue,  3 Sep 2024 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2OB85uy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B81D5CCA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390633; cv=none; b=C7domAIoWi3ujwOlKB5vtOPMGn91OYohKIjT97XFMUn93r2QxQZ9/gMsz5PVFWkVe0Zw00utvlJKaeUdIeR8QPu4OZ2CyWKlWOmVd06jg/VJjZDJc1skxDlnZX+1MuunZPtuCk8sN1pt0dHkHxuvAV2eOyVZrzFdwfbEqazcyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390633; c=relaxed/simple;
	bh=bi02hKY9TT2lgBGhRmTMgwKwEPLQd/+wT7G/ZLU/UDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A3NVyY6WFVmsVhyKxf2R7Fgg7EVdqwhEs9xAZZiPeJsfcbGXAljdY7HPzROXhx18kUJPGyeUtR362JwT7rU4TjkKrN+ztDZRu4XTUeVPBkL9VwcUMI+XU8UdVghRwzGqKRDntkULk4feLwJmyJUAP2eem4u8jGu5LGcvoB/vHTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2OB85uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03834C4CEC5;
	Tue,  3 Sep 2024 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390633;
	bh=bi02hKY9TT2lgBGhRmTMgwKwEPLQd/+wT7G/ZLU/UDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m2OB85uy3/ByOiuTgWLvMWJg9SQVFnrfC+BBdRug0UlmmL/Nsb2LamUihzVtmAwmd
	 51YRQth7CM1M/Gk/MEJrqUuwTA2TyrMnB98MvdxSIjpgVJfK4E8ciGxL/DqrvBeE6q
	 VC4eihS0HvI8viVkQBsuBWk+qNHbCwePm8AGNFhcvPd8J0QeEgyWg3VpRv0d3vcsxw
	 QFAx719cV1OZLbErNUTA/lHH8Yg1gRMOwuknz32BD/FqOOlQAPl1FiGhdUr19Y3k8w
	 UDd+9TT558wlHtSgEKnQy1PeYx4/MkRNJlW2z/tqIj598YhCA7EDURvJlUYAeLGbr0
	 EUcm59Fq2kIAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB95C3822D69;
	Tue,  3 Sep 2024 19:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v2] riscv: Fix RISCV_ALTERNATIVE_EARLY
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172539063376.409367.11331685769005840751.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 19:10:33 +0000
References: <20240829165048.49756-1-alexghiti@rivosinc.com>
In-Reply-To: <20240829165048.49756-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
 heiko@sntech.de, philipp.tomsich@vrull.eu, linux-kernel@vger.kernel.org,
 conor.dooley@microchip.com,
 syzbot+cfbcb82adf6d7279fd35@syzkaller.appspotmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 29 Aug 2024 18:50:48 +0200 you wrote:
> RISCV_ALTERNATIVE_EARLY will issue sbi_ecall() very early in the boot
> process, before the first memory mapping is setup so we can't have any
> instrumentation happening here.
> 
> In addition, when the kernel is relocatable, we must also not issue any
> relocation this early since they would have been patched virtually only.
> 
> [...]

Here is the summary with links:
  - [-fixes,v2] riscv: Fix RISCV_ALTERNATIVE_EARLY
    https://git.kernel.org/riscv/c/1ff95eb2bebd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



