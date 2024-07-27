Return-Path: <linux-kernel+bounces-264261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B15493E0D5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76321F21881
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0864F188CCD;
	Sat, 27 Jul 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi1py2xH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F2187860;
	Sat, 27 Jul 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110844; cv=none; b=CMrQcUfBVkrDNgZy73EawYI30wp3bKQMtNv8RtR813VLwDM9JryQYK73AfY/ca4FU6GrWRP+/Agtd++wr6N2aJMnMFyMR7eQ2GYS7pzop0tFNj0bFr1ZFLNeo+QYrVak8wnejaWSXqFSp7gNtv6DD6HX/oqoTyvkVlTY3jwkuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110844; c=relaxed/simple;
	bh=K8A6subew3tia4+k7zLxJCOdlvhMnJlBQow0U9HW9wg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dpZoF4Y3nu9DbP4nF2ASmLZ6d757gAns6UurUC78c1Dr+NlL7CSp+gUcTI8iRJ4C2bFHU8DM/XuQtN+0rjnPqBVXAPgBdpNKC8wz8gDRhaZxfoHv+83zu83IV5GjL/pQf4ttpa/fnX94Uz3SBooahu/GW+AjdS0uXJExIfmZ2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi1py2xH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2239EC32786;
	Sat, 27 Jul 2024 20:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110844;
	bh=K8A6subew3tia4+k7zLxJCOdlvhMnJlBQow0U9HW9wg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gi1py2xHU7hUc25Ti10QKWv/XjDHGFnXpwfB+dm4rQAcle3oQEv+OG1GUaBWwlic9
	 6rxbnLpbA+HhyIn8ntwcySSZslGjn7EPbVBUHPnZ6lstyoQkPVM8pTV2lsW2yueq/P
	 tyUUWH05VhjJP0XYs+sZphJ+rfAAv+wYyGQWgF2I/WYzhEQW/CXEO7GziHsIX3kD/q
	 7Ltl3IaUArlBRbm2RC1rJS6ONiPh3rvdVp7ZLJkVBitPFRFXbiDjB6NbuEJF0sQt55
	 EZN6zjK9J1bHu4DIZVeFhIdafTUNKg0DOi6zLv+BXU7FR2G+Y3SIRnUyqFH9dyyAyB
	 DOPRkPhUG/KlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11481C4333D;
	Sat, 27 Jul 2024 20:07:24 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.11, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240726191558.GA1888978-robh@kernel.org>
References: <20240726191558.GA1888978-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240726191558.GA1888978-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.11-1
X-PR-Tracked-Commit-Id: 6dc55268f64b780eb8774de3705f791b689853bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf80f1391a425081b96f9e04e5c608f854858aaa
Message-Id: <172211084405.16614.3911361105411400053.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:24 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 14:15:58 -0500:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf80f1391a425081b96f9e04e5c608f854858aaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

