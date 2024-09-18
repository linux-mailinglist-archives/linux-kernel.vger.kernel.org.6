Return-Path: <linux-kernel+bounces-332569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD497BB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7BE1C23CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E67D1898F4;
	Wed, 18 Sep 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWlDgHFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70409176FB8;
	Wed, 18 Sep 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657810; cv=none; b=fY3BVmIOgzSzTCmImvTpio+4lARLj1+tdM55oyj33jEqzKFs96cHRJFQg+EoPdEvwBTukeTMwfpfUNQ7Rkhm+ZcrCD0y4X1aKEOQFXrEjK9D4xFpNhGXANpqN5JXAtxjGh1UThwLRg04ggX7GyqIcR+S07OAJGuldRaj2Rcp67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657810; c=relaxed/simple;
	bh=ALDkIA745OfR5OoV4M5JTOIB6CYgb4tRakw9Uza/bTo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tof8CgLc3IORgVGdJrAG1MVJpXL4RUkrT8i9vnbD9cKN7HNfoF3FFdNMchef14M6ohC89d5U9FXvqYGKjhoIwQz/UnpGrIHv9a9K/lhX2ahz6u3nFmw39uNWKw0rBQRRmVX7r1yoI4PNwa26oOdxFokuKgsnKYOZEhbZ05adJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWlDgHFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13369C4CECF;
	Wed, 18 Sep 2024 11:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726657810;
	bh=ALDkIA745OfR5OoV4M5JTOIB6CYgb4tRakw9Uza/bTo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KWlDgHFU1gsZmJnIMfeeNzmcaCmdBnUMULBKsGsgaemesqQbiJGSK4Px/m41w2947
	 mmsVa09Sp0PHHm4iG/unv2MV4JDkLx10SI9lj8IHLRPoLK/wjLinVBLUfqCgjqxHRa
	 Hh1GYjwnARN0NNOQRGJl7MwNg0tllhZE6frcuXbgdLif1ioq8lHyQuovHqUlSccqvy
	 duvQ+UGSSwZQm8rDcNTj5PoCqQljirxtorUYXpF6FraxFWIGP+YMr5IqsztVv/ktGp
	 /48stMo/y1o+1va/pmDwST1F61VxYjs1qT1HZDH8Y9fMZ9Sb1LZuf1yyLcUBejF+VM
	 xCjlNy3UaAcSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16AC33806656;
	Wed, 18 Sep 2024 11:10:13 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240916164526.1161583-1-linux@roeck-us.net>
References: <20240916164526.1161583-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240916164526.1161583-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.12
X-PR-Tracked-Commit-Id: 2cb4acf2140be8a4f299c0b887cc314845ef6ec8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c27ea952c614779db84bc2326e686ba7cc1c865c
Message-Id: <172665781194.783948.7910291012457649945.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 11:10:11 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 09:45:26 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c27ea952c614779db84bc2326e686ba7cc1c865c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

