Return-Path: <linux-kernel+bounces-382369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617A29B0CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2BA7B251B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09A52161F6;
	Fri, 25 Oct 2024 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJTDFFy5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1520BB41
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879852; cv=none; b=ZtW7K7BNV1YttIykdTrZdP/qiIOo5qBVEKLRalJ4RPKJ+3h6jMP/q8nHH8QPuCUDz/ejuGcMS9EhaEDAcylWq1Iz8r9ivZnlPomQ0k0kWIPli0Sbrd7czwjD+2OmAn+aOu97qFGC0QP8j7sUiaMk6/SmZy20JnRUHuUV78OYMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879852; c=relaxed/simple;
	bh=9YqkEUoj54yXUqtteZibHJrZaqhqHVfUqNeyVn1kJMk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gDqcMjfFtYnRl6+CUVRDhmjH/8PLgndNc+ISLja2LtueJO2ar8xTk5oqaehUnkaXSBX1irl4w1X3IUow9GE0qcVx4D91lfzIgorpgSoQue1mAi828l9mpiKVRCRWGb0EnWwbN37uMbj91V0Kb8o/xTNpUIzXZJMu89tzU7Og6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJTDFFy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2726C4CEE3;
	Fri, 25 Oct 2024 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729879851;
	bh=9YqkEUoj54yXUqtteZibHJrZaqhqHVfUqNeyVn1kJMk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YJTDFFy5hEXWcZwOT05o/Nlve/WNxHONYsNKlsmnadOTTjCtXTe5EZJ97DFnEg1KK
	 O6s5d7OqmoPH93N7f3ui38hgBpau7W9DnnBH2nqxlnCIIcjRkxuI/j8NxLUn+AbidO
	 GIyYWcVrQ+xCKEM1hczLDP1TXso5B4VZrfE//VwQUg5c2qkoAaEr/PpIxDGINKoiJ4
	 G28OBH7lepHESlt0JeXAHyP5hKS4F9HswX6mt3nVhRXQ+RahltJq7y/cabhizwNA2I
	 AoNA5uZ5i7MICcb31qocRzeLZmwDUoAMg+NRs6AaG59id+6giTbTJjz4K6RMBCMXgx
	 3AzNKo0NSP2sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB35C3809A8A;
	Fri, 25 Oct 2024 18:10:59 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txMNPAbbfxvD+0ouRGY5nojRvu6n+cPc=hjNwQzzj6gtA@mail.gmail.com>
References: <CAPM=9txMNPAbbfxvD+0ouRGY5nojRvu6n+cPc=hjNwQzzj6gtA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txMNPAbbfxvD+0ouRGY5nojRvu6n+cPc=hjNwQzzj6gtA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-25
X-PR-Tracked-Commit-Id: 4d95a12beba146b0ca2de59c7ce905bc0aadfd0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd143856b094b1798318d6816f37ea7380668c4c
Message-Id: <172987985859.2995179.17746356893549475517.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 18:10:58 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Oct 2024 17:10:25 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd143856b094b1798318d6816f37ea7380668c4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

