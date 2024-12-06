Return-Path: <linux-kernel+bounces-434889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B19E6C5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA8163E5A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A951DF274;
	Fri,  6 Dec 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NI0ddyqe"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E333199E92;
	Fri,  6 Dec 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481280; cv=none; b=RSI8tzAs9nd1Oj4bqq7qkIU1K9f/IWAZkrarvk7os6vVwfzBQmSjVJ1ZXuwBpyUSOqj3yyHy9EsI7LpaQIKibVaDsWhQZ64TsfJ4EuBaC9NlIv5LzmlSacbeomP0fONGkplvOOjIHTu6AJJ6T7EXrfPnvK9aOW2V3eaXpbfJa9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481280; c=relaxed/simple;
	bh=i+zfIBw5DvlGVG+5jujERRBXQi9e8CjS112aE93QRYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSEeJ+7b6rQ7FZEUYXdj6tO80LsnSEw4HQperMtdQOa62uyyG6oGnkGtsF8O+EmpCokxZAV9blqAJy5vFUFUmHm9OvpvAXLVjcumft8tEyLnh1o/emOmRaHX//Xbs58oZJOC7JkcA0ascA7HvXI/2ftdAUN6U8LVt4yGhoXTxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NI0ddyqe; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B760CFF80A;
	Fri,  6 Dec 2024 10:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733481276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ajKPXRG0k9JASC73/ZnAiBhOVfRI5UgSWHK8cjfgbY=;
	b=NI0ddyqe3dsSmjff9NxKmmSpGUb/70r3vZO6id9LQjdJEOUuO8puBx6QNzi6QYjbbDgWMy
	jOoQj7fjpmsmBCObRsCjDUchSgkQiC/vapFzgkffT+dVyut43lFdzMWovHQtuSVMXRvRL/
	xjhX+D64S+6PvEAs4Q1sEEW7D/s4HDvZpH5l72zASCfxyqR6tK20wPs9jvk2wk7ex1mo/K
	+rhvjXEWF+28Tb74KI81KpR0f8P6yceD5rn8L7jyohcQAMzE7gOIEa/Z6Ky1Eiq2fVSsFd
	p/cAMQPJTGgFbKskLK7AazwTAvBwulMFaU+4wsLjKgZcoKOKULpFTNVpYM9hxQ==
Message-ID: <02c38a22-6196-4b53-b092-5185b4df134c@bootlin.com>
Date: Fri, 6 Dec 2024 11:34:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hwmon: Add Congatec Board Controller monitoring
 driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com
References: <20241115-congatec-board-controller-hwmon-v3-0-1c45637c8266@bootlin.com>
 <20241115-congatec-board-controller-hwmon-v3-1-1c45637c8266@bootlin.com>
 <e91a3c4a-6324-471a-a1eb-47eb329d2d6b@roeck-us.net>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <e91a3c4a-6324-471a-a1eb-47eb329d2d6b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 11/15/24 16:57, Guenter Roeck wrote:
> On Fri, Nov 15, 2024 at 04:39:08PM +0100, Thomas Richard wrote:
>> Add support for the Congatec Board Controller. This controller exposes
>> temperature, voltage, current and fan sensors.
>>
>> The available sensors list cannot be predicted. Some sensors can be
>> present or not, depending the system.
>> The driver has an internal list of all possible sensors, for all Congatec
>> boards. The Board Controller gives to the driver its sensors list, and
>> their status (active or not).
>>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>>  MAINTAINERS                |   1 +
>>  drivers/hwmon/Kconfig      |   9 ++
>>  drivers/hwmon/Makefile     |   1 +
>>  drivers/hwmon/cgbc-hwmon.c | 304 +++++++++++++++++++++++++++++++++++++++++++++
> 
> Two problems:
> - Documentation/hwmon/cgbc-hwmon.rst is missing.
> - "git am" fails due to a conflict in MAINTAINERS, meaning it is not based
>   on the mainline kernel.

It is based on linux-next, as the MFD driver was not yet merged mainline.
Now v6.13-rc1 is available. So I will rebase the serie.

Regards,

Thomas

