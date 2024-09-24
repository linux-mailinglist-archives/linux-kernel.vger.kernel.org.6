Return-Path: <linux-kernel+bounces-337736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F524984E22
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBC71C23CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E89E17DFFA;
	Tue, 24 Sep 2024 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2HJWP1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49817C232
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218218; cv=none; b=JEkyTm0quou8voO0TBcpf0tuypmQsn2vI3h4KN+2cUB/T4jCVp5ywURKihqR7mCm1olDkjV42Ely3wDNz2tg/R0igTHMtf1UgF5tCmoGKiENehhvKDkkqLRupLGwVMHrpZs1Mjh21HCGsQzEydv3PrXKhMWz7QCQ61f1jrim3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218218; c=relaxed/simple;
	bh=QENET4Mzz9O9DQtCtTOSaE29TyzjkynS61WG9O8dZto=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BaF0ctWrDaR/MKOZUxUDjrmU38fcvviX/Pvst0TEfby2ljg+RDuAm3rUFqDt72A05UJ/VRSmySyOeSp+iDw86DbewYvogbqj60faNqghiX8ynIm7N5txKX3xAq4qtIgXaknGUfIPOLEI9uNjab4aomU4eYrO/+JjVqRWueL2ihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2HJWP1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E44DC4CEC6;
	Tue, 24 Sep 2024 22:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727218218;
	bh=QENET4Mzz9O9DQtCtTOSaE29TyzjkynS61WG9O8dZto=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q2HJWP1r+klKZG1Hh3VLY33Cjlcnz24ykrGbNpSBeHtkxmAVGn0aK/zGmKfH72V3P
	 kjBhfSDxYehrU3HGnJMWq4xhg/2ua+C1U/UiXlxN8f7xqg7SAcsvyif9AlsZUSJ3uv
	 ZAhYfSVMjzr+hIGVMpSc2RYQVY+9VT4B4L6Mht1bmyil99Fe1qPSi3L/RqLxndRbYg
	 ozobimuhca++se7hkRdkY3MXx5i9O4IAOkO79bRlq1Jx2i5e5OzWEV01kZRkXIBOPs
	 kAkHZXidN+NoRkBpVujVB1sGkFNUZ66E0REjtKsTvZc3qg/3z5OwhbyWJj/c4GPNWe
	 TN0tKw+T+axog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBBA93806656;
	Tue, 24 Sep 2024 22:50:21 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd9NGv1D0A-B7T67nK1Md1XYeLH2hjC-H1q=9jF4rFPcUQ@mail.gmail.com>
References: <CAKYAXd9NGv1D0A-B7T67nK1Md1XYeLH2hjC-H1q=9jF4rFPcUQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd9NGv1D0A-B7T67nK1Md1XYeLH2hjC-H1q=9jF4rFPcUQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.12-rc1
X-PR-Tracked-Commit-Id: cb7d85014fb1ca3387f7ff5f6067337b3d7f3c5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4165cee7ecb112c20bc1a05fa8d93d16d11b68c2
Message-Id: <172721822048.30034.15717881172119646062.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 22:50:20 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Sep 2024 22:00:06 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4165cee7ecb112c20bc1a05fa8d93d16d11b68c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

