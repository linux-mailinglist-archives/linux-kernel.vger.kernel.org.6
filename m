Return-Path: <linux-kernel+bounces-416388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02389D442E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DB0280A75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546C1C57A0;
	Wed, 20 Nov 2024 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Www9KxD1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086A1BDAB5;
	Wed, 20 Nov 2024 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143367; cv=none; b=WvVmSZ14NC+ws1//DtooiORNjy1yLs+dU6s7pAxv1z/kby6tKi+Y7mqoDOAEBvk0gxKZFt5zque8wqX+QOnIUiTQYjDUzVp/X0qujHkwiz64f6UcJ6WjDFgatYHzKe51FmvmuheJPweNpPb7PdhGxkxrikg+jrWd7r99WsKluU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143367; c=relaxed/simple;
	bh=TtIUy8VQUCn/IsoUHCSlEK/jpmfn+FnpR4KMacYnbOQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fabf9FoiiXKP34IZsyTEA3aLlRvDUTVoGVy42++JUINxZec7pBx2KUBFpYzcVMR7xNNxgI8ZoEyXM+Bw4nGdCQZ1xjEatsDj1Eig0jsnU04aGGfogHCJbYVgbC+NRfrL7OsZ4i3hs5p9GDqDE1pg7Em6xgzC7HuApI1bpce9UJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Www9KxD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34123C4CECD;
	Wed, 20 Nov 2024 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732143367;
	bh=TtIUy8VQUCn/IsoUHCSlEK/jpmfn+FnpR4KMacYnbOQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Www9KxD1O+Xx21rliNQB7kx8v/KYcd94wGxI2pyZ35oSBN8QriEgnqrTrHqkGXbE1
	 MQMs2CCX9OJY5JUDYneAzQBIc0NcJMaeo2t/JtImz98beUf83wrLPMK8DySDwrqdQt
	 XQhTvQnZ3farlvzGnJ7vOplVE4omYXBjusB0rOaNAk05Rd313H/C4Jvd87LQyUl99v
	 s0Fngm1/v1hpeeYNm9atIMij9SnNcLYM9kbEVAkwZvKCW3/m3tKEbqT1mujWfAh9vw
	 nEWcYePmi2fNuFYSuY1V21DdRNdfyb6rzLK31dWmY6cIVGJ44n56tWWpBgyt00+TQn
	 BcZwVhaRhaRSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BAB3809A80;
	Wed, 20 Nov 2024 22:56:20 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118210730.GA3331421-robh@kernel.org>
References: <20241118210730.GA3331421-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118210730.GA3331421-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.13
X-PR-Tracked-Commit-Id: 28b513b5a683cf1e7125ba54ffe7ecb206ef4984
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6de688e93a93b98db2ba4929af773038a999e9e
Message-Id: <173214337871.1377324.11143303061719038229.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 22:56:18 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 15:07:30 -0600:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6de688e93a93b98db2ba4929af773038a999e9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

