Return-Path: <linux-kernel+bounces-176247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449B8C2C00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396241F215E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB213C81A;
	Fri, 10 May 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg/MUTOD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE613C9B7
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377154; cv=none; b=uz2JMAf/PMxEWs+ktQnW8yrLQRrxav3g7zeI1DXFunjeEyyVGChOi7Wr9rGzCFTO1pRfuV6SoojGjZHWaCZtDQmz4aZKL6Jx8I0KU6sGyQU2whFQUG73DZV9KS8Z/Q9JfORIsJKrDvRrSuwNgtHvjnMkh6COpZn54RGSty4F1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377154; c=relaxed/simple;
	bh=JAgo/kCzjYOr+03CJubu4G+6gTUVGg0w6nMVy9R0Ho8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q0OJ29+23lvUhyZ1nuP1XcYLKQfojhAjZg1c9zXkyBrVNLc2covdJ1PL6UCjHep8DxHdySpa9Fc3u5Z4OCrrMkcGOiiPRMNbQOp3tQ2EOAKQjPlimq7/3CahdCvwyXXzhNXI0Yv88ua0dF6Z3uTWSLNl5UamhuJkdxkaRybMmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mg/MUTOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B34CBC32781;
	Fri, 10 May 2024 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715377154;
	bh=JAgo/kCzjYOr+03CJubu4G+6gTUVGg0w6nMVy9R0Ho8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mg/MUTODtTBT4c1uDbudAadKDt8WBGRe87HANmUpO6JmBwNYfX7HsMomnmLgi/Fmr
	 s8kC4B8mG6EzFa0cT6OKbutuizVzNRm3wM32/k87Idw+reBzvf+gY1UMjiffEqs31d
	 g29ea+Q2cuKH8B4bvvtzNUNQySZca8lqM7iZkPOi1D/605u6ehzyeybYGR/MdOUyMP
	 7ze5PYrpn/r0NYfPxSOLimI3pb5gn62u5YU+xzusOU6/7jJmelDVVPUxD4f/7lJCyc
	 AQb/50U6jQxqIToz1q3ISPUu8U45xdp2h7TYH8L7AfIzImR832UFVvj4jcg49ZDhhx
	 ONAjD70gUsmSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A98F9E7C112;
	Fri, 10 May 2024 21:39:14 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.9 final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzZ8edq4gpxJpube9EOAVDFXr-n7Hwh9qwZ=_aBP34esA@mail.gmail.com>
References: <CAPM=9tzZ8edq4gpxJpube9EOAVDFXr-n7Hwh9qwZ=_aBP34esA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzZ8edq4gpxJpube9EOAVDFXr-n7Hwh9qwZ=_aBP34esA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-05-11
X-PR-Tracked-Commit-Id: a222a6470d7eea91193946e8162066fa88da64c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf87f46fd34d6c19283d9625a7822f20d90b64a4
Message-Id: <171537715468.8717.9971362074870569846.pr-tracker-bot@kernel.org>
Date: Fri, 10 May 2024 21:39:14 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 May 2024 07:18:11 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-05-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf87f46fd34d6c19283d9625a7822f20d90b64a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

