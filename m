Return-Path: <linux-kernel+bounces-299844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A195DAB8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB165B225CA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7621BF37;
	Sat, 24 Aug 2024 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/UrGGAF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240415E8B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724467606; cv=none; b=O3oHNA60kYOOoKXiALmniMaN4lmbwKEnbwrVbKw+GR0kWF0q3ARbyK7tuQ5RiM2u8xqitoT1czpUE3J3GOblsxIVfHfiZ90xzgq/TmzwemzfQKfw1pACK7OHQ++70bom75Ua7T3hlG+d0Sk7gY3G6X1RiQzVEeNwoOLS/1YcsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724467606; c=relaxed/simple;
	bh=sT6QSXHcBOraxXyWVJNG3yOfIz45SkRMNOnKFAQNrr0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j8qevCSjsb0aEkrBhSr/7Vdd74wkQRmhMQdtDnq/YoaBvRHW9ErkxA3Zmf61wKT0OKCM6OiMykbtDWTbAUHgHTSG68e54IoA0U4Z4FIB3umbuEcBfKG0pKgEwL9kpzDBa7ITmXXbyDDJ/ZhIzVoq4yBFcqJfJVPrQy5DNrXES/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/UrGGAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5E5C32786;
	Sat, 24 Aug 2024 02:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724467606;
	bh=sT6QSXHcBOraxXyWVJNG3yOfIz45SkRMNOnKFAQNrr0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N/UrGGAFt3IpaTq3MjNqben+qxO2PclFwLJpJVeEx/b6EJwNHTThQ5b9nB2O9/vkT
	 2WtxEVYnN5zq8vyVEIAlXFQ9UTUuuxNwNubpncYG/LuNyfjo1P2B/ccmxVVM3zxQU0
	 DE0ubMArDhyP4gcMiQ6n7eCi+G/cYVELGyokFCKd5jol3xYlcR9lTcuGtqYM4BaDoX
	 +Ac0n/Iw6cJz3kKafXs3x2GtZayVMlz7ybChjVOM/SFId6PJsfbWzIGDCZ6xHIxhEH
	 2dbRZ2MlAq7jPEFLQW8uIaSmvbKG53lEvwpIiRe1a5rN84ufFuHPjWA5sfTHQOXC9t
	 ZDNsQLP08GtFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2B4EC39EF647;
	Sat, 24 Aug 2024 02:46:47 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue fixes for v6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZsktB3D_K-80uc35@slm.duckdns.org>
References: <ZsktB3D_K-80uc35@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZsktB3D_K-80uc35@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11-rc4-fixes
X-PR-Tracked-Commit-Id: c4c8f369b6a6d21ce27286de1501137771e01dc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb2c84b38082f8bd052bf909c7da344b83578ace
Message-Id: <172446760577.3138696.4128010194755918888.pr-tracker-bot@kernel.org>
Date: Sat, 24 Aug 2024 02:46:45 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 14:44:55 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb2c84b38082f8bd052bf909c7da344b83578ace

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

