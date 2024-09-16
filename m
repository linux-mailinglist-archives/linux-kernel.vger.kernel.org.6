Return-Path: <linux-kernel+bounces-330564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50197A037
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10851C219CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801B15749A;
	Mon, 16 Sep 2024 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxXnQ+IS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15716155CA5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485959; cv=none; b=XvsjmrMU8xKl2HyEKaCr7JCDayL7+GRDTy198bOs+BfELvrizhQCD26nxReeje1DXTCsElHtI7YxCqUmvuBEpxVC0JjQktOVbVIYWGrHks2KLSKyxRgHL86MSJxDSQ6wNxQwvkwAVwuVJCvhHH73C4B2m9Wv9m0z3R8isZp9dGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485959; c=relaxed/simple;
	bh=djY62pJeIQ4FC3PgNlSMECUIaJ6uETnhddIf+NjYRJw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WLEGbBcfP4iSLlf5a3nhWz5jZhSq56Zs5f+NjUJ+oc2ZZCwFvPifCM+e44VsGPHvfiC7VoKh0EJtvGZN8aCqT/9d7s71HROM5yhOftaofx+9tMx3dtriReya/n+QYil+1UcR0bkbkykP8Anms1cd69/gbhGavY5GhLmSLAuacjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxXnQ+IS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6717BC4CEC7;
	Mon, 16 Sep 2024 11:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726485958;
	bh=djY62pJeIQ4FC3PgNlSMECUIaJ6uETnhddIf+NjYRJw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GxXnQ+ISXV6OdLn6Pw0CVn4xnfOq58X8mJUoND1IXJnRRJlpdDIDglhG9+0OttWbP
	 PN25LxL+BiHJuq9paeLkhwftez3zkmf4cYuJCMsN74U6aalrMMBpfnh4CEpsiRWu6B
	 ZXqTmypm9nTwb7kSC6TC6aRU6jm86Ac4WvPRjr3ykN1Sj8PYEe6wOB8wceO3mGn8OV
	 GpW5imoOuOLuxNE+vCIgADUN+aDOGNFUfqwlwKoKsUdDGaSCFwtSpwQgBCn3YKF/B1
	 WNl7dru4oGxQksHrywvDURWLXmjGPwTrz6UAtIAKsM6m0XHQc71Of5rPMBpRXOoVFI
	 hjiYYmoHP9m/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD73809A80;
	Mon, 16 Sep 2024 11:26:01 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZuR67f12ntVf59FZ@debian>
References: <ZuR67f12ntVf59FZ@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZuR67f12ntVf59FZ@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc1
X-PR-Tracked-Commit-Id: 025497e1d176a9e063d1e60699527e2f3a871935
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69a3a0a45a2f72412c2ba31761cc9193bb746fef
Message-Id: <172648595965.3656894.161718696410625414.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 11:25:59 +0000
To: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Sep 2024 01:48:29 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69a3a0a45a2f72412c2ba31761cc9193bb746fef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

