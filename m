Return-Path: <linux-kernel+bounces-385508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC89B380D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FCC281A25
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1921FBF50;
	Mon, 28 Oct 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKnE5Er2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EEA1FAC22
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137236; cv=none; b=ni2nBZ3g6gAk6a2uRO/gUQBxBhdCbmJntfryO+IotzHRz/rGFXx36EL8LYF+JJGL7CQcDh8tsWQY7yRx3iclNi+xk5HHtxZWqeuLdYM9dL+seesuAmqukLjaqPfwo0DjxsiWAUSC832GP/K/v/wiYrev1UA9NOuP7mgW8E4Paj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137236; c=relaxed/simple;
	bh=hCLTyCHZZNaVX1YHFRpV0tcuaIeZgEzJXEYYh4gvRwI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C1UMpUrPhywXOur5XdkWgSdgo33kWjBhPKXBm4G+7RgWrDXpDPW3FH+uMauV2K85vS6HhVEUwQ3rc6vuzBStgjPYNaGI2/TC0stUtbqampmbeu0qUnAc8AnBsj6LmiTMONEit4QBBof/7KBjcOlhGCQaCv9Y67z94RyeRoCGg5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKnE5Er2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A514EC4AF0B;
	Mon, 28 Oct 2024 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137235;
	bh=hCLTyCHZZNaVX1YHFRpV0tcuaIeZgEzJXEYYh4gvRwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OKnE5Er2Y58DmhytZml+LbWwHJlKG5KZPZ5kifJso1TPuxWtD5eMtzlgqM1JejNZ+
	 /b5LaTFemQ9cii+lb8vYGbdeu1tv9X0SvwKNSEXduB2g5U1Hj8H8GtqiEU4RdSQsI+
	 v+EaoLb+N46hMCyPcS//8He9ga8q6A+753j+aBC34r9n6a95LURuu4tA86y0XuDMdP
	 Etl6d+7DOTIm8KSCJHXycF1WdJUBdfcsGoOFSlGLvH7gokrlsKovDpYYjzL+sYHn2k
	 o0dmcfFkSENMfhWKhGDppSCZuhI/LAazZDrgNLuYeqAQaewRKYfeeTWuIraQvMHcFT
	 GwlKP3RZn5ZcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFAE380AC1C;
	Mon, 28 Oct 2024 17:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: zone: introduce first_zoned_segno in
 f2fs_sb_info
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013724273.126843.1612111639944304594.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:42 +0000
References: <20241018062638.2619214-1-chao@kernel.org>
In-Reply-To: <20241018062638.2619214-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 18 Oct 2024 14:26:36 +0800 you wrote:
> first_zoned_segno() returns a fixed value, let's cache it in
> structure f2fs_sb_info to avoid redundant calculation.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/segment.c |  4 ++--
>  fs/f2fs/segment.h | 10 ----------
>  fs/f2fs/super.c   | 13 +++++++++++++
>  4 files changed, 16 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: zone: introduce first_zoned_segno in f2fs_sb_info
    https://git.kernel.org/jaegeuk/f2fs/c/08060c0b1414
  - [f2fs-dev,2/3] f2fs: zone: allow IPU for regular file in regular block device
    (no matching commit)
  - [f2fs-dev,3/3] f2fs: support NOCoW flag
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



