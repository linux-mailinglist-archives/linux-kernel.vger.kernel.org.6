Return-Path: <linux-kernel+bounces-385499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA6D9B37F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746C91F227DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96201E0E01;
	Mon, 28 Oct 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLehbrUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94C1E0B93
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137231; cv=none; b=FbCYjj+cVto7mtANHZ8CVhEbOn2Q6Sj29PrLmzMAXXeZmtMmWPhdjgkOILiCt4idIkoNhGAeGXuLBY16A1uFYVgDBZppoLg1kOIObYdzHH+biCANTgOvsXaACMRZs7zVY7nTTJW9hOEW0hSCM9EI0IPLgWBM9rZSV9gmVJri3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137231; c=relaxed/simple;
	bh=jbD4kB2lny49lkRI36bb9+2SD3KFP/t23sZnoMVzfUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gg7d4R0Xzfj3BE1PaHnJkCepn0kP3gMqtLInf6CZVD/rSObCw5hi1AW0zzrKqCIwIjXThnSyQnhkYtgF5zZpET/m97lQ1uxMcXLZzBCZo+uMbC85k3kkxWtWaaf8uVJIc6afQlYoZjlAla/KyjQb5dq8QHdwEylXTHiEOqA6XDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLehbrUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79148C4CEEB;
	Mon, 28 Oct 2024 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137230;
	bh=jbD4kB2lny49lkRI36bb9+2SD3KFP/t23sZnoMVzfUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WLehbrUe0YqtilgTOIPZpghc25nUgpurmNrxelnT63js+josYYPVb+VSgS36IiK+e
	 hQSLTvCvpdcd6a6m8xWLQW5HrLZ8IDTnwhvLyOj3El1KGJCxzzbO+1BCmPIUkhDF6s
	 rQNfkqd1VopVfpV9EpQ81M3aQhsM5S/9ckkkHMLINF38aaIp5IIBWs6ATOrRf+ugIR
	 McQpLeseRsSQPBVs0w+psZ9KTVR2eyuSUWjGLr+40l8w32AN+NQqD6Wb8YUwAOym3v
	 Dqd6z/+5YE7mTH0qdTFsQNNi26Xjy8gxVyXaJa3WR7zjSh0pvv2CbW2EfwoA2RC0pP
	 gW4pysviKaKLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC1380AC1C;
	Mon, 28 Oct 2024 17:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: multidevice: add stats in debugfs
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013723774.126843.10015173129385559237.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:37 +0000
References: <20241016082420.610844-1-chao@kernel.org>
In-Reply-To: <20241016082420.610844-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 16 Oct 2024 16:24:20 +0800 you wrote:
> This patch adds per-device stats in debugfs, the examples
> are as below:
> 
> mkfs.f2fs -f -c /dev/vdc /dev/vdb
> mount /dev/vdb /mnt/f2fs/
> cat /sys/kernel/debug/f2fs/status
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: multidevice: add stats in debugfs
    https://git.kernel.org/jaegeuk/f2fs/c/4d11e609f4c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



