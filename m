Return-Path: <linux-kernel+bounces-184190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0C8CA3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074451F21EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5B7139D05;
	Mon, 20 May 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2WQhm58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD017BA0
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239807; cv=none; b=nJPfOWnNFc/8breG81VaXqW06t6cpu2cLPrpyGI+5l6KMWJuiIox/vq30bsjpnQlr7YGVF/2QKLkHfOx9tXYaapw4Z/JYtxh+MaLgzBRhJNO9WyEFSQ2CbbHi9+4h7ixBht23EejQ0Wqy4E5rXeFOqoogg7nKrB+UN+iTOwOxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239807; c=relaxed/simple;
	bh=54hX8vPKop6i3pWXoGxSp4JmH6Mg6jeOTgisbEHYQv0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IHnhUfEGNFDutrfn7SgKiTz+wcB10dFBJ7vgfU5WbbtmBF/Zo+8gEGKpAQ7qj9XypwHkOOhpSeyF5FiIxLqVszk0+Rn+vY7el4AZCBuNPbJFRP3pTBmqvCyj+k1WEGlGHQvEBrt06YXVeehm4XpAuqnKmGotn3oFywtnRT6+qtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2WQhm58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D011C4AF08;
	Mon, 20 May 2024 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716239806;
	bh=54hX8vPKop6i3pWXoGxSp4JmH6Mg6jeOTgisbEHYQv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E2WQhm58AqzZrWAiYKpT2/mhODonm7UeUACZ8sSVJYNiGsup+CqrZOEVgGVovEP5b
	 B9+ls2rrS5gMnHfgg9mkBJY2HQOABVY5q6CExoV76M6xKg+P/7U6Llgrj1pneea9JT
	 c2flWpduB8Om8QQQkw9XzCvvnjN4x8/+FTeMuwqN4HmfIQ9O3bpnd0hUFLxguKy9RI
	 2Kp+mlLEZ9xMhMUggGmZyjrdJkZUkGDtdljdIvDcG0W0rl/Wtej4agGN5B7Qu9tFYU
	 EIGW1k5wET4jWwLwMJe+l6cleneB0Il/C7vpyH1+av1Cx2iUx/cntUIWaBrMo+TabI
	 k3JgSD9ioZdiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7029FC54BD4;
	Mon, 20 May 2024 21:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.10-rc1
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171623980645.27511.8619360433381265549.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 21:16:46 +0000
References: <ZkumXs7POGImbr-k@google.com>
In-Reply-To: <ZkumXs7POGImbr-k@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 20 May 2024 19:37:02 +0000 you wrote:
> Hi Linus,
> 
> Could you please consider this pull reuqest?
> 
> Thanks,
> 
> The following changes since commit 928a87efa42302a23bb9554be081a28058495f22:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.10-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/72ece20127a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



