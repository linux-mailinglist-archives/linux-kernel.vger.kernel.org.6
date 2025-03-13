Return-Path: <linux-kernel+bounces-559618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44736A5F64D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E987AC783
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD3267B65;
	Thu, 13 Mar 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JOW6V3vy"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BA41760
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873806; cv=none; b=j/jaTE/0PmLRUq/7SoPkwLegoN7VXlIa9Lt5siupbaikMUA9RcfoknlDUoan665bEoU2yU6oihNt2yb9+MUjlL0QSgdbS/8nDkih0w46hHkBVVqfFHUUEDOMJbVjxNvWT+iyYMW3ATwhgQB9Zan1+pL7wFL9iaMdVZDQVGTH6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873806; c=relaxed/simple;
	bh=jRgklwSpOObB3tgAKwapZBR1LtUC3VEGXkKBpRqY8qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBdNeAtf04O9P7/k9wfJz743OdnvrK/QpGkwCiKcM7tAZvRE6OPBI47dkPszjbAsHLZeHa/bYg+72aV0fdwh4W6mPvZsX8UaobsJeEmQ0P4PDu0bJxl2F5+oBHvnbUQwA156QEXIcXRpS9Imjz/OmR5PvfWP0rMm6iPMl+B85rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JOW6V3vy; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 668E01020E4C2;
	Thu, 13 Mar 2025 14:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741873795;
	h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zwZpJol3r+NZfuPaketwR5AKh9kAknjnnobmvM92/Kg=;
	b=JOW6V3vyrlwAYaE654BuUamBuLqqbSp4zV+zSf1rcfMd4KjpvOyOh+yJ50hOgGXe4NfRZi
	LjfMJU2AKCodXW0KboUIPgH3P8YF9pJWjUdlD4F75gTXYB6Kp7+9R6FAi4QlgW8xJRJV3H
	ZpRP9vMphJdYWJXz5+mdXs+8i1Hn1+hN3OpVIL5o2TB0HEldrD+R3JwCU7fT8iQKQCwAT9
	NJAof/0sHfkhvRSlqGF8TnuPR+6E8qdROePI5szQ7e9jjezojfNek57Q2Ad2E6HZ+cFMfx
	Y4BsYiKbLHU69e+SO6Xr9YE4+SyZV4h1ewLSx+LckqSy3VbXCvNK4OXVIBQ4tQ==
Message-ID: <27e6e64b-9627-1307-3ca5-2bcfc471f157@denx.de>
Date: Thu, 13 Mar 2025 14:50:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] mtd: mchp48l640: Use str_enable_disable() in
 mchp48l640_write_prepare()
Content-Language: en-US
To: Zhang Heng <zhangheng@kylinos.cn>, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, han.xu@nxp.com, david@protonic.nl,
 jre@pengutronix.de
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20250313095756.945890-1-zhangheng@kylinos.cn>
 <20250313095756.945890-2-zhangheng@kylinos.cn>
Reply-To: hs@denx.de
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250313095756.945890-2-zhangheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Zhang,

On 13.03.25 10:57, Zhang Heng wrote:
> Remove hard-coded strings by using the str_enable_disable() helper
> function.
> 
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
> ---
>   drivers/mtd/devices/mchp48l640.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

