Return-Path: <linux-kernel+bounces-351331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C7990FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5CC1F22BC5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B961DE4E3;
	Fri,  4 Oct 2024 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAqixJ6t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529461DE4DB
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070162; cv=none; b=MCp+HvUKOC/qgX6mrRRjgONqbX5xwnlyj9GkiGs1aZu9p3bDFdcntjCR7gW+cLi49QOLBoROX44IIh+L3I5/IHb9Yv0Jo6TjZUY6134c4nPQkTJkG+bKm7NmOEaNILMaog/Lg6YygZ41t7lQ8xqR71WUX5gHpWqzmVH+PoA0/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070162; c=relaxed/simple;
	bh=kTdAcJZPhx85pyMtTZ/vfwqnkuyOG7HOAMI8NnYr77g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oLLwwqzAWWTloPQ8rpf9b5vzssqjkI/S9DjVogb7vDoolriRN9bH4xd9ozuTkr+U1otsprYodiipj7MXe2C3+K+QKxFuSUwd6wlTAwxteqP8Mz/IPxJu1gYTYxwFKdm50I+5ukFEn/VT6Rp+pzq1+ixDZmjQvK06Fvs+bzb8F/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAqixJ6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DD7C4CEC6;
	Fri,  4 Oct 2024 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070161;
	bh=kTdAcJZPhx85pyMtTZ/vfwqnkuyOG7HOAMI8NnYr77g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FAqixJ6tIYpbthOYN8JShD3yUt1EFfZKzOuWfaGYUuPRBrHcPHzIcOzXuWW3/6NZQ
	 r54TlwSz7gr+pFsSZaS+5jVME2Pb+ZfwSSv/06wnmEcG5Qf3RMjmRof4s7zRz1GUxA
	 5HJKrifloMGZHIHkqOzP7iWMkgwyiEUu/UfTElNLCpdOoId4xVxk27qDbCO3TfQS6L
	 c2GywVS1xdw/18ly2vDIJVWkmp2PjGFVF4HkwBr27Odg9IpTkOQbJEvl60wX/1AJ8g
	 I14iXcgy5ffgHH7BJm9NMb7tFHm3Wi9QOnBpzrqE3ReCZBlIcEhBjX9jroh2g59dFV
	 WDIv7gpOLR+AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEEB39F76FF;
	Fri,  4 Oct 2024 19:29:26 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZwAWOkX7bBvhXP6m@arm.com>
References: <ZwAWOkX7bBvhXP6m@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZwAWOkX7bBvhXP6m@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 3eddb108abe3de6723cc4b77e8558ce1b3047987
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac308609567d31fe44be80ab757a5ddf062362ef
Message-Id: <172807016521.2715268.1709781748972726390.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 19:29:25 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 17:22:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac308609567d31fe44be80ab757a5ddf062362ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

