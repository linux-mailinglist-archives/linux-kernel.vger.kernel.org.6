Return-Path: <linux-kernel+bounces-315691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365E96C5D8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9860B1C2166F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BD71E1A10;
	Wed,  4 Sep 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E56LaBJK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FC2AE9F;
	Wed,  4 Sep 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472614; cv=none; b=KUYDybrmZxKaTNb0cbnG54vPXrQn42XMafRFYG/cREQ8rPuiG2hixqR2kdo8g7Ff31OeJANBX+cdrAQRwEvO7d+xgPwvLAsmumtWfr17bBp80Sosg3yr1WEP5+VNS0bf1oukOBY7u+QKOvT4S9PdtV8O69NY5fOoDNdLH2TiM2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472614; c=relaxed/simple;
	bh=3taLaDCjwJRUiST6nA8KwVrhsHRZgLTs/hmh3jh6m/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PAhUFTyuVi2aMj7ungg1MdMl0dAEaLqJ/hNqI8y4mVlBeXqCSL6mJWQoapyT682y3bEp34WnX7WaYdRHEle6R1bImJDEhAd/UeC2czLPjzWXz/ILy3HnbAYaGJb8GtyRI2N4N/w+5zsScogWHd2CiJ9rqwzK2vEZ9F0wp6Shz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E56LaBJK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725472612; x=1757008612;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3taLaDCjwJRUiST6nA8KwVrhsHRZgLTs/hmh3jh6m/A=;
  b=E56LaBJK9QSfxwmnfGWZnZALF+UKqRdmuNBNK3khldiV5sSZeqYBdunq
   f59xLHqZ8YfUhTQH5gTVKK00v4bRKpkIGUCYGa6FJQ6KhLnMZYOBS/K64
   jhNciSWIKyyX9MhzTBrfi7dUvmJiy7a46bauTNJ6x/ZQ4npVRj/kQpF9s
   smLKf0GEMwUhXdpVSNbJNUMOHPjs0jofYN5ua0819bOvkmo+yQXnQvPol
   c4EN4Gs2C8fzpLNedbfSJIxsGVOjo2Qc4CDwSBakzwXr4MWulEVRYdhVi
   0EnnOxoDl0zQ00Z3ZHa0CImERyBSMTRWHjtNZMNHptFV4bNfz2TZGoTIr
   w==;
X-CSE-ConnectionGUID: 0Dz1qTvLQAeqyLYm0j51bw==
X-CSE-MsgGUID: Ru7ZR7O0S3K2YS/1bB4DFA==
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="262270139"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 10:56:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Sep 2024 10:56:33 -0700
Received: from [10.180.116.161] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 4 Sep 2024 10:56:31 -0700
Message-ID: <ec34efc2-2051-4b8a-b5d8-6e2fd5e08c28@microchip.com>
Date: Wed, 4 Sep 2024 19:56:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: get, prepare, enable a clock not in DT?
Content-Language: en-US, fr-FR
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
 <384919bc-7d45-445a-bc85-630c599d43ef@tuxon.dev>
 <20240820-grandpa-down-fec4231f971c@thorsis.com>
 <e7f69aa3-20a7-4233-96c7-0fa5fe67bbdc@tuxon.dev>
 <20240828-gainfully-cringing-2f420d8882bd@thorsis.com>
 <6cd18742-7ba8-4b0c-aff9-7065bccd4095@tuxon.dev>
 <20240902-machinist-straggler-cce44ffa4a7c@thorsis.com>
 <6bc72d8a-c7b8-40de-b4c2-0170dde36d33@tuxon.dev>
 <e1371121-8f06-4c36-a950-063ae716b47e@microchip.com>
 <20240904-grandkid-algorithm-4e9a73971e96@thorsis.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240904-grandkid-algorithm-4e9a73971e96@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2024 at 16:43, Alexander Dahl wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hello Claudiu, Nicolas,
