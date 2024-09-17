Return-Path: <linux-kernel+bounces-331438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA2F97ACE7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128FDB2BE7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CE615F3FF;
	Tue, 17 Sep 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7W7UbGm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB8415B57F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562239; cv=none; b=INS0jCttSYLLljwLi3MIq9+psmLuiWQLX4kz17MyCTGRGlhQigOqLeTp3ypHjxNO63CsX6V4vhPFvE5W3HlIZ9aGOPr9VmnwbrHvTB70feROR8QI6oK91Z1x6nIh6Xct8ObP9gOZ8qVd9pqlZLrcgd7b3eQcQ6WNpwKtVMmqKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562239; c=relaxed/simple;
	bh=QokYDtRyyHs8noEbsauqikkCBRpOOdz4rj7awP5lnQk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CW7JutCYeY0Hilz1gk/wwBUY39E85mBOWbrxvWzAHOfzpyJXFbNAXj86LF+K9x/2+6a1l9atT0fa4M+SzR5gMgeuYdzaddgstzUUGf9K9LehheLGxvV74Rwva2sFAX8pCtF49gVgG1dFFUqO9kTQGYiNgf+mirn1wE1N63cauFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7W7UbGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3E0C4CECE;
	Tue, 17 Sep 2024 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726562238;
	bh=QokYDtRyyHs8noEbsauqikkCBRpOOdz4rj7awP5lnQk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r7W7UbGm9ZsO52lYxDGXWGU6+0lNC8UuUprIGufO/YlPRt1hbSI9o3qYlDfxI5A1a
	 92GnvFwQf/eWuhh7JAUremwohOJYYUsdqsEiYLPncaqWeq/p18CosGrmOc16d0Zo8f
	 PDXrbmZcmfakdhx1s7Yg94YjoYqnDc5revX5n6gUZwI1BAB/7rxMS1KKGssEQTIFzp
	 ZyLnZPGXuBiyJp7BMCJ/btwpE4ImvlhOe9ValHoc7KNsRyt3TuDoW/7vK6naruo62M
	 j9SQGOAe9409u0Ajde7Sk+9UxnP39xnhejBiveRlY3gogz7ATPVl1FfM3A3Zc9jJME
	 gWyChPUU9DKiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACED3809A80;
	Tue, 17 Sep 2024 08:37:20 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <bc62e0a65070a84b3edaf3c03d6a4bd1.broonie@kernel.org>
References: <bc62e0a65070a84b3edaf3c03d6a4bd1.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bc62e0a65070a84b3edaf3c03d6a4bd1.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.12
X-PR-Tracked-Commit-Id: 4591a2271f2e4c320eaa63c348169e4e6e6f2852
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6df928086070b4db8cadc31a4424524f57c584ae
Message-Id: <172656223949.49587.10402951885452485300.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 08:37:19 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 00:26:27 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6df928086070b4db8cadc31a4424524f57c584ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

