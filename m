Return-Path: <linux-kernel+bounces-431362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027BA9E3C66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A672A169963
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C83207A2C;
	Wed,  4 Dec 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hA/CXNPq"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D81B0F19
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321682; cv=none; b=Pm3UjTHq1F8fliJYXzEPgVRsUBMnt1wnfFeqdyTarKA2txOvzlw7foek7Ff0/O3urqp2e9t9jZWV+wR4UF5/gaIYogXCx6xWiRH3AXIRgBTakDSLvlpQmnQ9YGTW8eDTe/cABfTQrZTG9XQyzvVlBl+vEWBe4LXbVikKjUej+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321682; c=relaxed/simple;
	bh=9e/D7Plyw7JzA8xTAL1xdgYdv8mxp8mIT4gvYy4a1Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgMQsOsvzojEn+NDwdlegl588QxD7HFNtMCTIrAUnhF883OC/NIvWBwcv/D+xQvKaUuJu640ZjCEGqHDHjGW9fj1bHbufZf33ZOtmZ8IYgzxJXppQR/A0M2Vo7ZVALBbVyVRXMX+RgkKNbZnSDY/4zgb79lQMcoMYLQfJqX9LnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hA/CXNPq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8379AFF80D;
	Wed,  4 Dec 2024 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733321672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OK/4gPzhGVRToMUjBY9/uZ0DFpXZz5xj2qyXIu0bR9A=;
	b=hA/CXNPqzjpZTRwJzs4+rbf+sICgYqxVu/aboyX/WWqRH9WTL/lFiK/A8Z+Xctn41qJMAS
	8qNyaiiI0WWa+dz/uiRGMaSrdxBarsr2Vx84C7EPmudrJ978DDdzVOuVUk6lQMpOKiZ3uZ
	TS2z7xBXJMvAXqNGDsZCp/QCrC7npe5QgMRzhuXCIn4eSc2069ZJOcwy967mQNS9X9ykGK
	vMzmszZZ8q1YbL2q+oHmSd7Tgbk0xQx8IuP5d4AoVRxg/DRea/8mto+H65xLWy9DhKwnbr
	EnbHn55qDEaobyBj8fvBatTAJHoDKjby2VLvhx0oK3KeJwcjs+GFuwHGE7SK1Q==
Message-ID: <30397c99-936e-4abb-b214-fca6ce95c2bb@bootlin.com>
Date: Wed, 4 Dec 2024 15:14:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mux: mmio: Add suspend and resume support
To: Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com
References: <20240613-mux-mmio-resume-support-v2-1-e8496099b034@bootlin.com>
 <d7e9d9f8-ac81-4cbb-897c-585741ca00c9@ti.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <d7e9d9f8-ac81-4cbb-897c-585741ca00c9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 12/4/24 14:53, Andrew Davis wrote:
> On 9/11/24 3:53 AM, Thomas Richard wrote:
>> The status of each mux is read during suspend and stored in the private
>> memory of the mux_chip.
>> Then the state is restored during the resume.
>>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>> In this second version, as discussed with Peter, everything is done in
>> the
>> mmio-mux driver.
>> A mux_mmio_set() function was added, and used during suspend stage to get
>> the status of the of the muxes.
>> This status is stored in the private memory of the mux_chip.
>> ---
>> Changes in v2:
>> - Remove all modifications done in the mux subsystem
>> - Add a mux_mmio_set()
>> - Read the status of muxes during suspend and store in the private memory
>>    of the mux_chip.
> 
> Do you need this private memory? Since this is already using regmap, why
> not use the regmap cache, then you can restore all the values on resume
> with a simple call to regcache_sync().
The regmap can be set without cache.
As you inherit the regmap, you cannot assume that the cache is enabled.

Thomas

