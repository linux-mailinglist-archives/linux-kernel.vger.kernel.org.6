Return-Path: <linux-kernel+bounces-260572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D43793AB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080B5284651
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B987A219FC;
	Wed, 24 Jul 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN7AhojE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02681BF58
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787407; cv=none; b=TSGLztZKq+aDuswY8Lla8LPYzRTLaFKV/E7BTVrS7QLm/XYJrNNkKeBkTyIPpQxPov280cxBRNLcTwL068N6aDr5PLdViQJ5t377jzpS7RAvLV8kzqySFAvmyUFyukEcCzZ6eUL5xqJJNfxsnsvfoiJPH0Yctf2L32r9HX2uSQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787407; c=relaxed/simple;
	bh=RxzxknUylVUGaV6PlU26q9c37KnidmqlRfe2BEvESdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yk/QQzSIM7WqDiaoyuwqPSwO2Z2sP5fO8XKqGsw49WhqOSYuePv+KhajxJDlMQDw5146zi+3r/JedYfDymYAsSgLM0gog4O04EBaHXQa8Q9EHNsYvG1LXVKJC+A/n2XLyDafU9FWVH23fZWU6f9oPPBRoVIuWW5JMyWtNrh/nHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN7AhojE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9765CC4AF0C;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721787406;
	bh=RxzxknUylVUGaV6PlU26q9c37KnidmqlRfe2BEvESdk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nN7AhojEmCkoanDQFv6I44e7EWMFSXU1x6iMMoigKHziv9uQFHxY1no7Fn0wDkBW5
	 28Lub/kDH6FqgdW4NQtoKYr987oiobTrL+7MM5K3agoqMjgBd6QfGFIDgxKxWNK9aP
	 Fm3LYhbEqKsQz5rbEunlb8sqiHObeavPnXIvN/iK4ghtj22gmc5cFPHQ2sd4EQk1Dk
	 GHICy9UP1NghYQKLVkU0WtF+CutfmhpUB+hoPtly702cRAOK8lplGtOeoNC2pDNyu8
	 0vqBe8huosEh/4c/t5bUQt5BxAp3eRDTurmhCUdDMTONUh3GfkV1FDvsqkpvacKp4C
	 8Awq2ZOLFS1Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83118C43638;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.11-rc1
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172178740653.17759.16908087723522583018.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:16:46 +0000
References: <ZqAZZAmghKIaBAkJ@google.com>
In-Reply-To: <ZqAZZAmghKIaBAkJ@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 23 Jul 2024 20:58:12 +0000 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit 2ef5971ff345d3c000873725db555085e0131961:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.11-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/5ad7ff8738b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



