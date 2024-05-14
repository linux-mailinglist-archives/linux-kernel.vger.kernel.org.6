Return-Path: <linux-kernel+bounces-179209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC808C5D60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616B01F21EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D51181CF6;
	Tue, 14 May 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJFj51pv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C9181BA3;
	Tue, 14 May 2024 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724021; cv=none; b=k+6DpK3su7mn4G3IaiHndY+ZS1q93yGlSe6QXJGgWa6/lX4b7WXz6nfn6iggN4qM5kqIA9Ead+kIQCzKkP/4zYE57wnykP/YpN4bKGXhia2PSPq+yyqKjrXX1ZeSuqWONXkpro8eF4SdzdBiE3Xr7FxdL/+VoHlMm9+M7idtGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724021; c=relaxed/simple;
	bh=28LgcHXu85R25On5IeNvhlNUOJ9Vci/Hu5MkSbpqXbU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LX5Z6iqePeTeJWssc8ULGMsk0KtE8khjL3SI0/7vFYsGTVcAO+FQ/HuJwtTIruPYIPSLV+6pNRbmq69CW58uZYp3syn8OzmZS/tAqIBnZmQuHGPArVdq2J9td7cZCsf+XCQr7xzxeg3uP3rzTSyIS0Ii+k/l68DTwwBPbwq1lt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJFj51pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1C56C2BD10;
	Tue, 14 May 2024 22:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715724020;
	bh=28LgcHXu85R25On5IeNvhlNUOJ9Vci/Hu5MkSbpqXbU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GJFj51pvIIvHtCxOrCenH0g6EFn4SZLDlMXej84NZFqWzdz5harKhVp0hYxvjsHCM
	 sMPrtEyY0jCVJUIMC1yc2NhFCyHLp/wawldkjxKIDpvIGv0YLA/taDI2lKGPRRLaw+
	 JRTYhRV2tueVBJf0IXMXLlg5XMLg8By+A/EUcFIXUER3r9KhjnfSRvEawET6KL9xn1
	 7ZmPtR0LmfC2YKhD5mFj5oU6l4QokpTf2U4EAD2On4wE3nC0mTXKTIfY7U0Dgeujfh
	 hUxK06awcdIgBFriyemUkZngnJJaibyZB5gFupRItHe1+gSVOUr2DLh2qYTuKN6Ofy
	 StDmcDyDmBzXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1D9BC433A2;
	Tue, 14 May 2024 22:00:20 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513230827.983884-1-linux@roeck-us.net>
References: <20240513230827.983884-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513230827.983884-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.10
X-PR-Tracked-Commit-Id: 5fbf8734fb36cf67339f599f0e51747a6aff690c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8cc7eb996f751e20c8c6454601b9184f010aa07
Message-Id: <171572402078.23495.303463128949491025.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 22:00:20 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 16:08:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8cc7eb996f751e20c8c6454601b9184f010aa07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

