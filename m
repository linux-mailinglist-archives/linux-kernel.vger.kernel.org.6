Return-Path: <linux-kernel+bounces-340113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF469986EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0B0B20CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE91A4B9A;
	Thu, 26 Sep 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AWTj59Ld";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qK3iL5dN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA604135A53;
	Thu, 26 Sep 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338982; cv=none; b=dOmScow7CpoHwpQoVBdBbJBy3gTkyJOoA4tRd0sL640i0YEnRqAQ9/wITYdhQboklz2TTZh4ZSflf1ajSSrlKk5xRJ2RRTWmMFBfI5b/jll5gHqS+Dp+Y8Wb4/0vCv1oofqs85pQkPVFipqt/SzhLeCvA/fTPPDAQwj5L71yIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338982; c=relaxed/simple;
	bh=BKPWbWN24FoK9KsV/z/F3U4oIOnS6c9QrVCQANQcabw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuoVDGdJ9rpzYcXzFj8EltbD8ezBUvc3QTnZ65RjLwxrV4/bm2lmZJLMZ/TULxn4lH1RBMLFahTYagMQq1EoMTOFgVBcVYOoBrR7a0DrwtkiN+yPMNk8C8lW0Bpc/vECwIPaoSUlrfUnE0mGLEHuHAuDj21bkAAiViYQxO1Yjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AWTj59Ld; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qK3iL5dN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Sep 2024 10:22:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727338972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z+XFNNNRJ73lg4ySG+mZ+blQuT3Nd/avtVdwrcLT8Bg=;
	b=AWTj59LdyVvKg/QOXbbZRd0SfNwXwOthWwn66r10prUCFdJJzePZPET/t7lDWo2ASP3L78
	6v+85TvnxgfsOkyMbDO+g9OQXAxmkxbih9QojOTLyQz4yoK8eQ7364mW/qxagpbI02FEhD
	KubyqL/jhBFyeYrzozuOcoLgjoOyy0pzXA/p0LUZkCsXDWf7bSwV3HKlZZbvzFSziwIF8o
	sWs+z7LSf3QjdRRnSCiS3/93f8ODJn+ezLehP9otYhW6XjVO6/DomvVcmFIjwivq5fuDcX
	rLKapPYDDSIaZYWyPEg7O1BXy3yhS85ly3q7eXvn6Dum336b4/uFM+JQqLxZ/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727338972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z+XFNNNRJ73lg4ySG+mZ+blQuT3Nd/avtVdwrcLT8Bg=;
	b=qK3iL5dNKrCmQnA3sCvVVl1NfoJf7p1Xo9tB7rScsTLmKq1lZgprv65E9z5RmU7eoCvyfV
	G0KNtQUmhoCB9gDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mikhail Arkhipov <m.arhipov@rosa.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Felipe Balbi <balbi@ti.com>, Mike Frysinger <vapier@gentoo.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] usb: gadget: r8a66597-udc: Fix double free in
 r8a66597_probe
Message-ID: <20240926082251.5jacwNgE@linutronix.de>
References: <20240923202019.37875-1-m.arhipov@rosa.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923202019.37875-1-m.arhipov@rosa.ru>

On 2024-09-23 23:20:19 [+0300], Mikhail Arkhipov wrote:
> The function r8a66597_free_request is already called in the err_add_udc
> block, and freeing r8a66597->ep0_req twice may lead to a double free error.
> 
> If the probe process fails and the r8a66597_probe function subsequently
> goes through its error handling path. Since r8a66597_free_request is called
> multiple times in different error handling sections, it leads to an attempt
> to free the same memory twice.
> 
> Remove the redundant call to r8a66597_free_request in the clean_up2 block.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0f91349b89f3 ("usb: gadget: convert all users to the new udc infrastructure")
> Signed-off-by: Mikhail Arkhipov <m.arhipov@rosa.ru>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

