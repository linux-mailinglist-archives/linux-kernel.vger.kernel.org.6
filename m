Return-Path: <linux-kernel+bounces-178190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6938C4A39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AF71C21372
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F29B86252;
	Mon, 13 May 2024 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7j4u863"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541E85923;
	Mon, 13 May 2024 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644253; cv=none; b=scbP06GYBGi56dslBM772YGaA/nFXG5ZVkPgvttzcLi0Ud3Mhs/veUELqxfslUH4rSOfxabvk7t14+G4MmImbgH0ugp5Q2WVkOHay5MCMsptQ2FVy5NErc4ha1h9P2OftN3Tw6g6/+rHHO+KjrW78Fqk/ZZF/yJoI33GvEF7jtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644253; c=relaxed/simple;
	bh=s8u0nvmNJOg1DS/o5uZYs29HJ+DuU4VAP3P3lQQpVSg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EyoPuHX6KCbQlSYxWly7F77qXofh87PBgo92odCO3NAIxxLHzwXYT2086+jKVYPcIGzlxlp5zDRQb8Vee+Po5XTrIfAmcgzE2q/m4Zc1MGPVHOL2tP+rM4I5q8oVbay9kLeFVDFHROW2wYUo7l+ilAzSuy74jvAiVLHh1cmeZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7j4u863; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F02FC32786;
	Mon, 13 May 2024 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715644253;
	bh=s8u0nvmNJOg1DS/o5uZYs29HJ+DuU4VAP3P3lQQpVSg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p7j4u863B+ET8nVRl8rSHkWdBuVUrW66qssF1/KdHn267c5JxKlQ1tQZgdJxVro+C
	 UbNUZMrTWX+G77iNlSEHLgy2Ian+KxxuT68NDNio6Bdutjwi3xVVnfNe/XdDLT6vCV
	 9Rbk4qev220LTfOdFosYsA2Le95goBzZfcBEnZ64snFDY7YtblOTQO+CO7UK9NHHJT
	 9j7BT4T49S6ZbBd19saCt0Itq8suyYQi602tEElVyakIsXjyTxGAOGIAvzHDc/773J
	 Y5I0D1VDVdEcvsDtxakYaN4YQMXv7jF0/IaDNenqXFUfL1Yo0EppgsGh+TP2eSGslv
	 be6sTj89ocuQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35853C433F2;
	Mon, 13 May 2024 23:50:53 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform-firmware changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkGWRmncTxuqnTon@google.com>
References: <ZkGWRmncTxuqnTon@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkGWRmncTxuqnTon@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.10
X-PR-Tracked-Commit-Id: 7f20f21c22aa22e488530f66bf4fc168e427f5bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7c840ba5fa78d7761b9fedc33d69cef44986d79
Message-Id: <171564425321.32070.7729734414650999432.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 23:50:53 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, briannorris@chromium.org, jwerner@chromium.org, groeck@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 12:25:42 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7c840ba5fa78d7761b9fedc33d69cef44986d79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

