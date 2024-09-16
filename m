Return-Path: <linux-kernel+bounces-330166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914F979A88
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1F32842CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28DF5C603;
	Mon, 16 Sep 2024 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWERbZMv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1C2E659
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462810; cv=none; b=R8dUX2XOij0O+mL6/PDQdM/de1XWHObIvU/sLZL1EEepbApx//b/paf9J0XRQnuE8E4FNhRLx07x3XHMR2ennywyENQqmUwWdJDF1ahCfgq7+l+QDZuIQr3ur10ZUiwqt/wz8xT5lTAPoV63r7I6jEWeBRwSRBs6kXB53Qi37b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462810; c=relaxed/simple;
	bh=J1Gea2SmMkRpKsoM+R8ADMrak1dfQ//8CcVMN4jKc4Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hAtkIkb/FIAIj/AHAF5NKk07E7p7ifuHThAzneR8Axjt5V1dJTr8rXUKG0s+tnQYXG6EXaNDUe6OIvTo34rDB34u0trpHJ+4Dixg7ynX/nh1fzkbujHHL6gD0sqN3cgop5i5LyDunWsFJLqecjn4+quYnQ91hfgHY7PUpcXTZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWERbZMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE704C4CEC4;
	Mon, 16 Sep 2024 05:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726462809;
	bh=J1Gea2SmMkRpKsoM+R8ADMrak1dfQ//8CcVMN4jKc4Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qWERbZMv3DFuoVgSlOZ4WmjhDF2b371Er8FkWsIiKmckZH9lWlqBHigqIdJcpfu77
	 JFXpiNOdgvf/DTxQ3/udRwoqPeo3D5UxjtaY3aCySIM4XOFHsjWIZKAXvVMhG1QPYx
	 7kf5kZIeR2h5XTVfSqsnbir3jW1K8SrBeDKJ2GVBRxZIWylIVys++OW+M2awYXqsZt
	 Uhsv7UgfvTeI5S5MvyvMLMyuxrT6oIADdiuLYCQmF5rhEyFAEma9Fea+JZB+TK+NCM
	 XyFxJK1ajuLMKobjg3njH9DWD+rQ0D5mdRgL+mxMQZI6ovGQRl6Nb75X+1eP7et+mg
	 dndDyhI+vDx4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714873809A80;
	Mon, 16 Sep 2024 05:00:12 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240913164001.GA24426@willie-the-truck>
References: <20240913164001.GA24426@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240913164001.GA24426@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: 75078ba2b38a38d94017bd334f71aaed205e30a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 114143a595895c03fbefccfd8346fc51fb4908ed
Message-Id: <172646281108.3240541.12447998392029137874.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 05:00:11 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 17:40:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/114143a595895c03fbefccfd8346fc51fb4908ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

