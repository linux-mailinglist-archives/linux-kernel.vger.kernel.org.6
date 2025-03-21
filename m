Return-Path: <linux-kernel+bounces-570699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B457A6B3B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DBC485F94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2894206B;
	Fri, 21 Mar 2025 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATCKSwGF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0B28EA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742531639; cv=none; b=J+w4y4C43hNA7TcP3AoGQSrXeHvPkjTrFVYsDLS9IFmU5/mSUITfHe0tHAYiI3Vbxms2G/KZhTErywBfgHN/PHP1LvjaXEMYLy/0APWSJ2ZS1rQbqiNd57QKMA/GUBN0yNonO9jBE/a6KMeC4rZ3Lh2wCyCqzOMKsJXeNsfg2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742531639; c=relaxed/simple;
	bh=KcOx8O1H77hnjxGqdj4bgLJ6OhoSyJWcxsShykGdxUU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rC47mwNSq5Lg8R0E0kuMsSQCJ78cTNrGHIm7ZUk4ibN3+z92e4Gdn69asoflDEWEaBjR1qjtyowm9QbVqNP8uwwZsuOzJQaY7kmF+n21UDQO0Ry0aY+JPinT15STfwqOa61EbfRwRa+5yVW/fYXQvCAPXLoaxLwJEQI6L1Jj6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATCKSwGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74A4C4CEE8;
	Fri, 21 Mar 2025 04:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742531638;
	bh=KcOx8O1H77hnjxGqdj4bgLJ6OhoSyJWcxsShykGdxUU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ATCKSwGFIwTIwgUwQ9BpDyWxy1ilvQYzYB2ztncNodEX2ssTHBIp0rqBxfPRh9JYl
	 VQ1pkc6ery4Fa19EO5VPksdfxNtF950OfxyrMXPG0M4FYS3c8+ocfqfk9jFB02yvUx
	 mb/yydsLc95A0slw9EdNJ4vVQEgORkl3iFZWDesRyYKnzE6bnWXBdBGXHdPoDYvVwH
	 CX8Skwy+l2X+nLwjn2OPtbNqh6aDFIjOu74Qry3pm/71WJRBgZhkbhhtC3fQJd5Ys2
	 hwOI5YDw9S46Xmr5k3RZYZ0JXgkKZ6gme0HmtcxJ1vw8QgTsBtu00XAwQNaGt1y4j1
	 HPAv4FC5reCtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB15B3806654;
	Fri, 21 Mar 2025 04:34:35 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.14-rc8/final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txGdh-rbWbxA_nQVV_1AMin8SgJpo1T4HNcCc_4aRtJ0Q@mail.gmail.com>
References: <CAPM=9txGdh-rbWbxA_nQVV_1AMin8SgJpo1T4HNcCc_4aRtJ0Q@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txGdh-rbWbxA_nQVV_1AMin8SgJpo1T4HNcCc_4aRtJ0Q@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-03-21
X-PR-Tracked-Commit-Id: 41e09ef6c26f0bd89f93691ef967fd621a38d759
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3ee1e4609512dfff642a96b34d7e5dfcdc92d05
Message-Id: <174253167447.2013956.2398442468965880120.pr-tracker-bot@kernel.org>
Date: Fri, 21 Mar 2025 04:34:34 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Mar 2025 14:19:05 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3ee1e4609512dfff642a96b34d7e5dfcdc92d05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

