Return-Path: <linux-kernel+bounces-555426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E11A5B734
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E16F171251
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141461E9B20;
	Tue, 11 Mar 2025 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCYr6Yph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3E1E25EB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663798; cv=none; b=uUGl20YJP+uJjlD0E1rNsirT8BtUhzzMa1kT6i69/tLvM4F1oGI1MbaSrN/BBnEBvMqORYD8TS5NCq/wiYcLcTZGg18rGGlDWINoZ/awRBb7/blny3B0dMqlKHUfJ14CX+wHxRZGyenEu43pRYDjyhy5Q2ljHScRR2NZaJbePcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663798; c=relaxed/simple;
	bh=WWxAhaRyLLk+xBVfpWcu3+Ywmw8Hlr2w5bUud1h5QkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J/pgyWgr8x7GuLxJ6MrrpaJB/x0oPwzt8oXBOBBjaN2HnBVb6QF88yBAY5bMI6fKoSIoVHWoGMgxpVNP+dk/BKw82djqfRXrNpImtAeNFtBK0j05Yyb1KCPkOxI5Rsxo0jR7ZE2p/b6qwKaqaCKfJUSmPC0uLje5RdhevqteUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCYr6Yph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B7FC4CEE9;
	Tue, 11 Mar 2025 03:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741663797;
	bh=WWxAhaRyLLk+xBVfpWcu3+Ywmw8Hlr2w5bUud1h5QkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dCYr6YphytjUHkJsvbhC+0GKywhOOmawkZvlN2HC0uOMsT7MTuzOEcTReh7kc5PoH
	 ZJS9ngEBlSQ96imcw6uvqNpQcmuu15RddT68zlRsXkeIU6OnOsBp1evkU4cJ29A/BK
	 SMqXut5iwgubL1/QfE+pfc/JBBBdMCOEWMxdZaSaT3EN86NWBT0JSYS41pJSeBF5uF
	 1XKWx9GuE+xuMQsObOmcmt4jM0imdOlPLEG2VwmCGXkieEoKqibDnMOobYIVgFQspk
	 1Y5nwZIPMHdI79Fmyn4gPMJLr8/zY89WVnrQc0W9dRCXr3Ag2vxf5Wmz/mDKlOVX5D
	 EZ2GrdCIBvhTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EC0380AAD1;
	Tue, 11 Mar 2025 03:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: control nat_bits feature via mount option
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174166383201.3785903.5420256276801883297.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 03:30:32 +0000
References: <20250308051846.29079-1-chao@kernel.org>
In-Reply-To: <20250308051846.29079-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat,  8 Mar 2025 13:18:46 +0800 you wrote:
> Introduce a new mount option "nat_bits" to control nat_bits feature,
> by default nat_bits feature is disabled.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  Documentation/filesystems/f2fs.rst |  2 ++
>  fs/f2fs/f2fs.h                     |  1 +
>  fs/f2fs/node.c                     |  3 +++
>  fs/f2fs/super.c                    | 15 +++++++++++++++
>  4 files changed, 21 insertions(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: control nat_bits feature via mount option
    https://git.kernel.org/jaegeuk/f2fs/c/c2ecba026586

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



