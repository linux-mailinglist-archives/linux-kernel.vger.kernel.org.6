Return-Path: <linux-kernel+bounces-255311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57F7933ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4740F1F255B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D89181323;
	Wed, 17 Jul 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JwV93CQZ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874DED8;
	Wed, 17 Jul 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227608; cv=none; b=eJYPSRSmTBuApuEXhgw2i6sjSPM8AZzDZfuHH3gTMHUogh1njjD/AIAvHHG7jli2yoMD023JC3Qa225q8GV4lvJJ1yEdj4poJyOOGFqTTPHzdu3LBXOD9lcW/qi+xBYjfzkKWlQlmGi8r1Th6dP04HzUw46PyC5nZVZgdybuRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227608; c=relaxed/simple;
	bh=9UypgbdK69vly2iuCiQPKXb/bxjUBe83B8hHTMSs5eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEMOGtpOAK0UVpkMFVA6XcIRmp7mKFEq9aMttha7zdD54fqZ5tzlpYqU5jyIhiZoP9u093HhCgYthqBIjbAYdEFdokKK30nI9mRn8E6GJlMGs8g0JO89DUsbEvpbSBwuzKRPjOfOzxUP6ERLupyaodD4DTfpXvvuf1sBAzUijto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JwV93CQZ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC1B960005;
	Wed, 17 Jul 2024 14:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721227604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDzwIwMGC9LvQeNI5HwHnRTwy+IJfn8/44kVuhaFgFQ=;
	b=JwV93CQZrkfkE9v0sK5mbpw3GbP6l8X5IP1Uw4KHAspm6tJ1qb1rtM/wB/wJEiIg7is0BD
	U9PgJCZq4cRcXyM29ClrHPxV9vo/VLs3Tbnzl3WvmA7i31G1M2hrkK78ZQyCbSe3+DOwHi
	Vea3VAuS1ngEwPn7D8qji3Zm16AYg8RUIJzxl+s4G9rIB/uipZ5bYOPP6Zq2Z01JJKOVcP
	ZNaYAm5B+Idy1Z3sDl2nnOy8uDv0q9kjmTCtTjf1JzFIQ8cachr7KncdL7NZm78cz4hRO0
	buewyb4ZIQFMp0vZAjzPICENDfjw+94ksMKD/v0EtG2O5eDIPJN+lP7HEO8GzQ==
Message-ID: <9e8405fb-6e80-4949-ad37-a50a8cd930da@bootlin.com>
Date: Wed, 17 Jul 2024 16:46:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: davinci: da8xx-cfgchip: Initialize clk_init_data
 before use
To: David Lechner <david@lechnology.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
References: <20240717141201.64125-1-bastien.curutchet@bootlin.com>
 <6081230a-2324-4200-a51d-9b7fefc454f8@lechnology.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <6081230a-2324-4200-a51d-9b7fefc454f8@lechnology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi David,

On 7/17/24 16:22, David Lechner wrote:
> On 7/17/24 9:12 AM, Bastien Curutchet wrote:
>> The flag attribute of the struct clk_init_data isn't initialized before
>> the devm_clk_hw_register() call. This can lead to unexpected behavior
>> during registration.
>>
>> Initialize the entire clk_init_data to zero at declaration.
>>
> 
> Probably should add a Fixes: tag.
> 

Sorry I forgot about it, that would be :

Fixes: 58e1e2d2cd89 ("clk: davinci: cfgchip: Add TI DA8XX USB PHY clocks")


Do I need to send a new iteration with it ?

>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>> ---
> 
> Reviewed-by: David Lechner <david@lechnology.com>
> 
> 

Best regards,
Bastien

