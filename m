Return-Path: <linux-kernel+bounces-300334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD8295E286
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DFE1C20BE9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AEB61FC4;
	Sun, 25 Aug 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qG2gek/p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5KhDxMT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC272E859
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724572228; cv=none; b=gpBVTsy1RoNCkHLOVk1yXdGRAzjBUi31oqnOmBv81COdC76XWA0AAR27Y8JFZg5kYjJXTPEq78pSUzbcHYrcmsOShARqRRkzWmc1RH2m5NVB5vnBzrFceW+ca8ihn6A23BnmN66iWpqtfE4GEOXKQ/KpYzrVx4rHIfrtsslw2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724572228; c=relaxed/simple;
	bh=OBXGBrmBGJoMTCrC9GzNQFEt1YwFHAjCcLlOArfE0Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRMPc45ld4A846R096UgH5QWmL7PWBaDke8o6FbhdN+8s/GDvhSFR40rsUc0gwJBTNcZKhUlGGhwAFL29hWInSvLU3Yv3xtVFY8vPHTyj61hg+8tiEkNV1v0bQ9FiBiErm9LBVG/6ZEWC5VvhnJw317bMsrr3RN1sPgWkbFjXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qG2gek/p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5KhDxMT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 09:50:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724572224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJZk6x+ErO8QvudU2ZY5a1axQjDiBh/GyeY7TMTp9Wg=;
	b=qG2gek/pulHLnZV3RVeHAyZbYDGrxBVsA/GauQDVtOCwBA+oUMRNATuCd69s1MXNmCapqG
	Jey0Kccejqpg80/ufJudbQnnnlSZu2pUIwqAz/Cf76yf2hIgx7dT2NsfsBTF7sauKuxBpL
	LcdAHSsYjxOsHEOPpbqt9TjyVlPGNGKcQqky3CwgF11WefaHlLlBfKhHzNNqF+Rs+UKuAh
	Uat6OIxPR94qIT9l1dGKqN0y9HPrXr8OyqKtLlATvJ41uDXw2xfzXLNG5GPvHhSH2nJ4aI
	mQ5pRbuUGfqkViM5Qsh9Ce7S1Rxrsz8bPiSaVg1gr1utqWnTUBgJ2DSxtCV4oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724572224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJZk6x+ErO8QvudU2ZY5a1axQjDiBh/GyeY7TMTp9Wg=;
	b=S5KhDxMTH1NwCdxc3pbNuf1dhZ34HMHP1cSz2jWCty392VlaM1bWkZ6DQgKoevsvh5bDFo
	oRD1AMFq/16UalDA==
From: Nam Cao <namcao@linutronix.de>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Change slot number type from int to
 u32
Message-ID: <20240825075017.WNpBd0l7@linutronix.de>
References: <20240825072955.120884-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825072955.120884-1-riyandhiman14@gmail.com>

On Sun, Aug 25, 2024 at 12:59:55PM +0530, Riyan Dhiman wrote:
> Change the type used for VME slot numbers from int to u32 throughout vme
> driver. This modification more accurately represents the nature of slot
> numbers which are always non-negative.
> 
> The changes include
> - Updating variable declarations
> - Modifying function signatures and return types
> 
> This change imporves type safety, prevents potential issues with sign conversion.

Signed integer may be used to encode both non-negative valid values and
negative error code.

Are you sure none of the changed functions ever return a negative error
code?

Best regards,
Nam

