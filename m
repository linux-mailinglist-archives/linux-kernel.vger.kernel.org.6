Return-Path: <linux-kernel+bounces-331717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F28497B071
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC70B26597
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF2D175D2A;
	Tue, 17 Sep 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEH4LxVl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99E173320
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578041; cv=none; b=HagGN5v5IX1uh7QFYvI/UFzJke/QNgxzXuFCWoVGWi77E87Z9UeotS+aOcduam3EHceYcJt8dwsoznBxNGgada3yTI9EBvBwGNhLLgyEUF4TW4Z+NRApACxMQ8jvUosOdqroJ+tQ00jm/qVUHPHIT3W/PfLXa7KW1Tz2C1NSo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578041; c=relaxed/simple;
	bh=+I6YJNqbdS6L1MKoC08v99ILu3LMq10ZIEs52n/9GwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lBXnipxuZbKm8aPoYk+7gCbAJpF6xAMgyfSVGGByvFUpf3lblV9ZL3Wjy1Ibu5oXhA2DZtzhq0m140YLy03zqsKwySnzStMerk3qGPEHkCErjVWjT2gNmK++1hK1n2Tg3GcdFpSAxhURY5m0FBwoEqa5afwzWSs6T14AUzCrJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEH4LxVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B696C4CEC5;
	Tue, 17 Sep 2024 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726578041;
	bh=+I6YJNqbdS6L1MKoC08v99ILu3LMq10ZIEs52n/9GwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jEH4LxVl1YVf01Fn16xlBk3tziXeXWCBEq9mwh7k2aCKrq6pKbYmnFkSK4yeW5+fy
	 8Kc0YYtez89HiikNsvFQP9UpbAWQdSvCdHJ6IHHNi7h3EBGpWqp7kCpdKh2x2idDtK
	 VJ9HVeS3THp3eYX1VBuaZclps8n3sEffrcOIfBYQsDUJpw2czvIfEBBB83kFyixZ6B
	 Sa57g0jmsx/BCBy3/NHIm4pWiIAREb2OcAPz+S7wkzgWsGZpAS4qS+t9qy5wo8hqKL
	 lGbLHoRFVNYr04RqodUvqOVniByJf6R4k9tYQMcFioaKMJYib8gMbziKlUNeG080Mr
	 RvXIVwNt026aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACCC3809A80;
	Tue, 17 Sep 2024 13:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers/perf: riscv: Remove redundant macro check
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172657804252.126252.6901114018072567420.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 13:00:42 +0000
References: <20240708121224.1148154-1-xiao.w.wang@intel.com>
In-Reply-To: <20240708121224.1148154-1-xiao.w.wang@intel.com>
To: Wang@codeaurora.org, Xiao W <xiao.w.wang@intel.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, atishp@atishpatra.org,
 anup@brainfault.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  8 Jul 2024 20:12:24 +0800 you wrote:
> The macro CONFIG_RISCV_PMU must have been defined when riscv_pmu.c gets
> compiled, so this patch removes the redundant check.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  drivers/perf/riscv_pmu.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - drivers/perf: riscv: Remove redundant macro check
    https://git.kernel.org/riscv/c/1e206fad765b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



