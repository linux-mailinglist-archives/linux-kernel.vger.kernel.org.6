Return-Path: <linux-kernel+bounces-331549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 168EC97AE31
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18161F25BED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34C317BEB0;
	Tue, 17 Sep 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDkaR/2I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6616A95B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566486; cv=none; b=WAXaT8lBeTgqxdl9yheJswOjkheNMb23+I9KDPTfFCWpNb+hKwqNGrzFap4Cxxb3qXu6Y8ATaEzR0Rn3v5TSseeelcwiKYTCgxddSPvjtFYURqqPbGeFT1pluA+on9CWdvBVcwO1Tgi0EIKpAe8Lj25KsOC5ovzuDijmGQpRQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566486; c=relaxed/simple;
	bh=xEWGF+GFlGBTQhGM0SD9HwnK1are9QrUqGIc1zp7Z2M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ux6RwnQsnpx8ExIIKQ8u5EO59nipOwZ3d0fs/V9LysQDQke6534gjbBkSO/xe5Y+IpK7FI6KRWCGMAt/gx2csMV2FnWS0/KyYOnRn+XsY0FFN9cwQdIh6gB/jr8VeeTVFsq9hXllyjWG5NKmXEYk1fWhu23TwWDz5BgQF/ARa0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDkaR/2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81444C4CEC6;
	Tue, 17 Sep 2024 09:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726566486;
	bh=xEWGF+GFlGBTQhGM0SD9HwnK1are9QrUqGIc1zp7Z2M=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=DDkaR/2Iz19WmskRQzvi5SPiHFr0LuVDBgXhswMynWuo8CTQkPKkxVxBOoGEtcMTj
	 pPEnRN9hNhJ0TlgxG/3q0ypJqxbo6IqJaHBsqRN6soq0Xwge92nU+ZhUMt5Y8qrzJE
	 y04s9Zy+7IgvzjJNJKjCG3g9gESJsPiSD1ETWSBrOO5HYV+ZPdBxNsBfokrAOMyxub
	 RBH/GBwcDxlBHm1mf5nmV66sXbQ4GiCPOAjZsCA5MP14axHUR0x9Xqz0287BiE1WIF
	 ePWFNmBZuyDQ8Vd2/N2MTZeosN3phWmXS9K+hJc6Wh8d50yNk+josEDTmy/JU9j5Wg
	 h9mQm4aW22XTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF53809A80;
	Tue, 17 Sep 2024 09:48:09 +0000 (UTC)
Subject: Re: [GIT PULL 2/4] soc: driver updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <8253b661-af65-48ea-8630-24e4b722ad58@app.fastmail.com>
References: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com> <8253b661-af65-48ea-8630-24e4b722ad58@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <8253b661-af65-48ea-8630-24e4b722ad58@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.12
X-PR-Tracked-Commit-Id: b62800736f61521547d50fd8cc332cf9b74cbaff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8979c6b4d0d1b36e94f5bc483fd86e38107e554
Message-Id: <172656648793.78027.13430329274137020495.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 09:48:07 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 16:32:23 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8979c6b4d0d1b36e94f5bc483fd86e38107e554

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

