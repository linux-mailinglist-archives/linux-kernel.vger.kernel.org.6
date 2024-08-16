Return-Path: <linux-kernel+bounces-290321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D7B955235
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380C01C21EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A1F1C57A0;
	Fri, 16 Aug 2024 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+Izm+ec"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548CD1BF339;
	Fri, 16 Aug 2024 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842443; cv=none; b=btMD1vlFh6d4qfSfkT2eUeqE1bj0AVVdbytwg5kNwwGSKyywrg09kXLFwHMMDjaK0dj6xqlSOKKITLYvXNzgf+59mLEhHArdEk4wxGzHEkgrqPpq9MFU2APmSalutOc969itMBAbcSY6MeqpkvhqnT6dXdAMF/jA6cT3IRdHxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842443; c=relaxed/simple;
	bh=/gRSkYEFMDVDbDqo01ete16dzsu3sk4Fs05af01UGjc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=slFB7jTFFYvWVmw8iAgx680h2t9iNhac6Wn5G3Yp5Pa14+shlnMch9LsdhFmcAdeSdxCltWw7RKZqVLV87CvHg/xdWHYRwhBfx9pRejWqClDF60r+wdZ6zJl4t9B7w24fhdydwio830t1za/nPM9f1JZ3voiBAp4ItFa/yzmUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+Izm+ec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5160C32782;
	Fri, 16 Aug 2024 21:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723842442;
	bh=/gRSkYEFMDVDbDqo01ete16dzsu3sk4Fs05af01UGjc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E+Izm+ecEdO4IikhAyOAL/1/pVwp+vFwtXgRSv4jcGb8VXLOKjxU12/94vbdK9Rhx
	 L2DMx07p3HjuxxZpTXZkwERk9wWsknPoxHghElyiwnDm6tDaaKxvVmCYLgsD2uyxdL
	 8ysaofqnPZDDFcXZYXcDF+ZAylPc+UBzpO6kYKyH6hal8TVpkE9X3oJzIvxD4vvW7H
	 kKfdqs/Nbp9EUpTuqnwo+LJmG3Nk/uUteMO2Pw/7Uau9ZdzhgJeEpNUZudd07W5ph6
	 tH6eknkqEhz805ia+3en7jrJy2QYzuCu7jbp9Oe1RwGLZa1zmfGGn9NHUAwfzIy2cm
	 k1t2eEDoju23A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB538232A9;
	Fri, 16 Aug 2024 21:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.11, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240816200824.GA2049154-robh@kernel.org>
References: <20240816200824.GA2049154-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240816200824.GA2049154-robh@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.11-2
X-PR-Tracked-Commit-Id: b739dffa5d570b411d4bdf4bb9b8dfd6b7d72305
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2731835f3f2e5b0642ad82a3a0265c98a552283e
Message-Id: <172384244211.3626293.8409715064643586952.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 21:07:22 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 14:08:24 -0600:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2731835f3f2e5b0642ad82a3a0265c98a552283e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

