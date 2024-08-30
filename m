Return-Path: <linux-kernel+bounces-309461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FBA966AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4CF1F23E82
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054731BFDEA;
	Fri, 30 Aug 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXZX55nB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A81C1756
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051104; cv=none; b=OpYWmuVoUwJhSNhM5PhRn7IzWx5qPOQv4+Nhi9Dk/kUFDOp5ECgMvAWZmtW4pGTjpvi+K4j74w/gI7hB1R3Ze7WLG+K0uSil13dU2i7Sg+Hglm/QwMzDGiM7IbGCcRiWjJ+kEQY+NQ27+hgwUrZ9doAnaax/hDogoHvdVaghjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051104; c=relaxed/simple;
	bh=WXxE0mTRDrcgb4N9+MYhxEZZT3OXqpBy5Yj1GIK/sfE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JEdpTEFbRkHyDbY+3FMAn5uCNkqFoIlAz2DE4yEUzcL7D/UKfOFKt8AVYiinLSwnaAB/uGANIQLLIPtwG1nFu4qI8vUzuLG/a2MVGY55xTMa4c22ZGjpalRDJwwUCqPn7BUNGy5k+xRn8Wdrtwdr5d9NlcXQsWyb6F2zO8Q27k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXZX55nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BDBC4CEC2;
	Fri, 30 Aug 2024 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051103;
	bh=WXxE0mTRDrcgb4N9+MYhxEZZT3OXqpBy5Yj1GIK/sfE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AXZX55nB//eD/NOzBJgg8vgYDlGecce3j4Opmo6QeZxK2+55tAruCTvH1pFMFC08w
	 RbpRzKy4qrRjDPOmujoAoyUTO6S4oojTzlBqN3roFoDKgQUeUdhb4HmGcz8wbz+dLl
	 +hR46pccjROMaHswb2Wu9TQP0jHR3NYZesv7FfeVDgIKBG6+3U36FEfIHA0ZaXgWiT
	 hsOJf/KWfwof7mBEXIZgP6bXQTmFP5wLGL0+OpMz1f9ZK+Ptrz49/U1rVom0cK//pu
	 ooYKUnac62epzEPLCdaXLLf24+aMOw/KRZ54XAfwZa8fs/FBn29t1P3md1KATYigVL
	 86Kr2wsX62VzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA23809A80;
	Fri, 30 Aug 2024 20:51:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up val{>>,<<}F2FS_BLKSIZE_BITS
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505110399.2712133.5128196263519102281.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:43 +0000
References: <1722476031-22106-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1722476031-22106-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Hao_hao.Wang@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 1 Aug 2024 09:33:51 +0800 you wrote:
> Use F2FS_BYTES_TO_BLK(bytes) and F2FS_BLK_TO_BYTES(blk) for cleanup
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/checkpoint.c    | 2 +-
>  fs/f2fs/debug.c         | 2 +-
>  fs/f2fs/file.c          | 6 +++---
>  fs/f2fs/node.c          | 4 ++--
>  fs/f2fs/super.c         | 2 +-
>  include/linux/f2fs_fs.h | 2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up val{>>,<<}F2FS_BLKSIZE_BITS
    https://git.kernel.org/jaegeuk/f2fs/c/8fb9f31984bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



