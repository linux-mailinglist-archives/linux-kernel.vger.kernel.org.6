Return-Path: <linux-kernel+bounces-225339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D26912F48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AE4282584
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1A17BB1F;
	Fri, 21 Jun 2024 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3p6wp2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8991607AF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004630; cv=none; b=aG/iYc5FbSQoK0N127fSj2XK0cn4d8lvZDMOdE4bFq9LXTK1QLz1fNA52ucEC+1+W27YYvODRa+lwDdN+eLlLahLg55ZFtXxd3teBnyFlFKkdriRYZCMBNyiXRU8RcNKDoAP5dWU/Faj6QKv5ftOXAo9L0dE9Rh2uji/J84EeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004630; c=relaxed/simple;
	bh=BD1C7XWZWXhO1/414bvlPN5f2q8+iAA4aSQQAnc/OfA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jilo+pMSuuohb3vGdLrc6+aMT6l/XqMSItP0/eAVPB3FwsEvtfrQsww87IcX8A+KHjRYF99fJ4bRkIZu03kMEuyF4Nxxpe/n8dg4qU+GuEj5A5L32P8vVv0DnG0ZIppXnw9bqaiajKfz0Cgc31YRhomrvBw/BpGMcZ3EqcVsaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3p6wp2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3C0CC2BBFC;
	Fri, 21 Jun 2024 21:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719004629;
	bh=BD1C7XWZWXhO1/414bvlPN5f2q8+iAA4aSQQAnc/OfA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O3p6wp2OCP5li1gyDjIeQMJxcAnKy9bkapBYLck6JpfEo07ClOI4U+TrCdK6PZYdG
	 obdSHg3/Szz6qg8mqgq/uBgS/lPySf+C6Ga12w4T5AfmWbfrlzG9ORvvgBie24Otkh
	 rSoNLmwCGXoFyYH0vW/b2idKPDyLqsy0UE64U93BFEyO2rtiNoLEqoNGV+h6dUr8fk
	 0h391dIWTMAH9KFeUJlvABAGYzzLjOJc/Ty096bhYaOGllIuOdWoS6ARN8TWEpMXzE
	 y+8hlhRiu4Dw3eRH5zfYbroYZW/L3M0EPxLoSqTN/wjZ/MViR3/cf3RhH+/6E+MA+E
	 PdHMwFlNjCt5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8D71C4167D;
	Fri, 21 Jun 2024 21:17:09 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyhLY-=pyy=RU0kyTQmV=_cFujRQ0Z=KY+o8V6KxcA7Ew@mail.gmail.com>
References: <CAPM=9tyhLY-=pyy=RU0kyTQmV=_cFujRQ0Z=KY+o8V6KxcA7Ew@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyhLY-=pyy=RU0kyTQmV=_cFujRQ0Z=KY+o8V6KxcA7Ew@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-22
X-PR-Tracked-Commit-Id: d1913b86f7351238106068785e9adc63d76d8790
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6c941570680d4d11e5c7480c3bcbeff8d3860f9
Message-Id: <171900462981.11487.11294674151371155855.pr-tracker-bot@kernel.org>
Date: Fri, 21 Jun 2024 21:17:09 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Jun 2024 06:41:13 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6c941570680d4d11e5c7480c3bcbeff8d3860f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

