Return-Path: <linux-kernel+bounces-329994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A340C979843
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667FB280C6F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8671C9EAE;
	Sun, 15 Sep 2024 18:49:54 +0000 (UTC)
Received: from sxb1plsmtpa01-10.prod.sxb1.secureserver.net (sxb1plsmtpa01-10.prod.sxb1.secureserver.net [188.121.53.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29D2F4A
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726426194; cv=none; b=o3h0/JQwYeQfZ3DHsbKEyrnUUy3UNtNdAOxWyoHdwJqg6NR1Cm3TCcWAVgplMEXrBA/AqFujMkniI1JoV0KRowOSDVVGVtAFN9ygFXcG29o+4Y6RCKPA1TnMmWnjCvHd8UbX8+whyXVVj93RdnnV/meq9GddAGpsaotj2iv9PHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726426194; c=relaxed/simple;
	bh=c65Fbf/FXkxO2G+Er6ipoAOMVU2ROiSpwiMZwMHYJGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEsA74y5n3mhAB1Dz4+tGZtjdrXyp7dc9kxqNQbWkoFtnQiI72dd6PcCOcMShQMJOErMKPMgWj8ONp/e5aO5drDi0mrPdeO33aC2Rom8yJRSCzdFdguRMofJI4Sd4xB/hweAyyM5KxX23wB9F5K7x8EnIwgwIg7Z6OFckP8fp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net; spf=pass smtp.mailfrom=piie.net; arc=none smtp.client-ip=188.121.53.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piie.net
Received: from [192.168.1.27] ([109.90.180.58])
	by :SMTPAUTH: with ESMTPSA
	id psigsD6CJeV6MpsijsWsDn; Sun, 15 Sep 2024 10:07:34 -0700
X-CMAE-Analysis: v=2.4 cv=W5DzVgWk c=1 sm=1 tr=0 ts=66e71457
 a=ujCVow8R4Y5jPCx6COW8WA==:117 a=ujCVow8R4Y5jPCx6COW8WA==:17
 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=QyXUC8HyAAAA:8 a=t3YNmgBSAAAA:8
 a=xA_eoFYLF_hYfpCd0WQA:9 a=QEXdDO2ut3YA:10 a=ctH_qozkpUrkr3SVbfwb:22
X-SECURESERVER-ACCT: peter@piie.net
Message-ID: <690dd991-45ea-4c4f-8298-54cb8377e093@piie.net>
Date: Sun, 15 Sep 2024 19:07:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: gov_bang_bang: Adjust states of all
 uninitialized instances
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, =?UTF-8?Q?Peter_K=C3=A4stle?=
 <peter@piie.net>
References: <6103874.lOV4Wx5bFT@rjwysocki.net>
Content-Language: en-US
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
In-Reply-To: <6103874.lOV4Wx5bFT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCidow2HK61jS6f8O+DnwvWSfmfO7DYeslRe5RiMQZMvK6It43SAYPo4moNTklnt7pLleVXcDnuf99HLdPV2JohlB3//s/wupVYQuJ3TqT/8WvnmdIYS
 I9vzXYk8QEnsiPvSdhcJ3lkjpx2oncbkNWQTDJBfmko5hrgE7wh57TEDGHcyyGKoaUBeD2NI5cdOeBKJpVq5HS05Yv87JQxICpJWKVu8t10fzo6l9nepG/OK
 UY3OFP9Y3ATqeeBkO5yqlJ1QVg36n+lYWc/o/uCpyrdORcsd7qk0pL5NdN1cqEKqq4GZZbXCaLUsPxnXFflZKPw5/I+nMmPqiyFUzTCzEMORyGE1m7jkl25u
 uCJcUA3p1je4j9ve0JsHOtTgBjHnvA==

On 26.08.24 18:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a cooling device is registered after a thermal zone it should be
> bound to and the trip point it should be bound to has already been
> crossed by the zone temperature on the way up, the cooling device's
> state may need to be adjusted, but the Bang-bang governor will not
> do that because its .manage() callback only looks at thermal instances
> for trip points whose thresholds are below or at the zone temperature.
> 
> Address this by updating bang_bang_manage() to look at all of the
> uninitialized thermal instances and setting their target states in
> accordance with the position of the zone temperature with respect to
> the threshold of the given trip point.
> 
> Fixes: 5f64b4a1ab1b ("thermal: gov_bang_bang: Add .manage() callback")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Peter Kaestle <peter@piie.net>

> ---
> 
> Found by code inspection while considering a related change.
> 
> I don't thik it is super-urgent, but it qualifies as 6.12 material IMV.
> 
> ---
>   drivers/thermal/gov_bang_bang.c |   14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -92,23 +92,21 @@ static void bang_bang_manage(struct ther
>   
>   	for_each_trip_desc(tz, td) {
>   		const struct thermal_trip *trip = &td->trip;
> +		bool turn_on;
>   
> -		if (tz->temperature >= td->threshold ||
> -		    trip->temperature == THERMAL_TEMP_INVALID ||
> +		if (trip->temperature == THERMAL_TEMP_INVALID ||
>   		    trip->type == THERMAL_TRIP_CRITICAL ||
>   		    trip->type == THERMAL_TRIP_HOT)
>   			continue;
>   
>   		/*
> -		 * If the initial cooling device state is "on", but the zone
> -		 * temperature is not above the trip point, the core will not
> -		 * call bang_bang_control() until the zone temperature reaches
> -		 * the trip point temperature which may be never.  In those
> -		 * cases, set the initial state of the cooling device to 0.
> +		 * Adjust the target states for uninitialized thermal instances
> +		 * to the thermal zone temperature and the trip point threshold.
>   		 */
> +		turn_on = tz->temperature >= td->threshold;
>   		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>   			if (!instance->initialized && instance->trip == trip)
> -				bang_bang_set_instance_target(instance, 0);
> +				bang_bang_set_instance_target(instance, turn_on);
>   		}
>   	}
>   
> 
> 


