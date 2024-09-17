Return-Path: <linux-kernel+bounces-331835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E797B1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541511F24D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78CD1991AC;
	Tue, 17 Sep 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbQxnxTU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B119343F;
	Tue, 17 Sep 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585221; cv=none; b=jPVEEHi3RDtc0WVIh0wL504xAg3o+6NA+ckpS7+rE5Mommk+SZpfZnWQkBDn/HRNcmIxeH6tnUqYzX+S4GgmtGjcnQQuV3XBRlGxRBqZBma+RR0xdltFJiZA8fqVHONMghNCfOaOUwxWcQEwoKNi4uK82rHwhWDSm2DpF7kt49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585221; c=relaxed/simple;
	bh=suCmZLVIVlsCWK4ZMYSQkI3POWmDXD9VU99aDFP2oAs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QfdMBBOsbqkiGrFVvlG0OnYaDS7oPA23ATwIaG0VsAi+NBaz/gTay7rrBE/Q3Bky3IS9AVYqk26YbjYDEhqqf7eSwzgiEbwqG6sg8Qz9c/VehvF0iu3fEfaTg5IInKxFBC9ZQppnZ0GZRC4lIyNfSCu8Hs9o4clGlE36zuWyLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbQxnxTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378A8C4CEC7;
	Tue, 17 Sep 2024 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726585221;
	bh=suCmZLVIVlsCWK4ZMYSQkI3POWmDXD9VU99aDFP2oAs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FbQxnxTU67GJPI/FPMbgSDW4gKX4pFm9PzTxfbBu9+kXoKwOqojAry5W98qfA2LpM
	 RQ2Um2SbcCBtBjOJO0O43VMpc7tLqtk3RddqbngWztsTNnlGzsO2kmWWWXdBoqriif
	 3HJYnPUZgr8wqTD3vvgMQZd2ub8QVVy8qAA/dQZZxJLnjaWsAKgDPZ9/v/pn2uBeo9
	 24LwcPrcsLwnp2QIT2SXU+oB9g4tkP3RXyZAGpcy+OdRZXjBLZI810oXquoBEvOA4o
	 giuzseyFxkW1oA3cRzB78mm5LMNrBqTpJr0skzknyg4020OZjUfu8acizTG73xVNcR
	 Gq0F7D9DQ3Fbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 29DC33809A81;
	Tue, 17 Sep 2024 15:00:24 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <87a5g7wwl2.fsf@trenco.lwn.net>
References: <87a5g7wwl2.fsf@trenco.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a5g7wwl2.fsf@trenco.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.12
X-PR-Tracked-Commit-Id: 4f77c3462308c62ffe7129cc18b9ac937f44b5a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d58db3f3a00af00fce5f914c9d1a946ef7feecb6
Message-Id: <172658522268.168423.15028675715931564824.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 15:00:22 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 07:35:05 -0600:

> git://git.lwn.net/linux.git tags/docs-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d58db3f3a00af00fce5f914c9d1a946ef7feecb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

