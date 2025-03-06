Return-Path: <linux-kernel+bounces-548496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E83A545A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E881881FEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A692209F4E;
	Thu,  6 Mar 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="R72szu28"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158B20896D;
	Thu,  6 Mar 2025 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251461; cv=none; b=mpBNTFc7kR3f7AE6AyNUk8bvENQTcdOCprh/PhuZ7zi4GDX0w6W8KXelXo7BNBZaqwNhItyEnz7KZ80feO+UwawWwwGBgdF9hKRsRuhWrH+TvTwqOm+D5Cv+ziHKhVRhn+SjxZN0CEIuChVqEcqKW+C31y6J2nkW8OCY5mKQeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251461; c=relaxed/simple;
	bh=RxI+sn6ItS1HjBLrenfZWt6mdaN+DJqre18glSgG4wI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ciodu1js8TjlUc9LRMYq0RmfPemHO4IaNRtbfQf702RunhXqA6JZQr+B1dFEWDBa+0JqSKWXAwpSsl3cozUR08w4otq8Cwu0gcgpwS01PmjR/V8RIpA39G9XNVMeC60B09ant6AkD/9mv/LbQEV1an1eGecu5Xnc6ToMKFuq8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=R72szu28; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741251451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2EQXtwX2k8Ao3it0ml2knRXy6h7kOt3zIk2p2gCi7Y=;
	b=R72szu28Tny5mtJPlLwYZjQZpIIUhaE2gpVqe+evn5BWhclxNazmIWXMb6gqrWySTWjYXe
	IEbVH4My+20cNl2S99qRR3DQxqo73VvHEimj3PpCu/yzsC81HcXhP8kgZh0myLDLP0WhJT
	VRVgUI0ibNQ1aFJ2nYwQUE7w/mku2mhmPf3tHVpQsOp1C5nZuM9C1Oe6BWKLmKxX4iAey2
	sOB9pqYd05SqnBCZjqmlZaG3RBHj8lcYAjjQuOShnXvjlSKGyj/jh4UZO/l65wYZeanZMy
	Rc2o6TgRJWHdoYAHb/LK4+rZpB1H4i0H2Npd0pBFcaMUfjQCgAveJU2zFaVWSg==
Date: Thu, 06 Mar 2025 09:57:31 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: dt-bindings: Specify ordering for properties
 within groups
In-Reply-To: <20250306-dexterous-goshawk-of-aptitude-e4f1f6@krzk-bin>
References: <47c51c10098f089e52fb14c5c5527611dc8daf32.1741164239.git.dsimic@manjaro.org>
 <166a7b77-74e3-40b7-a536-ee56850d9318@kernel.org>
 <f05919742c34f5d4489d2cd711c7736f@manjaro.org>
 <20250306-dexterous-goshawk-of-aptitude-e4f1f6@krzk-bin>
Message-ID: <c166178a01b7e83e9d3c488f4871bad3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Krzysztof,

On 2025-03-06 09:38, Krzysztof Kozlowski wrote:
> On Wed, Mar 05, 2025 at 10:53:48AM +0100, Dragan Simic wrote:
>> On 2025-03-05 10:36, Krzysztof Kozlowski wrote:
>> > On 05/03/2025 09:45, Dragan Simic wrote:
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst
>> > > b/Documentation/devicetree/bindings/dts-coding-style.rst
>> > > index 8a68331075a0..15de3ede2d9c 100644
>> > > --- a/Documentation/devicetree/bindings/dts-coding-style.rst
>> > > +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
>> > > @@ -133,6 +133,12 @@ The above-described ordering follows this
>> > > approach:
>> > >  3. Status is the last information to annotate that device node is
>> > > or is not
>> > >     finished (board resources are needed).
>> > >
>> > > +The above-described ordering specifies the preferred ordering of
>> > > property
>> > > +groups, while the individual properties inside each group shall use
>> > > natural
>> > > +sort order by the property name.  More specifically, natural sort
>> > > order shall
>> > > +apply to multi-digit numbers found inside the property names, while
>> > > alpha-
>> > > +numerical ordering shall apply otherwise.
>> >
>> > The last sentence was not here and I don't get the point. Natural sort
>> > order should be always preferred over alpha-numerical for properties.
>> > About which other case ("...apply otherwise.") are you thinking?
>> 
>> Yes, I added that sentence in the v2 to, hopefully, clarify the 
>> natural
>> sort order itself a bit.  I've researched the natural sort order a bit
>> further, and it technically applies only to the multi-digit numbers 
>> found
>> inside the sorted strings.  That's what I wanted to explain, and 
>> "shall
> 
> Natural sort applies to everywhere. It's just the same as
> alpha-numerical sort for single digits.

Technically, it depends on how one describes the natural sort order.
I'll get back to this below.

>> apply otherwise" refers to applying the alpha-numerical sort order to 
>> the
>> remainders of the sorted strings, i.e. to everything but the 
>> multi-digit
>> numbers found in the property names.
> 
> Sorry, still don't get. What would be the difference if for remainders
> of properties you would also apply natural sort instead of
> alphanumerical sort?

Oh, there are no differences in the results of the ordering, it's just
about the formal definition of the natural sort order.  In some places,
the natural sort order is described to apply to the multi-digit numbers
found in the sorted strings only.  Thus, the wording I proposed tries
to explain that further, but I do agree that it's somewhat confusing.

In other words, the way natural sort order is defined in some places,
it applies to the multi-digit parts of the sorted strings only, while
the remainders of the strings are sorted alpha-numerically.  I'll 
consult
some more sources and get back with some better wording in the v3, to
make it less confusing, while still describing the natural sort order
a bit, because the people who will be reading the DTS coding style may
not already be familiar with it.

