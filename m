Return-Path: <linux-kernel+bounces-379261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 158C69ADC22
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D781B22E94
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B73E189909;
	Thu, 24 Oct 2024 06:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exqWy8rF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236D185920;
	Thu, 24 Oct 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751087; cv=none; b=oStPltLUDbowx1AykuscAZ4mBvSWXDrg6uby7rRZZqHWD9L9xz4gUMS5IJv/p7RjQySNNQ2fQoZXfeW+OVtv3IZgsoq0rNoPVYNZRpVQFm2BYXkNDEVwF5Q7BQkHnNWmQ40vrftX8VB7Q6L7kS3pusqcwVmhfG9woapGfWWESLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751087; c=relaxed/simple;
	bh=2XvsYj0Ms6fqASHAm+m8OowANeoy1TenFBRkwyIDeLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0sy9sNCsgf0sQiYZ9kv6DN4ObZnP53O4RdRFH/foFfxgYwbgLpMjbQlONUjxzsBE8inxGNzTkDv8scD7xmiaR2GNWRuIu+gvVR6snV2B0gU7xePivSb0SqpOmy2KKd/nk1yFrJbi1087DCdk+KK7yzDxBx4ItwpmBrHzcvkwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exqWy8rF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FEBC4CECC;
	Thu, 24 Oct 2024 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729751087;
	bh=2XvsYj0Ms6fqASHAm+m8OowANeoy1TenFBRkwyIDeLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=exqWy8rFlj3HtQVJeCOlXbRWHcPHJ08imMNc9l+6ZGpxm0+YdudDblY8xLZ+EamSp
	 Uv6YWL0rRJTkQCh7r1kb7O0gyjJNAvtiRHq6oEe1k2GwG86RrR2MXSmvx1cpi2FfXJ
	 zB5cMd7IJxSMTlYcDkuDIvFPz8Z50Zlbi9NXQ8DxrHLpplF7Cy6yrysZiK3hqZ0F1V
	 wMNj8VNBOwDRDoEwS2ZgzwWzzUBy425iCIfpW3IiuyasG8LXIOlljlGRAXRtaWyWjm
	 PDzSaK/Esbovs9caoeLantXAmCtW/M6e5hOAcGbLXM2dm7dNJXH7RG46d04dkasKr+
	 rsiMG9bUe6+3Q==
Message-ID: <cdc7032b-4d09-40dc-86a7-16d244517d11@kernel.org>
Date: Thu, 24 Oct 2024 08:24:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 12/23] ARM: socfpga: dts: add a10 clock binding yaml
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
 <20241020194028.2272371-13-l.rubusch@gmail.com>
 <v4gqnsyhqjccdac3kgmo7y2aunigqquqc3f7n7wgt5hiv3rnip@jfmoq3is4rjh>
 <CAFXKEHZOPioES4guqjco+BE7i=Eqe2DdHiUxAksBCZm7nx1Rog@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAFXKEHZOPioES4guqjco+BE7i=Eqe2DdHiUxAksBCZm7nx1Rog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/10/2024 08:10, Lothar Rubusch wrote:
> On Mon, Oct 21, 2024 at 9:05 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Sun, Oct 20, 2024 at 07:40:17PM +0000, Lothar Rubusch wrote:
>>> Convert content of the altera socfpga.txt to match clock bindings for
>>> the Arria10 SoC devicetrees. Currently all altr,* bindings appear as
>>> error at dtbs_check, since these bindings are only written in .txt
>>> format.
>>>
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
>> your patch is touching. For bindings, the preferred subjects are
>> explained here:
>> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>>
>>> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>>> ---
>>>  .../bindings/clock/altr,socfpga-a10.yaml      | 107 ++++++++++++++++++
>>>  1 file changed, 107 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
>>> new file mode 100644
>>> index 000000000..795826f53
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
>>> @@ -0,0 +1,107 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/altr,socfpga-a10.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Device Tree Clock bindings for Altera's SoCFPGA platform
>>
>> This wasn't tested or you have some very, very old dtschema.
>>
>>
>>> +
>>> +maintainers:
>>> +  - TODO
>>
>> We should not be taking unmaintained stuff.
>>
> 
> This is just a trigger here. Basically, I have no probelm in placing
> my own name here. AFAIR Mr. Dinh Nguyen has his name on the other
> intel/altera related files, so I'm not sure who decides that. Please
> let me know.
> 
> Basically this particular patch is related to my initial questions
> (cover letter):
> 1.) Documentation/devicetree/bindings:
> Executing the following find...
> $ find ./Documentation/devicetree/bindings -name socfpga-\*.txt
> ...shows 4 text files describing "altr," bindings. I sketch-implemented
> the clock binding and could reduce some of my dtbs_check warnings. So, my
> questions is, if this is the right way? Shall I try to write .yaml files
> for all 4 of them, too? Related to that, who will be maintainer?

Whoever is interested in that hardware. Platform maintainer, device
maintainer.

> 
> 2.) Some bindings, e.g. the Silabs clock generator seem to have no
> driver, thus show up as warning:
>     compatible = "silabs,si5338";
> IMHO it is most likely rather to be probed/loaded in the SPL of the
> bootloader. Is it problematic to keep those declarations (showing up as
> warning in dtbs_check) or how to deal with them?

Sorry, I don't get the problem.

> 
> 3.) Please, give me some feedback if the DT and binding adjustments are
> going into total wrong direction, or where I may do better. If it is ok,
> and acceptable, or what is still missing. I tried to split them, to
> allow for better single integration / discussion let me know if this is
> ok, too.

I still don't understand. Nothing here is different than with every
other platform.

> 
> 
>>> +
>>> +description:
>>> +  This binding uses the common clock binding[1].
>>> +
>>> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>
>> Drop description or describe the hardware.
> 
> Ok (the description was taken as content from the corresponding .txt file)

What corresponding txt file? You are adding new binding. Are you saying
you duplicated bindings instead of doing conversion?

git log -p -- Documentation/devicetree | grep -i convert



Best regards,
Krzysztof


