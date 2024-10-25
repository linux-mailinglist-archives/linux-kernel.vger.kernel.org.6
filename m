Return-Path: <linux-kernel+bounces-381081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D649AFA05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3179D1C21FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724018E362;
	Fri, 25 Oct 2024 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txjIyHVQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h1ind8EL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE78170A16
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837975; cv=none; b=genP1rIzxe4TU5bvp/2r6EZe19RXdmu/MkFoXOq5YPktr9cTPug9z+2Zdox7h/qUfDdXju23mCqMKx9si0m9R2X0N9TduqGZvZbNlKfGLQdUFlIUNjUs+xf7hnDeK/WIBQk8SHnKD9L4YSC/Og1bVJglpqmfLjJl32EA/N59pVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837975; c=relaxed/simple;
	bh=YqdOTsrNJnrLbOZ1bSoMecZGviL4/R6yS/njjBxSJbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYsB/X0g6BneXmmz4i5VaLzE2yB5gmO6n7Pf7YD7BLUnnB3MZ9NR9hbfaeaumKos3ExzhdqVZjFkqGhxMb/hTy4V7VxlsRMd3ppZjvRbDiF4z7XQYT9jTwv2zRSvbfZFd2OpFFUn5x8i0i7AjCbrN0KRdogIAjXT/cqLO6vwrf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txjIyHVQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h1ind8EL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 08:32:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729837970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xcjSBDDyZz7KjAQwhG9HZGIfUvUSzd5QasxiuiBOlmA=;
	b=txjIyHVQ5Lw6Fu9Ugc40fQiuEXrY5MtkAY2/pOnYToWz/phPP5UsyRRsFDpO+TQ9fEtfdC
	KeFytYXtUE5nJkRWgmUnhUtT5TtD8wRp2pbztgcWSAbF4B8DAFcwZO5kY3AqjD56hQQuYj
	MYn3RdY9l4fvf/vzwl03wlAwc+RSupRdB/BnqNYJ4cR4L49AS2Yy04RqXbMayjSQA++BEP
	eoRjYtLG9wHIY7f59msW+kHiz2cnNDcPwCRbzTUh5FD1wmsHjbIfOUaNiPF0SWL/S+ZIIv
	HXbP3dcwSDPGVTxuH3UztQI3JpQpNdBe/QrN3XxYf998VAWt5xsIb78KtNC+Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729837970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xcjSBDDyZz7KjAQwhG9HZGIfUvUSzd5QasxiuiBOlmA=;
	b=h1ind8ELAn/B7hfiCrHD1u5D9KH03k889KlsJPiYyFn+T0ieGMClj6L+MQVmy3Pe0v+bIH
	eNWZrKY9ryN9mNCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christian Loehle <christian.loehle@arm.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kernel/sched/core.c:1361:21: warning: 'uclamp_mutex' defined but
 not used
Message-ID: <20241025063249.Q3RPg_vY@linutronix.de>
References: <202410060258.bPl2ZoUo-lkp@intel.com>
 <7d19367b-a4ac-4c65-a543-9a4d614bec44@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d19367b-a4ac-4c65-a543-9a4d614bec44@arm.com>

On 2024-10-07 11:08:36 [+0100], Christian Loehle wrote:
> Please allow me a day to walk through the code just to double-check, but
> the obvious fixes are either letting UCLAMP_TASK depend on SYSCTL or:

This does not look too bad. Meanwhile I got another report
	https://lore.kernel.org/202410250459.EJe6PJI5-lkp@intel.com

Mind to post this?

Sebastian

