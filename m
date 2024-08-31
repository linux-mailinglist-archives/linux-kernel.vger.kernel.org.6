Return-Path: <linux-kernel+bounces-310012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9048967319
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 21:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA2828370F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9418317C7D8;
	Sat, 31 Aug 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhH6jfKf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CDC17ADE8;
	Sat, 31 Aug 2024 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725131633; cv=none; b=H+Nv3ekOCAz1KO0EeinHBgN/DvmOmSLfpRY7CWac3OuwiY/adf/3xq8iEkZvoYC6vgNfXzoC5YOEIzY8M4m4MXacsb4g3zy42hqz3PvHcZHXAdn2Qyh9CflX+DpY3UuawOKqX5vCn6tirGEKoY/zubXcRjCKdlIlhr6Qq41YSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725131633; c=relaxed/simple;
	bh=RYG3gy/oG2IMT9vBe2RFrC5np4vuiADPid5nAhxY3vc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EEv0H1k7hM1M94UYrMEtA57rmwedRn3HUqegAGgHhH/mFI6sDi9SzWKqtIN1dbaLXx1oejdQHhWyUNWqYMJPzeprRpUksdOt9ldMguj6TYId50hQ0Dg+UDXIKWOkvk2M72jQRyxRjw6tSltHGOv2cp+ysQPBw39yaZHhox5ZtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhH6jfKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF31C4CEC0;
	Sat, 31 Aug 2024 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725131633;
	bh=RYG3gy/oG2IMT9vBe2RFrC5np4vuiADPid5nAhxY3vc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DhH6jfKfn9gOozgU/jOSQVOpco47aqq75aa+V93A44VvPbZSDz51ENpof/VkXsmKN
	 oA/iZ041hy64A53LeubEQHui+7H7LXSMT54m2wQV4GDqOEhnKUKhIYPG3BJglrby8/
	 uE7XFPJD5N6Tw/UlXUHZNOJWogUMhM/UoPp+5aMmCU8neT6rGmN95ox3aFgenk8w21
	 iRa5AHx5JPyXmN/GIC7dwVdsrsFp0mesR/YSuHckP90Y4Q7fRuAMcsHg1P9hQkuvzJ
	 12xtZiPUAKc8V3R0U58IE0lblWIwMQZChML4rVlpmtV83ZcBGPPoOmTFWrKJjb1acp
	 tOVQkpS8XPfDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C333809A80;
	Sat, 31 Aug 2024 19:13:55 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZtNVkRAgDKh7q0Nn@kroah.com>
References: <ZtNVkRAgDKh7q0Nn@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZtNVkRAgDKh7q0Nn@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc6
X-PR-Tracked-Commit-Id: 58c2fa54257d640c83137b44e12c174fd660a485
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8784b0aef62cd6117e1c93c64d060e4c7314a1f
Message-Id: <172513163392.2915779.17711697234749117283.pr-tracker-bot@kernel.org>
Date: Sat, 31 Aug 2024 19:13:53 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 31 Aug 2024 19:40:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8784b0aef62cd6117e1c93c64d060e4c7314a1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

