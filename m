Return-Path: <linux-kernel+bounces-202874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD4F8FD238
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870F91C234B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625C614E2CA;
	Wed,  5 Jun 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcI9E5s0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF710A0D;
	Wed,  5 Jun 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603144; cv=none; b=TfauEGsOI52VIyiIgD0ttDD6XwMulEik+n9a4eBzdNYah79oD2sQ4v3Y6B3KHivBElaMBzFMyKB0kK/ie/UzfvK+2UIwAXYtntFhgUZk+ZG5YGSwMZZlu2DP998Ama6uzjuRcTIkKcsTsAWx6UjGh8TaQV3p6dz8SwhOhduxRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603144; c=relaxed/simple;
	bh=GzBIWIv61sAJ9yFR55SxyqZ0swetgU0jo9y5+0368oE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jHJaJ5YYQxUNZhOmRtbBwZJZtZNfevitVsETQXJp8VDjKvxq5gLuc9E8tyVVbEFkYkKE8mubF/6bdDSGaSPNiHMAzfLFtPQAmx8cGkUzxyH7YBTHwSI2ocGIfoay19PC6Dh0MERE/vE2+40+qlQpklidiFTVom71sMvzGb/IFRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcI9E5s0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79235C3277B;
	Wed,  5 Jun 2024 15:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717603144;
	bh=GzBIWIv61sAJ9yFR55SxyqZ0swetgU0jo9y5+0368oE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KcI9E5s0OPuqfeeawfx8aoocTriZ9hyDSr5JosVMF18RVJSI9OeAEMGOGyYHuaGgc
	 JjiXZp2xIrJ0b+c9d/sLgj5XGL4wgYqle7kept83zP1XAsa0uhWItEUNhH5XkKMOgw
	 ZrTDsSaL9qT+ao3zi2i5ogSkHMiFoeZBjm+9UpMmxCMbApdrP8kCO14IJ+EST3anos
	 5NKkeKOE1SyiE0oGRLHQ+qn/xh/y88IGOUOlhg0RthJTfGbzsja4vnTEKgRTmGOq7Q
	 8NPEw6r+S95mqO4vuB6UiULqw0264StSAUgRfBrC7SJX4hb4H904acxlJZNqmIEGfQ
	 /jwyQXBuYK97w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 700C8D3E996;
	Wed,  5 Jun 2024 15:59:04 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.10, part v1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240604203511.GA1345593-robh@kernel.org>
References: <20240604203511.GA1345593-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240604203511.GA1345593-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.10-1
X-PR-Tracked-Commit-Id: e7985f43609c782132f8f5794ee6cc4cdb66ca75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51214520ad62e6cd5ec216e9b840999b4aaceb5f
Message-Id: <171760314444.19032.18335377332388477250.pr-tracker-bot@kernel.org>
Date: Wed, 05 Jun 2024 15:59:04 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 4 Jun 2024 15:35:11 -0500:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51214520ad62e6cd5ec216e9b840999b4aaceb5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

