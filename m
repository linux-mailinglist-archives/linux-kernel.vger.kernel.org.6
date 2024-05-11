Return-Path: <linux-kernel+bounces-176334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BAD8C2E33
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5FF284AEC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07D9171A4;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxLOwnMY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094BD527
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=feJj3/kyWa+2s1ZmAV3/idJe3Xm1F8DgtGTwAY1htuXH4rWlam08jf3GKLmGy07z5n4ox0rURI/4xpQM8LD5MD7MpnyDqC0uWCVkpw0axQsFDWwNB2pEYC0KZBujbdiLGSwuscaeSodiVfTvkmzYKOr72m0JUV1ws17laylJrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=UURFY8r6IzMFK8eicn2U3n+2WWbClvjMqKKMxWH0TDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CrTgFSOLBnQrOmNLh5Yp2AT4XPE2VwkhC7EidvdmAZy0pEdm6h+sj0hs9NHzJcrTtvtXn3/N8JkdfnRUS2yukQdAQZbqnwZLkt72pfH7Z4LXzSyKVlWaspVSEsDKSfMvYzmZeDc+ASTXkJcUK5nre3upaP+LYuWE4lktK9oFxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxLOwnMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D43FBC2BBFC;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388633;
	bh=UURFY8r6IzMFK8eicn2U3n+2WWbClvjMqKKMxWH0TDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HxLOwnMY/pPHJVJ1MP88HcDxMuBc6DsBSNgq6hxeDu6kO5oa1MOEqPRO+1FHJFLVh
	 O6ax8eKjql05OpHY4kY3byFFdDCD7bMc6I8AHmHzbBeIF4ADOvuThoT8N6luSIpXVZ
	 SwOpqmnoOd/S2mT+T8uYxBexar4WH/kfqXOnLiGUeLC/v7qmfQLVqaTgkBLz3f9E0e
	 CtAxqgzTO2vr3+1vqTaDWnSN/g/0dBN14oiqTDgL6lugCzy/G9rX9byYFY+srO7trm
	 N5HX/fcNcTUVp5i9t6ssUOK0WBRBByC2mp0OLEj7MzX2jB+eaFc1SLUMoXj0gkERAy
	 1UAt60P0BX9oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B37E7E7C114;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: compress: fix to update i_compr_blocks
 correctly
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863373.11229.5565331058940503874.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240506104140.776986-1-chao@kernel.org>
In-Reply-To: <20240506104140.776986-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  6 May 2024 18:41:36 +0800 you wrote:
> Previously, we account reserved blocks and compressed blocks into
> @compr_blocks, then, f2fs_i_compr_blocks_update(,compr_blocks) will
> update i_compr_blocks incorrectly, fix it.
> 
> Meanwhile, for the case all blocks in cluster were reserved, fix to
> update dn->ofs_in_node correctly.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/5] f2fs: compress: fix to update i_compr_blocks correctly
    https://git.kernel.org/jaegeuk/f2fs/c/186e7d71534d
  - [f2fs-dev,2/5] f2fs: compress: fix error path of inc_valid_block_count()
    https://git.kernel.org/jaegeuk/f2fs/c/043c832371cd
  - [f2fs-dev,3/5] f2fs: compress: fix typo in f2fs_reserve_compress_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/a3a0bc6c2239
  - [f2fs-dev,4/5] f2fs: compress: fix to cover {reserve, release}_compress_blocks() w/ cp_rwsem lock
    https://git.kernel.org/jaegeuk/f2fs/c/0a4ed2d97cb6
  - [f2fs-dev,5/5] f2fs: compress: don't allow unaligned truncation on released compress inode
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



