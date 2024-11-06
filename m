Return-Path: <linux-kernel+bounces-398460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1A29BF199
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC51F235F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2282036EB;
	Wed,  6 Nov 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bzHfFpuh"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76DD1DDC39;
	Wed,  6 Nov 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906849; cv=none; b=GtB5wwHx1xNwyfIfPyJdE/SCHYpRyqfHptE1wEiPJyreNrhDb42df3Jy7qezPw/S9AQmcOqDLIjYrX4kY9Nwt4V106OQU943qT3q+evJEVSOq3LBX+CCBMUxm7ab9wl2Qtjdf7Q+AnDElxsnwvvGoYkiFkky3BvC0y2zLIXix4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906849; c=relaxed/simple;
	bh=iSzKz+shELWSNdupg1yixRntT7CVK2nSAfylhyalHC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qc6ybD51R9NRaWwlONBszAZBgbODdLvSrmzk1lsFOzrvD6gqqLd7JUErWhwW8mAgQvI589TICfSY1Y/6vgxTKGNFM6vtjiQOUVPuaY3gpUephuBj1tnCDbqIU7WiSLtmY8nQ4uewavaNRtQXq0qGHgu3NQlrU7C83nkHhVhmWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bzHfFpuh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71FCE1C0005;
	Wed,  6 Nov 2024 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730906838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgCd9n1DYZSPzsVkD7Mntk31olVCOSxSO4/s3dPkw/Q=;
	b=bzHfFpuhzYJ+A4Q5wxVrWibz+boRuT5ucqxBNAANy95NcEGExX+j4mKPsQQqBXYiLRG0bT
	97W9LcYRZu/V8xjP4VFso6q6RigavNepgPxp+zuCyYc0m5Xm4tHg7eYjOuHZ72KBn5N0xp
	jesznPs4W6oITahkQP0BjricE72+1VeG3CRWuyq0Gjn1nGm/tcrpgG8u7Oq6j9nmXVtdvC
	tYmKea+JZ1Rj0rm3Kq8a15n2WkJLQmUmLqFl06RuEXBvS30mB4nIHLkYwt9yXZL6KAJlby
	VQC81bUlskcOlrojEZILA89AOvyjyHgAE3UxFbtv7tg4yIQGZsKdvBo8CdAKWA==
Message-ID: <4d0bbd9a-d73c-4551-8f21-78468bb2dc38@bootlin.com>
Date: Wed, 6 Nov 2024 16:27:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hwmon: Add Congatec Board Controller monitoring
 driver
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com
References: <20241104-congatec-board-controller-hwmon-v1-0-871e4cd59d8e@bootlin.com>
 <20241104-congatec-board-controller-hwmon-v1-1-871e4cd59d8e@bootlin.com>
 <d699cddc-a8ae-4094-b1b5-7af8cd7e91cd@roeck-us.net>
 <b85a7486-578f-42c9-9ec2-b5befa75d893@bootlin.com>
 <761490f4-b0b2-442b-b1b6-ced74e9b6300@roeck-us.net>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <761490f4-b0b2-442b-b1b6-ced74e9b6300@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 11/6/24 16:14, Guenter Roeck wrote:
> 
> My thought was to use the sensor ID as channel index. In general it
> would be preferable to know that, say, in0 is always the CPU voltage
> and that temp1 is always the CPU Temperature.
> 

Ok I understand now.
I'll try to do it for the v2.

Regards,

Thomas


