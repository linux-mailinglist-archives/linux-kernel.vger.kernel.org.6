Return-Path: <linux-kernel+bounces-400598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817569C0FBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B274C1C21788
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B076218D6B;
	Thu,  7 Nov 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4+H1YOu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89CF218944;
	Thu,  7 Nov 2024 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011438; cv=none; b=Gzz7WGo/q42zSoyyHfkJOTz+dGK81LiZrIaoZ+MzoHXBw29MzChXdeDNZ+QN0oWj57iHWsdjuztZaP85p62Ko+oXya/kof1GGweCe0C0GgLrI90c7HtarHXrlhKijCW7bOMSUQvpfPHJZLOy/cP992pHQByBdVzCTkx9eG1BDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011438; c=relaxed/simple;
	bh=6LF8apqu37tZ/vIkjEyn73lKkMP5tjDYnlJPBlAL/JY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NolyQr8sdZchrH4eGTaKFQwcPwN/lLlrCXgyVia2GdgK0YckATUVUukOPhhFtRJGhVvj7aMFDhCk6wfZe7qITmFMNnbTR/f6GYaMNNo26yEY10k7uhu0+ukwL9QCR1EP87CD2IcSzzHOXbKCd1gtf8ydOrNW0Mb+vIVvN++6HK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4+H1YOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74068C4CECC;
	Thu,  7 Nov 2024 20:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011438;
	bh=6LF8apqu37tZ/vIkjEyn73lKkMP5tjDYnlJPBlAL/JY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K4+H1YOuwRo8vOUQfqpa7F5GU+110ragLWqwhQBwoLPpdWeGhoAS9P7A8C03k99+Y
	 mIvy7dfGa29CTQc6B0uDh/HuCpS6/Du080QLoqtdHrAeNgmuWiujB0XAyxal5tpnUi
	 QWnwiz/9s+MzDSs1Y3OJLziRPYzo/j9MwTk/j3buTodQzNY0w83k/QovNnUHNYCTAE
	 grUwoNlgqZ/S53jOLI5v7EwKpvQs8CGdpb0kDd5TxSkI/ovwhN48ioZeVM0k8sNYwz
	 pDME0htS8doJRBTV1QcmRzkg/Q+9IYeuuVmbsUK3bMh9K36KoLOS+K9gztZAwk3YYM
	 3fu1YbJGFfMeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3993809A80;
	Thu,  7 Nov 2024 20:30:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix typos
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101144749.2084993.7190591063897866454.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:47 +0000
References: <20241027140623.24802-1-algonell@gmail.com>
In-Reply-To: <20241027140623.24802-1-algonell@gmail.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 27 Oct 2024 16:06:08 +0200 you wrote:
> Fix typos: datas -> data.
> 
> Via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  fs/f2fs/debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix typos
    https://git.kernel.org/jaegeuk/f2fs/c/e63ce120b41a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



