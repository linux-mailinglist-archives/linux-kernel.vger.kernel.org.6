Return-Path: <linux-kernel+bounces-361959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0FC99AF59
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B87B287B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084F1E6311;
	Fri, 11 Oct 2024 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNSIGwIg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEFD1E5005;
	Fri, 11 Oct 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689100; cv=none; b=deuENHhf9JKafIXAf1mnBaJJiRnV1QLyebIkkcPT362ieKnc84e988rm4SkzQJXcJRmxbns8lvfjW7aOSLSjfzMATC0R131Kp+nH94zX5b8pmt8pwWswsHF7O2Zx0+535nFI/k8J46yOpxKscZ92HQiFzDQOlc1//6ndRYlMRZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689100; c=relaxed/simple;
	bh=KcA3x9EJtIIGDjAfYeubBqj8TKCCDhbMSpZk7U89qBs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Un73dR8AKwRfdOxFt3cRhLuHRW7hG+Pw9aN7N3Opu06/ZtEQfQy8SLQuOoRuXeMwtcr8EAN8ng2IbN788/vTIEUCI4d/+p1DiEyWeRjEg8CourwNkb9idFq4AhBjS1i4RatW6mBXCWiyrHaAcEtBqnPCS1nEQpPnjEFo1V3zif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNSIGwIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D9CC4CEC3;
	Fri, 11 Oct 2024 23:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728689100;
	bh=KcA3x9EJtIIGDjAfYeubBqj8TKCCDhbMSpZk7U89qBs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lNSIGwIgFPC5aazQQ8KToHzD2KD2vL2MnJqKfDT8uzNtwa6w0cOfLN/XG8VX1P0OP
	 npRCyvctVYSFbRF+frDWgqLcPbRLaPDaVS7QO07XJXZn+joS0y49LSvNnE59wfG0ke
	 djnaDSRoQGncOj/I9Qo0wVsRWscTUBo+Zg5E5F7FBhbkULquyPtX684hTrl+JHF4ft
	 fIKWKfOz1VZdsa7C/PKm3NEQY7KQ7M+gRITBUUNWNerMFd/5IPMH29/j1m/yXpI4Ar
	 Exxv0xTHddkoMHt5IkD9ZMl5n9Z4cINw+lF+U28Q3Eo8Sv5jB4ZTzPAWIrux7OldI7
	 S2Fa6vaRQmvqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343C138363CB;
	Fri, 11 Oct 2024 23:25:06 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.12, part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241011215529.GA2601838-robh@kernel.org>
References: <20241011215529.GA2601838-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241011215529.GA2601838-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.12-1
X-PR-Tracked-Commit-Id: 6e0391e48cf9fb8b1b5e27c0cbbaf2e4639f2c33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 974099e40e924a911000541fea0b59d075a3d1d0
Message-Id: <172868910484.3026331.6283095049479128204.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 23:25:04 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 16:55:29 -0500:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/974099e40e924a911000541fea0b59d075a3d1d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

