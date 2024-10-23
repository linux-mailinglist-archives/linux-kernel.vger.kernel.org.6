Return-Path: <linux-kernel+bounces-378905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9DA9AD6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF352856C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84411F7087;
	Wed, 23 Oct 2024 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Wod1yYIR"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A722615
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720386; cv=none; b=UyYeQ8S44N9S9XdIsxyYBkD1K0T2QAxAsiwXB49CXaHQfrLKTSTH4f9PjsA3i6KhuLxbAa5JMO6X7jpJDZdEp+RZ1hJNBz5wZujE4ZX3vfDZ3MW3j5X2AbC1kfNhICa9tucbXuXm0gfXeNtn6dRI518S5upx6HUk2k6ej6fIwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720386; c=relaxed/simple;
	bh=azhfJyPgiSL8BV7CUX9kNnYUD2sjnRoQsii/YXDXRF0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p0cpJj1ktDFjNE664VO55tD+UueujjL2PwZpSlvSQY376ewjZ/7vZmJDzMS2xC20IuKnpmasL0TFynII5JV6LiGYZlL11E/bny/ioXZkH4lAx0CsbDGJnNYkUdifhGDvIVuFP0wlONU5WyayHKMYCdU7jq39zWyE8G4girilXRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Wod1yYIR; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49NLquEf1418336
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 23 Oct 2024 14:52:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49NLquEf1418336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1729720377;
	bh=1I+TI4vvcf4lYzt7P/++TQ20n6mUN1BARtvraLIcfnY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Wod1yYIR3U1gJ1Gg020HGe47dcSHv9MEm4Sq08W6SVkxJadNH5M9ew5fXEsQeYfb2
	 u4UaOsI8jaPSk3NmghIpYQ87Jc7mu6icjzOwpIzaKG9fIWaj0R57SOLmEdTM7jJeXY
	 Kz6J5DuCzK3ogG7H601u5v1SXFJJK1mrIqG5TUinOGo8HTYKqd4yiXqPPJnA25OoRp
	 i1DS6PHeQRhe7rIjB3rh8jNluNtPmLfgDFZ/h3vbwled9r4/Wlf7pOryBzS10Hp5bP
	 FXXxDx9wyPlaEwyV7dwTq6Y3NZGaWwqUNqo0Xnaboq3FKSK0Sr6e95khiXNUam6apv
	 9KsknknpSxOrQ==
Message-ID: <9f939484-18bc-42be-bd1b-ef48d3366a69@zytor.com>
Date: Wed, 23 Oct 2024 14:52:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC, untested: handing of MSR immediates and MSRs on Xen
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin3.li@intel.com>, Xin Li <xin@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <7a4de623-ecda-4369-a7ae-0c43ef328177@zytor.com>
Content-Language: en-US
In-Reply-To: <7a4de623-ecda-4369-a7ae-0c43ef328177@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/24 14:31, H. Peter Anvin wrote:
> 
> Note: I haven't added tracepoint handling yet. *Ideally* tracepoints 
> would be patched over the main callsite instead of using a separate 
> static_key() -- which also messes up register allocation due to the 
> subsequent call. This is a general problem with tracepoints which 
> perhaps is better handled separately.
> 

So I have never quite wrapped my head around how heavyweight tracepoints 
actually are. I do know that static_key() is definitely not a perfect 
optimization barrier[*].

The case of MSR tracepoints in particular concerns me, because having 
one knob for all MSRs is an *incredibly* wide net to cast, and doesn't 
distinguish in any way between performance-sensitive and 
non-performance-sensitive MSRs.

I do wonder if tracepoint sites could be implemented using traps (or 
perhaps better, software interrupts) especially in critical flows, or if 
that would increase the cost of the tracing too much.

	-hpa


[*] One thing we may want to consider in general is if we should 
increase the bias for __builtin_expect() by passing 
-fbuiltin-expect-probability to gcc, or use 
__builtin_expect_with_probability().



