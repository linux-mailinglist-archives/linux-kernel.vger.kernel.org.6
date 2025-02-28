Return-Path: <linux-kernel+bounces-539621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A34A4A69C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67CC189C11A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF41DED6C;
	Fri, 28 Feb 2025 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="n2czX+hM"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866F1C5D51
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740785635; cv=none; b=bzO8lqwqsaoVGuJ4WA6buRFWXeHBS+lQZ3NWlM5h7E3qNiA/cmNbTsbYIGoFMJ66fuuVjRJdTNJr4GwLAZuv3OvAT70Ed5pq4lbK98NASjKh3nr/nH3/DjLNEkR6hgHxJ0ijdpzTM7r4KER3UXfbpqoLEiaZAOW8bh9zDjJC1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740785635; c=relaxed/simple;
	bh=S4DWdJSXo3EsQVNU/H8JjRSJVl1roSe06d0p1dLn9N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQ2mASV90IceH/tq8LAsbt6OVdKyTZ2xbde6c8bwZtZ6eg2OaNMgSpkAEG2//T+Q7P8ReiAB7kZ6UDgFmcR1nnHBKPWEr+1+rnB0SVVpPK2dxQqj9tTsveCZNnIfEzt7ZSnDkTHupRVze6fWciaf5cweIexLEtPW1nQouNusZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=n2czX+hM; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kJe8WYgRelDHaLDfrLsMKGMT1MsK663ED9mnxFKPYSQ=; b=n2czX+hMjcCWoJnSW2R6d2Xloq
	5Smbp46WrjQXnPZX4+6aaA2xNfebG9C5dX7JNheDqR+Zz00i7/HWHnl523H3L7+Y1btOsYUFxJ2pI
	pwvmlc/mVNGVSjaxJLyBYF2MI5yGZwvBFKcu6rRBukILrWgvSxY/3BCSyfxgRyMlWGzp+ltGaRRw+
	epyAOPrdmX9f9O1dhnKaHiZgCICqypelN6A6/usIbxt2K838vjj2v60lVT7BFgjwnKLb72EQbpBBg
	aX/oh5h1EvDN3Ni1o7lE0hO0kLZXZXACUZPvQTSx4Z/2PzILFKPcSGE60P8Cwjy3+UXfUWoV94Dui
	uchbpfcA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1to9rM-002IuP-Or; Sat, 01 Mar 2025 00:33:43 +0100
Message-ID: <86a6c5c7-47b7-49af-af57-b1d2171ba97c@igalia.com>
Date: Sat, 1 Mar 2025 08:33:36 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched_ext: Add trace point to track sched_ext core
 events
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>
Cc: void@manifault.com, kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20250228085944.19451-1-changwoo@igalia.com>
 <Z8GKCkWNVN_Pbcc0@gpd3> <Z8Hy6qu8shpYOR83@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z8Hy6qu8shpYOR83@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tejun and Andrea,

On 25. 3. 1. 02:31, Tejun Heo wrote:
> On Fri, Feb 28, 2025 at 11:03:54AM +0100, Andrea Righi wrote:
>>> +TRACE_EVENT(sched_ext_event,
>>> +	    TP_PROTO(const char *name, __u64 delta),
>>> +	    TP_ARGS(name, delta),
>>> +
>>> +	TP_STRUCT__entry(
>>> +		__string(name, name)
>>> +		__field(	__u64,		delta		)
>>
>> I'm wondering if we should use a __s64 here (and %lld below). We don't have
>> negative deltas right now, but in the future who knows...

That makes sense. I will change it to __s64 in the tracepoint.
Also, I will make corresponding changes (u64 -> s64) in other
places, including struct scx_event_stats.

> 
> And let's also print out the updated value.

You might have two options here: 1) returning per-CPU event
counter or 2) returning aggregated event counter. The first opion
will be fast but less meaningful from user's point of view
compared to the second option. Assuming the tracepoint are not in
the hot path, I think the second option will be better choice.
I will add an @event field and a special version of
scx_bpf_events() for faster aggregation.

Thanks!
Changwoo Min

