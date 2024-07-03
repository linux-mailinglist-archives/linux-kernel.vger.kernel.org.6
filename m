Return-Path: <linux-kernel+bounces-239503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1702926108
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84DB1F23573
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E7178CEE;
	Wed,  3 Jul 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B3QwUuHM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D7142649;
	Wed,  3 Jul 2024 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011731; cv=none; b=ZnQOTX9aROTwSNVM36Mm0v77uICd4J0HpHMzQJHY0PBZFbo+tVAPgk0gTRmKW/izluEWQzo9XSC3ePg3DLbhWLjwafvtyvi+rUTMGpLs0DCk/gq3/V05CjZQ+5f0dvwnSyQObjqqUoa4Vqaf+cxVn9TAGpOtupX6o3lQpf8Y1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011731; c=relaxed/simple;
	bh=TOADNGjX56WX/yUPHZlqe4KeE8KUG2F1J81HJ0Nduqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAFP7JgJEZIH5HWtVAMyleKz+8rxOW4V4JAFpLjUtiNAu1m96v7xVQlPBNZdaRroU4bFS/FQUrUcFGZY5Jmas3WOwKIaEvqZLZLrm/SGe5sBD4SEsZynJ4MAINoTeT/FpGqE3MpI2qdbL2OZBJor1VomjKqmMEVUPvO0Av7vWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B3QwUuHM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720011728;
	bh=TOADNGjX56WX/yUPHZlqe4KeE8KUG2F1J81HJ0Nduqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B3QwUuHMiLSNKY8w9FvSDHWQGC8RtMk2lCdQq680c5dTUYDC/xAUAToJfsYk4gQqd
	 Vka1X3ruIcwYyoVLk7s6JNyUtCMW0ib1JuQsk40T2B5QvFINWA3n0Augx1T7UNBjhc
	 SLyJ9mqrkTvrCFepImK9vz23Ap1/wd3ktUlbZbeI6Dx9oXQ74s4knmj8TLq0C+9sG3
	 aOBDnN1SONNb81JtpD6lX1CHNFL3s6uPPvRizudbF2VQ+boZioAzfZmSdKsfCoAkvJ
	 1uDZiztl0i4Jsj/j1OoazfDi8AqdtGNJnQYAyUnoj4QNTQcPOxN60sZfVpCSaWy//R
	 Tow4qrC+Y1+Lw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AACA43782194;
	Wed,  3 Jul 2024 13:02:07 +0000 (UTC)
Message-ID: <59b24780-3c17-4e1a-ae3c-14584f9f5101@collabora.com>
Date: Wed, 3 Jul 2024 15:02:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] soc: mediatek: pwrap: Constify some struct int[]
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 matthias.bgg@gmail.com, fparent@baylibre.com, fchiby@baylibre.com,
 s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1719652155.git.christophe.jaillet@wanadoo.fr>
 <626783bb264a8b3b0c8cd7e1d9f9b241f0a494b6.1719652155.git.christophe.jaillet@wanadoo.fr>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <626783bb264a8b3b0c8cd7e1d9f9b241f0a494b6.1719652155.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/06/24 11:19, Christophe JAILLET ha scritto:
> These arrays are not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>     text	   data	    bss	    dec	    hex	filename
>    45528	   8532	     16	  54076	   d33c	drivers/soc/mediatek/mtk-pmic-wrap.o
> 
> After:
> =====
>     text	   data	    bss	    dec	    hex	filename
>    52664	   1384	     16	  54064	   d330	drivers/soc/mediatek/mtk-pmic-wrap.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



