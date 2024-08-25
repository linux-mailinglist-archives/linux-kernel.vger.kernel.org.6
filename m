Return-Path: <linux-kernel+bounces-300342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057A595E29B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1471F21525
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E3A6A8C1;
	Sun, 25 Aug 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TiG7bTGk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G2STAvTC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE0EAD2
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724573590; cv=none; b=qi2Act1f3j0IEgmNlfsDHM1MiO/xBL2r3JRyqm0coX8GGN/1jyWTcrehBc76mKroIJ/gsIs+ANKk/jy17bhXdPxWDc2tUhY4RzkfAzfwpLAE0kYqxHZwMGacrn+5bDFw75RaFgGT51KUFjvVIQXURs8QZEpRqq/81B1U1uCvzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724573590; c=relaxed/simple;
	bh=/doJ8dNpt9LQ4Cgg1gBW7rViLmZLJWKJPTDqxYeJ5Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhdgtygRFTZjH/G3TNeSGhgnDCE5LemRxYWxmZCq3KcmpqSbMR7fkUYl4mMclkRlHDeSl6dlxvfYcUwy8uhhhYnNLPqTouHHSzgQoBoP4NzltLXEH1HxMDUHuHjB4CetyjWC1EgSHw+F8bkf2dR51YdbmeCQrJ3jnZNzx8po+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TiG7bTGk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G2STAvTC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 10:13:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724573587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/doJ8dNpt9LQ4Cgg1gBW7rViLmZLJWKJPTDqxYeJ5Mc=;
	b=TiG7bTGk9Ed2+QiTy87MjgWQiUpubvw9iEPU0Li6qv1HS1hzzB99ITZzjzglxJvXTSa0WO
	6sgfbB1GttxuTde3h5r8BJN/DAd2lO6nMVJkAlYfdGb3D4VIHYxw6St+cQ0zxTa9NrK2EI
	DRl4sl2wQojCNWdFwr/bpgFKjVeUnKfFZLPvOdoREwzLmbl4CjofhedKn/ODL9iFxYZHn0
	WWgmsrd59Mw/HiryvmvO3FAWJtO+wivYOfJdvTsM3qGPpLBeFdd7y/u/YCI8Qe45u92GZj
	KDgR7GPzm+snzLAYMDx41tepkXYxr9qDF/gEqsiFYrjMNBh9Hjc7RykBnPn2Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724573587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/doJ8dNpt9LQ4Cgg1gBW7rViLmZLJWKJPTDqxYeJ5Mc=;
	b=G2STAvTC1JuCkuPrnkjeaLaTB7l3fM8HCAbfu0uqxl2Xkrsv6knwURdSMTFD64qIIltpZh
	9iqV1G8dkGJ+d5Cg==
From: Nam Cao <namcao@linutronix.de>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Added static to image_desc and
 vme_user_vma_priv struct
Message-ID: <20240825081302.qBkqUqoK@linutronix.de>
References: <20240825035514.40095-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825035514.40095-1-riyandhiman14@gmail.com>

On Sun, Aug 25, 2024 at 09:25:14AM +0530, Riyan Dhiman wrote:
> struct image_desc and vme_user_vma_priv are used only in vme_user.c file.
> Added keyword static to these struct definition to limit its scope and
> potentially allow for compiler optimizations.

I'm not sure if there is any optimization that compilers can do, when we
tell it that the struct definitions are local.

Did Gcc not complain when you compile this patch? Because it did for me..

Best regards,
Nam

