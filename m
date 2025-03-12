Return-Path: <linux-kernel+bounces-557398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95594A5D864
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8B81750F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDD52356DF;
	Wed, 12 Mar 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ7+TiBO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881EE236420;
	Wed, 12 Mar 2025 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768809; cv=none; b=ADLtbJIbyZL8FwjEMDyqxSI+aHVrO+mFgXzt4Uk+thvaWq4zGwwMVcgTDlUDysPZdxXO4ZQMOPf86oqhLBUAaAUeQRyqurDqibnar6vJXdQcDTDL/7sgzzM/4r2mKGAp8ryoeTBr4sGMQ8KyptjIuBLXruyv5+n609g4cqFWHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768809; c=relaxed/simple;
	bh=vjrLKZqFmOgUUOhvEPy7JGLdtin8amu+im5/QhAzgfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orMWZftNCfXJq76h1TvIIjyYW1YZIGOyglMIs3fOT2hszuBgTYXOQBgmmsFSyffUR63lJ5ccyrnMUkRVxhKtqE3TE1Zw72APiIg1DUVMv0pIEnOqPvtjP6uAXrw10E5YaKYqXfdLBrisJ0jhOI/h8upOOxC1ZnA8u3cPHT/scnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ7+TiBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35223C4CEE3;
	Wed, 12 Mar 2025 08:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741768809;
	bh=vjrLKZqFmOgUUOhvEPy7JGLdtin8amu+im5/QhAzgfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gJ7+TiBOx9kiYATQSgNGpGTP0hsf97orKtjs2QJBgTWOcu1Oz5Pbx8T5uyVI0sXss
	 5xiDdsRHRmoc0wTBPPaADb/HYxsUUCn4eEyo2yXAumcxRa2+YyXE64gBc5GKlMrUay
	 DG1+S7wtGj8LV7AZB54np1yJfp1h/1UVlIgyGxK6vlCylZHT8y7h0Fe9u5TGSEABWq
	 XOhjJOTgaCmZYbNXEd5lRxeFzHSAUcF37hwlYEoLXQurHSYsc3K7vDDEQot0OV+iTN
	 PcqWQmA7LG2QcSo7ckUrZHuVGGCefuXNsHW6vxe7tPO7ij5wuqeE7KH2KmFMuGZMcB
	 QFWo3udgv7vrQ==
Message-ID: <faad00bf-0274-41b2-91dd-6b2d2dd59b2f@kernel.org>
Date: Wed, 12 Mar 2025 09:39:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC and
 EQ support
To: Rob Herring <robh@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 patches@opensource.cirrus.com,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
References: <20250307135244.100443-1-francesco@dolcini.it>
 <20250307135244.100443-4-francesco@dolcini.it>
 <20250311-solid-poetic-camel-77a29b@krzk-bin>
 <20250311175931.GA3885406-robh@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250311175931.GA3885406-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2025 18:59, Rob Herring wrote:
> On Tue, Mar 11, 2025 at 09:42:45AM +0100, Krzysztof Kozlowski wrote:
>> On Fri, Mar 07, 2025 at 02:52:42PM +0100, Francesco Dolcini wrote:
>>> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>>>
>>> Add two properties to select the IN1L/DMICDAT1 and IN2R/DMICDAT2
>>> functionality:
>>> - wlf,in1l-as-dmicdat1
>>> - wlf,in1r-as-dmicdat2
>>>
>>> Add a property to describe the GPIO configuration registers, that can be
>>> used to set the four multifunction pins:
>>> - wlf,gpio-cfg
>>>
>>> Add a property to describe the mic bias control registers:
>>> - wlf,mic-cfg
>>>
>>> Add two properties to describe the Dynamic Range Controller (DRC),
>>> allowing multiple named configurations where each config sets the 4 DRC
>>> registers (R40-R43):
>>> - wlf,drc-cfg-regs
>>> - wlf,drc-cfg-names
>>>
>>> Add three properties to describe the equalizer (ReTune Mobile), allowing
>>> multiple named configurations (associated with a samplerate) that set
>>> the 24 (R134-R157) EQ registers:
>>> - wlf,retune-mobile-cfg-regs
>>> - wlf,retune-mobile-cfg-hz
>>> - wlf,retune-mobile-cfg-rates
> 
> 
>>> +             * Config registers per name, respectively:
>>> +             * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
>>> +             * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
>>> +             * KNEE_IP = -42, KNEE_OP = -3,    HI_COMP = 0,   LO_COMP = 1
>>> +             * KNEE_IP = -45, KNEE_OP = -9,    HI_COMP = 1/8, LO_COMP = 1
>>> +             * KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1
>>> +             */
>>> +            wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
>>
>> <number>, <number>, <number> ...
>>
>> unless you wanted 64-bit?
> 
> Why? You would need "/bits/ 16 <number>, /bits/ 16 <number>, ..."
Uh, right.

Best regards,
Krzysztof

