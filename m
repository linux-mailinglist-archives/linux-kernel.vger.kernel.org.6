Return-Path: <linux-kernel+bounces-326146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C231F9763BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C93AB22CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB818F2DD;
	Thu, 12 Sep 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NtQWR1QJ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="c3lH6ZI8"
Received: from a7-49.smtp-out.eu-west-1.amazonses.com (a7-49.smtp-out.eu-west-1.amazonses.com [54.240.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676F11712;
	Thu, 12 Sep 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127965; cv=none; b=Q+86z4C2eTWDzcfj+NQ1nuaXriANv2YYiQ7ykJ/JZp5XSbxbPsO7h5exg/DK2Rpk0Clxd9Z+B/YwQvWpwik8Jbk1sddE2d1mS9R4dzsoXR0Bxvh54E5EZ0MB8/hoFjmd7XeRx5HrnvgMTKdCMwTxA2e2z+vu9lHSkW2hUvWRdAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127965; c=relaxed/simple;
	bh=cldL7U+54qSN12pAQeSnPmmhceVDu+NalVaDHIDluX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4lQ1mXQi+HEnw41fC4ciQub15ASc+H2syCJODX7GtQjQpOZr1fbw9LZthj5Yq/BZm470+VB+eQVMpW8ykIgdVSVj0xYh6zqj6Z8i8/Pr1HhucOhU1szEXS57SZ06BRDQpgra+tUuUm4OjpX/k4Ox2Z+HC5sNR0ZMic0hUmh3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NtQWR1QJ; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=c3lH6ZI8; arc=none smtp.client-ip=54.240.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726127961;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cldL7U+54qSN12pAQeSnPmmhceVDu+NalVaDHIDluX0=;
	b=NtQWR1QJPkxoJQdRf/qJU1KmHdFte6fnqP/Br8NrTPqmIobSI96U3KORXePFfeBW
	8Qjg0OpjTYHEOczbvUeA3AWAlja00Mmxcdy9v/Gf+sp2cmNIjgxPv2D4NCLV7/ca4Dw
	NeFgee4lZazq4OQW53Ug3Eg6LZwmhELVAI563IpHalXGZJgJVew0Rex0x5Q6swN6Oe0
	LnGUhrb0r3ZWsr3IGxBE+NwSNY0p24n4Qu0E0rgbJfOCHYy4mpyRzJV4r0EgfSlGGO8
	EaZIk5wOKQk4kajYE/kKKan3wAl4rMiBkHllhm44y0RumUElatUnY71WOy8cW8TxWGg
	WtuURPawQA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726127961;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=cldL7U+54qSN12pAQeSnPmmhceVDu+NalVaDHIDluX0=;
	b=c3lH6ZI8LwowGvCxpLVTIMn1EB+gq+KJXUJ4peySHipaj8FHkKBlLr+5a+AYDhzW
	dzLL8sxo21e9kb1bJsZyRwn7mYtQTuN/Se55g0fh0emWEG6BAIs+Mch8yP7qPmML1lq
	z7qafrMtxlOBBSVlS/gx83XFBYMukITGF7Vm/tGE=
Message-ID: <01020191e53e7670-d04af181-0137-4f35-962e-2f1119d026df-000000@eu-west-1.amazonses.com>
Date: Thu, 12 Sep 2024 07:59:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mailbox: mediatek,gce-mailbox: Stop
 requiring clock-names
To: Conor Dooley <conor@kernel.org>
Cc: krzk+dt@kernel.org, jassisinghbrar@gmail.com, robh@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, 
	houlong.wei@mediatek.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com, 
	fshao@chromium.org
References: <20240911104327.123602-1-angelogioacchino.delregno@collabora.com>
 <20240911-unhappy-wifi-b0a851e261bb@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911-unhappy-wifi-b0a851e261bb@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.12-54.240.7.49

Il 11/09/24 19:51, Conor Dooley ha scritto:
> On Wed, Sep 11, 2024 at 12:43:27PM +0200, AngeloGioacchino Del Regno wrote:
>> There is no reason to make specifying the clock-names property
>> mandatory, as the Global Command Engine HW needs only one clock.
> 
> Have you checked to make sure that there are no users that do the lookup
> by name?
> 

It's just that I didn't want to mention any "driver" word in the commit description
for a binding ;-)

(Of course I did, and the driver is not doing any by_name lookup)

Cheers,
Angelo

>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/mailbox/mediatek,gce-mailbox.yaml        | 11 -----------
>>   1 file changed, 11 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
>> index cef9d7601398..ff5d010fbcf0 100644
>> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
>> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
>> @@ -56,17 +56,6 @@ required:
>>     - interrupts
>>     - clocks
>>   
>> -allOf:
>> -  - if:
>> -      not:
>> -        properties:
>> -          compatible:
>> -            contains:
>> -              const: mediatek,mt8195-gce
>> -    then:
>> -      required:
>> -        - clock-names
>> -
>>   additionalProperties: false
>>   
>>   examples:
>> -- 
>> 2.46.0
>>



