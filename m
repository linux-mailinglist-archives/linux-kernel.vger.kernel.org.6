Return-Path: <linux-kernel+bounces-513943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E00FA3507C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2FC7A3848
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D017266B58;
	Thu, 13 Feb 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcKM0PAW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB8528A2C1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482197; cv=none; b=pTpRyL0jaZXVly47B5KTqKfEofUQjECp+G1XQ5CxQ4iGK9WZLusVXIUI268TkO3/IXxPHkKJIwO9wT+7SMw939O22my4ksZgCCI74ogYqWJQSVM9QO6TFKfL6EhE8jy2oYEiKnVG0douEPvTEgEVFZn5fMGEOKR84i4fZgW3w10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482197; c=relaxed/simple;
	bh=z677wUmv/ptNniMk7TyZAH/gVXzq8IKHrf6PlOEhkmQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i/cqet/9KJjl1FkKdfJmBTR6GHARpJFUZLar9A8r8UcogkWUyq5lPtnJXXTvo/hZxJxKqY/XsC6fiBQB46eARkS2bRYwhdTovtxZmKve/mWax/1chaw2v5OA6UTM4X7QRg5y5Yslke+WmNfX4EYlR8jVmMvFbG1gafv7jryllDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcKM0PAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352C5C4CED1;
	Thu, 13 Feb 2025 21:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739482197;
	bh=z677wUmv/ptNniMk7TyZAH/gVXzq8IKHrf6PlOEhkmQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dcKM0PAWibEFGSGv4d8W175vrGsrbsun2/SH61LHZIWrUXBzNQlOv1yNOisZ4SNL5
	 M1/M52pqv90p5WJwzmbbxFQmmhGoe15pWTcV1RGdiO1ohK/n9/Q6XmHrrFsRJ5U5YH
	 bUkqukLagzJHaDmDvqZoPV0d/pkPQ0SnIVHI6UwKLS6Wovvo/2Vuqwv/NUQj9A7u7v
	 L9VJjYHNhwDhhUwQ/yRhBjsjHGT/BV6iOEqcC4HyaLnfiY0nUirm+7Pc4WiJPrQ32t
	 6Vwi+/TvMsxCiAcEJu5Jqle2wJiW6sW0HzP5l5VREWVIbNL8PWb668imjP+ivZdc6s
	 R3njNBlaKiIQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE362380CEF1;
	Thu, 13 Feb 2025 21:30:27 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <c3dbdf8692edfa264e6c7471a72c0175.broonie@kernel.org>
References: <c3dbdf8692edfa264e6c7471a72c0175.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c3dbdf8692edfa264e6c7471a72c0175.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.14-rc2
X-PR-Tracked-Commit-Id: 32ffed055dcee17f6705f545b069e44a66067808
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9af8e7718904f0b77595d1b610c96dd7796c655
Message-Id: <173948222631.1382339.11916199836504145705.pr-tracker-bot@kernel.org>
Date: Thu, 13 Feb 2025 21:30:26 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Feb 2025 18:59:56 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9af8e7718904f0b77595d1b610c96dd7796c655

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

