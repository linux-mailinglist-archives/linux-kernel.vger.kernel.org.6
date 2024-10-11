Return-Path: <linux-kernel+bounces-360614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FC7999D41
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387351F240FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68C20966D;
	Fri, 11 Oct 2024 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vo+V9xE8"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037E1C1ABE;
	Fri, 11 Oct 2024 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629773; cv=none; b=feMoXDy/0LdFqFoTYyWy/fm3O0V1F/oQL2Nn67L5RCjx8wImGUNEIU5w9OddutW31On4mrJl54OXznhPkI+TpicBf6Bln+Pqwr8JzKHa6NcbBwGy/s8qWoK+i55pS6j5HQvgDdVTtk7pP9YhU+QBcvcdGrv+TNinPKhy9Upguwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629773; c=relaxed/simple;
	bh=I/bkuFifVNbbTlacm5aTQgbOViMbpKBYr7bKUYwX+gU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VOV6IRmjzMP18Wq+RPif4fziaPlyVcAl2kL/v/esgGV5GfIxTstuIX9I0abn9RwWjzt+OTt2NJtltaZpOraDvPzvv71AHy2FMAWoTKz2FC53YUoyiQcSdqfO1U65AUSnQfQQ69FwE42eJGiR+qd1VeRE82UFwXjenEpED6LsCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vo+V9xE8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728629767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJS99CP66Czeek9OTXCx0i7J11bJHXKEYklS5RBKyCc=;
	b=vo+V9xE8SzMr8AIcvJX9/oxaqhH6UG+OkajEt5hqd1d71I9zxln6wUOYYMmhFlhzPIi5fv
	tGBRPIjlimg2rdOCw/te1SNpxgyWMkXKRfUt23EP/DeSoDjsoJvyhNW4xh3sz0rkWYJfXk
	xaEhBNHNb7FvFoGS4Co/N4392UfAjP6G2SToAFpcrmBfHST2dBEk9CJstMJHlBo6YsGVS5
	zJfZouacvTiE/L9IRFVxsfshIUjjABcKLHUUBW4pJE724ES61dPWu7c8SrVcvJLuXi+mqp
	y6Z7Q5gkPjTivhVZervWUWYpduaFRuBvzga1wkmVpl0DGN9wqWK8qBmyUk98sA==
Date: Fri, 11 Oct 2024 08:56:07 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add dtsi file for RK3399S SoC
 variant
In-Reply-To: <46729153.fMDQidcC6G@diego>
References: <59c524a9a12465c21e01b779b42749fae148c41d.1728482151.git.dsimic@manjaro.org>
 <46729153.fMDQidcC6G@diego>
Message-ID: <ff3e9357b9014a217ace90703688758a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-10-10 22:24, Heiko Stübner wrote:
> Am Mittwoch, 9. Oktober 2024, 16:06:00 CEST schrieb Dragan Simic:
>> The way the introduced RK3399S SoC variant dtsi file (rk3399s.dtsi) is 
>> named
>> diverges from the way the two already present RK3399 SoC variant dtsi 
>> files
>> (rk3399-op1.dtsi and rk3399-t.dtsi) are named, but that simply follows 
>> the
>> commonly used and/or the official RK3399 SoC variant names.
> 
> This is my only gripe with this ;-) .
> 
> I.e. looking through simple google, the rk3399t also seems to be 
> written
> without "-" most of the time.
> 
> Though for me it would make the most sense to just go with "rk3399-s"
> here for some sort of clear style between -s -t and -op1

Believe it or not, the inconsistency of having no dash before the "s"
has bothered me too. :)  Let's add the dash, which I'll do in the v2.

