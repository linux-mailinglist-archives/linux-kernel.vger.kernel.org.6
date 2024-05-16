Return-Path: <linux-kernel+bounces-180857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EB18C73FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972491C23404
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D6A143861;
	Thu, 16 May 2024 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gnNhJynD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC14206C;
	Thu, 16 May 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852577; cv=none; b=mejk22RRZsmbUjh6yKZlkh8RJRStkQa/lClzpD9EW+9xh1YuMg+3SvvymfSPzuhkc0PBtJJ5aG9L0KMVsmEKCMauTdypt26iBzxiEjFpV2Nx796YTwgvoa3OKxAtduk9KvBXKcqzb2Q99MiVD7uZYhbSLehIDE35wz9NFsd2+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852577; c=relaxed/simple;
	bh=H3O243kSJW6K88T+dVi/0NKhZPWFTW+Zoxcp6Ablel0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyFMyB9r+7x7XY0lZcMxDZpouu81VasiC3+ZI9i8IkCQhUUd+81Cm1a28Tif3+/8T9ONzooe4nLkJ9XSX4OaP7zba88u/c3wdVleuejP8VZXI/DUETTJfpdsa+ev7DrFDFo9QpDvXRC0oflbW8Cj6LsKlEwZi2w9PRL9QQH9mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gnNhJynD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715852573;
	bh=H3O243kSJW6K88T+dVi/0NKhZPWFTW+Zoxcp6Ablel0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gnNhJynDO17dcyTxR6IcUdoYBioRyWNo6YNIhTGnexQTXUsYyAh9GShoVghxoArH6
	 qxyvmblrOC38+tgZ2W1QMK+KtFJ+z5espYG1FUXHJ4GHmSYz8iFWf2rGv5TH6oM/2t
	 kSTbK/2h6IGMLbuu7Eb2dM1Je+8U6sck88t1mdEOba1Jc056FMXxrg93uCAIscqApD
	 LPv6a3twrBJWDshPYZrzh9zIx3E/xDZUelDBzwBrl267PPBuvqmYs/a4M3jbeeKWuT
	 fnL8KRGnEwYgUY+muMuyWySO6+OTxU8xyMQbQ5P0G3zWlHcLAe97uCx9TyWvZmKMuo
	 FNeNt38DERbjw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0726737821A9;
	Thu, 16 May 2024 09:42:51 +0000 (UTC)
Message-ID: <eea541cb-1917-44de-ae40-0824372baab8@collabora.com>
Date: Thu, 16 May 2024 11:42:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "wenst@chromium.org" <wenst@chromium.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240516081104.83458-1-angelogioacchino.delregno@collabora.com>
 <20240516081104.83458-3-angelogioacchino.delregno@collabora.com>
 <389716757b2a79f56b3cf4f4127549795c867785.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <389716757b2a79f56b3cf4f4127549795c867785.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 16/05/24 11:23, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Thu, 2024-05-16 at 10:11 +0200, AngeloGioacchino Del Regno wrote:
>> Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
>> per HW instance (so potentially up to six displays for multi-vdo SoCs).
>>
>> The MMSYS or VDOSYS is always the first component in the DDP pipeline,
>> so it only supports an output port with multiple endpoints - where each
>> endpoint defines the starting point for one of the (currently three)
>> possible hardware paths.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/arm/mediatek/mediatek,mmsys.yaml | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> index b3c6888c1457..0ef67ca4122b 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> @@ -93,6 +93,34 @@ properties:
>>     '#reset-cells':
>>       const: 1
>>   
>> +  port:
>> +    $ref: /schemas/graph.yaml#/properties/port
>> +    description:
>> +      Output port node. This port connects the MMSYS/VDOSYS output to
>> +      the first component of one display pipeline, for example one of
>> +      the available OVL or RDMA blocks.
>> +      Some MediaTek SoCs support multiple display outputs per MMSYS.
> 
> The display pipeline number usually depend on how many display interface. Display interface is in the end of pipeline.
> 

I have never stated that the display pipeline number depends on that.

Plus, the display interface is not described in the mmsys binding: this document
is only saying that mmsys' endpoint is to be connected to a (supported) component
of your choice. Nothing else.

> In below case, two RDMA is merged into one pipeline and output to one display interface DP_INTF. This is usually ONE display.
> 
> RDMA -+
>        Merge -> ... -> DP_INTF
> RDMA -+
> 
> In below case, one RDMA data output to two display interface DSI and DPI. This is usually TWO display with the same content.
> 
>                 +-> DSI
> RDMA -> ... -> +
>                 +-> DPI
> 

The actual content of a display is a software capability - if the hardware supports
that, and some MediaTek SoCs do, the connection does not happen at the endpoint of
mmsys, but later.

> So the display pipeline number does not depend on the number of first component. It usually depend on the number of display interface.
> 

I sure agree with that, but again, I have *never stated* that the display pipeline
number depends on the number of the first component.

> Regards,
> CK
> 
> 
>> +    properties:
>> +      endpoint@0:
>> +        $ref: /schemas/graph.yaml#/properties/endpoint
>> +        description: Output to the primary display pipeline
>> +
>> +      endpoint@1:
>> +        $ref: /schemas/graph.yaml#/properties/endpoint
>> +        description: Output to the secondary display pipeline
>> +
>> +      endpoint@2:
>> +        $ref: /schemas/graph.yaml#/properties/endpoint
>> +        description: Output to the tertiary display pipeline
>> +
>> +    oneOf:
>> +      - required:
>> +          - endpoint@0
>> +      - required:
>> +          - endpoint@1
>> +      - required:
>> +          - endpoint@2
>> +
>>   required:
>>     - compatible
>>     - reg



