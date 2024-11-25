Return-Path: <linux-kernel+bounces-420734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9AE9D82AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8532D2827F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62765194A44;
	Mon, 25 Nov 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iqaRCXmA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335F190676;
	Mon, 25 Nov 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527627; cv=none; b=PLYtizZIjnDk1WYDRIxGhGQSPJcfLyRX0rStKBhPu7oOj1JPA9IDeyfDDsT9Tbrt1w/bbWQkzhhKe9mS3lXkcsYVNesDu0dzQ9uLmkgy+y8u4hO/m8pLgP1gLsVlabjuPuH8iv2nyaTvDbZHUsYzTd/FiqUXhluxprvEbmUbbbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527627; c=relaxed/simple;
	bh=d9COl/HNryGOtsnndDDZCpiMYa8ON1Clq6F2gVqRaWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfPTvXDpmtgqAFQ8juuPyUa78QIpZoJbUnywPTavzccAozSV+z2MJ4kBqv+q4TT9aGH76586t6PJ4D9kilC5D0nqyKdObC4AcGEfUXWvPTpJet57hbM4kZpDcap+5DY6BbRD9n1xulhDOGor0C21CrcfifLdxif2NQUIrWmZjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iqaRCXmA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732527623;
	bh=d9COl/HNryGOtsnndDDZCpiMYa8ON1Clq6F2gVqRaWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iqaRCXmAPGiFTo1xKAHvs4MZJXM3fxG9nD+pGnOJH7t3F8fOjFY1lGQaL8bKiloKf
	 ZdPABCbAi2V2rifIE0bqa0vz0fP8elp3cdd7f/HN9SAXqMUBeGahFmPOuoFmKyjy3a
	 plnUOVhIR9yAiBt2DMkkop93hprpv1YhrmQB8cOXVfHfG06To05w69kjaWHUFq9oXS
	 FqkF9KSjpOacEuIf9Tsga2hDnDt0P6BK8EwICMxz86CDJi7vro+JIKolJkPLzI/23H
	 l2fp8cnzDXAeg/gEYfUt2HIJp13OUUrgHH8sBH8TCvJQDAa5QG5V+XwC5dFGk3nb1U
	 KpR10zPAMkeew==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B51017E1411;
	Mon, 25 Nov 2024 10:40:23 +0100 (CET)
Message-ID: <03b5a671-e0c0-4d18-a103-e7f0ab18e20e@collabora.com>
Date: Mon, 25 Nov 2024 10:40:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
To: Maxime Ripard <mripard@kernel.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, ck.hu@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
 <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
 <20241122-cobra-of-authentic-discourse-e2c5b6@houat>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241122-cobra-of-authentic-discourse-e2c5b6@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/11/24 10:20, Maxime Ripard ha scritto:
> Hi,
> 
> On Wed, Nov 20, 2024 at 01:45:12PM +0100, AngeloGioacchino Del Regno wrote:
>> Add support for the newer HDMI-TX (Encoder) v2 and DDC v2 IPs
>> found in MediaTek's MT8195, MT8188 SoC and their variants, and
>> including support for display modes up to 4k60 and for HDMI
>> Audio, as per the HDMI 2.0 spec.
>>
>> HDCP and CEC functionalities are also supported by this hardware,
>> but are not included in this commit.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Just a heads-up, you should really be using the new HDMI helpers, it'll
> remove a lot of boilerplate and potential bugs.
> 
> Maxime

Hmm... the state helper you mean? Or the inflight series from Dmitry?

In any case... yeah, you're right, let me check which helpers I can use: that's
going to be done for v2 :-)

Thanks!
Angelo

