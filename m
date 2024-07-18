Return-Path: <linux-kernel+bounces-255856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CFB9345C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32AE285289
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF71E1B86E2;
	Thu, 18 Jul 2024 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eygm8kRU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04038DCD;
	Thu, 18 Jul 2024 01:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266034; cv=none; b=MUYXZ7ar96WMFLQ93eNCS7ns1VOtdxQGPuaE0rf7ol6AVBCsJIEEmLruEZIQqKR78MUjSPK+rUZTHsNV4H739SO58/ojRoQB+w9tSKctrC2FBmiF2Bu4GmAKALwjQuWCLPtKc6brECMsuzZ0U0vpv9I+7bkQ4UKgOw0u74An2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266034; c=relaxed/simple;
	bh=tW//LgP7k/CQCYgUqtUvLcwfgiieu2vgF7lTtZ7Tdvg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TQHIFxbpPl8EieXc4QCB7Q7D1qim5DX+bundoB2YF5JJJogdapdGz8rwCnP2whjJZrD0bfotofECryDPjeeNt0hsfMH/BFwZSWPnbKtvV5Fv4oJdZe2Virpe5805xlRPJBFFoJj1fQ+/l4SRcTaUvd6o7cJ4xw7t7RmFlTnXetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eygm8kRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C93FDC2BD10;
	Thu, 18 Jul 2024 01:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721266033;
	bh=tW//LgP7k/CQCYgUqtUvLcwfgiieu2vgF7lTtZ7Tdvg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eygm8kRUE2lYL5RKu857YmTHeMhrBypDUU4SDy/CCrs4FPZpk7tpxompOckKTphBY
	 EpIdk2ltpE2s3Obp0AVVQRh85UY1ItkzVFL2mXIGSoqbSsVSYjpaomVGjSMQ4jg5Zp
	 n/3BGAUDWCyAipoy56QnQ2juATtDMuEbiaZ9i0iiWS3jX+hXqkGgHNXTHfGPHreHkw
	 yGGuCEOgAnA6TkCOl7gGfkuZif5w3TfuWuACQi6yD9ad5tgWmkKvEkQSNTEoJtqSFZ
	 bSEsn8d6vI1N7W8/zzllQR2bg4z8QgvXcBNh8Li4JbkBVqn2Shwlmlyi3HacHzy2bp
	 uOIAtpd/5mquw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1D19C4332D;
	Thu, 18 Jul 2024 01:27:13 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716214508.GA436704-robh@kernel.org>
References: <20240716214508.GA436704-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716214508.GA436704-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.11
X-PR-Tracked-Commit-Id: 76be2f9823b10c07daf814cb6c732eb1456a0b9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ffb8a4c96e55ecf0e572aec1a0220af3da84e22
Message-Id: <172126603378.24030.8575909622586038028.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 01:27:13 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 15:45:08 -0600:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ffb8a4c96e55ecf0e572aec1a0220af3da84e22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

