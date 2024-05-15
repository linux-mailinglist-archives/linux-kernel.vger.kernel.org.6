Return-Path: <linux-kernel+bounces-179395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0E8C5FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66752283A69
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49997383B0;
	Wed, 15 May 2024 04:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg3KclTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0DE8488
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746830; cv=none; b=RrO2OemPa3Hd0NdFdPAz6FXN/ToB82yZEL5F7/fQ6uo7xZaKP96CyeUDtxi9lQK/Bx/hDkamwfXoPBDwYLNsANTWyjkmJJ12uYSvJ8MiVARXccnxnjb5tMCvzgdfGtINdpfg4j057YWa8oC+AqCpoEhBVqH67t2vZq2Bn/6+e+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746830; c=relaxed/simple;
	bh=IPVEhIi6lCtFGo0sCu4Gf678CrgSqtPa+8kjZYLJNZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r/S3VUMXXJVNuGfU48fqococ714uz8QuuoiiwIrasAxnIxl9/U0YcOMNXDF1VYUzmi5gJ3WS38gCymKDXKj/EI/IQuBFjj5/nflpCTcXWx/2ASBBcczg9w+5W0R63CI3HyOdvkfbrIPhrlIyRmhPASmbH9IUlA0lyZUrMDLSFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg3KclTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B2C9C2BD11;
	Wed, 15 May 2024 04:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715746830;
	bh=IPVEhIi6lCtFGo0sCu4Gf678CrgSqtPa+8kjZYLJNZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lg3KclTg23Q4Ta5axXjPBz51TQyZCIUD+8ScpGpJNRiPzthEQeUYkRetchUhjG2Q3
	 CWOlKqQTrAGVY6T1CElyF5yG6B7rYx+umwLmHTvnklZTQRp08Y4UEneaWIwUS60Kpb
	 HydpbsF9vR2YD8KflZeP2HVj1E/C2Vsu7v0GezkmMIbXUUypWURlVpZSIq/OGcu76o
	 3G/dAO5NvY59NipDXeIm6Gk1X7J5D5ByIS3Ac7JSUJqwJ/WGjQA4rOOfrRMzjWhxWT
	 iPBeYQlXnTCIJiIAYT61AJgaefnci4pQnEaovRQ+vrqINd6V4Pqv+mgR/HzwtXDx1u
	 clmq1V1/p+LIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF361CF21DF;
	Wed, 15 May 2024 04:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize last_block_in_bio variable
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171574682997.29254.10154206807293240549.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 04:20:29 +0000
References: <20240514113529.1498545-1-bo.wu@vivo.com>
In-Reply-To: <20240514113529.1498545-1-bo.wu@vivo.com>
To: Wu Bo <bo.wu@vivo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, wubo.oduw@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 14 May 2024 05:35:29 -0600 you wrote:
> Initialize last_block_in_bio of struct f2fs_bio_info and clean up code.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/data.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: initialize last_block_in_bio variable
    https://git.kernel.org/jaegeuk/f2fs/c/16409fdbb882

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



