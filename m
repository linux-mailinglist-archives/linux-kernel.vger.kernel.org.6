Return-Path: <linux-kernel+bounces-176343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4898C2E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036FDB23DCC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772C17BA8;
	Sat, 11 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEXTyCqt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1D12B77
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=r6c0jWlty4e41xu+s2yn2P84paeZWH1yobTgBmID3YPDow4yyNfSEzRdiym04OZs8ikUO2p9F3WGKwQYmcXxT3CquT/nDqgi0vvuYBEpbxJziNkwN9kAw/scwt3nj8lQXg61kGOpdei8pKSV/6Mzc/4y58gTGONZvPVBdkrwyy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=k29d+zi6/5QyA5Jm8QI53vH7XuREqf3q+JGSX44Smb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qc4hwv16pQedU8XAXxvWQjXLjcnr0in87zYM7kM1CQPZyPcWd48XOpegu+GuLpfTJbTq1vaxB1qIltKg5CMk89anfQxsJwLuNcvxhK/xM4xz/tWqM25vkSrkExkS62C5NlHfdFGS9H8gBmMvMrkKTVYjUl5MTHxeRgmICiwUNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEXTyCqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07B39C4AF13;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=k29d+zi6/5QyA5Jm8QI53vH7XuREqf3q+JGSX44Smb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kEXTyCqtxWo0DoOBtCJTgiCAp7eOe2Sw/KBO7/mhD4y/vvU4I1tY+wxyw+gy6kO+D
	 rua40dk5oN3iy0OvAoYGDQ4Z5C62LD/xkYmz8mHS2uJXC3NlgF96p/TNpiY4RL553X
	 TDlBSoWqHiSMTQHfrf/xlA7qJFl8ei2sORBMXq4g1T89KWUqSljfvxjoNn2Czg2xUK
	 CHzByCtiDvlwqxbcLVS2cotIGuqxP9mQUefV8dwMZd/dYMunC0CNwlDu9HictqVaMz
	 Qbma/HCc5Yvxx1vEomDJH5rl7wgZAKSwmaJo87p6wo/ipssy9sP9ha0Oyrd/TCq8ya
	 FAH5jToxPEevg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F02BFC54BA2;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: check validation of fault attrs in
 f2fs_build_fault_attr()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863398.11229.15562636520334285373.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240507033847.1047251-1-chao@kernel.org>
In-Reply-To: <20240507033847.1047251-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  7 May 2024 11:38:47 +0800 you wrote:
> - It missed to check validation of fault attrs in parse_options(),
> let's fix to add check condition in f2fs_build_fault_attr().
> - Use f2fs_build_fault_attr() in __sbi_store() to clean up code.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - add static for f2fs_build_fault_attr().
>  fs/f2fs/f2fs.h  | 12 ++++++++----
>  fs/f2fs/super.c | 27 ++++++++++++++++++++-------
>  fs/f2fs/sysfs.c | 14 ++++++++++----
>  3 files changed, 38 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: check validation of fault attrs in f2fs_build_fault_attr()
    https://git.kernel.org/jaegeuk/f2fs/c/4ed886b187f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



