Return-Path: <linux-kernel+bounces-178273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8F8C4B51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2381C20FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515538385;
	Tue, 14 May 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS5M5LW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752D219E8
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655091; cv=none; b=EzSvlxLFEbCHnIEFr1k+0f5WhqNkjdxgE/evdQvURiTdPWOkK0ecombZqJlSfxYafUk4O/2j5RlNjIZmGgy1AD8tHVsFH71Rd3FPq+GjLB04Au+6vE5F0PwwHbaeMqqC9JoZSKj9MFSrTcEWyege4Oa5ym1/GdvBLLgos/sOUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655091; c=relaxed/simple;
	bh=hbRno/yK/oZD/u5sfmcRQBPckaybxlj/4y+bqyAXXR4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G36tdJlH/v+7tmRd7Gi5rsBP7hE+H2F1S4nd4eyYHaUIK9RmJzUMnevILO+e/fPALd7pyT3jBTQYjGmjGnIT0+wW2+dCP2QjtADtY9FLUQuRVCX9sldMi7x2Ykg//BMG4R3CFkBpqvdF8Aexfy4IyOIkuHGJ+x/WhlrnOUPwP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS5M5LW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD10FC32782;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655090;
	bh=hbRno/yK/oZD/u5sfmcRQBPckaybxlj/4y+bqyAXXR4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NS5M5LW2gTRwPRzj/RVhnPCOlTqtGLjPB7ScD5YhkMI7mKK8oHNm3iVAak8iWLFqr
	 mSciWXFjK5ldNYYReW7F84ypc934C7fYxVHQqkbmE4+q8hGw3a+ewd4Yv213D4WjRI
	 vGj98TSPkNSWyOEO4tyTE3XqOeffO7dXlJXu/I9/TYYi1SjYzGcE42n3BhthF1d4NL
	 9RmgFz71urvPk3271KiRYWQKhPJWCSMOF4ExtdzTVWlkU19RFqdRuX5b/Gp9BCqI7J
	 GdGyAz6s2jca5EjA3qvNqxt4AOYKRh6XR3dq0EpArWp3e8Jpni25MIhIyJKt6bWB7S
	 54rji5TJ/unlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6EC0C433E9;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86/percpu changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkHH0E9XmbUSEzA6@gmail.com>
References: <ZkHFtnfjXcZQX5ds@gmail.com> <ZkHH0E9XmbUSEzA6@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkHH0E9XmbUSEzA6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-percpu-2024-05-13
X-PR-Tracked-Commit-Id: 93cfa544cf9e4771def159002304a2e366cd97af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e76f69b91e1ad11e9df68ba6ca4b4ad2bf39915c
Message-Id: <171565509087.649.12413070936063404609.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:30 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 09:57:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-percpu-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e76f69b91e1ad11e9df68ba6ca4b4ad2bf39915c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

