Return-Path: <linux-kernel+bounces-268808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27393942983
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60961F22E76
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429991A8BF8;
	Wed, 31 Jul 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eHF1CUo9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4BF43169;
	Wed, 31 Jul 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415679; cv=none; b=Y+80HfGaalQ9ytAF/+GxJ8bVcK2bYq4XL+Ptn4C7K4Td1tOvwClpwfzgP8emN38xfXrieVvGgVAtEFEp4capJGi+MV/CYUzLKJ7zVmHggrKwxNWyKZeN/J5qjpiML2VzbCvg2VixXGYR4XOg2LyDVh4UCakL0TINViGk5J1lIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415679; c=relaxed/simple;
	bh=J1sOSME0u6roc/a+qPwtB9E24QMzJiJjbIjiPdJuLEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwjKFY3Eruz0F9+bKZl3ypEDUovMmiIajePjF+SPTGTpggr/z/oqXNefmvT4qu0gVmIofdz3zkgbotpiv/b8R5FBUKRm/0ZZxuGrMjdjjGoO/JfT09TyXHgB78CqjOkALkXwpSkFcb6CCn4bhotadV9rclQtZSSK7Q1iQFzfegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eHF1CUo9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722415676;
	bh=J1sOSME0u6roc/a+qPwtB9E24QMzJiJjbIjiPdJuLEI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eHF1CUo9Tpz2SIqoHSYcs7456H81OBUsVZLx6BNkBU5BriLDzbv62GM84XOQ1dzGl
	 Y30xAP/z+AyVTY4DWsdsWAIGJy9OlnfBQU2O303CXN3N4GynXCTPoaeuwTjGRF4i9T
	 kZ/LgLmap5rPeNHh6WESYaaAKkEzujwmVF22odyF7324oQ30NS4XpXGkVkIGAFv5eM
	 5uJvvujNubK9V/svOMfHnt3ZAfkLba3xI3kuihe+4f1Cq5hgQqSDqcGRfyThYtUgtC
	 bmCnmoj29+HsxDRfZ+hnYk3Mx8yAQLMP/zGV6WqYt7W4AEk/BH/llZw3hxI/wypzNL
	 r+Jr1JNEIiDrg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6E9F8378000B;
	Wed, 31 Jul 2024 08:47:55 +0000 (UTC)
Message-ID: <909d4058-e3e9-4b59-b476-8f78e668c73b@collabora.com>
Date: Wed, 31 Jul 2024 10:47:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: arm64: mediatek: Add
 kukui-jacuzzi-cerise board
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240731-jacuzzi_dt-v2-0-4995335daa30@chromium.org>
 <20240731-jacuzzi_dt-v2-2-4995335daa30@chromium.org>
 <bb696e60-642f-43f1-9ccf-972e1d839bcd@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <bb696e60-642f-43f1-9ccf-972e1d839bcd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 31/07/24 10:16, Krzysztof Kozlowski ha scritto:
> On 31/07/2024 08:26, Hsin-Te Yuan wrote:
>> Cerise is known as ASUS Chromebook CZ1.
>> Stern is known as ASUS Chromebook Flip CZ1.
>>
>> They are almost identical. The only difference is that Cerise is a
>> clamshell device without touchscreen and Stern is a convertible device.
>>
>> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
>> ---
>>   Documentation/devicetree/bindings/arm/mediatek.yaml | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
>> index 1d4bb50fcd8d..087773a43673 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
>> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
>> @@ -146,6 +146,20 @@ properties:
>>           items:
>>             - const: google,burnet
>>             - const: mediatek,mt8183
>> +      - description: Google Cerise (ASUS Chromebook CZ1)
>> +        items:
>> +          - enum:
>> +              - google,cerise-sku0
>> +              - google,cerise-rev3-sku0
>> +          - const: google,cerise
>> +          - const: mediatek,mt8183
>> +      - description: Google Stern (ASUS Chromebook Flip CZ1)
>> +        items:
>> +          - enum:
>> +              - google,cerise-sku1
>> +              - google,cerise-rev3-sku1
>> +          - const: google,cerise
> 
> Why not google,stern? If this is not compatible with cerise and has
> different name, I think logical would be to have different compatible -
> either here or the first one.
> 

They're both compatible, but the commercial names are different because one
is convertible, one is not... and the bootloader still checks for cerise
even on stern - that's how I read it, and it's not the first time...

...but it doesn't hurt to have a "google,stern" compatible added to the mix,
it's just one more const to add... and I don't have any strong opinion about
that, so, Hsin-Te, it's your call. :-)

Cheers,
Angelo



