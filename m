Return-Path: <linux-kernel+bounces-253073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AA8931C01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71F71C21DED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1800514600D;
	Mon, 15 Jul 2024 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjsC6u5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCD13D601;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075684; cv=none; b=C3PQqT1Zy1a6t6PmaEvTVfjgZQkIiKxCSG7FTHeso4OsYKHNm2PTkOH0uRkP+pa1C16G6T2CDXHeQql3OJ501/d0GZTHgsweg6cfvtrLUbcz1yKilhBEY/R4nnZnG/KUA7C6uRAyUZlIbZa1hNxidJjDgN+RAALqWi+CFnTyGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075684; c=relaxed/simple;
	bh=NStixb+RQv4t4A6qoSLHw7XMnFo/lkh66JyNN19GnJU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f2apS3ZTKIn0AYyGiMehzELW2p+3xC+DNkpn1H4REsZcXemQs7+LtYreS+RVOZirG99aS/cTIRQ7dv6exag7H0+NawBhFrCu7QzIVW8ooy7ipZQjr3I0KtHg5ck7G9iDw8NsVabo2NVDGdA3i77bGgW8/gOWAkxdkKOE0maN0tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjsC6u5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3430AC32782;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075684;
	bh=NStixb+RQv4t4A6qoSLHw7XMnFo/lkh66JyNN19GnJU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SjsC6u5UAFDT+1MX1E0oYFAbEJptx1xrrdrT09eoxF4yE+Z/h09RHoKHrgiTdF9YE
	 TCmj468QRjW6ZQ3lDsYkwnhVPAIz4umMXId+HQQvQPMJpLbUtuIyYKmzpW/dOCB2UB
	 /lpF5VCphdNghh6uwJAy/0K7nLgCqnc3MHbo1wGWRvgGWeVdoD+om72S8KVomxqVy0
	 RIxNFj+MfAfyyHZxSWnIX61Jp7nEsyJuM4OLPnh5v4sfXHX/MicDQf0hOaOiO+UaYH
	 /8osUaH4AVNQRYPtoPeqVZ1A394CfrZKmMeh7nce9UXnxpUFVb4CubMs6JycN4tN/H
	 FjLGog9WJm19Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F4ECC43443;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Subject: Re: [GIT PULL for v6.11] vfs nsfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712-vfs-nsfs-bb9a28102667@brauner>
References: <20240712-vfs-nsfs-bb9a28102667@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712-vfs-nsfs-bb9a28102667@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.nsfs
X-PR-Tracked-Commit-Id: ca567df74a28a9fb368c6b2d93e864113f73f5c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b074abe885f43b2c207b5e748ffa60604dbc020
Message-Id: <172107568412.4128.14957017074983322898.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 20:34:44 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 16:00:48 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.nsfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b074abe885f43b2c207b5e748ffa60604dbc020

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

