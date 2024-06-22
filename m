Return-Path: <linux-kernel+bounces-225852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19AE91361C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F301F22FC9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A6577115;
	Sat, 22 Jun 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+7beDD+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E99D6BFD5
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719090312; cv=none; b=Ey81LFongh3p5nim0Z487UT8JN4gHwEutDEXVo1GFva7JSN+TSeCvkXkTPSQTzVqliKXpb2zSi0wwMJ5ossymGcjsdMaMoxBbl/r5oRl7GYrikpMQrJUTdYsmvb4w9GPsxJRdstSP32GI6AELKyRdZxOj9jYiAf0NFbSAs/wew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719090312; c=relaxed/simple;
	bh=5gaZHCMIy2p/Zf4oPeOz61jVIYBSZsCRT08IzrXUb3w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FAP+ynvYYe3mnlKZPlwAGvgree6g+jURMqunqxWu8PdCb1JYPU7em9HklbnR2f2bgOdh4g3WlhNXDDLi/UwU/+WrxA0I76D3q8YeVD7ueAfwPw0NOOVVTE6q15t/diPVGW93RrmTGZ9NklkW0wFqO1DR2QbJ11kNQB73e6FbAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+7beDD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC71FC4AF09;
	Sat, 22 Jun 2024 21:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719090311;
	bh=5gaZHCMIy2p/Zf4oPeOz61jVIYBSZsCRT08IzrXUb3w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o+7beDD+TL9vKbnfqm8N9alw8IVyyr9NMS1ndyd0p4qPykj/LzcfcTvToqH7AdEjC
	 clOLHylHhLA8GOVhU54MljWhE9AY2BV5JBbLDqzqaiaf7EmVLZn8R11zKEd6uNUm1T
	 8h+bdpLrE2OhkO17jCZ0k1wLeJp1vpjsGRp2EB8f9LqJWVp82TyxB7dKIg+vdKejPB
	 xSSm7pvVfvmWNLbB4ebKbHMSAQ6GyTE5fQA3cjLQq/sKygtjwV9xQiwI0pmV2DIEha
	 knYxr8NSkaQJQtfNkdGSCbwCWpCEFQ0sqenrRIszeSPp7HMshDgYC/7ASLASmscPhJ
	 AL3q2jKvL9ARQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCFCFC43619;
	Sat, 22 Jun 2024 21:05:11 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <f91a2271e0971d201278b80773b6a6b4.broonie@kernel.org>
References: <f91a2271e0971d201278b80773b6a6b4.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f91a2271e0971d201278b80773b6a6b4.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.10-rc4
X-PR-Tracked-Commit-Id: 0057222c45140830a7bf55e92fb67f84a2814f67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2765de94dd3823fb1db1c939b07cc3e0a93e613e
Message-Id: <171909031183.414.6969858919573064442.pr-tracker-bot@kernel.org>
Date: Sat, 22 Jun 2024 21:05:11 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Jun 2024 17:27:24 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2765de94dd3823fb1db1c939b07cc3e0a93e613e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

