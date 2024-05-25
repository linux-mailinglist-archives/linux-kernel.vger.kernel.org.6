Return-Path: <linux-kernel+bounces-189214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0738CED3A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 02:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165ED2827BE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 00:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD8323A6;
	Sat, 25 May 2024 00:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYgPZVXC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0F1C14
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716597126; cv=none; b=ar2Ek4cIyuBq0WD5A1wdi9kh/jG/4eAe5sPmRKboVOip1UDi5YeTLSvnXV3z9uvZBgE4tbhMBRReSUSxrqD4NE6gKsCYnagOJtmxfnfAUmbUMqb57RlshDFy9YdKbAL9dC/rHzO//XZmWXstplEss3AcmRfNWIUSe/hILodADnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716597126; c=relaxed/simple;
	bh=EvgWL2BDkJOvNs1ZjmnWRRwbqncAWAl+1GT4o4nFRbU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RUCHc8/xOLoLYWheXSoo83qW/SxcesA6YQmWzolE2O2joAj3UPXYi39BInuX3NdS5AhdFzVy7w5xlziGtMBDfzG8x5JlNhEcfIOg2yst27v9ySnsHluLBmNqpYqAJ8IvNVNzifh9Jmq4bimzhfPZuphryE4NK7vyXE0X4Rk2MH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYgPZVXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64256C2BBFC;
	Sat, 25 May 2024 00:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716597126;
	bh=EvgWL2BDkJOvNs1ZjmnWRRwbqncAWAl+1GT4o4nFRbU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kYgPZVXCpjW8Rui4RXPPp7WsjXrMfr15ROG16SIJVtyuprNKJCRoQELPc83hmINRu
	 sXMEAwv1PR8+BGgEjcSURe203ZpVrQZ+dalV8xoIhXuqapK1zuRXlGN3NJX9A/9IzS
	 ErPh4GHoEh6Ec6SR6eMz4VNDw/skcMM5+X6krEatqv+eNPeZYfGXNL2cIwY0EtWOOY
	 NCTTvcUDEmYWEv9IXLLoxjseP3jSdr5DRFo8cwmCNRXzXZ0iRbf1WIGVn7SQF06Mhw
	 J2keGsjIU/UBYkjyGaueEoGXl13Qyu1UVTatpFbfuVY6kVUOw5vmLU8A6S5lcwiwCR
	 rCVwUetYBOetA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57F3AC433F2;
	Sat, 25 May 2024 00:32:06 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txzvSpHASKuse2VFjbdVKftTfWNtPP8Jibck6jC_n_c1Q@mail.gmail.com>
References: <CAPM=9txzvSpHASKuse2VFjbdVKftTfWNtPP8Jibck6jC_n_c1Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txzvSpHASKuse2VFjbdVKftTfWNtPP8Jibck6jC_n_c1Q@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-05-25
X-PR-Tracked-Commit-Id: 32a0bb7ef217aa37e6b67ca7950f5e504312ed72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56fb6f92854f29dcb6c3dc3ba92eeda1b615e88c
Message-Id: <171659712634.25728.14253838140127757042.pr-tracker-bot@kernel.org>
Date: Sat, 25 May 2024 00:32:06 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 May 2024 06:23:25 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-05-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56fb6f92854f29dcb6c3dc3ba92eeda1b615e88c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

