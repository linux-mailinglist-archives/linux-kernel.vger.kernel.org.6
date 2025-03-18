Return-Path: <linux-kernel+bounces-565352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D299A66674
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B221898DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D691925BF;
	Tue, 18 Mar 2025 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXozGuDy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B218871F;
	Tue, 18 Mar 2025 02:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742265727; cv=none; b=WxoTFW5/TraJwVQ02NO8OldHCdwckNgSCyH34dg+q59L2jLSC40jooDvHbXWNQ6WAa6g9ZBL9VHPfFSpKCVV2ShiO5/D9ieghrkL8bKvv6PF0FT55ykQ7uTLft4R1ZrQxVR51XxqNU8u9PvlrZtKiQrMSdLcXevxTgxQzOJ47Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742265727; c=relaxed/simple;
	bh=1/YnOw4TNIKciP5NQwC4UyK5OcYEwOpvaukPg1yTD8g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HzkfmwfTgggiVbKcUEZbA/uRwwxa9WVGW/b8tC1qIAcBPhzbe0JO0GHbCbyEepvgglSAivH4fnjntrR+Nxy4lJIbuw1JBbqBp6OvAqakkzXrPZo2+4UVfCvyUG55PCQOxYYfeelSh9HlPlqT6LWRZ1qapuqqQVZcGJ900Pwfz8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXozGuDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E41BC4CEE3;
	Tue, 18 Mar 2025 02:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742265726;
	bh=1/YnOw4TNIKciP5NQwC4UyK5OcYEwOpvaukPg1yTD8g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BXozGuDyKD72zVwOyyoiogfi8budas8+RmGW9Rc2q03Dz2rcDn5z59SIJQubLqskx
	 A2EJHesEj250uEbXrC/O3BY7o/aInBbO2+xYenprFurRS9TRuwxNEvXjJOPNfkJd+y
	 0LNzF3Qwz6c+HXrmq+c28zVs5UPa+hu+CY0vvJTsFLFHC6Oini9tQnUgBpEW9Q/I/6
	 au8PYvnSPDlIzd0pPh1TvOxgogp0Qon3IdauoX8ZaUzAH+4ISbH5K4IWAEPpsn+KfB
	 QbN3Uf+oKHK7TWaFJzx3B89ncWlwORchZecT0oiCbINcRZWDKF62txMi8mhHdXvdWF
	 KU+nSSJp39O5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34645380DBF0;
	Tue, 18 Mar 2025 02:42:43 +0000 (UTC)
Subject: Re: [GIT PULL] soc: fixes for 6.14, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <860b2eaa-1aea-45e0-8bf5-3645b3840966@app.fastmail.com>
References: <860b2eaa-1aea-45e0-8bf5-3645b3840966@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <860b2eaa-1aea-45e0-8bf5-3645b3840966@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.14-2
X-PR-Tracked-Commit-Id: 45d5fe1c53baaed1fb3043f45d1e15ebb4bbe86a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc444ada131001812c5d10b380837238c9cf7c8c
Message-Id: <174226576175.3993121.4904814038298026258.pr-tracker-bot@kernel.org>
Date: Tue, 18 Mar 2025 02:42:41 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Mar 2025 18:57:57 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc444ada131001812c5d10b380837238c9cf7c8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

