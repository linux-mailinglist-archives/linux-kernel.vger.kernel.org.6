Return-Path: <linux-kernel+bounces-383705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D99B1F51
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80ED8281D30
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF7817798F;
	Sun, 27 Oct 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PTrhxT/V"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059E1CD2C;
	Sun, 27 Oct 2024 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730048880; cv=none; b=KMuh0HeD0i5hT0MjMNQ1kmGAn2QoVInALmLZdQg0AlXKevWyhxD6dFapTgmx8Fm4h9Jk+ktEwnVQNoE700BwbmpGiPfcjygF1VvNiK+9D3gvljbvKfgWVbYPAz4l9jRslu+gW/HK2u5xZVNrAy0qFLCT9WgahMoWMs6lH+6Vy6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730048880; c=relaxed/simple;
	bh=e8axfX2mpFWjV8vbK0WZRMJNOcFQ5bvgWv4zQwxfIRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0D2kc0RZsppRHv1dztWxJr74GX0VEAynlZNAE4bMKmEE3IAy7cSzLMt+6ANlBQDAYTu5cbVA9+y4JNNkBVTR4CYU4aLvzzG2izhGqpbjaEMTisl4xOtFXIW6b/sUsvX/nGUKw+OdhEuJ4pMQXaFltOsV+liASAjFVwKcSt8hJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PTrhxT/V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=MOV7G635ZHeO21+UFSbHL9SdIS44+C3yBqOBuyrwsQY=; b=PTrhxT/Vc2+t4y/tf671Ex1O0W
	XuIy6aUbbL3Zp2X4NO5TlRJb24fRH3ycqCJP+hxfCtbBwEAhOGdDNVzs0zGwvvQtwwR5XKitT9Axp
	axtn0UCUdyUgsDmgqNUha+bX+RMkLCqeRmDU6icjJvNpUtECRPHAR8FqnbaqBjGszv6C7L2cZd0Ap
	vLpxZ6OCGEajo4KaObBjg8whHyA3VYAtQEWYy48wQoJHBW2hPPHsJdHFqhcICc7k8XCk7lN/DSutE
	uN92M298UnuqriO0Vt10IX0/huJ1hhNvaAK0hTzlnx6y9WqLaObpum9fBVdNZj4Juq0tYhOhlonFw
	O+eIZ1xw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t56k3-00000007PgR-2Qq1;
	Sun, 27 Oct 2024 17:07:52 +0000
Message-ID: <933b175b-6b0e-43ba-bfcf-2148b76916f1@infradead.org>
Date: Sun, 27 Oct 2024 10:07:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/maintainer-tip: Fix typos
To: Andrew Kreimer <algonell@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20241027125712.19141-1-algonell@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241027125712.19141-1-algonell@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

I would  have copied the tip maintainers also, but they don't seem
to identify themselves.


On 10/27/24 5:57 AM, Andrew Kreimer wrote:
> Fix typos in documentation: a -> an.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  Documentation/process/maintainer-tip.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


-- 
~Randy


