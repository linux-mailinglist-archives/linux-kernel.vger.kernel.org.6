Return-Path: <linux-kernel+bounces-209642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39519038CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7088C28514E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C18175548;
	Tue, 11 Jun 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="JDHn4zCx"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022314F9F0;
	Tue, 11 Jun 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101545; cv=none; b=DEVux3wLL3kQOiOYb4X10sESIMU9VRiT8tHIfpxrJmJ7ZTaK6WY0FxUFad6gW2TRj5thbaf/3rqzUUtAOMaP+IXeR7CQaSLhCOJmkxd23PdoraUyzyOkWZa+9tLJSjpqNkNc/UOqn3zIJbn1uxVuuXQovmIA0GW6cHnWAJgow5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101545; c=relaxed/simple;
	bh=qyQC/+nHWKRiwRIjTlFbMH4bzMl2g+3evAo+vGkwdOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MB3bg5BgxCHu/8AIkHn+RSvw+vuwBgecifD+WmHA7bhYDSaRT+710lv/d6niBYe8kbrL+91UmOvoZB5H6Sp/If+g/PL5L2CN/WauF3PFJdIeA4cvVBss4uSkLYiuRNLDEcEOPXsby3Cdz8lg7TKgkeZpbXBW/yWKQUy8KgpodAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=JDHn4zCx; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 703C81CE260;
	Tue, 11 Jun 2024 13:25:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1718101531; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=MEdCQgjM3nOB37rAToIyGZH6oxZZXWG+KBwDS6+xGt4=;
	b=JDHn4zCxz7fjwFmmRTyuplQ6iWIukT2rjvhLsh46T/+wWRBfRLt0wzV93kHjxOhnNZm/tK
	MuoQi0A847lVu3zOVC1kmfhWRLEdVOTnUBTa8WGkScxk4VaLPgCIbOoSgbxhNBSDMvjuWp
	P4pqi7BIfY6K5yUbGcXHsCMcY7unXN3j/s5b6pj7xRR78218KROk0whZizGhjDPziGM5Gl
	EGh9laBchUFBJoob4tyjDsJCVHmDfb627bsWY6Kekkwi9gfs0z7TvjAd002nqPqt/usXzi
	+AG3/h0NrU3INMLUzx8DgbaohLbmJg/VGHo4Mg8LSvNwsH5IvW0bNUraHy0y1g==
Message-ID: <4866f6d4-2e3c-40c7-a8cb-ba4e422ffef6@lexina.in>
Date: Tue, 11 Jun 2024 13:25:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: amlogic:
 amlogic,meson-gx-ao-secure: add secure-monitor property
To: Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20240610084032.3096614-1-adeep@lexina.in>
 <20240610084032.3096614-4-adeep@lexina.in>
 <20240610-dropout-compress-6d6a9b749524@spud>
Content-Language: en-US, ru-RU
From: Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <20240610-dropout-compress-6d6a9b749524@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi!

10/06/2024 19.08, Conor Dooley wrote:
> On Mon, Jun 10, 2024 at 11:39:49AM +0300, Viacheslav Bocharov wrote:
>> Add secure-monitor property to schema for meson-gx-socinfo-sm driver.
> 
> "bindings are for hardware, not drivers". Why purpose does the "secure
> monitor" serve that the secure firmware needs a reference to it?

This driver is an extension to the meson-gx-socinfo driver: it 
supplements information obtained from the register with information from 
the SM_GET_CHIP_ID secure monitor call. Due to the specifics of the 
module loading order, we cannot do away with meson-gx-socinfo, as it is 
used for platform identification in some drivers. Therefore, the 
extended information is formatted as a separate driver, which is loaded 
after the secure-monitor driver.

The ability to obtain additional information depends on the support for 
the call in the secure-monitor, which can be described by an additional 
link from the amlogic,meson-gx-ao-secure node to the secure-monitor 
node, similar to how it is done for amlogic,meson-gxbb-efuse.

> 
> Thanks,
> Conor.
> 
>>
>> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
>> ---
>>   .../bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml      | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
>> index 7dff32f373cb..1128a794ec89 100644
>> --- a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
>> +++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
>> @@ -32,6 +32,10 @@ properties:
>>     reg:
>>       maxItems: 1
>>   
>> +  secure-monitor:
> 
> Missing a vendor prefix.
> 
>> +    description: phandle to the secure-monitor node
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>>     amlogic,has-chip-id:
>>       description: |
>>         A firmware register encodes the SoC type, package and revision
>> -- 
>> 2.45.2
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic

--
with regards,
Viacheslav

