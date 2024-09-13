Return-Path: <linux-kernel+bounces-328937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA80978B10
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 00:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B671C22673
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1395E17C9AD;
	Fri, 13 Sep 2024 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2cVO/hy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3B17A59D;
	Fri, 13 Sep 2024 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726264812; cv=none; b=N6XgwWa8GxcWaZ+sULdc8uS4QQTdp8j+HhT/7e/DUcFfUKGgPUvT5BbkdnoyYxi1lgj1vUgTKcd2ZuM35GbO3gLsJjl2pGiFpDbAHD6xAunDyiw7q7ID3uCJSVWRMOUQomwHMjSMGgnHUiX29O7/Tz8x9SxyBYGp/WkyGfBvB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726264812; c=relaxed/simple;
	bh=sKHzPiNHwCFpc3clftc7oPzTGkpvqFenUcty8Gb9HOc=;
	h=Date:MIME-Version:Content-Type:From:To:Message-ID:In-Reply-To:
	 References:Subject; b=oEhexJsyCe5gchja8NomTIZKReQk22sXWtVjQJBcFCgKs+ekSr6Ek9myoBnk1dn/eJ4wD1WmGwspezVto1c/yTOzRjm6+aSg4UxKQa2L0VDiVV0Mz440Hrsk+8xyzdXqsqnzu6ThbDoCIQ9lg05OgzT6bfRPoormLXG9HZtoyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2cVO/hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C68C4CECC;
	Fri, 13 Sep 2024 22:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726264811;
	bh=sKHzPiNHwCFpc3clftc7oPzTGkpvqFenUcty8Gb9HOc=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=R2cVO/hyg2sNRpvOYSIfHwatBIguaSJ7vKqA0PrqVissTeuF3h3O2feRTa/qgoiaE
	 a7wedeXB6j72qweg4eQ3GLK0LIeGS6fiFxmr1A2puSYk0C2qx7v2CA92DjPPpAVHB3
	 scZ8tuARXuojajMD0BvvrR8hTST4/jsWmoX8qacgJssiSMqMf9HhD7bEnWyAl3jGxw
	 G5YFURF46ZnrUJjkX88za9to35PGJ9lzik+zgJ9vE5Q3MpCqg+hSb1hNRIfe3aMAp9
	 pqvEOAu1n0eruYVXo8xVtnGstyyTUVfzjQDaT0U5ii68/FhcH7VAYDwyirrSWRUUcg
	 7EU6jtKV/Gheg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712B63806656;
	Fri, 13 Sep 2024 22:00:14 +0000 (UTC)
Date: Fri, 13 Sep 2024 22:00:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: tglx@linutronix.de, bugs@lists.linux.dev, frederic@kernel.org, 
 anna-maria@linutronix.de, linux-kernel@vger.kernel.org
Message-ID: <20240913-b217598c1-b7b80e6602c1@bugzilla.kernel.org>
In-Reply-To: <20240913-b217598c0-81d4abf24530@bugzilla.kernel.org>
References: <20240913-b217598c0-81d4abf24530@bugzilla.kernel.org>
Subject: Re: setitimer works incorrectly
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: bugspray 0.1-dev

swaminathanalok writes via Kernel.org Bugzilla:

I believe this issue stems from the fact that on your system the tick interval is 0.004 seconds (4000 microseconds), so setitimer will not be able to accurately work with intervals under that number.

View: https://bugzilla.kernel.org/show_bug.cgi?id=217598#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


