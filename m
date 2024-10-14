Return-Path: <linux-kernel+bounces-364689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBFE99D7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC6D1C22AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A931CF5CE;
	Mon, 14 Oct 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETvuTmWZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88214A4E7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936657; cv=none; b=PRJwYGSPR+wh2VivTxX760RExFX4t3I5tMHUycMJNJruiQmrFuNUwaZsujVPEA2zmTVtIlUvlx+7g48Tnl56ifRW33T0l8f3yVZ6w1WiWcN4+gxgR+rQ31ssqXkwrthFdMeoely3nVJj2HFf2x3uYY/m+Fm6qUVbY5h8QyZAt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936657; c=relaxed/simple;
	bh=p9G35PbIUK7+ewU8XEznrjm2gtY2iaGnOlU5FjnoMzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z7TD6EiDKW8Xyqlqtx0dsbDcHY3/eKwSIJRVVwBzgwMPYHkRa5zcwcHeN9x0I0UjYZ4uqPtpEmnLplJT4npshaChZ4g1gdlCZQEx+S4SIuR2tbWzrvfdHtfd4vQnhu1dnAPomOOdOFgb22Dmpd3jH6OSpWObDMWxpqL/SB+b68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETvuTmWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFF4C4CEC3;
	Mon, 14 Oct 2024 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728936656;
	bh=p9G35PbIUK7+ewU8XEznrjm2gtY2iaGnOlU5FjnoMzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ETvuTmWZfbvIBwricVrBM+hYqjKbL7+aiqWf8jeGfvaIle7BLpXe1ySv7Hk9G74Kt
	 YmdO8fotJU6DkXNQkogW8a0roxG/CmBguKoY+gipsxsn4/aKoGzGLe8qp9A5lHtDKK
	 yte4U3pkBWDJG7Fzi2pp0hQiQsiEGTZcv9oohriujVyK1QDhpvyZgwHbbEqdxo+w0s
	 oVDygm/286D0EtVIrwunDZelcYVx8noxGYmnN9mavKcgqC5+1AKH1qUA7Iujt4NMqS
	 EigkwpQjuVx3O5VrSPHHDQUdIyj5xODgIs/8ptsMRR1u78WqWF/uIE5nazqmRwcTEV
	 2i0s1MCXSizJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3E43822E4C;
	Mon, 14 Oct 2024 20:11:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 6.12-rc4
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172893666179.626029.10613192954961999474.git-patchwork-notify@kernel.org>
Date: Mon, 14 Oct 2024 20:11:01 +0000
References: <Zw1MHWwr3fRgJpLr@google.com>
In-Reply-To: <Zw1MHWwr3fRgJpLr@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 14 Oct 2024 16:51:41 +0000 you wrote:
> Hi Linus,
> 
> Could you please consider applying this patch in f2fs?
> 
> Thanks,
> 
> The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs fix for 6.12-rc4
    https://git.kernel.org/jaegeuk/f2fs/c/eca631b8fe80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



