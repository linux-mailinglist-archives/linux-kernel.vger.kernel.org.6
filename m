Return-Path: <linux-kernel+bounces-178269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D38C4B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5D81F21279
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20558364A4;
	Tue, 14 May 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXgGM5El"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343841BC39
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655090; cv=none; b=BqbSGTCTr9xlpfDXl6O/BGejujQAnyWCvLUpdxo8XSgV0eyI3GpDNiWbbQqIOLC6E8xf+Cp0gFB0+R4Hu40oajhpHOdEEDHjjHnlenM7wOdZ0n2e9nlgRC0Ta/zl/QtGaKjEuiGirjMP7Z2iHHXnyKvVAQp+nckVDo8VdLdlIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655090; c=relaxed/simple;
	bh=mz7Mpbeqg068yg66oPzDx2BWZ9PokBQcD0M8liX6rbA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NYQ4GByXemqwT7oODfYFBZCy54cnqQmnWb7B+wP1M3Ojfc2ssoV1/Lezc18eYtmvA1Bp0UlH86LUOghZEZsLeIa1wjjYEGviWUDWbryiTI//CV3mnwcwsyGKc/UKMALsffyeGH+U7DLuciwJH2uJ6ZMDSdfuOT963AHl8C9A8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXgGM5El; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 152BEC4AF0A;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655090;
	bh=mz7Mpbeqg068yg66oPzDx2BWZ9PokBQcD0M8liX6rbA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VXgGM5ElJBOQLKMzFIUTjv4fXWK5ayYEFi3NzuCY/b9xfJ/agC94JlmdWpRYa+1Wa
	 Bn6llakP7hBkYcGpuzGcb3e/udZ9AWcakYzaKkdfZrCJ7lIEsAMUwgMiyC50+y/xhS
	 k3W/wEYmtF319x6B7iSntOIpfdkwBwT9HLxy8evCbIyzdTPsQZzfrqErCLTpaaD9ZK
	 9bnwQkZcVpws64tMHSpIZ/T+Gte9DeTRPFlvkr9YKHqncYYpaHt9OPDCbuU5iko5YQ
	 VHRdYGDAUVeudzNChgJa4hHodNhNfq/NQkVz06mcAjS8zhLCH8ZbaCRPxjhfnVbGOz
	 Y4dJVhZv46AbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CA95C433E9;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkG9HSBHAdwqQrEY@gmail.com>
References: <ZkG9HSBHAdwqQrEY@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkG9HSBHAdwqQrEY@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-05-13
X-PR-Tracked-Commit-Id: ad3bd7659b68add28920982e02233b5dc4b483c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4273a66921219803b70491469c8d248909cd185
Message-Id: <171565509004.649.10213378730281973292.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:30 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 09:11:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4273a66921219803b70491469c8d248909cd185

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

