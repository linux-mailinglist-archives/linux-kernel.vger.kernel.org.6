Return-Path: <linux-kernel+bounces-409802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF19C91DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26F4B25E71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769DD19B3E2;
	Thu, 14 Nov 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnKiH8ju"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F73FBB3;
	Thu, 14 Nov 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610227; cv=none; b=pWS0iPNJb6VQJOvFQ4plkuvE76uVukLChdXLJ6Fcc0uxsg+2yC1Qbg7um0EiuTQUzTEZfSdUUWDSvmJsDEPiG/5J9TAsxrFVJ4K6VD0tCOm8Gf1okwQOeQ+ykputwsN3OtJXx6LVlYzUfyF9K7XWUgYbkHHc1W4GdGoyYEvo/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610227; c=relaxed/simple;
	bh=8F3U00WV1sc2JKJIoXZXmUjcVQMLy54YzqhvPXzpfCU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HXhK50ewcLnzzjtN04sV5shg25tKcgyrqX0VuK1tuBmTcMmiHozLGamMR+nm6P7Ml7aAPJY9P8LUUuDa1qJA3X7XnCi2oJPJD71sBNUCt9EdZy6g4JDb+0vbXZjcSUlS6bZOXEQ6xP8FAndqCUjxyouWziSV1kHlySGcHKdqP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnKiH8ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96F0C4CECD;
	Thu, 14 Nov 2024 18:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731610227;
	bh=8F3U00WV1sc2JKJIoXZXmUjcVQMLy54YzqhvPXzpfCU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NnKiH8ju9ch7DxJnzB4nMlB2OHk2qpZVcAcz66xFxwXTfSxr6bbvWvGy2BqGO+Pm+
	 6WGnfUZMIZAljLamkatGzXFzuSh8qhgMVIBQ3rRp9xjRfTU/WKu0yARDv2OvURo66k
	 Pe364U5Q0NL87RyHwcLG1T1WrIPLIme+QjpKNaniMn8feM5XqRf+N3JYO8vW8gTDzF
	 S46CMzTzAaZ0uybyMvqBMypQmI3APOVEirV4h2tJDG9VYUE+0hpKAan1hveKhyyiNa
	 eUFMniYTEyMsbUWkPvBQbJ3fOP0N4jWS6OVusWAv0oUDyoUUA31prFrmSi6zRsPReA
	 65ToYW50x1exQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E843809A80;
	Thu, 14 Nov 2024 18:50:39 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.12-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241114130846.94852-1-pabeni@redhat.com>
References: <20241114130846.94852-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241114130846.94852-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc8
X-PR-Tracked-Commit-Id: ca34aceb322bfcd6ab498884f1805ee12f983259
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfaaa7d010d1fc58f9717fcc8591201e741d2d49
Message-Id: <173161023795.2023216.919904636063156671.pr-tracker-bot@kernel.org>
Date: Thu, 14 Nov 2024 18:50:37 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Nov 2024 14:08:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfaaa7d010d1fc58f9717fcc8591201e741d2d49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

