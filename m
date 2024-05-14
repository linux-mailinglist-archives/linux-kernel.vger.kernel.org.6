Return-Path: <linux-kernel+bounces-178274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB78C4B50
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B751C20D85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B4A381D9;
	Tue, 14 May 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8sW639e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDAC225D0
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655091; cv=none; b=H2iIyr1cz3qDP145jLv1ytE2wIQFIok12c0Za6FE8h5VQ160t5ggwrPTJw9WMOUkcclYaiF7Z4r5VqxRRd7dP5OP+egj4ruJ9/Dat0iZAw9l6H2XJEjSKfx6lIbc5LLYYEYZrsoGsCSEXWW7L0MKBxrpKGJ8TpEBJEDT9safzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655091; c=relaxed/simple;
	bh=ai7mGj5zTKEWy5emUnYb8R5doiVllpzAE/3wLbrmwHk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j8ot+pNDZnfQXU2irRKiMtPnWCDx5eWT2PbOMh4EVqjn6OkdICHXIhx59FQh98MH0HPzF8/WQNRoatJJ5qWPlLMrkP2b63vUnfW6MdZo5TTZPrG/BiOJMy2OxWxQMwxr4eus1B+NMOc6nCxvbOG4YNYDv814f8r5eWqNvbpl6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8sW639e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13AC0C4AF0F;
	Tue, 14 May 2024 02:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655091;
	bh=ai7mGj5zTKEWy5emUnYb8R5doiVllpzAE/3wLbrmwHk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J8sW639eV/vtN1268gkLzFvBDPs9i5rxn2lZmH7CBIscZVMPe76YoGvExIpxDEJfv
	 ZNj68q+JI/SIbu0EGqHHfCTCen469eENCmcJsA4DVGvDfxi/VnobU9TqjLAEe8Osik
	 BanDTf3ehuEGBWMf0GMCIiui+v7R1dP9+TcVVhMs/TKMd4PVswIq3uzWVDesciOHq5
	 ButyprMVZJ8iKkJu/tOjuNke65rns7T46pWHAi7ZIUqIfxoaCTq4vc50JTCDwxgtYa
	 uwjf+Dr2VeiE4lvgtzBDs1e1IsUeTU9IMwskYub7AQAMTiGvzdpeAtA64VORQlwcUy
	 zTc7T736Vrukw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C6F2C433F2;
	Tue, 14 May 2024 02:51:31 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkHJRYpDIBpxWeyz@gmail.com>
References: <ZkHJRYpDIBpxWeyz@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkHJRYpDIBpxWeyz@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2024-05-13
X-PR-Tracked-Commit-Id: 801549ed6abe7586eb9ad0cf7147b0bef383ad22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f487cd8290f3ae742cee18d92f2bb0063dc471c
Message-Id: <171565509104.649.16272902117197267730.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:31 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 10:03:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f487cd8290f3ae742cee18d92f2bb0063dc471c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

