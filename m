Return-Path: <linux-kernel+bounces-295519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E555959C16
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90271F21B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936AF192D93;
	Wed, 21 Aug 2024 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Pnjkthhk"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1E166F04;
	Wed, 21 Aug 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244105; cv=none; b=VpRDpCVAvz46MkSZvhm1uU95XHgl/kczxjiotm5AyrjXmzICdzTihi2QPzR53zNoXDOaTe5BB5FMreuFNiQ942bKsy0d47cvFMZaeJRk1VI6/Z8PcJ0XGPWmO5NmC6L5xTtqTZImcFEdY+Wnzjn23w9tbrlr1pyh4pFgwCuaotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244105; c=relaxed/simple;
	bh=EsMQAnljqLYk2mg+9BgJGe0kw7IlSVVj24D6Cx+uNhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7Pzq4oLqYqY1fvIG7uuHTfp+7S/CIC2FV07xo3wfFrOvGBSHhz47Sf2Mq/Qd9h5EZ3XLOcBKKt+S4hF3lZPbSPYgpjwLzqVg6gSpjNGpkQbc+pOpBKv4SrGYLKqp545Q68JgCInuwueDIhGGSPpqO8nPSgC8Qz5sD0NtEWwcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Pnjkthhk; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gkeesb6mZOcVzgkeesvUMF; Wed, 21 Aug 2024 14:41:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724244101;
	bh=38otxe0rShpu9V3hspfMhWjYBCrw6aZylL6ZPFg4CXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=PnjkthhkeaiC56ISU4uKqMxDwwRj+xU9NgrcGaPz74Y7NhGoY/Pmi7CMD/hAcEBTb
	 AMm9lUohxobH+9XLApb7Jowc1NlpG7YFKOWOqU/gRAtIqMCXz4jzOv82XGR8ZcmAxt
	 raTliPob5jIwUFek3wpY3KdmOcoxhd+EkRalC+VQTzs8G/Mps0LLTlnGhYsk4UynE2
	 kRCTb8GVj6S/TIafxYcDfPJCVo85EEjMqOsHojsq3jTFGElGQfJSSCd6DtvF8xude3
	 mhk4otKwKWJWGubrn6MD89/0b8GJ7w6iibe5zUHwZNXpViRZTzrbnb94jiRF4hBu0+
	 GE3qnQLYCKcww==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 14:41:41 +0200
X-ME-IP: 90.11.132.44
Message-ID: <7818c69d-8821-46bd-8f70-fc3cc6fc06dd@wanadoo.fr>
Date: Wed, 21 Aug 2024 14:41:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] platform/x86: int3472: Simplify dev_err_probe()
 usage
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Scally <djrscally@gmail.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com>
 <20240821122233.3761645-3-andriy.shevchenko@linux.intel.com>
 <a096554e-fdfe-4deb-b19b-500c86beec98@wanadoo.fr>
 <b9504b3e-5657-5c0f-7ded-69474a9e5647@linux.intel.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <b9504b3e-5657-5c0f-7ded-69474a9e5647@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 14:39, Ilpo Järvinen a écrit :
> On Wed, 21 Aug 2024, Christophe JAILLET wrote:
> 
>> Le 21/08/2024 à 14:20, Andy Shevchenko a écrit :
>>> Since dev_err_probe() ignores success,
>>
>> Hi,
>>
>> Does it really?
>> It does not seem to be the case (at least on linux-next). Or I miss something
>> obvious?
> 
> Yes, you're missing the first patch of the series. :-)
> 

Lol.

Sorry for the noise. (* blushing *)

CJ

