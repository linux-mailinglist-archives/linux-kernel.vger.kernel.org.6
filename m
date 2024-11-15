Return-Path: <linux-kernel+bounces-411190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D659CF4B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7343CB34542
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32701D5148;
	Fri, 15 Nov 2024 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9g54Qma"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507531E104C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697140; cv=none; b=QEYhvWtzUmsehfBBQ/cZyoU73uPHbqy/KmcXserAIkfxDLSpJBLfcbsIQXHHAZii4xL+j2dNNqGbBfn+s//AN0PPSv0wrZdZPL9K4+9DVS2B4O6QQ8n5SNhBqZwHZoGTKEmh3aART0XIhiYPCFtP+moF5I6C+tBRCZAj14PiqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697140; c=relaxed/simple;
	bh=08qx2vorwQoE+dyyKyA2lthxHsKd312kYHHidqKZcXQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XnAlDoniRix6X6iEAu+BPrgbV4vNhutBbDPudMizti5jBVft8u0TMHIBQ/yVzAArGJjv283I9l5fNVs5N7MMY+s3NLbjELWMXahTV796Lgj39hRBy2P9NE+MJTuVLYCyJ/u1g2GlP0zegNbdZKaH8mkiNtAqG9zPteEB7PfWuyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9g54Qma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A0C4CECF;
	Fri, 15 Nov 2024 18:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731697140;
	bh=08qx2vorwQoE+dyyKyA2lthxHsKd312kYHHidqKZcXQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G9g54QmaWmxtcy1cw1m8eqcEoJ3GfnQfuOsJkYuQYOSZFVg4eXckMBWqFZnTRLNJb
	 IwAwiwVGPEjO51fMdTSRJLJiOVRLI0EDun9DYdVdq7ROyVVmFlCzPzB8iMY9WQRKB6
	 LCgDmOq5PeAAdlzOFC1cYwMOD3I828MwMcEEWV+d2HFT/MhhddUTdKAAhNUUhywTcS
	 ALO0eBfa9R0p8KuZXtFf/gy2Tzo18gSsSAeo7wsQoAYY/avbsEiPUxQX8cgEHV7WGJ
	 jph0pAmq9S/rxWzf+m3hkHpFV9So/NcgEPK9hFOYvVdwzpRljsXvSV0FQmDPs9zrSW
	 mZo7tUExmv2fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34EBB3809A80;
	Fri, 15 Nov 2024 18:59:12 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.12-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyjNNXJ-UZryHaGhapXqhPHB=SWH5v0tR_BF3iZOL873g@mail.gmail.com>
References: <CAPM=9tyjNNXJ-UZryHaGhapXqhPHB=SWH5v0tR_BF3iZOL873g@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyjNNXJ-UZryHaGhapXqhPHB=SWH5v0tR_BF3iZOL873g@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-16
X-PR-Tracked-Commit-Id: 21c1c6c7d732c2f6f4c5ffc77e103aa3ae8bff1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f868cd2517763c66783c6000b29d97f0b966b311
Message-Id: <173169715083.2685462.9543357655578271455.pr-tracker-bot@kernel.org>
Date: Fri, 15 Nov 2024 18:59:10 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Nov 2024 04:43:28 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f868cd2517763c66783c6000b29d97f0b966b311

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

