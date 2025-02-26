Return-Path: <linux-kernel+bounces-533563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F292A45C13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B257A728D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D208524E005;
	Wed, 26 Feb 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U5FQXFP/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E801E1DF7;
	Wed, 26 Feb 2025 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566671; cv=none; b=QJevtKOzESqaweVSu5LJIYiYONja9RY2d9O16fTjUJfJjFXCNPj8i+UZ5gteWpN/AURIXvBaNF4m5UC+wXuJT8gqQ4fFxbCBDb5iEuw8UF67iRn3DYaWDqdRo2k+W8Ku+8ilcDPCoGtKcZYqt8ylOTuLfc73KOTWTkzoaueh+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566671; c=relaxed/simple;
	bh=eNYaagGBQl3zI4PG/iw1/+t9855oK/Pqf/7j9jiqRWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nolc8FdVZqA+fzNHZxi2IeMicJwz0oAUkVej2Y1BKvZGcB+oNP1H0phTlEV8qd+zhC92zVMlm2BNOx6AWT/WrjDoNogXPnXmdjP3KhxMyHMS7ApAPgY8I3Wni3FzSBu3KbmtZTfeN2/h6gjO7k2ga/h44vKQe2DKqBKaiizy79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U5FQXFP/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740566660;
	bh=eNYaagGBQl3zI4PG/iw1/+t9855oK/Pqf/7j9jiqRWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U5FQXFP/5o25fTSqQ0Okey4UykTudRi0qQ7P8qymo77inRkdD/U+d9xv+5nNtxrSX
	 24uakRMkjyasTEvwf4YvO3IPgBI7E2ReaQVYYbRcGGI3oMed3HTVqUkThm0QiQ3iH5
	 8S4s4fmUijpB5GH/IFg/o15X2fX/hOnIzKBP5mqNf4OYDBsmh1wGt0QUhHs5J91L6n
	 xzIAJwCdJsO1lKq0z5cWNQ67al1Hrpc90icq0YPZmC5bZTnxyvATwp2UsL/MHUBWz/
	 mWfjY3gHNbk31sowpKkr6WRVdKD35P6Nd8yFBoYcSdjOfpy4WdlBsQuViN3xMl9Luy
	 UIlgFnqKzUAiw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE57317E0605;
	Wed, 26 Feb 2025 11:44:19 +0100 (CET)
Message-ID: <ca325a7f-fdcf-4561-9e5b-8153ca7b8f0e@collabora.com>
Date: Wed, 26 Feb 2025 11:44:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: mediatek: dsc: Add MT8188
 compatible
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 pablo.sun@mediatek.com, Rob Herring <robh@kernel.org>
References: <20250218090427.20318-1-angelogioacchino.delregno@collabora.com>
 <CAL_Jsq+4+=3ccuwa1whv+UQ56H6ueia4Mqy2z73M-5D15zZw=Q@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAL_Jsq+4+=3ccuwa1whv+UQ56H6ueia4Mqy2z73M-5D15zZw=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/02/25 18:08, Rob Herring ha scritto:
> On Tue, Feb 18, 2025 at 3:04 AM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Add compatible for Display Stream Compression (DSC) IP found in
>> the display controller of the MT8188 SoC.
>>
>> This IP is fully compatible with the one found on MT8195.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../devicetree/bindings/display/mediatek/mediatek,dsc.yaml     | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>


CK, please don't forget to pick this patch :-)

Cheers,
Angelo

