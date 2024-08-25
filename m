Return-Path: <linux-kernel+bounces-300215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776E195E080
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 02:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214FF1F21AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 00:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD924685;
	Sun, 25 Aug 2024 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRU7SFtG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156A2119;
	Sun, 25 Aug 2024 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724545360; cv=none; b=IR/Zfh9nFD5FnVVdYEwoUbVEYuaI6xWl00ulNgLIJNp+CF0pUgzoWq/sRg4w3kTZppvBFaQV3eKCARkrQqN4vYzc4fkcOSmHwSSgykItnos0wA2hSgY+tj+yOjdoDXs1zqgu5BkpKZO864DiwTphFwlMVeWBgJ/L+s6mGCxbuxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724545360; c=relaxed/simple;
	bh=dfEP1FqSBTUx2gtoUmR2H2w9t8eUoRGLIgE4sMDcAXM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G8kRQo0U05eIeb7UivOPRzm9i+ncogqzTZV89DE707tD3ZqlfC/u7F27+7zc8YPPJ4btVMZ4V5g+ut6bJyv4HYPm8mNz1I56ReljxCsPRp+ouCOy0CaEtrals8sMqeOp1zxaZvzee3yQJN1USkH9LCeIvQkm/p+cUDL7rBhfl3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRU7SFtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CD8C4AF0B;
	Sun, 25 Aug 2024 00:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724545360;
	bh=dfEP1FqSBTUx2gtoUmR2H2w9t8eUoRGLIgE4sMDcAXM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mRU7SFtGPXrQzzELGMuIut+2tP0KP/pNWwVH7RTbClRl2/seOQkvWC3jorH/Rd1lt
	 0KagLWxoNT3BnJObJS2fHPaenSVEtJlU5CwDrsZeI2WD9fusxMWsEAqxgBlG0ygipO
	 kjv4kfCRtlXeKzifdaRXOtZRDobwC3U45lb/pvy8Fo1s2T8pPAOCOWB9/7M9QTg3is
	 ugy3k0at/tEhfg4yd16MSRF3Rell8p1MPOKXpi4NoUKzbA/5Gh+KmGK2crB5U0T44B
	 6MZnuQ4/75fMatbX6IBSLQIL9t5NSY4Cu/TdoKf7NaZ2OiBxzx79PybKjXkbgSDIhQ
	 LQxyX0HqAiR4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF923823327;
	Sun, 25 Aug 2024 00:22:41 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt24xmXoKUiqHhGzEqXxwusQQQ9iQk0up6xzMbP9xfrKQ@mail.gmail.com>
References: <CAH2r5mt24xmXoKUiqHhGzEqXxwusQQQ9iQk0up6xzMbP9xfrKQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt24xmXoKUiqHhGzEqXxwusQQQ9iQk0up6xzMbP9xfrKQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.11-rc5-server-fixes
X-PR-Tracked-Commit-Id: 2b7e0573a49064d9c94c114b4471327cd96ae39c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 780bdc1ba77646c3461f1988b12c42c60f836d77
Message-Id: <172454536033.3302759.8825895372061602876.pr-tracker-bot@kernel.org>
Date: Sun, 25 Aug 2024 00:22:40 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 24 Aug 2024 08:35:23 -0500:

> git://git.samba.org/ksmbd.git tags/6.11-rc5-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/780bdc1ba77646c3461f1988b12c42c60f836d77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

