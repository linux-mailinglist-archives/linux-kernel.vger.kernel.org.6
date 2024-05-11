Return-Path: <linux-kernel+bounces-176335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B428C2E31
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8251E1C21405
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED42F168DE;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz28MCtp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F1DDA3
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=K/D9AC7rzDXbIz/xAVIIiXFimKc2T+W6seDmrWdmTTc+EvTjXx8gDPum1RgOfFM70Ah7amwAvUvKusFRWoWUnYd5EJhRBH1uuVutUY/1gfndvmK0XzGtuvVnN2x0rhS43i/CcEo+WP6mIwZSA4n5/trk90Vf40MKS2CzJJR6cyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=R5U8t8MN0hqu7l7yU22M0NMbzTpnmhHxeE8rTHlv+ew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hWiZKmubsP+L22/lXCnCUAIBGxL8JefWCoakMwJKKcLYR/y5nqECAvjEcw0HU3WC8E+1QF074vkcc4JRX2veEq4ObqIOVxYf/SZD3m7fI7XohI1Y8PZtKedETei57nuGZtZlwiotF0cHiaAi3/PYBnVFx03Lsqgz5KFbDVODK1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz28MCtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB33EC32786;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388633;
	bh=R5U8t8MN0hqu7l7yU22M0NMbzTpnmhHxeE8rTHlv+ew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gz28MCtpXPmTPfefkM4029fWb2/+g9qSGTYfkjjC1VYkUqpXnKjMP2R0EqOztr0Gw
	 a+J2ITB5JhNUrZ5kfDfQ8ICmXYR60ntCvA9W8d0jNf5Jhq88SvPk7p8vCnosmAJIVU
	 ChZUWxUyqaEVQlS1z6Wr5E7VaYkce5B5TP6yZIHpIzdfmaALyWt6nHnKBZZRJ2iAdl
	 OCd+iXfjGZnY11sM33azMkgVfW/OWRAQOyU9bJF7pFZnLCYESpH5sZJrkq0Zx7jnj0
	 XnGfZcnwdy/+s1JXYO8gFECsfsAATIjmmgFQYitgAExW2gAyXKHqfq5l5eyWyVk6aQ
	 8hMBfM39yN4Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3E03C54BA1;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove unused GC_FAILURE_PIN
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863379.11229.10303320996620120996.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240506104538.778116-1-chao@kernel.org>
In-Reply-To: <20240506104538.778116-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  6 May 2024 18:45:37 +0800 you wrote:
> After commit 3db1de0e582c ("f2fs: change the current atomic write way"),
> we removed all GC_FAILURE_ATOMIC usage, let's change i_gc_failures[]
> array to i_pin_failure for cleanup.
> 
> Meanwhile, let's define i_current_depth and i_gc_failures as union
> variable due to they won't be valid at the same time.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: remove unused GC_FAILURE_PIN
    https://git.kernel.org/jaegeuk/f2fs/c/968c4f72b23c
  - [f2fs-dev,2/2] f2fs: fix to limit gc_pin_file_threshold
    https://git.kernel.org/jaegeuk/f2fs/c/c521a6ab4ad7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



