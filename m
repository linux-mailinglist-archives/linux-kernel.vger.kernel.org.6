Return-Path: <linux-kernel+bounces-400597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48899C0FB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9233F284A62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE16D21893C;
	Thu,  7 Nov 2024 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QetRH1r1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19A20EA3D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011437; cv=none; b=d53fHUWnQKAf6YN0jRWWEsWB31p+b+Q3zk89nV0GeF9xmDvLV8WFh0fIX/K9Et7w7+JqRxT5GIRrxKHrK/+q1EO8HI0dVQ8EBdypLpOQGpzZbLj0QKVKIs2UZszs8EmxbNkGa/9An+m9Ehyul3238uOlNrOnTQ+ed79te2o79iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011437; c=relaxed/simple;
	bh=SRw5c6vZEaEZIOBQZUZInuFqCOHYEQSoUqSyPlNpi2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uXvC9k2gPgyxnRtu9xcNarfAFVG/LhysTzYvZ6v6yywxdL7UMF5JiP8x4lc8ldwqjt6yKGVsIDa6VPnWE275+VfgbJBLjO+xBBPDDcDQYHYlXroDd08rUgXdwoAoPpyP42XMcT4Gvm+XFSchkCKwztH9rJPUWujO9RRuy2eigSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QetRH1r1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFCCC4CECC;
	Thu,  7 Nov 2024 20:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011437;
	bh=SRw5c6vZEaEZIOBQZUZInuFqCOHYEQSoUqSyPlNpi2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QetRH1r1q8FzJMLkYGU98H8LWNtduPVUU0OBLwPq/F4Ek1YXQOOHiWgu6dyrsL9E/
	 L3kAdRRETjo9fP1/jMRKsWOMBOIMDMTvZumxo2S/dyl0E12JW1hHQGelnII+9nyRS6
	 94zK1Dy7+FZ1ivnV2SqZ5+3uJxg100VwyqV1G3+bqCxH+lIto0WxiTsqA8JzZY3DRO
	 H9TY/VdJMGNuQdHn1lpyYe+f2lVbfeplLdemjGT+DfSOLAC9PT6Ez9l9ka7/UFC82g
	 KQu2cvb3pQnxhQY4LVXG98st6E3bwyhojfFFduSY7gf/uxYVH5D30Zz1D79EVtPGo8
	 6meERtJTpQQdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E353809A80;
	Thu,  7 Nov 2024 20:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove redundant atomic file check in
 defragment
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101144603.2084993.2473689864185308218.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:46 +0000
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Hao_hao.Wang@unisoc.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 31 Oct 2024 13:59:52 +0800 you wrote:
> f2fs_is_atomic_file(inode) is checked in f2fs_defragment_range,
> so remove the redundant checking in f2fs_ioc_defragment.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: remove redundant atomic file check in defragment
    https://git.kernel.org/jaegeuk/f2fs/c/744e66cb8779
  - [f2fs-dev,2/2] f2fs: fix to adjust appropriate length for fiemap
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



