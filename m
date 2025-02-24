Return-Path: <linux-kernel+bounces-529763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A401A42AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC6A189F106
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB5226618D;
	Mon, 24 Feb 2025 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="QHb7XYev"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2C265CC7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420234; cv=none; b=O/yQlAzJWkqZSbkGVuG/yGwjTZGqPUYHme8lONk1KFFawQJMLftCYeei3F90bhnruhCUXkTz3vmREABQhsLw9zWFoCdzrv/8U7Q2hjDv0/s1y6iUZhLLAXzJJrgmdUObhQdScrUck0fCt43syDu8gAVCx2YNAhn3WeRN67w50e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420234; c=relaxed/simple;
	bh=5RpMAGSZ0ZNkJ3JooIv7O3KzA0gyrRIWj2o3HUgtdfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKtPzBxybbjtNU2URr/yjE4mYUSXL0ylc2MkXQ8chn+J9s3za4WUw9/GFZOaZGPfxN3uau/FI8lalCSOwxtzcF94FzgPBB27EBZmeihKMtwXX5z5HCIv2yTF59R/C7aRhc9HZy0QJpv83MUjTwLH8qFQmeMjDgdHbpQq/gSpv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=QHb7XYev; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Mon, 24 Feb 2025 13:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740420229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nXUDp/2MWc9Zgcs/aIwBZ8FKfaDetZqTuesjivcVPQ8=;
	b=QHb7XYevWDc6ou8iTHrXYw/+/PbT7u/UCDAqUt4Tn6FKYAMSPA6Y/46u0eX61MreH05wUo
	uY2BM/JQk9Vh0Bowihp/4zl/aJG125Ng7VSzpI+39GCUFca7PWIsZ0RaeSpneisBBHxcTL
	mH+OVHdjqQ4BeGy+UQeYTp7kffSBJTqQ76vZ5xxDUWo6eo+U8CrK/eupappRZJ7YtMOGB3
	1yolobGSZ/PFOdLr51o8d5JmUeM1Hg1QSI289vCAJ0mb/MTEhSav2/xKj1hDmOK9HawGsP
	iBVZxtfOLHgedn1TDLJ1d1o51bSfunrymeCjqLjol7jVNBgbfznjGUIlAyr0xA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] soc: apple: rtkit: Add APPLE_RTKIT_PWR_STATE_INIT
Message-ID: <Z7y0gJPD5-OQvyog@blossom>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
 <20250222-apple-soc-misc-v1-1-1a3af494a48a@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222-apple-soc-misc-v1-1-1a3af494a48a@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

> -	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, APPLE_RTKIT_PWR_STATE_ON);
> +	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, APPLE_RTKIT_PWR_STATE_INIT);

Commit message doesn't match the code. Just adding the state doesn't
imply a behaviour change but the patch is one. How about "Use INIT state
instead of ON" or something to make explicit the behaviour change?

