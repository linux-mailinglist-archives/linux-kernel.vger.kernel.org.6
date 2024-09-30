Return-Path: <linux-kernel+bounces-343286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C998992A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F7A2838A0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6704018EAD;
	Mon, 30 Sep 2024 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YuTRUl0B"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B34C8E0
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662614; cv=none; b=hUicRsmgkHuqrAsOUrYyrMfyxUfy5lBPItw7p2plzyb2zD9ms3n6jxJ/NOG5I5sen4xLJf7tlehGOEatn5hXNyRPZIiPFL/y3KwvilfhGjGxll88dFDliFBohSQ2FrfisbPWgZjKQBDd3yjASJfWcVNw1mi2jR9VWTjMp7GIn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662614; c=relaxed/simple;
	bh=o3B0uOWls6xsGY9wVulMzDDE1YmV7y8MzwPjGyKBT48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB9ejf4/Uh9fB4zTN1U9YzV+aqK0WNwZ8VEaVO1uR/F1YFOLRKfo3K0f3oAXdXNXNbflTHGS6eq7tIa67mSVRHfKolexjpsH8S50i0Dj5nZRTttlvAzj1sW1ej+IkCzHYyua9mk85BHpyvQLrP/YARlMiUZ1ojL0M1iE/i5r2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YuTRUl0B; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 29 Sep 2024 22:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727662610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VbEqWepXWG7Q45YXTdZt8bILPgK/debgqYwEOJCG6KI=;
	b=YuTRUl0BDI1KZ8afE8kEV0BP/OFfYBJddiPcb+AZvR283yhPrUICBJaR0uc3+9cmHZ76sq
	SLG4rkztCybSQcI7UkVjpR1omBcUN707P1Ui1hn0L/RZS0eOQIie4i+YXwBJJaP3QDZ6Al
	OBm0W6ZPrRiq0/Ot9qjpaYWq9bS9hlk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bcachefs: rename version -> bversion for big endian
 builds
Message-ID: <4aywuhjiqls4aosrvk5cfobognm7vgrgxdqq3fxow4geruhzyq@tlr46fz6gicw>
References: <20240930003902.4127294-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930003902.4127294-1-linux@roeck-us.net>
X-Migadu-Flow: FLOW_OUT

On Sun, Sep 29, 2024 at 05:39:02PM GMT, Guenter Roeck wrote:
> Builds on big endian systems fail as follows.
> 
> fs/bcachefs/bkey.h: In function 'bch2_bkey_format_add_key':
> fs/bcachefs/bkey.h:557:41: error:
> 	'const struct bkey' has no member named 'bversion'
> 
> The original commit only renamed the variable for little endian builds.
> Rename it for big endian builds as well to fix the problem.
> 
> Fixes: cf49f8a8c277 ("bcachefs: rename version -> bversion")

Thanks, applied

