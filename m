Return-Path: <linux-kernel+bounces-521532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DC7A3BE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D384C7A4D81
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482151E25ED;
	Wed, 19 Feb 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HCLC3kZR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CF1E1C1F;
	Wed, 19 Feb 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969356; cv=none; b=r9fqdg88AkPbyyimUpAD8SHv3Eo2MLteAHHHuFu431UmhjjjqRPGbWQgNGjednZoHWe7zrJNoKqid+vtxvfxaCbjB67TblchYMriBveSsxMOCIFQXwlpuFYfaMnCu9AQXw5v+DfOOMliiHla7riFxV7eFxA5Vql8mKoFUjZadRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969356; c=relaxed/simple;
	bh=ZRkBJqfwNxsy4NNpzr6JGnP5yZqlVEWFWw7cYvuNgiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b03rQAQGk9R661jRuTLf3UX1AK0HVhbe5rzJ2Ml1MhtnBmudpYbKb9L2N8fPxiYKYMtJJgsqUKhRxM+ZaAdVwgQgFdvHrMQGPLlN8LOWqXbSsdnhA5QU/o7lsM42LRbCqjDaseJtcse+a8WsuAZfZ29RZsmpD8BBOiFBnhFll/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HCLC3kZR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739969352;
	bh=ZRkBJqfwNxsy4NNpzr6JGnP5yZqlVEWFWw7cYvuNgiw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HCLC3kZRyknIKRy4X4tvHCuM73kSn2JvXMr5HWCdfodgZMf5ZskztPuQhJnC/o/8l
	 8y/TqOf0WiTDwN6dkwSyoNzE85TdLcn9ThMii2ol/CbLK7BdU21egioKu4yGj5UPh/
	 H7y9bde6V2EDGDIAzCR3gyPCmSYGugYImPZN1knxFb0kYTS+qZkn26zRL9fUOW+dya
	 7BhQwkYfgc4LRStI1jzfKwHfJhC122UFk5Pcz9B/JVTPHX2bGJwm+jGGKvaWpMJQOA
	 viyqoQgJYNoH6mjFR1KuMOdlyJpB0P/S4AC4tLrpcNYEpWsG5M/zG84j9DgfZZkZG7
	 ZA4sEm145csZg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BD53817E14D5;
	Wed, 19 Feb 2025 13:49:11 +0100 (CET)
Message-ID: <ce224b2e-a3c2-4543-9926-c524944ef1b6@collabora.com>
Date: Wed, 19 Feb 2025 13:49:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] dt-bindings: display: mediatek: tdshp: Add support
 for MT8196
To: Krzysztof Kozlowski <krzk@kernel.org>, Jay Liu <jay.liu@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250219092040.11227-1-jay.liu@mediatek.com>
 <20250219092040.11227-8-jay.liu@mediatek.com>
 <4d8abd3f-c39b-49ea-8a43-b6ad0cf6fb15@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <4d8abd3f-c39b-49ea-8a43-b6ad0cf6fb15@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 19/02/25 10:25, Krzysztof Kozlowski ha scritto:
> On 19/02/2025 10:20, Jay Liu wrote:
>> Add a compatible string for MediaTek MT8196 SoC
> 
> No, this is just bogus commit msg.
> 
> You did not try enough, just pasted same useless and incorrect message
> to every patch.
> 
>>
>> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
>> ---
>>   .../display/mediatek/mediatek,tdshp.yaml      | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,tdshp.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,tdshp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,tdshp.yaml
>> new file mode 100644
>> index 000000000000..5ed7bdd53d0e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,tdshp.yaml
> 
> Filename matching exactly compatible.
> 
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,tdshp.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek display clarity correction


Adding more comments to Krzysztof's review....

What does "TDSHP" stand for? "Display Clarity Correction" rolls up as "DCC" which
is not "TDSHP".

Please clarify the title by unrolling "TDSHP"

title: MediaTek T.. Display... S... H... P

>> +
>> +maintainers:
>> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
>> +  - Philipp Zabel <p.zabel@pengutronix.de>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +  MediaTek display clarity correction, namely TDSHP, provides a

Again, TDSHP does not stand for "display clarity correction" - that's what it is
for, and it is ok to say what it is for, but say what TDSHP stands for.

MediaTek T... Display Sharpness? (TDSHP) provides means to adjust
the image sharpness displayed on a physical screen, therefore this
IP is meant to perform display clarity correction.

...rest of the blurb, etc.

>> +  operation used to adjust sharpness in display system.
>> +  TDSHP device node must be siblings to the central MMSYS_CONFIG node.
>> +  For a description of the MMSYS_CONFIG binding, see
>> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> +  for details.
> 
> Missing blank line. Do not introduce own style.
> 
>> +properties:
>> +  compatible:
>> +    oneOf:
> 
> Drop, unless this is already going to grow?
> 
> 

krzk: oh, it is, guaranteed!! but ... not exactly right now (not very soon),
so dropping the oneOf is a sane recommendation, I agree.


Cheers,
Angelo

>> +      - enum:
>> +          - mediatek,mt8196-disp-tdshp
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +
> 
> Drop
> 
> 
> Best regards,
> Krzysztof




