Return-Path: <linux-kernel+bounces-252699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0431A931705
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B472A282730
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2E18F2E6;
	Mon, 15 Jul 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJvRySsx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A865318EFEC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054432; cv=none; b=Gk0nuK4l6pGp0cLdNDr10CvU31lwXy+dumnl6iPqwW7pxYe3g50ZbCTPL/65RQDRxaEk4/8tXd+uDQOO+XhBf0x9sO2z+Imi792/8LrwilQjsw8Cc9yBq678A6H7XIzVGBo+abQT1+7i2OuWadZgYvYYLi/48rtAYuFcWYYFHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054432; c=relaxed/simple;
	bh=pzlx/tMbvXkzfRiRUmI4MX/JAOn9gs9uWE/iXLcsQqY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I9rkjYuY2IZ+aUuOAELV3nutesyOMt48Xl/IqaRKzRNIWJU7b90bXinnu6O9yfgl7WuuR8KV81BPH2yfML3BpEPQUHxnscJlSyJGTPJT5/e/TGJp0B6PZu5Q7Hm6kyRHK7ZTWeOmkECbBcgoHnH9QTr/G0JhSAcAAa7KOQYf3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJvRySsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55488C4AF10;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721054432;
	bh=pzlx/tMbvXkzfRiRUmI4MX/JAOn9gs9uWE/iXLcsQqY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kJvRySsxr9IiHoKOmgNM1aNAIDwwlP51pJ9aRnjMvxOSIImAyVaQb87f80NdXwXWb
	 6s5+8AgYQwdnGOvdmQuLTs6Ir5yfOkvTb00XzJ2aPvwmiLbOV0a2MCzWA52UNs+fsI
	 nv/VvU0UpFzbfe2H1gp/fJ/NjKmLoAjF+Tkie6tJKCsqTEQZ73nLezBdqyGn+Dqn19
	 ar3Snq9CWk09K0l7OR8QGzlFqiU4t+TRzyZO3Se0wojWF0rcOwly7jwsLYPdoM8rIy
	 b4SvBfZABAm+1E6o4LQ+Q4pmPjlmxqxxLQ99umjqUK5TqcJRFA8H8hF2jjYyK6uf9R
	 5WjXr28PYVTxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43C71C4332E;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: clean up F2FS_I()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172105443227.17443.11712744166407927088.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:40:32 +0000
References: <20240625031604.3587691-1-chao@kernel.org>
In-Reply-To: <20240625031604.3587691-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 25 Jun 2024 11:16:02 +0800 you wrote:
> Use temporary variable instead of F2FS_I() for cleanup.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h     | 32 ++++++++++-------------
>  fs/f2fs/file.c     | 64 ++++++++++++++++++++++++----------------------
>  fs/f2fs/inode.c    | 54 +++++++++++++++++---------------------
>  fs/f2fs/namei.c    | 20 ++++++++-------
>  fs/f2fs/recovery.c | 11 ++++----
>  5 files changed, 88 insertions(+), 93 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: clean up F2FS_I()
    https://git.kernel.org/jaegeuk/f2fs/c/7309871c03be
  - [f2fs-dev,2/3] f2fs: clean up addrs_per_{inode,block}()
    https://git.kernel.org/jaegeuk/f2fs/c/bed6b0317441
  - [f2fs-dev,3/3] f2fs: clean up data_blkaddr() and get_dnode_addr()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



