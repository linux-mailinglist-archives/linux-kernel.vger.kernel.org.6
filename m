Return-Path: <linux-kernel+bounces-449655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5EE9F5314
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872EF7A61B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07D1F75B5;
	Tue, 17 Dec 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru/PJ2uC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170598615A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456285; cv=none; b=I9mJ7eEulhYw8AdhfIaTVgCF18vFw0SZZ+WeYIzFFL+VUumwqdNEFsCViJ1AQkrWz/VTBQm7qt5W7T0WGqfa3yb/O+m3+9Gcnpg27sZscZZj7Jocee6g8uQ01KeM1dfeIzU4uSPwWVtKEf3zNRSvOUJj2KL4nMpY7v6DNIx7mWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456285; c=relaxed/simple;
	bh=vkih+vTC0anfKwkMg/POuYbkF6Vn/VZd8I3+Jw5L4/M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FJi75eAMx4G5FNMD9HWxGRV3JUl/iZMeJMIjnK73wZOmYF5etr9OcAf1rUCU3RyPdfKeW86eV027Xfx5O0qZ/v7vHcI50kkVp6hGm40oG2nHp6l2looVSnwYymaROsW8RUpdLkU0jS8dQX6pW130Bxj68qOz1ByQrgAuit5bthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru/PJ2uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA25BC4CED7;
	Tue, 17 Dec 2024 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734456285;
	bh=vkih+vTC0anfKwkMg/POuYbkF6Vn/VZd8I3+Jw5L4/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ru/PJ2uCJEU+joTDpw77K93zAIOWyIJSaCv3+BGutXoBU7GDxM5cD2+2WoYfUy1Wu
	 3ENKCfNauHIgzudwDks803COXsFyPNmQtOq1STRTRVSmldTRo5gdWNjREG5gkESCrP
	 GANpCwTaZOCv7Oku6PoK6x9oC2zLgCjv9jPVzZU5cdbpgGIVEITJAhuEd/ILaacjlV
	 vZrzTvNXX6MVnSw+0Piq1NPBTpHJt2/JuZlNmY2+9+DBNN1U/q45V1UtCq+GV92BSE
	 NrRhLK6LxQdgYSSJ2F2bT0WC9GM/PxDIPt8B7V4LnCgzhIdhOeiZALcgy2GGp2o1k0
	 Q9hZbkHJZ2K4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA43806656;
	Tue, 17 Dec 2024 17:25:03 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fix for v6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <202412161633.8F8CF08C@keescook>
References: <202412161633.8F8CF08C@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202412161633.8F8CF08C@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.13-rc4
X-PR-Tracked-Commit-Id: 239d87327dcd361b0098038995f8908f3296864f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f13c38a854d13acafe6feedaa2705e61f79a538
Message-Id: <173445630192.974395.2291189638851138165.pr-tracker-bot@kernel.org>
Date: Tue, 17 Dec 2024 17:25:01 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>, Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Yury Norov <yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Dec 2024 16:34:51 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f13c38a854d13acafe6feedaa2705e61f79a538

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

