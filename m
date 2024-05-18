Return-Path: <linux-kernel+bounces-182743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B58C8F3F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E899283423
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A22E4C8B;
	Sat, 18 May 2024 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwrBdJkz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788995C96;
	Sat, 18 May 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997245; cv=none; b=b42FNxB68l1FOCxFj3N0X/Iqc/YWBRW85Z0uFzoolNqb8q0Ah8AcCTXGcsRt4+9gNXzayMbm4b24uMHp+bzfmaaR1Eqh+MQ3p5FPkf+TYJKjwPMg8gPPFxYJA0hV6fZDVTXGFuGAHlRWVngTIW4tqLp6HJ+r/DJTm9AuW8EZ3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997245; c=relaxed/simple;
	bh=cIokRFyV6U9Xl4rstYdCwhL4xA3XHYrRZW38rqJ2QSI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CK2mPgQk2yEmRk6NflE8yz5Lb/xbAV/NnnxxtKyUOR4z7ZyvOqYhI3pJfdDGIXq1VIaEW0hTNr9gg2yD/VWmBKc/nlP+LXOlvDbPjTuySEgxUqDvodMykwXxPV2TzJbNT8V9AxDPFjQ6VPYw5dZfFZi715PS6ijec7A6+g7SGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwrBdJkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 544A7C2BD10;
	Sat, 18 May 2024 01:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715997245;
	bh=cIokRFyV6U9Xl4rstYdCwhL4xA3XHYrRZW38rqJ2QSI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LwrBdJkzNfkwcZsnfynwYzEH2uwguAbAAqLovhVfwU3od72Hn/AHA4cpTLhjGIz4Z
	 glF1cjJO5JT+w8ddBB5j3jlZ+Ixq/VcPDli/ozj0FDjxhRrwyzh+L4q2DNJsbR9BLi
	 Oeofz5q9wM3JxpbggT+vhB6f8r46mvx0gMBmPGpzLzf+a//C0QjK+Q8imcW7jU3zmU
	 ZDJxHml4IIr2cbIm8bZPcBTTqCIITiFbharJKrrRANQH24S46O+lwuejySHWQk0m8L
	 qOSoaQnDnPTkbTWc7n4vCio0hdtnhdVO/OuHgdQpUxMv2atrZTwxGnke0M9hKLt/tc
	 WEhENVp6LsS0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AA7EC54BB2;
	Sat, 18 May 2024 01:54:05 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240516173625.GA3518068-robh@kernel.org>
References: <20240516173625.GA3518068-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240516173625.GA3518068-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.10
X-PR-Tracked-Commit-Id: d976c6f4b32c2d273d44ff9ad7099efe16279a39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06f054b1fee83415fe35204845708988fc16ef22
Message-Id: <171599724529.22868.12357077037121326544.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 01:54:05 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 12:36:25 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06f054b1fee83415fe35204845708988fc16ef22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

