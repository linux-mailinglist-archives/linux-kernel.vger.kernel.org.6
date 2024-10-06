Return-Path: <linux-kernel+bounces-352550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9AE992096
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FDC1C20C90
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40A18B47A;
	Sun,  6 Oct 2024 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjpl90jO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5C18A95B
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728242039; cv=none; b=pGXHFHxLwSFhMVo5BfoeWN50maeylZP7D9gI/gNJgPfTje5aPpDY1cdn7snAQTQuhDeYD2t1Svcc3TskQ/FY6IFOGcdy3YlxEz7bteeDhzHRNJKVZNs+ticPTXSyc2poGuxwd0uot0nxsOXYFiLGq7L1eKXI0KggA4s8OcvSfPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728242039; c=relaxed/simple;
	bh=QqHODBGAmDsDiewZwnqtkjjxYYRrjU2tBqPeDbGJGMY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lwFHfTNgxoXBSmLKUB3boCPgnbV4JkcWl5urHu7lx0s8raOPDLCnx6ZNzmUWX+mYDBYZIJCNjE1IQUX0JQ3e6gAZN0oHxn6Hr1IdIXuAFJXDOz/nva8BksDUiFK+uq0a/6ou87sBPVX1qnUgRwWGh9LHEHiwxr5vLyzGnnmKB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjpl90jO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB99C4CEC5;
	Sun,  6 Oct 2024 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728242038;
	bh=QqHODBGAmDsDiewZwnqtkjjxYYRrjU2tBqPeDbGJGMY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qjpl90jOtr69yJY9D7pwkizOhbAy3szzY6rVd9P+bS0p1uokZB15c6i6JAAf2FT87
	 VOsAhinf4FHarbSRLKQSn/86UW4+1T4CbaL9YLrkJlbQqRRO5BdRUvEfmPOBoSUsd6
	 uqhnnQ8gBqx0hDE2lTxyLI7Wb4z12plsRgYih8R43/85rZbcs/gU82uygfA94Gw7jI
	 uQWCo8kIT9tXOeS6LKcrCSETjZMyNDGy6qPZFDFdRp2MNDHYd6/YAy0BvnYffR+kly
	 cudkFw5yob8ljgmUs/FhyjHNdB2A7FLGu3dBnkdHLRTONOJNuv/jzk/Tb5rAi6snV5
	 AqmPSokC1XePA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB63806656;
	Sun,  6 Oct 2024 19:14:03 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87bjzxlnmx.fsf@mail.lhotse>
References: <87bjzxlnmx.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87bjzxlnmx.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-3
X-PR-Tracked-Commit-Id: 4b058c9f281f5b100efbf665dd5a1a05e1654d6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3ce5c30a0e05ee3600c82925bebaa4dc1b29cfd
Message-Id: <172824204192.3486601.14939940245333023042.pr-tracker-bot@kernel.org>
Date: Sun, 06 Oct 2024 19:14:01 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jason@zx2c4.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 06 Oct 2024 18:02:46 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3ce5c30a0e05ee3600c82925bebaa4dc1b29cfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

