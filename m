Return-Path: <linux-kernel+bounces-333139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834A97C471
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7651C23562
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACA018EFCE;
	Thu, 19 Sep 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYhGdgtY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF818E038;
	Thu, 19 Sep 2024 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728496; cv=none; b=gmIb9R0afd0Veh6GMH5w2yYYMnPa6fkDrYpIxzb1DyF66VGmJuMR6vjE9bGa7s39wDOKwwakCGITGPns86M+funyW6O1W6Ee4b6RxfOmqSjyGakUJJPd3PdBvSKLVICtgOa/6baQtyiLznCOchVr02iWKv/YOBrwDb1qdFTW+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728496; c=relaxed/simple;
	bh=2wIvcnknKHbJt2Qckd44bp7pz4B40lzERH3PJFHf4f4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gQe+bfkyV55HH8dexi5kDw6NbGiC0jeyrfAW2r4vrFY46xE5eDgHMvhbNK6OhMX1hauEZe2/GISFO0KaIXY2C6NxIABRGtUFfrB5vunLHWaKPYYXbmlHucri90c/G3lb2tUJCW/AQMflBQs+zRjnpWa0FpKrnTP2ICYW3tgHaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYhGdgtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D93C4CEC6;
	Thu, 19 Sep 2024 06:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726728496;
	bh=2wIvcnknKHbJt2Qckd44bp7pz4B40lzERH3PJFHf4f4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mYhGdgtYLMfZoENMX17h65VD2JU+sTWH5enQS3SWOnnZLTBUJFGuLq0mKlwaub84/
	 HyjmhpL5oRxBZqDIf2LVvupv1YBYgdeuLpug6a5O+x2T14+g43X30lF347EcytRghi
	 slLvJfNdJKRj6n2ILEcctMbxL4ApRbV1gQ3uJ8n/qu72Vge4wf6GIdBJOssIvOYkGE
	 NtoD+f6gCD+6OJh+tYXr9pSRILieaqQYHBhDpZAbUubVIw/ItbL3CfESf/pov13qhV
	 bGBmKa8hu+VRnXpyf1dDXz0+nQcnnPErhOKfrJZ87hsBdeyGoa/Y69lrI8QXQRG1s4
	 FsRf2vRLP5fZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713CE3809A80;
	Thu, 19 Sep 2024 06:48:19 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240918215735.GA2208101-robh@kernel.org>
References: <20240918215735.GA2208101-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240918215735.GA2208101-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.12
X-PR-Tracked-Commit-Id: 0c36680c0e2d959cc264a1e65628c825f7f87add
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a17bb8c204f2b6461524a1b52ace2dbe097eaf7
Message-Id: <172672849802.1360580.8104420461942341727.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 06:48:18 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Sep 2024 16:57:35 -0500:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a17bb8c204f2b6461524a1b52ace2dbe097eaf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

