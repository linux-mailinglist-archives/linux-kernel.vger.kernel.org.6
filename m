Return-Path: <linux-kernel+bounces-196943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820A8D63FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489B81C2787C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE6D1649BE;
	Fri, 31 May 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dcdxt/2v"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5C155C8E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164287; cv=none; b=arGaJ934bmcmyK5+5VwDIE3Tt95CyGnyU95atMNpkV1qC4K5mLZ3qky0GSzkeMmhUdPXotYj0G6cizEgmesA5hMqrCjUaaZA0t+b4VZ3M1fPLUCcSbFT6h5ci53x/EKQFIVLfR7xEJaV7cTq+Vbh6od0Mw4QNXjt9jUY9jwwZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164287; c=relaxed/simple;
	bh=9X3/+K4zOUhzNbutloj3w6yI0u7JNa7iWNyhISz2UUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPsLIn5zV0g28EY0iuFVhw3rVJKFNHlqJjCm2VHZC9aZDsDMu+YxXGRzmUsFCwCygKrPbCCrETQUlb/XFNo4hvqXrfVmMuM15VYor6DlUJsVxoKyMk9BTeXmqBvmLR+BXR2vPvYj1T9/tjczVc23ue7L3rJ9LENb2YVhFWBZjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dcdxt/2v; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sam@ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717164282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/qvTrH1SiQj3MlmnfxDD66NKPm741DV2Sf6ZGRQjq0=;
	b=dcdxt/2vKtqS3mvkvS2XwUo4rVK/Gi3jVopqG04THr1VzIf7XXW6pasFPOGn1fuDJAZp3Z
	pM86B8Jg1dR0SbpIP0CqPk90+ackIQKmtNnD+v+Pq8GQ+jUZuXT6gB8/+9qgOksy9sYsAa
	NrKgSHKf79u9c0ljICkoi5d5I1JCESU=
X-Envelope-To: j-choudhary@ti.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: dmitry.baryshkov@linaro.org
X-Envelope-To: andrzej.hajda@intel.com
X-Envelope-To: neil.armstrong@linaro.org
X-Envelope-To: rfoss@kernel.org
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: a-bhatia1@ti.com
X-Envelope-To: dri-devel@lists.freedesktop.org
Message-ID: <955a6d94-9a4c-4f7d-974c-819261579f14@linux.dev>
Date: Fri, 31 May 2024 22:04:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v4,1/2] drm/bridge: sii902x: Fix mode_valid hook
To: Sam Ravnborg <sam@ravnborg.org>, Jayesh Choudhary <j-choudhary@ti.com>
Cc: linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, mripard@kernel.org, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, a-bhatia1@ti.com,
 dri-devel@lists.freedesktop.org
References: <20240530092930.434026-2-j-choudhary@ti.com>
 <e5ce13e6-1007-41c9-bedc-2045d6f75480@linux.dev>
 <20240531133324.GA1715839@ravnborg.org>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240531133324.GA1715839@ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi, Jayesh


On 5/31/24 21:33, Sam Ravnborg wrote:
> Hi Jayesh,
> 
>>> +
>>>    static const struct drm_bridge_funcs sii902x_bridge_funcs = {
>>>    	.attach = sii902x_bridge_attach,
>>>    	.mode_set = sii902x_bridge_mode_set,
>>> @@ -516,6 +529,7 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
>>>    	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>>>    	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
>>>    	.atomic_check = sii902x_bridge_atomic_check,
>>> +	.mode_valid = sii902x_bridge_mode_valid,
> 
> As you have the possibility to test the driver, it would be nice with a
> follow-up patch that replaces the use of enable() / disable() with the
> atomic counterparts.
> 
> enable() / disable() are deprecated, so it is nice to reduce their use.

I agree with Sam.

Please using atomic uniformally with a follow-up patch, the mixed
using of atomic API and non atomic API is a little bit confusing IMO.


> 	Sam

