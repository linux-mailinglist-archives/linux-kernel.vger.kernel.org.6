Return-Path: <linux-kernel+bounces-411927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5859D016A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA91286C26
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF61957FF;
	Sat, 16 Nov 2024 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHm/s9hc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088F1990DD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731799002; cv=none; b=bNNHrtgugL31ci1sCmx1voKySvxmWdBrseiK6x2YlxsNVIrUK5vfTUbSeROr4F4ENl8pFKD3QMZ3kQEaTww1IIky0Q9lWvbdMVoV6c0fcUmKmyYd21yW0TZhlQJorlTxbDqDo7zeuSKAc52YS9NqWdyKznPYeknoaXTsCdyTyf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731799002; c=relaxed/simple;
	bh=GbXpcyHhxgIfnOWa2TB1qAot2k4wdumjWPKSJ3Z5kzo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=awmWZbOM5aTAK+y/UTdtD3I0H8XDU4kPtP5f60n6tjHjHXxaDjBEyy8i+16vSSUc0yB0Br6cLbjDucB7Y/RJ6fwRQGpxOkB19Caz55i5eLYce4fVGHFMzg43KtjenrzWxCG85AC2v+wJr4HEN4QzFweMhANED1YmZjG71Ha1p/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHm/s9hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB66BC4CEC3;
	Sat, 16 Nov 2024 23:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731799002;
	bh=GbXpcyHhxgIfnOWa2TB1qAot2k4wdumjWPKSJ3Z5kzo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nHm/s9hcdURejgY+zqItv57mhsvGsmGybLI5HsgUo4BSgrlNiOrmmRZ63g/8Duocb
	 CfnpHVp8AluReUkwWNx4fFZyxCgUZXyPGcP0y5Rq2/tWAhGdIwusTnpQuxId92Q53W
	 1GhlbVBAVCddHrSbs3F0OX9ERspiRCjlMl7TCOsnizjUDRK9BGE/+c9ANVsx4ZgNNk
	 RPmtWuxxtxDlkQp/xduB5b7Bl4WS2LqRUYf5ugxgilnf30KrofU0D/WmOADSR37Uun
	 zjBP2OGqaWcHZuA+8sphu92QT+wKB3F4IAvf4TEoE094ox4mUW0AijK5WrRdQMZjSB
	 Y2OjIRmah1nqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E4B3809A80;
	Sat, 16 Nov 2024 23:16:54 +0000 (UTC)
Subject: Re: [git pull] drm amdgpu regression fix for 6.12-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twfZ5B1NqByVsvHO38MGQ+ZfTEz6xmtZXQarHvKgg3gLA@mail.gmail.com>
References: <CAPM=9twfZ5B1NqByVsvHO38MGQ+ZfTEz6xmtZXQarHvKgg3gLA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twfZ5B1NqByVsvHO38MGQ+ZfTEz6xmtZXQarHvKgg3gLA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-17
X-PR-Tracked-Commit-Id: f48ab0a39f12fd83fae13bf81152531565cd5e75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e06bc45bef9aca52c6bdcb56aa6d392d99516ac3
Message-Id: <173179901270.3014796.14579671165827628624.pr-tracker-bot@kernel.org>
Date: Sat, 16 Nov 2024 23:16:52 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, Alex Deucher <alexdeucher@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Nov 2024 08:17:17 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e06bc45bef9aca52c6bdcb56aa6d392d99516ac3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

