Return-Path: <linux-kernel+bounces-425960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6CB9DECF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B50B1611C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB9242AA1;
	Fri, 29 Nov 2024 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olmrFY2o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666515D5B6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732916016; cv=none; b=dykeeMLInudDL8mdcILsjYD7RYaLESw9CTP2Wctm0wA3pGt9oDH776QteqzBQHXGnLf8K1OOoa1cDlGRu6SXNhZT0+6uh49RTty+1usKw+e5GwooRTHB0P/IvJyIDHcFCqT9WEemElSuV7Pz4sN8UdisoYCnPdMW2KwO1uKxYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732916016; c=relaxed/simple;
	bh=4LPxw8NLKEvTsTwQkiku9k9b0iolpwIs1mbFwwujtwc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q0Ch9nlJipaoyHXq7kgR+vUOTXUgEstRDYq0QRXt2r0H05gCzI2cNoP4SPbipWCwFFmDDodsZMj4CLC2lDgInR6bjd91gLcjNtHAZzUFA6jExk3DELGgTmUhXzD6D0oxctXYstI880To2BHaVmad+x3PlDbeXBvyjDuFFedQRf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olmrFY2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA6EC4CECF;
	Fri, 29 Nov 2024 21:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732916016;
	bh=4LPxw8NLKEvTsTwQkiku9k9b0iolpwIs1mbFwwujtwc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=olmrFY2oxHsXuGqXxZj8gMCUUnTDxytOjDfWX7IV+9K6CCCmDuZZOY2UD7xfo8tcg
	 en5PdbYOXk+8/TyiLdtNhGV/Iwr7DwDN/2qba0gVwDfQ7j7qQAO6Okit5x8v4+XDdu
	 1Ai+GhdopMrwCRdigm54tpbVNaJjh3sYevftcRvGEeiR9qcS3WD4GloJvHxdKld6CK
	 +usJOeAjnNJC8FtawNvfoI27IYd23525KopLTOGf6mIZ+NaiCLgTbWYcOp2yr/aDS4
	 vYKWb/Zi0C+7rROczm7oTIvLySfYl83TjsI2Q1D8aknhPvJSACVIwkhJWF5d+jtCp5
	 6hcGn3PMh0GVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB7380A944;
	Fri, 29 Nov 2024 21:33:50 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzpFOhQN3yCb4+OpLsfYVrq4mLuUS+SP=H=gq=qSLDz7g@mail.gmail.com>
References: <CAPM=9tzpFOhQN3yCb4+OpLsfYVrq4mLuUS+SP=H=gq=qSLDz7g@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzpFOhQN3yCb4+OpLsfYVrq4mLuUS+SP=H=gq=qSLDz7g@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-11-29
X-PR-Tracked-Commit-Id: 9794b89c50f7fc972c6b4ddc69693c9f9d1ae7d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ba9f676d0a2e408aef14d679984c26373bf37b7
Message-Id: <173291602931.2191389.5966734357629265259.pr-tracker-bot@kernel.org>
Date: Fri, 29 Nov 2024 21:33:49 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 06:42:18 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-11-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ba9f676d0a2e408aef14d679984c26373bf37b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

