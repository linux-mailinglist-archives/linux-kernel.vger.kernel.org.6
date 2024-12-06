Return-Path: <linux-kernel+bounces-435585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8F9E79C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2CC16C8DB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA556215181;
	Fri,  6 Dec 2024 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6k5Q6yL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20940202F9C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515500; cv=none; b=Mg4o7m1qc00q8rTuhXvzFTECVsnmSPKPDzBCtEUCiknvNs2qCB/2QtzosKLfW43JJ/XJDCOZap9GdJsZEwnEXGgu54IkTqU6ixRWFxTTFcNm2Q7DSd8fIoKY+vwACjs+/ZLLd5P5OmLgexc+8It2BPMlfIIOB+k8ctvkiw9qRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515500; c=relaxed/simple;
	bh=192PVLdFXHBwIqSVPc7xAcnjVaYO9hyaFFPezdOqafQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CputjDPvxqjIGcKvbl1PqBDyfgIPxwCk2d5ldSiFk3tN/nQVvXKvasLMiN9XQXSFi0JaQ2gS5AvTGi0PYOJdybAFlfCSHvfhRpHnTuqUch91aS/djJfmbKhp3JjNsCjeKk10l7noWrI52PytOCZYPNj4lzgTbmHcAh2Vzi6Fh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6k5Q6yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5396C4CED1;
	Fri,  6 Dec 2024 20:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733515499;
	bh=192PVLdFXHBwIqSVPc7xAcnjVaYO9hyaFFPezdOqafQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f6k5Q6yLn5M4pcybwwq0+5X2qzz2crUCteC45o29BQbpAbp9aZOxNv0lzXFE7/OlF
	 ctrLCE75jN87XMdjuZy32W+BOAbo1ILCc+BXK9oh/5EtKKlvXzePLM8VAi65Bcshr2
	 759HYmnH7SjnoVCn2Cm2SJPXPnQmbmPwY8NTaR50zHLnKDqwb4xhvIpWnATxQaVIAO
	 HjEOEgq0O7n2q9qyXScWJL1GYmlA08wg5dsWwAsrDI2WynJoMZpzBmqJaei2Ra8p+G
	 4GyZhTdAH435KyJL1Z3ZLvhtufJtUh62ra3X3g/Y+/6wpP0n2OhD6y0cZx3ZrywMnj
	 RvvJmXCQ7Rmsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB111380A95C;
	Fri,  6 Dec 2024 20:05:15 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9typZWd9P_81asANhuE_F7a9j+k5auWhwwCn=xLDQ1mFdQ@mail.gmail.com>
References: <CAPM=9typZWd9P_81asANhuE_F7a9j+k5auWhwwCn=xLDQ1mFdQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9typZWd9P_81asANhuE_F7a9j+k5auWhwwCn=xLDQ1mFdQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-12-07
X-PR-Tracked-Commit-Id: 471f3a21addd4e5f170ab1364f11c3e4823e687d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a6e8c7c3a024b9e9ec8fd6295c3159504263cb2
Message-Id: <173351551460.2778953.7274571387002474349.pr-tracker-bot@kernel.org>
Date: Fri, 06 Dec 2024 20:05:14 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 7 Dec 2024 04:44:29 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-12-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a6e8c7c3a024b9e9ec8fd6295c3159504263cb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

