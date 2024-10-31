Return-Path: <linux-kernel+bounces-390959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0BA9B8087
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186861C21CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA41BC9FC;
	Thu, 31 Oct 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fUMyf5bh"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ABA13AA2E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393267; cv=none; b=lMdl8WdQqg1DPnByouPwOe9fxDqP3jqEt9R02aBp83GNiN5XbyGJ9aNVy2YYzAuYl3ok4546fZjXJN3InEuhbAiPNemnUsR8cBbr+J6WDGijkjMgq6mqexmJpnInagpDahj7o87DSTVouScO9tfwUl7MdUNM2aWmz8RYtc/3y6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393267; c=relaxed/simple;
	bh=SeEUX5njvke53zSHqwWyR+DvkTW9wBsVfjqo4Jt1CxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyT0NZYAZcxEj3qCEqA35sg7UFLNaQ16epZzUlxEFJzGwJzYLQjnXB7LtpfPgLDwUjHYToX70tY+Anj4YaeD1Wyr6Jc3n+R5HBMgYiezp8ZYY6P6b8vFDss9ebI2JUBVmxF1d0LgHaofYctIRC9u6HRbcT49/kr9lFxbk39Lnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fUMyf5bh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730393262;
	bh=SeEUX5njvke53zSHqwWyR+DvkTW9wBsVfjqo4Jt1CxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fUMyf5bhR4XTfba+wDgOxJ9ljmPafckRpGno7OojS/tKwcQb11ubcgd+KVdfRmatK
	 Biy+Gp3TbKcPnyI3M3hrs2hHKDug2OQa9Yzlkb+lf9tNzLDcLVC7R0WTrbW2Lnw/gx
	 PDEEJhopRVbxWOCsXFRfwuY24zllHBShFK5S4PCTuoGosKa3cqx2kOQ+Br1avMPEiI
	 TjHfDJvu01PpmQwgGkeY2uVD0FAIuxit7IxGWKfrfoUTtjJLVZ/gjW0gzIxUgkIHQR
	 xGPdpsVO/xfzp+A6ol2LRW4Z90Q3XQV1T3O7LfqjdIZygIPaph540vHUpPk+w6qd7l
	 cxP+GLKsKqShg==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9755817E369A;
	Thu, 31 Oct 2024 17:47:42 +0100 (CET)
Message-ID: <cff230b1-cf19-4f19-8f93-e3cb2b3ed9b3@collabora.com>
Date: Thu, 31 Oct 2024 18:47:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] regmap: maple: Provide lockdep (sub)class for maple
 tree's internal lock
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org
References: <20241029-regmap-maple-lockdep-fix-v1-1-7589e57390bd@collabora.com>
 <5e6291c5-06a6-490e-b4b0-18a6563d336f@sirena.org.uk>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <5e6291c5-06a6-490e-b4b0-18a6563d336f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 4:29 PM, Mark Brown wrote:
> On Tue, Oct 29, 2024 at 11:50:12PM +0200, Cristian Ciocaltea wrote:
>> In some cases when using the maple tree register cache, the lockdep
>> validator might complain about invalid deadlocks:
> 
> This doesn't apply against current code, please check and resend.

It was based on next-20241028 which contained commit 49a85851b14c
("regcache: Store values more directly in maple trees"), but that seems to
have been dropped recently.

I've sent v2 [1], which applies cleanly on both v6.12-rc5 and
next-20241031.

Thanks,
Cristian

[1] https://lore.kernel.org/lkml/20241031-regmap-maple-lockdep-fix-v2-1-06a3710f3623@collabora.com/


