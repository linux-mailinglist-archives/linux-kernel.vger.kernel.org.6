Return-Path: <linux-kernel+bounces-227690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B091558D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298FB1C2235A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321C019F484;
	Mon, 24 Jun 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUOYVnPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFBC19EEDF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250831; cv=none; b=mXO/4aMvGPb6wnksPt5FJeAd4HBbI76Aqp44kbWz/Op1EUr6gwTCPL53jyuhYZValC15FeC87fkTeWnKMmXOxYm2WsHxHUWL3hK5+oDKn+lNCfi2hMXacp97VIgjdxv0xryupGteo3vyzd/T0tQKcSP3xBLWV9DaYEAI/4RPTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250831; c=relaxed/simple;
	bh=yZJMLWqazJ2QSZSlbJ0fJBz37N1160tDc8KHGpb0W6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rNVMIQA5PEGJMPdcDLu+SibrphfgXTOsDgTtaobxfCtzhRCG08SmO/Whwi/Q5zAJ66PJYQqckchKYc4wFLHpaInzt9/ohGdUMxc3yBzrXu/b5j/xpxxjyTw6Hd3OoiQ07lYBfKU3WgB/p0tZ4aiwP3dnAjDFGurq664uHykkSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUOYVnPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27101C4AF0C;
	Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719250831;
	bh=yZJMLWqazJ2QSZSlbJ0fJBz37N1160tDc8KHGpb0W6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WUOYVnPP0ZW5NF0ER3QjMMCft4dA7JqbSVKFKJAyis27MUpaAVo3zpqh5R57k6RAl
	 qaqAqiaRQhBPYM5vRsJ0/+cQjJCe4cTFXTf/Gsr0+B9qsIz9Z2IDCcap/8rVEf/Pc0
	 CxhIiYTJFtdpCXK0RBkV1oBoWl6qQZrMZMtiP/2W0q015QiDtOclVbkZLOD/oeBPqD
	 e8f3FPrNTWS5obhEwyzkhG9ZKctXotrnssRijrX8M3OtGj6/Khimm9uD39EQB4N9s+
	 DBtLzW1ef812iOMpUTVQQbozhiirfpoAzTpkud0jti8rGpojAqDELQET6ENLa2R519
	 XyW0+kpwhLl/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 056F9C43168;
	Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up set REQ_RAHEAD given rac
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171925083101.4247.13790083235420551794.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 17:40:31 +0000
References: <20240612193831.106524-1-jaegeuk@kernel.org>
In-Reply-To: <20240612193831.106524-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 12 Jun 2024 19:38:31 +0000 you wrote:
> Let's set REQ_RAHEAD per rac by single source.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/compress.c |  2 +-
>  fs/f2fs/data.c     | 17 +++++++++++------
>  fs/f2fs/f2fs.h     |  2 +-
>  3 files changed, 13 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up set REQ_RAHEAD given rac
    https://git.kernel.org/jaegeuk/f2fs/c/6aeb084fa0b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



