Return-Path: <linux-kernel+bounces-176332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C98C2E30
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8FF1C21106
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AFF1643D;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaItr4cV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30911D2F0
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=fMa5e4BYy69Xu/26TJa/EVFzFV2T0wHVkmY+GSK0fjJCazgf/Q2gmXoV/Fl8jYtWCBx+P7E+uQM6V/yxnJDXebzRbyoKgkB3u43R959XtYGgJUB11lDWw0hhkDPNw65uayXKh4GTVARKzqJ8S0ecAPQ0eB+lyl4lnVYypvgn4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=8Yop3smxewSROz7DAHuqzNJwUb8FvXPb5lUi3OGSIu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Al4tqT/CJfPWD/0Qq86bCrMJALJLE6eZmNj+B9jvrtVRwM+NSUELAaM8LIdFg/1YzCK+53vb7NnJRwAggOTpsVkNZpuCeRFRF+9tN2M/02IBLbCR7pEG6kUyvPcnnMqWSiUQVT04aVSNLz5f7Fgn7nRUtDzoOEoMV3HADF3ELE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaItr4cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8EFDC32782;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388633;
	bh=8Yop3smxewSROz7DAHuqzNJwUb8FvXPb5lUi3OGSIu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qaItr4cVfJp6WlyqcwFaD0BnCkFTkgScfqQp8CaRtpcdAH/29//J/LyJVc/LX6+gZ
	 8IYtMVrqHFD+0MzUesF/5gRTpk/MyUQuOlHEg/6/k7J5exaoei8DMsLEkZ2TqP7F++
	 RfahxO49CNmWumvP+23GlopBn7G8iXs1n4rBECKxj4UMKgNkrAdik+oiCFJEPjetf3
	 Npp7L4AbtTq5In0XDieCtlngZ12hSYp4Ji2tfWgsRkEQVAYHmLNW/skz0Rj8yYxpip
	 u2HfRMpLPh8Nm9VThxVNDpWxbdRXU/tsHrC8vuxxn7WzER+GpT1oUsTfiyi6vxufVq
	 yFwin0Vhp27bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBE27C54BA2;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: use f2fs_{err,
 info}_ratelimited() for cleanup
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863376.11229.7632095101337485351.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240506104742.778789-1-chao@kernel.org>
In-Reply-To: <20240506104742.778789-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  6 May 2024 18:47:42 +0800 you wrote:
> Commit b1c9d3f833ba ("f2fs: support printk_ratelimited() in f2fs_printk()")
> missed some cases, cover all remains for cleanup.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 54 +++++++++++++++++++++-------------------------
>  fs/f2fs/segment.c  |  5 ++---
>  2 files changed, 26 insertions(+), 33 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: use f2fs_{err, info}_ratelimited() for cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/a78118406d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



