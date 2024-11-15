Return-Path: <linux-kernel+bounces-410773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D63699CE0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56539B3183B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598461B85EB;
	Fri, 15 Nov 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W1E4fNyn"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242991CD20F;
	Fri, 15 Nov 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679239; cv=none; b=p9MJb+F4Rte7Nq0vQcuLyj8cKsmioh1KbtwuaABE1udgEZhOXhXb6KJW2YZhw9AMqEXhZRcQp7d1AAULAUCr1VTyzvXl//EjTMpsHbor+fxppWToZTbWl0Q2K0ZLX+V79hRHrf14TTSExV5P0muREoYqfagUj0QRnYvJMod1vKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679239; c=relaxed/simple;
	bh=I5T+eZHulxp39JuMwVLh3FhcOJkyaOrgtrdF9TbIReA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjDWMAq9F9sWIPHLbwp2LAeZ0r6WZ5/Q+AHz14iJu0xsTREoiResU578N40BmSapFOw9MU4SYLjxr0XbDaHUWLXnh/LKEo0rJfm+r63OX8FbPgKj4LU4HoLFnAts1zcDx8PgraD+Ho+KtZgWb/ksHqEvnhds77N+/ms9BRJ52rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W1E4fNyn; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67B9940007;
	Fri, 15 Nov 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731679228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZxAHWylk3A1SUrCfDTgCaWa8f0dpQznUWfUWRKeChQ=;
	b=W1E4fNynHjgHf2rPzaYB5Ln9OuQwbze9DMtg7ux5keXImME3K8QYTewrhmR7qGkVexYa8v
	DTfvD8O1qXa7d2ojm5h1tMfUxgCX3uG3hzq9E88jw23rufuV8MDuFhP4k3rtccKfGh7sNJ
	oUtYWV6Gz+YaC57pS+f6uxnOgDfiqefHuuwbR9yzF4+v5tEtrTvKA2CUvGpC4WDk4AyAf9
	NDr+/vyZzkC8HMIkmTmEjBILgBi/J/l0F48N8MeyBaRrOlCshhQ+eKgg+TcHfJGTxYeqeC
	GeEOTPwFQ8NAfEufZs74aPFXyOrafviCqKDEryifjmH6FucXmf/NXngghTinqA==
Message-ID: <c4eb5a59-4551-476a-aa03-06849dc9680e@bootlin.com>
Date: Fri, 15 Nov 2024 15:00:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: Add Congatec Board Controller monitoring
 driver
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com
References: <20241108-congatec-board-controller-hwmon-v2-0-16e337398527@bootlin.com>
 <20241108-congatec-board-controller-hwmon-v2-1-16e337398527@bootlin.com>
 <609715ff-973a-484d-9267-ff80be7e36f3@roeck-us.net>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <609715ff-973a-484d-9267-ff80be7e36f3@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 11/11/24 20:31, Guenter Roeck wrote:
> 
> I don't understand why this would be needed anyway. The current channel
> index is well known, so adding or subtracting a constant should do it.

My first idea to use this macro was to avoid issue if a new voltage
sensor is added in the future.

But it's useless. If in a new generation of Board Controller a voltage
sensor is added, it will be added at the end of the list.

But it doesn't exist for now, so no need to take care.

I'll just add a constant for curr sensors.

Regards,

Thomas


