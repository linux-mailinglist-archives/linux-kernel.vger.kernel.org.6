Return-Path: <linux-kernel+bounces-176342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562CD8C2E38
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFA31F2211F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AD144C86;
	Sat, 11 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKfmjuB/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED212B87
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=Ah4yb95qlVop25++lBGw4Hz+T35O8lL6ALuMrj0mo4O/lWbW8Ave9hRIxCZvPoQ8nowTnZLjjY+YG9PwnNVFIoKIsmPNURjUKBOEMBi9CV9cGx64QxVJeDcsAFletc6ggtkau0k5vPY+haE4Oo/yYtwE3YkWskyXL+fbQSV4hX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=f/QziGJMQfc3AVEjvIb2SXkPaytTiSIZVj8Z4dQuuV0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XaigbC5L4UiHDHwLEq+iqk2DGwck/P+jiykUIockD+Z4JG4jVHbBD7xtVM6heUxJnEKOx735fJ53QKBDO0MOt0kWT1Mg11YGa6TBtmOfZxMlUuNAgd/WvES/d/rggh1vQd8v35d0ued+wysFxQlxk91+LIKDfJB4hqUFHZa21Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKfmjuB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01859C4AF10;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=f/QziGJMQfc3AVEjvIb2SXkPaytTiSIZVj8Z4dQuuV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LKfmjuB/FrMY9Dza4ye4K5aty+xxhteXPrObXZ3zFb8GSxQwcVRPCiXY/TgiQ8kJC
	 8y366RjZt6V2H4CsMAuY5Xntjgb7UcEnJJ4uNsPMh1uEwBV/Nh1teQhBY2xtF3cKIg
	 qKblRdK+aRqjeetDfVLWXyo8Krqm0HTTEXfn71sF9p5oGybqt9jQiLQbSnKyX1OxBH
	 9F1ckx4Won3+N4cuB57k/HRsm0jDPc4/DC1Iex/ckldSmhK8Sb5BMwnTjlidIRO36D
	 urGIiMx0d6bVh2ioFgkqAt1LUpXjiPuiXGeuNcghcJOGjyCHcdpXEnNQvVNw8yrjy/
	 0CuraQo5Lw7iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7716C32759;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant parameter in
 is_next_segment_free()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863394.11229.6682600182078372745.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240425145528.2925372-1-zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240425145528.2925372-1-zhaoyifan@sjtu.edu.cn>
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 25 Apr 2024 22:55:28 +0800 you wrote:
> is_next_segment_free() takes a redundant `type` parameter. Remove it.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> ---
>  fs/f2fs/segment.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove redundant parameter in is_next_segment_free()
    https://git.kernel.org/jaegeuk/f2fs/c/ecd69be71aad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



