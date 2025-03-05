Return-Path: <linux-kernel+bounces-546441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09646A4FAB7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBD33A7873
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE92C1FDE37;
	Wed,  5 Mar 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sG5+rQfb"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347C2054FA;
	Wed,  5 Mar 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168432; cv=none; b=gJfwpGsASr7K2RO3YqeOdaqWFl+KSOxajrO45dBQFi5RY6DA0kqdccE/uV9frALGzNHazP0Btd9cxkveF6XxvsCXFwUnXvIO01kiFl7o09cwonhAclyqx6eehFrikAW7RfcHNz3zPASgK6bOZDMGbGqGadyBWEu3HI5VOltES1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168432; c=relaxed/simple;
	bh=ias0EnAhhayGJbHbMVVhKT1PU/RJx8ezmGLJc2aLVf8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BDFwoi/OgMCNAJOCzhDZtccfv/JfTRmtvMHBRT2gpso0cMp6SwHju4yE/BLmt9U/lTpLGZL1h0Y+EcPu0vWrtjqgLNGjPVCapT8XttelurEXPdNcOg6hC8cGmnVjEfsvFoIS7be94XgP5lyHIcnMYRZ5+yxPKSo/2mXgZ0nezK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sG5+rQfb; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741168428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1bVR4X0ePGK/oRqohewsCjBonguuJIp7QjmsiVlbb8=;
	b=sG5+rQfbWLRZO2uOz7sFWLIAnRuEotqEHsUwvgJENU6SQjktontL9UNIjzHJGg6pyTCIGt
	XMMkTEb5gl2FofrqqL91r1EzE93mTneVXY2DKXmRb/S1U9xiG8ky3o97e0o/E0RCYhPMFD
	upyhJ87nlwGVA8ePobwV9MNldX77Z3orjQtH+BB80t7v8jnYtBjk63wBV6CEH8Cg0Mdu6u
	8f2Sa1KgIYjy09MAFD+XxYFFZ30rJcZ3GwB15FcgjpU9bPSciPfXIyUw+CRinX2MSnqfTs
	Y8RSSAh3nURiorJhk+gvNrvpKJkdmpe7BSQkgH/pghOCrSrpxHPstaG3OoWFKQ==
Date: Wed, 05 Mar 2025 10:53:48 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: dt-bindings: Specify ordering for properties
 within groups
In-Reply-To: <166a7b77-74e3-40b7-a536-ee56850d9318@kernel.org>
References: <47c51c10098f089e52fb14c5c5527611dc8daf32.1741164239.git.dsimic@manjaro.org>
 <166a7b77-74e3-40b7-a536-ee56850d9318@kernel.org>
Message-ID: <f05919742c34f5d4489d2cd711c7736f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Krzysztof,

On 2025-03-05 10:36, Krzysztof Kozlowski wrote:
> On 05/03/2025 09:45, Dragan Simic wrote:
>> 
>> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst 
>> b/Documentation/devicetree/bindings/dts-coding-style.rst
>> index 8a68331075a0..15de3ede2d9c 100644
>> --- a/Documentation/devicetree/bindings/dts-coding-style.rst
>> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
>> @@ -133,6 +133,12 @@ The above-described ordering follows this 
>> approach:
>>  3. Status is the last information to annotate that device node is or 
>> is not
>>     finished (board resources are needed).
>> 
>> +The above-described ordering specifies the preferred ordering of 
>> property
>> +groups, while the individual properties inside each group shall use 
>> natural
>> +sort order by the property name.  More specifically, natural sort 
>> order shall
>> +apply to multi-digit numbers found inside the property names, while 
>> alpha-
>> +numerical ordering shall apply otherwise.
> 
> The last sentence was not here and I don't get the point. Natural sort
> order should be always preferred over alpha-numerical for properties.
> About which other case ("...apply otherwise.") are you thinking?

Yes, I added that sentence in the v2 to, hopefully, clarify the natural
sort order itself a bit.  I've researched the natural sort order a bit
further, and it technically applies only to the multi-digit numbers 
found
inside the sorted strings.  That's what I wanted to explain, and "shall
apply otherwise" refers to applying the alpha-numerical sort order to 
the
remainders of the sorted strings, i.e. to everything but the multi-digit
numbers found in the property names.

