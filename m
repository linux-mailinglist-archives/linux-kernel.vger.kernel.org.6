Return-Path: <linux-kernel+bounces-332710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD497BD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 470B9B26180
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7974218DF79;
	Wed, 18 Sep 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqPYEZCM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A218A944
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668006; cv=none; b=GtHrtRiVOMovJ3vR3hlKhL4TrbTOuf6IezkwkNv+GBD0WVQtFXWO+7gYK7WasdWULlQtVV1kqcUPCqLAq19H+qsj2ed20znTFgZnnc0ZwNUKYDVjC/vI/XtTTy9XScTmrEo5VjSMsn5qZPv2cbdEwYr5/4G+F6YwHLWA/1vN++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668006; c=relaxed/simple;
	bh=8wWxMBJbfB/nsNlwNlLfLcNmBvmSKqsvyqwmvqiF0m8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NEYHbp2lhSDXeln8eklHVrt3JH05rYbcvU3R+2dfiQZgL0y2o/fyOYp+C+BkHMaWJpLewubLu1/frvRN8Kz4n+SGaxYeYIYJJ5iOuFXtM2d6Kew/K4oHPs27Kz0YJjdiq0e+518cXCnb+KTiDbFxHISvOt6uX/f4ysOZXz+DDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqPYEZCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C63C4CEC2;
	Wed, 18 Sep 2024 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668006;
	bh=8wWxMBJbfB/nsNlwNlLfLcNmBvmSKqsvyqwmvqiF0m8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eqPYEZCMvgwS5v2sKfvo1oRPCzdyUowetTfhSmykqaUuM5HV5H/CGCmxQq2L4Xyy9
	 1t0q08YzOJN0SscnWl9R3K3cXhfivlk4wJGsi0tay7g/r5NM1OBer8bJ2xPELYco/W
	 YujJzuHevkZR1IT+EMG0TDPKpoO2RTRFPAMfnqd5tnecxfdRTxcbczhSOLuHqv/4/n
	 tgmTlI5URuh3QweIrveOq2qYxy/g+Eh15zALX+eduAfHQuLfrsmS958Ep/LASWaHLv
	 6ldVqXxvcf5cTcVh/+5E9EDb2sM4O4iYNUePc5FIrdX+11Zh2Dlm6fJ4KEabx2baO8
	 KmUTTbu/VCg+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C49B13806656;
	Wed, 18 Sep 2024 14:00:09 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator updates for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240916121358.3666562-1-Jason@zx2c4.com>
References: <20240916121358.3666562-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240916121358.3666562-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.12-rc1-for-linus
X-PR-Tracked-Commit-Id: 210860e7f7337e47e77577fa5bb168767e2d8a1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a39ac5b7d62679c07a3e3d12b0f6982377d8a7d
Message-Id: <172666800860.843157.11637456256597096442.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 14:00:08 +0000
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 14:13:58 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.12-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a39ac5b7d62679c07a3e3d12b0f6982377d8a7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

