Return-Path: <linux-kernel+bounces-400602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C219C0FBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698F5284E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A072219C94;
	Thu,  7 Nov 2024 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+Nl1vTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863821948A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011446; cv=none; b=L4NNa+extDh/agJTWM82SUBRFcOXaEJYG+kF8A0jCH4bo6Z+v4hfypYQZZaIuXxaYq1Zzs5WcMorgLBzALngn9FnbLE41eOj38Oy0LgnZCWIhKKG7WNXboyLz6G6n+QoAPnB6ImJ1V5itOZWTf7Ze83Ss9qpIwut8TYy2NNdZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011446; c=relaxed/simple;
	bh=stBgZK238R2cyyfyc6eob3WN+UB09hSCIb53SWNy9+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LlBHBerHtjTynTl56FExyuIgumnyyrYUsywoCItPLLjV8x5+D0B3OGTPMHbb8t0HmWerDLSa/By16/CrokJXDR+zD+gBj3Z+nljJg7J6+vYWYzkfIFvOSB3jlrWSz0fW7Lpb1PaYn3vulMZ9utWv8/RZ5psHuYXrfMvvqVHW52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+Nl1vTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44F3C4CECC;
	Thu,  7 Nov 2024 20:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011445;
	bh=stBgZK238R2cyyfyc6eob3WN+UB09hSCIb53SWNy9+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E+Nl1vTgFE8jRqgFIiaEJTbxZDp4IgLVDAqEXWfUKOnl0iptFZH07eZKcKDQrtLuk
	 lhIJwsd5O1urKl8+IsCpBXo2JH6YFbdk0x5j4U+1g9PYcMrnvOQa6J6dCPpTNNEf96
	 bXKECgxqp/P12B8Y0Z3Lqj4GdvHGTYqBHvcoyCSvvA+HLrSg2TyqHJKBTH2QRmycMi
	 6Bds44++hn9GZV3lPrrPe7ADvKwCziY0rHlanh8PD9p3jGMYhb2cPMkgMR/7wBsDS7
	 zHGnMUfHMJBeMg1EiD8bpNYJlcuIU3CSSTkVnKx6J4IGFdTPr8Kl//scFI+KuHr47K
	 nu2hlSkrmuv3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D0A3809A80;
	Thu,  7 Nov 2024 20:30:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up opened code w/ {get,set}_nid()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101145498.2084993.7253487947002191370.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:54 +0000
References: <20241029005703.2740230-1-chao@kernel.org>
In-Reply-To: <20241029005703.2740230-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 29 Oct 2024 08:57:03 +0800 you wrote:
> Just cleanup, no logic change.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/node.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up opened code w/ {get,set}_nid()
    https://git.kernel.org/jaegeuk/f2fs/c/cffaa0976fcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



