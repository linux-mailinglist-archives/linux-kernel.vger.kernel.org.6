Return-Path: <linux-kernel+bounces-514943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A2A35DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC27188F3D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC0263F5A;
	Fri, 14 Feb 2025 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K/LZvksN"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC15A261567
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536929; cv=none; b=McXn62HjwwBO5J7rGtVatr/ZmGyG9WkM3Gg8Tux+tOMJfk76gGofNyB01ZFV/E9IqGCmlATw0kBwK8a8F8liiLGhgEivW5tgEcZaiKy2fI8hIjP2YzUmCanUSiw+a74jJLyXDV+m4LnG5NO9imzFAjY4ieloTDkfQeZt3DWtiKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536929; c=relaxed/simple;
	bh=Lgm54ypC3Xw13cFe84CkEda526EsxKI+I0wTtJzS2kM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A8lWUkwxCBm8r22Z8HCo8vFgzYCjFflT/GHOkyo0bLdtUPvKddLNdyxQKUnYpGIU0txVED7qI8lLBii3333JxKp7qK4CdZtXca5iQzx/RoyQJug6ocD1QwEnKBkNWYarLyYazPpgtdp900S7W2VjgymDIyEYrBpPkh/23vrBRxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K/LZvksN; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <062b78a3-7e83-4202-a753-4e7bd43e8bc2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739536924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmoaaQDA6QHoK5d//GwIdE1FQgIBFCuZsGqbpAtEteg=;
	b=K/LZvksNFFiUrhXDWrfGZ6wnfWWXw1lTTN6Ee4nsCPd47TEooPFEB3jleQYXkJe3DkUEH+
	hIJBUBj1e2ldbdCtsVKKPiX6JM4590naTHtJOwl/SBtSczRghhj7ZnuZNQQFmoM6aQK5Uk
	XY2kEp7H56jZXDsvyiBJNp6y3CZylY4=
Date: Fri, 14 Feb 2025 18:11:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Subject: Re: [PATCH v5 2/3] dt-bindings: display: ti: Add schema for AM625
 OLDI Transmitter
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simona Vetter <simona@ffwll.ch>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 DRI Development List <dri-devel@lists.freedesktop.org>,
 Devicetree List <devicetree@vger.kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>
References: <20250209160925.380348-1-aradhya.bhatia@linux.dev>
 <20250209160925.380348-3-aradhya.bhatia@linux.dev>
 <16db8f3d-04a2-408a-964f-4cf9478229b4@ideasonboard.com>
 <8c6e790e-f1b6-46ab-9acf-bdea8076405b@linux.dev>
 <cd62bf21-adad-4422-8fac-ebd20e8b39a5@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <cd62bf21-adad-4422-8fac-ebd20e8b39a5@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Tomi,


On 13/02/25 18:50, Tomi Valkeinen wrote:
> Hi,
> 
> On 13/02/2025 14:33, Aradhya Bhatia wrote:
> 
>>>> +  ti,companion-oldi:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description:
>>>> +      phandle to companion OLDI transmitter. This property is
>>>> mandatory for the
>>>> +      primarty OLDI TX if the OLDI TXes are expected to work either
>>>> in dual-lvds
>>>> +      mode or in clone mode. This property should point to the
>>>> secondary OLDI
>>>> +      TX.
>>>> +
>>>> +  ti,secondary-oldi:
>>>> +    type: boolean
>>>> +    description:
>>>> +      Boolean property to mark the OLDI transmitter as the secondary
>>>> one, when the
>>>> +      OLDI hardware is expected to run as a companion HW, in cases of
>>>> dual-lvds
>>>> +      mode or clone mode. The primary OLDI hardware is responsible
>>>> for all the
>>>> +      hardware configuration.
>>>
>>> I think these work, but I'm wondering if we would ever need to check
>>> something from the main oldi from the secondary oldi. In that case
>>> "crossed phandles" would be better, i.e. something like:
>>>
>>> (in the first oldi:)
>>> ti,slave-oldi = <phandle-to-second-oldi>
>>>
>>> (in the second oldi:)
>>> ti,master-oldi = <phandle-to-first-oldi>
>>
>> When I had first designed the code and the devicetree for OLDI, it was
>> done so with the belief that we wouldn't reqiure a bridge instance for
>> the secondary OLDI, at all.
>>
>> While that idea holds true for dual-lvds configuration, it doesn't so
>> for the clone mode configuration. For clone mode, as you pointed out, we
>> will require a 2nd bridge instance to configure any of the bridges and
>> panels that come after the 2nd OLDI.
>>
>>
>>>
>>> Then again, if we ever need that, even with these bindings the driver
>>> could find the first oldi, but needs to go via the dss's node.
>>
>> While it is possible to do it this way, it might not be the cleanest
>> one. And _if_ there is a ever a DSS in future with more than 2 OLDI
>> TXes, say 4, then the decipher logic may get too complicated.
>>
>> While I cannot think of any case where the secondary OLDI bridge DT
>> might need to access the primary OLDI bridge at the moment, I wonder if
>> we should play it safer and have this option anyway.
>>
>> Maybe something like this?
>>
>> (primary OLDI)
>> ti,primary-oldi;
>> ti,companion-oldi = <phandle-to-secondary-oldi>;
>>
>> (secondary OLDI)
>> ti,secondary-oldi;
>> ti,companion-oldi = <phandle-to-primary-oldi>;
> 
> How is this different than my proposal, except a bit more verbose?

That's all the difference there is. Just an alternative to what you
suggested.

> 
> If you're thinking about a 4-OLDI hardware, how would this work there?

I didn't mean that my alternative would be more helpful. I meant that
passing phandles would be a simpler way for 4-OLDI hardware in general.

We'd have to sift through a max of 4 OLDI nodes to find the right
primary OLDI for a given secondary OLDI - if we try to find it via the
dss and oldi-transmitter parent DT nodes. Passing phandles directly
would save on all that logic.


> (but I want to say that even if it's good to plan for the future, we
> shouldn't plan too much based on imaginary hardware =).
> 

That's, of course, true too! =)
It's been tricky enough dealing with the hardware combinations as they
are today!

I will add one more reason though, which made me get along with the idea
of passing phandles. And then I will defer to you to make the call,
since I don't have the strongest of feelings either way.


Passing phandles would allow for _that_ condition to get dropped; making
the bindings slightly more flexible to accommodate for any future
surprises (especially around the clone mode lvds configuration).

(That condition being where the bindings either allow a companion-oldi
phandle OR allow the secondary-oldi boolean (but not both)).

I could drop that condition without any other changes too, making the
companion-oldi property optional for secondary-oldi - but this feels
incomplete.

Hence, the addition of the primary-oldi boolean. The companion-oldi
phandle property will be conditionally required when any one of the
boolean properties is present.


-- 
Regards
Aradhya


