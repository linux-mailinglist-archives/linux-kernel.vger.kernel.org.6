Return-Path: <linux-kernel+bounces-433850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0F09E5DE4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861DF16D3E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9D6227BAA;
	Thu,  5 Dec 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+BYOYBW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6E227B92;
	Thu,  5 Dec 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421846; cv=none; b=GDgU9IBit2suO6ZRVrQyckV5qMECZqag2a7YKlZ4blV+Zc1wG0/TmsK7zSNICCc+uOW/IWYi+FEagdY6OO4ZCTCo42adj5rLnO5WdfQaPDQcvPGWXw6juAMwt8pOfHn7MDqYP++0+M4RAJWockPV4WEx8nxiW2i471HXlQioOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421846; c=relaxed/simple;
	bh=Tc1K0cGBA87seGcnVccWvJN/6iYvMywul7HFh3GlU/Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s+jk0v2F0WSgLe2jogjyZOPGHUj1WmsKd8wWDYAP/80bfpVRePX6tBVt/z4h3X3afeDtYCGKCO1L3TzttDwfNUE2eLbjHYDhLimhnt4dpq9mrK4zjrdWU6pE1Pv5J4F5+4u0ZaCbh4Qq9cXg32tCkdAmwcD3CzKa3qbJumcr1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+BYOYBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6D7C4CEDF;
	Thu,  5 Dec 2024 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733421845;
	bh=Tc1K0cGBA87seGcnVccWvJN/6iYvMywul7HFh3GlU/Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X+BYOYBWRlK9/5LVwN2OcvtUPi9P7kId/E32mR7ZYK5Q7NB81RgZPiRi8ZNAZ89rT
	 hF3+h5d9OqiCU8MATXHaLLrQY3JizSH2cKF/aw/YNtsS3XY3sB6WTnNIUgHXqpN9Ok
	 kD6FxyJnIBeXbZ1IEZPjdtePHcUkDO+Pf50LY2qx5fM9JccOigmpMeSvPDbiNaiYEM
	 50vXCtHTdDRFmfJ65Z8iD2kPaSG4Wme2WvnhC9paoTHtcLtv2SDSaC9cQhCvg91lSK
	 Ka8dWx62nxXnEm7A766XZh2EM1jcQ7UoCEPXgz6MJjcOlLRenioU+3D0TVmlTlSh1q
	 OdlW7imYNbbJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE46D380A951;
	Thu,  5 Dec 2024 18:04:21 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.13-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20241204141206-1813515751@linux.intel.com>
References: <pdx86-pr-20241204141206-1813515751@linux.intel.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20241204141206-1813515751@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.13-2
X-PR-Tracked-Commit-Id: e9fba20c29e27dc99e55e1c550573a114561bf8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0769a8f69ebc4603d5c068112b7caf2f2187a1e6
Message-Id: <173342186032.2011200.14942856430930016979.pr-tracker-bot@kernel.org>
Date: Thu, 05 Dec 2024 18:04:20 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 04 Dec 2024 14:12:06 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0769a8f69ebc4603d5c068112b7caf2f2187a1e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

