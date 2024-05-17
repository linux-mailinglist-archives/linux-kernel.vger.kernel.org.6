Return-Path: <linux-kernel+bounces-182271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D518C890F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2B91F26D67
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0443B6BB37;
	Fri, 17 May 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gddoIic5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D06A8DC
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958674; cv=none; b=Phf1Y5dGr/WQfvllL7VUHhNbbLcXqLGMeRZKjsiEGwDhqOv0F4YMKohEX8OnSEIQoSJ9sDuTii4gUwMsosxyNmq/iZcsim/vr42B1qnpTK1MV4sfWLSVYXAFGTkRhxLeSmtNMsnqpHJMBGBFKM6sIGgmX/agMNPHfg9lImMaZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958674; c=relaxed/simple;
	bh=AH2OPi34MeT4uPkwc8selbRygzGB0cXzmtw9SFgahv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s23yLXOzmQPJuFAk+9BhekLzyrICBKu7o0z4iNFwjft0q9Om0oFr3Rniq3V9zoO8yCENcSckHicQhiuiHclrKTIJTAf6TjOIwiN0jJp0lNgUt+1Sq7HjsOtE2cWTeYaWBDFDFhycNWRnQheQ0NwxhycpKu7x3UwUi/ReCExz/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=gddoIic5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CDBC2BD10;
	Fri, 17 May 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gddoIic5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1715958672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AH2OPi34MeT4uPkwc8selbRygzGB0cXzmtw9SFgahv8=;
	b=gddoIic5jN/6RJwW0XR41xgTKZw+8S/IwoSN5n1KTscirSyesMGImY7eDPAJOe9l6Jhfb1
	EfskXpGzyMBhQZIaVYnJ07b+HkI4ODGCjqH3LZWtVJ2/ZmTOcGZJI3hepZpXfIOzC7lrxm
	+Q7cUp5JTCb7CX/8KhOcc6GuQ7AEB70=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1ab7018a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 15:11:12 +0000 (UTC)
Date: Fri, 17 May 2024 17:11:10 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] random number generator updates for 6.10-rc1
Message-ID: <Zkdzjh3XwS17WwiI@zx2c4.com>
References: <20240517150315.2213425-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240517150315.2213425-1-Jason@zx2c4.com>

I forgot to mention, there's a small conflict with the pm tree, which
you've already pulled, where `.owner = THIS_MODULE` is removed from the
driver, as part of a tree-wide set of changes. The changes in my tree
convert the driver to a platform driver, rather than an acpi driver,
which also doesn't have the `.owner = THIS_MODULE` line, because those
got converted years ago. So the right conflict resolution is to just
take my commits and skip 00e8b52bf9. That's the same resolution in -next
too. It should be trivial enough.

Jason

