Return-Path: <linux-kernel+bounces-331722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057A397B077
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C54AB269DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611218732F;
	Tue, 17 Sep 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQHiXsXt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C591865E7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578048; cv=none; b=eMEyImbc4518FU25XHH4AebA52CbTMXNe4Mw5B1tSlO/Wh7TDedDFI+5wllWLfsLMSaEfZt5D6CGJvCp5iAhXKTiGo5i9UM1mPKrufuCEpGHd5iojzTHeVKKjWrUWR3IhxsSc9WukaKeRl1iHa7c2yTsX4J4e8R3fzyZ9hMkD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578048; c=relaxed/simple;
	bh=13+lBwvxPVO2YzZgD8MFY652lnuH8q/bLmJzRCKZ9O8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pDLBBykitK6fKFadHyvDlCK3o4sxz64W6JPpK1ONO4iPKzkAYFua3MFFhCJjexFFhqi42lWVgQU9feuUNEt0zvmHg8AE18b1gH4lHFoC8ISMYn2mMdbrSK/wQHYnub174lj8cY54qE6hlm1uL1A3ubk9Wq0o5SNqajNSdKHYP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQHiXsXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1288DC4CECE;
	Tue, 17 Sep 2024 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726578048;
	bh=13+lBwvxPVO2YzZgD8MFY652lnuH8q/bLmJzRCKZ9O8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XQHiXsXtGWTaeXInAeOBHbvavc1cGKZL8PxRsDiJXoyOcQ4BAPz3aUYJkY7DdkJcB
	 sVyqrHuZ1mGoL9MY9+NkQHyCiGW2h5YvyB4ujx9/Uqr/9RrWsq35i285z1OOc7t1MI
	 hrVYNsOGGulFvYqKPhcGaFAWitTtS9qJkwG1HJYqHAgDLzikOR6OXVDTujuKV90rgX
	 +EgvXqcuB4K6MS7ihtbyOp/rkL4eaoGRLFaR3bZAXOku4PPMyftACJKHhEkFdt0oCa
	 a/3VnVZk8xhYLtE74unnmsBrVegXOfaFQyi+qCqNXMyytnCgmr6sRoVgtjWypWX6Dm
	 KW5/gizybVdaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD083809A80;
	Tue, 17 Sep 2024 13:00:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Remove unused _TIF_WORK_MASK
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172657804950.126252.10342609864354079162.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 13:00:49 +0000
References: <20240711111508.1373322-1-ruanjinjie@huawei.com>
In-Reply-To: <20240711111508.1373322-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, samitolvanen@google.com,
 debug@rivosinc.com, andy.chiu@sifive.com, guoren@kernel.org,
 songshuaishuai@tinylab.org, bjorn@rivosinc.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 11 Jul 2024 19:15:08 +0800 you wrote:
> Since commit f0bddf50586d ("riscv: entry: Convert to generic entry"),
> _TIF_WORK_MASK is no longer used, so remove it.
> 
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/include/asm/thread_info.h | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - riscv: Remove unused _TIF_WORK_MASK
    https://git.kernel.org/riscv/c/cea9d27705d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



