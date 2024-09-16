Return-Path: <linux-kernel+bounces-331129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFD597A8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E252C1C27212
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE9517BEB4;
	Mon, 16 Sep 2024 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3cqY3Kr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD217ADE0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522239; cv=none; b=rK6jiPMXcI76L9kAj4IVGN/b0wdoleCA0qtoarQMvwuzyxM8ePre+H03MzEt6vr4vzk3tAFQ3Y0em5P0A2rZfx7VpKoW0G6sG2y4VMw5B3AOkBgdLXWy7BGHmU5rqktvwM7Wj6NlZOA8tgsXZbX2EdwbumBBBC0cR6d7k5rxR6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522239; c=relaxed/simple;
	bh=/LTfMGIkXGSWPvlj+TCbpSSwcSOa/6IWvXCKKM62UNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1Jv+Ia5TroOAT0xZWkOBVkyykOk6eX+09wGsfFFJbtMBlXPi2hrO+aqg2fZtvpoI7c738Puw6Ythi/9Tw04zL8USIgsE6ki9dh5dFxQH0qHWpslOKJqC5BkylZt2AqAawQg/uF/FM2HyG3hFvghmk9bA3p+W/NF3TjChvM5gL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3cqY3Kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61D4C4CEC5;
	Mon, 16 Sep 2024 21:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726522238;
	bh=/LTfMGIkXGSWPvlj+TCbpSSwcSOa/6IWvXCKKM62UNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a3cqY3KrneybyUBzNYha9tYbpkgYUAlrR2Zl7Q4mxuSRDMjPUPfL2JJNgZTINxkhb
	 lk5cTPvs1Mj3ok6G98BW4USYcWod8KodpiIlVDcsJUeMNuH96c3SJehFuc7MIqB5ox
	 S95PrjhYpdQfXaIz/p8IPhQgriHJh79IB+T4QtFHkSahbHzzItUqy6ir41vwLpalKa
	 7Qc5vQmtP8p9VZZdTl3PVJDMPXTff7vKAybGttFEX/eusDXRZ06twc+VhLaHPH9m4I
	 +3VzAaV17JnlCt3jszMYMny31BoogcRIzeB5k3tfXU9Xj9qY6xc/HiXkkQdLVislF4
	 y1fxr01YWjZEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBA43806644;
	Mon, 16 Sep 2024 21:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow F2FS_IPU_NOCACHE for pinned file
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172652224025.3820990.7553839359732316755.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:40 +0000
References: <20240915032251.2300459-1-jaegeuk@kernel.org>
In-Reply-To: <20240915032251.2300459-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 15 Sep 2024 03:22:51 +0000 you wrote:
> This patch allows f2fs to submit bios of in-place writes on pinned file.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: allow F2FS_IPU_NOCACHE for pinned file
    https://git.kernel.org/jaegeuk/f2fs/c/755f18261376

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



