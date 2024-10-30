Return-Path: <linux-kernel+bounces-388391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED49B5F01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0857A1C20D43
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036771E22F1;
	Wed, 30 Oct 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PPS5OmUT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DZOdZhaZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF71D3578
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281116; cv=none; b=k633vuqIAji+S8Ph27zrUKPGxZE4b/7TwtjbX57mgJJKFDyadLkUIBshc/6gRyNW6SinWLpy6AC0JfCeIbCStOL4kEg7reD2bGvj5CU0SlnL/88tdfWfP8kJiqjBlG7mDg9Pw1mU0JQkX9+h+cxufAHzLwIZ25kozZaUxbVs/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281116; c=relaxed/simple;
	bh=bBqDyHLK1vWpbzc4gSQ4P20VPpoRWihqbMxmBhK7XP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk/YtlU78odTimK8IjbjLZFtm0BUr2ScXz/uXLIPJO5b0EDf82Cd+nPCMWF4OKzy6aFqjyKxFYCEkMhhwPX3R9R/36V/M8uWIoCftPpAYRFIVSqzLIZMyC9NUNrmkVY1H8UFZzuDXfB408Qf1VkE1GtDsJ8KbP5esk5dVdXXGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PPS5OmUT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DZOdZhaZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 10:38:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730281112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TmbuJ8tIL0U0CXQgiEtrGS9NH/UsX6GKwzkR8vLmdOY=;
	b=PPS5OmUTStezmCawOKnBMHnewKSlKMXeTiCvWGbabgx1Hef8pIRkFy18kRWnT3Wt5fiPkY
	mIRF0Bw6KJecwAIChQJbBek05J5E5MmznHblnxfxXqAvYEpY9ua4Gq3bX96N3AdAcrQTlJ
	kMuZQIKddG4QFnG54le2YoPvFzaWtc7K7LauO+mudy4hwUx6S+dQlEFKiqtHN2XJrxoW4F
	Yr7AihtmIAjTssxom/OaNPKJ57GtZTX+/RvfPi5EACUOmKLAWPIQFdntLR+pun8m7McU4j
	nHV3k7sL5Fwpwhx+Lzn/gFSFftvCLZLkIi0463MAIs4fwkCXS7s1ao20gY3ABg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730281112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TmbuJ8tIL0U0CXQgiEtrGS9NH/UsX6GKwzkR8vLmdOY=;
	b=DZOdZhaZeHytsofQoHf/wBsN01A1Ej43ZNjmfQct5VsSi5+1uq06LLRoZh738Df6AtU8ZK
	iI2vKiGFr57kwDCg==
From: Nam Cao <namcao@linutronix.de>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linux Driver Project Developer List <driverdev-devel@linuxdriverproject.org>,
	Kalle Valo <kvalo@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>,
	Xingquan Liu <b1n@b1n.io>, Tudor Gheorghiu <tudor.reda@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Manisha Singh <masingh.linux@gmail.com>,
	Dorine Tipo <dorine.a.tipo@gmail.com>,
	Tchadel Icard <hello@tchadelicard.fr>,
	Felix Yan <felixonmars@archlinux.org>,
	Moon Yeounsu <yyyynoom@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Roshan Khatri <topofeverest8848@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Christian Lamparter <chunkeey@gmail.com>
Subject: Re: [PATCH] staging: rtl8712: Remove driver using deprecated API wext
Message-ID: <20241030093830.QSofC7Cl@linutronix.de>
References: <20241020144933.10956-1-philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020144933.10956-1-philipp.g.hortmann@gmail.com>

On Sun, Oct 20, 2024 at 04:49:29PM +0200, Philipp Hortmann wrote:
> This driver is in the staging area since 2010.
> 
> The following reasons lead to the removal:
> - This driver generates maintenance workload for itself and for API wext
> - A MAC80211 driver was available in 2016 time frame; This driver does
>   not compile anymore but would be a better starting point than the
>   current driver. Here the note from the TODO file:
>   A replacement for this driver with MAC80211 support is available
>   at https://github.com/chunkeey/rtl8192su
> - no progress changing to mac80211
> - Using this hardware is security wise not state of the art as WPA3 is
>   not supported.
> 
> The longterm kernels will still support this hardware for years.
> 
> Find further discussions in the Link below.
> 
> Link: https://lore.kernel.org/linux-staging/a02e3e0b-8a9b-47d5-87cf-2c957a474daa@gmail.com/T/#t

I added owner of that "replacement driver" to CC:
Christian Lamparter <chunkeey@gmail.com>

I vaguely remembered that he mentioned the replacement driver doesn't work
very well. But can't find that email again.

Nam