> 
> Am Wed, Sep 04, 2024 at 03:26:45PM +0200 schrieb Nicolas Ferre:
>> On 04/09/2024 at 09:33, claudiu beznea wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> Hi, Alexander,
>>>
>>> On 02.09.2024 11:24, Alexander Dahl wrote:
>>>> Hello Claudiu,
>>>>
>>>> Am Sat, Aug 31, 2024 at 06:49:59PM +0300 schrieb claudiu beznea:
>>>>> Hi, Alexander,
>>>>>
>>>>> On 28.08.2024 09:55, Alexander Dahl wrote:
>>>>>> Hello Claudiu,
>>>>>>
>>>>>> Am Fri, Aug 23, 2024 at 05:29:44PM +0300 schrieb claudiu beznea:
>>>>>>>
>>>>>>>
>>>>>>> On 20.08.2024 15:17, Alexander Dahl wrote:
>>>>>>>> By chance: I don't have a sama7g5 based board at hand for testing.
>>>>>>>> The datasheet says the same as for sam9x60.
>>>>>>>> Does the nvmem_microchip_otpc driver actually work without timeout on
>>>>>>>> sama7g5?
>>>>>>>
>>>>>>> Yes! This should be because system bus is clocked from MCK0 (as mentioned
>>>>>>> in peripheral identifiers table) which is enabled by bootloader.
>>>>>>
>>>>>> Not sure I can follow.  Citing the SAMA7G5 datasheet section 30.4
>>>>>> (OTPC Product Dependencies):
>>>>>>
>>>>>>       "The OTPC is clocked through the Power Management Controller
>>>>>>       (PMC). The user must power on the main RC oscillator and enable
>>>>>>       the peripheral clock of the OTPC prior to reading or writing the
>>>>>>       OTP memory."
>>>>>
>>>>> I don't see this in [1]. Only:
>>>>>
>>>>> "The OTPC is clocked through the Power Management Controller (PMC), so the
>>>>> programmer must first to configure the PMC."
>>>>>
>>>>>   From this I got that it is about the MCK0 listed in table Table 8-11.
>>>>> Peripheral Identifiers.
>>>>>
>>>>> [1]
>>>>> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765A.pdf
>>>>
>>>> Well, this seems to be an older version revision A from 03/2022.
>>>> I have DS60001765B (revision B) from 12/2023 and got this here (note
>>>> the missing 'A' in the filename):
>>>>
>>>> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765.pdf
>>>
>>> This version clearly express your findings. The unknown now is the
>>> "peripheral clock" that need to be enabled along with the
>>> main_rc_oscillator. For that you may want to play around with PMC
>>> Peripheral Control Register, PMC peripheral clock status register and see
>>> if OTPC fails to work when disabling the peripheral clock with the OTPC ID
>>> as there is no information about peripheral clock for OTPC in the
>>> peripheral identifers table.
> 
> The SAM9X60 seems to be different here, than the SAMA7G5.
> 
> (I only have SAM9X60 here, I can not test on SAMA7G5.)
> 
> To make it work I did not enable or disable a certain PMC peripheral
> clocks on SAM9X60.  The peripheral ID for OTPC is 46 on SAM9X60, and
> in the Peripheral Identifiers table there's no checkmark under "PMC
> Clock Control".  The ID is also not part of the sam9x60 clock drivers.
> This tells me SAM9X60 does not need a PMC peripheral clock enabled for
> the OTPC to work and my experiments confirm this.  Enabling the main
> RC oscillator was sufficient.

The feedback that I have from our internal teams is that for all the 
products, the main RC oscillator, the OTPC peripheral clock and the MCKx 
clocks associated to OTP must be enabled.

I cannot tell why you don't experience this on your board. But probably 
reading from OTP and writing/updating/locking... operations could be 
fairly different in terms of clock requirements and (internal to OTPC + 
its associated memory) synchronisation between clock domains: so my 
advice is that, even though you can "use/read" OTP on sam9x60 without 
the other clocks, it's probably a bit fragile.

As a summary, in addition to RC oscillator, the peripheral identifier 
for OTP should be:
         SAM9X60 : 46
         SAM9X70 : 46
         SAMA7G54 : 67
         SAMA7D65 : 63
     and the associated MCK :
         SAM9X60 : MCK (needs a documentation update)
         SAM9X70 : MCK
         SAMA7G54 : MCK0
         SAMA7D65 : MCK0

Basically the datasheet for sam9x60 hasn't been updated too recently and 
the same sentence as the one you noticed hereunder, on latest versions 
of sama7g5/sam9x7 datasheet, applies as well: "The user must power on 
the main RC oscillator and enable the peripheral clock of the OTPC prior 
to reading or writing the OTP memory".
Note that internal documentation update request is entered in our system 
thanks to your feedback.

>>> Hope this helps.
>>
>> FYI, I asked internally. I'll keep you posted.
> 
> Thanks Nicolas, I appreciate this.

Thanks to you and Claudiu for digging into this.

Best regards,
   Nicolas

>>>> Linked here:
>>>>
>>>> https://www.microchip.com/en-us/product/sama7g54
>>>>
>>>> The revision history is not very specific, it only says "Updated Power
>>>> Management".  Errata sheet has nothing interesting on that topic.
>>>>
>>>> We both cited what we saw in the datasheets.  Revision A has the
>>>> section you cited, revision B has the section I cited.
>>>>
>>>>>> Table from section 8.5 (Peripheral Clocks …) has no check mark at "PMC
>>>>>> clock control" but indeed lists MCK0 as main system bus clock.
>>>>>
>>>>> This is what I was taking about.
>>>>>
>>>>>>    If it
>>>>>> works on SAMA7G5 without explicitly enabling main RC oscillator, then
>>>>>> either that clock is on accidentally, or the datasheet is wrong in the
>>>>>> OTPC section.
>>>>>
>>>>> Might be.
>>>>
>>>> I don't have a SAMA7G5 at hand.  Someone who has could test if OTPC
>>>> works with/without MCK0, and with/without main RC osc, all possible
>>>> combinations would be most helpful: with none of those, with only one,
>>>> only the other, both.
>>>>
>>>> Hope we get this clock stuff sorted out?!
>>>>
>>>> Greets
>>>> Alex
>>>>
>>>>>
>>>>> Thank you,
>>>>> Claudiu Beznea
>>>>>
>>>>>>
>>>>>> Personally I find the "clocked through PMC" part in the OTPC
>>>>>> section suspicious, because in the peripheral identifiers table OTPC
>>>>>> has no "PMC Clock Control" mark.
>>>>>>
>>>>>> Not sure what's the difference between SAM9X60 and SAMA7G5 internally,
>>>>>> though.  From a user's POV it's possible one of them requires the
>>>>>> main RC osc, and the other does not, but currently you can't tell from
>>>>>> the datasheets.
>>>>>>
>>>>>>> Here is a snapshot of reading the NVMEM on a SAMA7G5 with bootconfig and
>>>>>>> thermal calibration packets:
>>>>>>> https://www.linux4sam.org/bin/view/Linux4SAM/ThermalFaq
>>>>>>
>>>>>> Greets
>>>>>> Alex
>>>>>>
>>>>>
>>
>>


