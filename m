Return-Path: <linux-kernel+bounces-414911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38ED9D2F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D29E1F23B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E91D3581;
	Tue, 19 Nov 2024 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1su0qEq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD01CF2BD;
	Tue, 19 Nov 2024 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045966; cv=none; b=Wm+hwmirf5WzS/ajQ8yaLK/+GMblnX0wIQKNCw/rGmiwspvgzJBDbv5GwVjcoGEEtoMt5hWvJAw7owtH3r5M0yNGQtLUg0aRgbd+k7oF5rmdQZIMS9DhbP1iaEV/I3//PA6IfCULOvENyOHpbvBi/afZmzW8iOlNjbTG42KLqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045966; c=relaxed/simple;
	bh=u/Oc9PfpWDaqe9WRUg0vP6SCrb6k4DOoQXBZDcreQ60=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DnWF3/GoU7qXKGXYFx35tAjeWO8+D7+qtQZ0XACxwk0tVWge3p0EtHJo6jBg/VP1Avag88yWumsIKI8TUbuyQt3PqMoK7GN3aOE3JosFEgtHYhvg3ojopOmdOVgC2BXcvasa+qgEgnAN0U8FRKHzVQOf6KTrFkMroH6upFpZZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1su0qEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14A1C4CECF;
	Tue, 19 Nov 2024 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732045965;
	bh=u/Oc9PfpWDaqe9WRUg0vP6SCrb6k4DOoQXBZDcreQ60=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P1su0qEqTtC+FkhnAI0scAd6niJNuW44JkGaJ1EGYWHjxrYLD7ov6gOa233VTBaFM
	 OosRTpcHEHA1q0fkcJkdL5CeMS1bZ3aEIizSOEI/pCbSS1ND/a6pGRtRhVVhxqbn/8
	 0s3DESvhKaM6H50ORwEoTCJiZBwYw5uFALlbtfu0YQrixz4s291YQYvaPUNbk8AvP4
	 JRb3fYLmUlGqBH4Pvd8E2kojaCe2PiV3VBV2oQy/PRh1NsdCpIsryBqyMIteoK6wlx
	 KNnNv9VL4BPErRMhyMl2HFb2oFunighokSpBZ60mn2/GSjqroaVfys6+o12UGdeOfe
	 KOtPOo2MiREag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD513809A80;
	Tue, 19 Nov 2024 19:52:58 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118033837.3586271-1-linux@roeck-us.net>
References: <20241118033837.3586271-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118033837.3586271-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.13-rc1
X-PR-Tracked-Commit-Id: 3996187f80a0e24bff1959609065d49041cf648d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b5d5f23d4056543757919bb2db06d0829835f7e
Message-Id: <173204597717.668199.12429408067726554757.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:52:57 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Nov 2024 19:38:36 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b5d5f23d4056543757919bb2db06d0829835f7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

