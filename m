Return-Path: <linux-kernel+bounces-429196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C52669E1899
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DF32879CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B21E048F;
	Tue,  3 Dec 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vX2G9rAJ"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235CD185B48;
	Tue,  3 Dec 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219887; cv=none; b=c/OqqVUJWKVtHpCmNPiurnbNGXTpfyzr1KVm5b7c0lLeWvCvkYhfjyNTdZi+87BJyEHlsgQ9UGbtwWQQ5ggtczODLwbIfmvqsLvZI+ToPTvM3GSVYdtp9SAMXXT3t0WDK324YlluhgGk4iP5zy1U3vHPmUJdHupf966Jdz7Brds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219887; c=relaxed/simple;
	bh=82sC32BBk3DWOy6v3ntFAlsx4Y118DDNrQnhZ6MMxPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWMGbDznYkc8E5U3z1+AMnNOZBYjPx4XDi4sOA/zj+jhuwcISWK4srAZGwFeuMZTtPXFfWhlhx/m5pHCfNPBmDTpbth9s9VSYEe0fkgwrwPHW9QKol5HPRFJ1B4XhElHIUyhLUyp5v5XwqPyplJ8Q8WXxu8qXc8NKOFQY75RtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vX2G9rAJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [192.168.1.107] (87-97-106-140.pool.digikabel.hu [87.97.106.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id EBA9588FED;
	Tue,  3 Dec 2024 10:58:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733219884;
	bh=6+kB5Wl7gjZPdI2OI0HIygHEI3G3GMS7nXK/Vezw7xo=;
	h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
	b=vX2G9rAJ9adCKPoap+Xcp4Uo/S1Z96k4xEvEe0teFmng5ZVSvEGp/fTr/Yh8wqo5F
	 bki/oa7qOjg+nikw2aPWTYLhisdmtInvjSx9e6ecTS1oVBZhnXQ9VvtsggKs/jgFSn
	 Bh1IElZ3Vmja4OzXmu6PFdiI+2fZukaHYW4Foiqrmnb+P7qVP3E8BsFiBEYLhtLXl2
	 GtBLrUkyg/80/1+p87v3XVnvYlxMKBZadEaBnBvNz/eKeFbuRHlnXKwwMWE1FEIqn/
	 BuLwzx2PbepI/qUE/7qFMFecap5TBykU8vCFHU0WvdfwYb6txowtTtk/QeWjWr8DHB
	 NbKtwUvmcM6vQ==
Message-ID: <71e330ff-c5bb-fcd3-1ebf-630cef8fc626@denx.de>
Date: Tue, 3 Dec 2024 10:55:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/3] mtd: mchp48l640: make WEL behaviour configurable
Content-Language: en-US
To: Jonas Rebmann <jre@pengutronix.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, David Jander <david@protonic.nl>,
 kernel@pengutronix.de
References: <20241203-mb85rs128ty-v2-0-42df3e7ff147@pengutronix.de>
 <20241203-mb85rs128ty-v2-1-42df3e7ff147@pengutronix.de>
Reply-To: hs@denx.de
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241203-mb85rs128ty-v2-1-42df3e7ff147@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Jonas,

On 03.12.24 10:37, Jonas Rebmann wrote:
> From: David Jander <david@protonic.nl>
> 
> The 48L640 resets the WEL bit (the Write Enable Latch bit in the status
> register) to zero on the completion of write operations. In preparation
> to support chips behaving differently, introduce .auto_disable_wel
> capability, and, if it's missing, explicitly reset the WEL bit after
> writes.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>   drivers/mtd/devices/mchp48l640.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

