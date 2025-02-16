Return-Path: <linux-kernel+bounces-516443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14AEA37196
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 02:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0678A3AC676
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF53C8E0;
	Sun, 16 Feb 2025 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b59G1zAE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A268653A7;
	Sun, 16 Feb 2025 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739669419; cv=none; b=ibHqDp+3Dnq2cPMDD/hp5SdBccFj5DVei2slsfBw9uQn/eM0v+vzAY6HEsP0PHZmqbyqP+yaPByF8I4Xhf/2c5beqD4cKQYUnwy5BlgB15s6dzgbtIVRSGsa78sVAr+FQxWZXwCouUnJKYS4duIacqP75vBpC9YMhenV/SEzaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739669419; c=relaxed/simple;
	bh=cUfsJbRkIbD9gOc0OG1IMMQqFBByjda5/ElgLu5N45w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Yeve7++UlAue2Nr/xJGIdWu5/inezGdVUdIAd2P80d3Y966kOpAQiEAOesmEEzSfO13/4nc3RCkIITLoK+nytyt1kShj/fTdQo9j118jGkrqDV+RTT2Ef+SsJ+l/zi4lJbnApt852uNyjGMJ7CIQWIQStSyak7q2K24axvfwVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b59G1zAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FA2C4CEE8;
	Sun, 16 Feb 2025 01:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739669419;
	bh=cUfsJbRkIbD9gOc0OG1IMMQqFBByjda5/ElgLu5N45w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b59G1zAEhpBjix+gyIvvU2w8Wv/j9xm/ZJ3+Y7y5pc45gUoHI9BmUzEWwMMBgcex8
	 mJDXJ4EI4RclKFiTLqxVs/OtquCWyoJOrUkcoecr86aXccrm4UjhwmSguOfXcCAtnN
	 Qfc7S18JjgvhJjtzPCHogZQ1kDVpb4ciOO+akQYX+rHaOLskSoeHBIlQOsLEcSO2OW
	 Ac5GmVIlBH4yRsXnUhWTxDHqktLxvDNFbiROAlMD57UGbe8Wtw+qpHhC68n3jT13f7
	 FrdjLVoatoA942OX3PDMeFWR3ebWFiiW6fOJN3Y0ARd9Ts2spzvs/FqvnP7KKQjZ2g
	 c8Z+izZ828k/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F34CD380AA7F;
	Sun, 16 Feb 2025 01:30:49 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.14, part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250216000325.GA1688225-robh@kernel.org>
References: <20250216000325.GA1688225-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250216000325.GA1688225-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.14-1
X-PR-Tracked-Commit-Id: 038e33fcd40e59b60cdca561c2a39998e6759e08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad1b832bf1cf2df9304f8eb72943111625c7e5a7
Message-Id: <173966944874.2368117.11573699023523436396.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 01:30:48 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Feb 2025 18:03:25 -0600:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad1b832bf1cf2df9304f8eb72943111625c7e5a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

