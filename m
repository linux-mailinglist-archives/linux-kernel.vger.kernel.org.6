Return-Path: <linux-kernel+bounces-413572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 637979D1B27
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D870EB2225E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADBB1E7657;
	Mon, 18 Nov 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQEcO9AP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691414E2C0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731969436; cv=none; b=kKa/QT2BAhY476xk9KuuhJ33c5/KRJhG+nTZh9vjikMo1h8qfrbIJsJQEbTWU9+jl2ZeOdcTJWb4jdoT6U5+Tlq+iqOwjNBWcFgFdfzKn2a6NgxSDIs+sBibifMdOGKbk+T/THq2y8HnkGOWce1BZMPpE89DVPGcqkpwhb4YMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731969436; c=relaxed/simple;
	bh=+Da2EUxoTsOjPeVElA9B/PqKIwe35EA9sy0XrDXIkhc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CM/+Jd1WoAd6ly+/4keOVymPoQXWyzqHgwSSDtS+qEFK0OaBy+xXz1BurlZ2JcszVWxYyUWb3knuJi7+4oUSBmPXGgNVfMFEedVGtXNhFEqSmoACj/HbYy8150SufHhqMHtQzysXsKdS1tEIQaHx+FUI+4JHQIIRXLBM68NFDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQEcO9AP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B47C4CECC;
	Mon, 18 Nov 2024 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731969436;
	bh=+Da2EUxoTsOjPeVElA9B/PqKIwe35EA9sy0XrDXIkhc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=sQEcO9APU+FbKm8N8Doe2IHGbfM6yHVopz07mUFFwK4RIRizIqMFnpGBkuFVexqjL
	 J4sDWUjmyU2vth8DdFe5Kiu5iXjsO3SL7vQ8stJ+byznWVs/lGGefxOlyuJ/cTtzAu
	 +IMEI2OqEkAtco6e0e65bks6Fg4svhW7Q6yxF2mvAKs2x4SiviT9hznL+yOAeBEdOC
	 X+sBiVC+Sm0G/usmCGwo7AiSDyLrmGWoMP1ab28MGoKUuA/jI5asE6A4zp9rNNCfBt
	 ISMChsUfYfHpigpqjuXWgpRY1+/IW8SEfuu4Bd2DVI7RSdWZtL8aOirpT/E6buWw9m
	 4Ze5bSCSZOjPA==
Date: Mon, 18 Nov 2024 23:37:13 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] HID for 6.13
In-Reply-To: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
Message-ID: <366r6ss5-2qo9-or0p-28qo-634892op88ns@xreary.bet>
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Nov 2024, Jiri Kosina wrote:

> Linus,
> 
> please pull from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024111801
> 
> to receive HID subsystem queue for 6.13 merge window.
> 
> Please note: there is one SHA that you might notice was not present in 
> linux-next, and that's e8a0581914bd ("HID: multitouch: make mt_set_mode() 
> less cryptic").
> 
> The reason for this is that there was a hiccup when merging this patch 
> originally, and the topic branch was based on some random state of the 
> for-next branch, so it contained a lot of unrelated churn. And I've 
> noticed that only now, when preparing the pull request. The end result is 
> identical on a code level, but I didn't want to send you the branch with 
> git merge history that makes no sense [1], so I've created [2] instead, 
> and that's the one present in this pull request.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=for-6.13/multitouch

[2] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=for-6.13/multitouch-v2

is of course the missing reference.

-- 
Jiri Kosina
SUSE Labs


