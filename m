Return-Path: <linux-kernel+bounces-235553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37B091D685
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC14B281770
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A211DDB1;
	Mon,  1 Jul 2024 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CFwryO+K"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D42C80
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719803993; cv=none; b=rBPt+/Uo3txrNSi2Xy3i/jK6Jis1w1WEWs5z2gIA+E16EyOhN0H7Id6lE+1XQeQ7dZ8ZQRUwUmIeH71HUr8F/wrG/WqIs0W5yGzaxqo32V2dKg3o1SMVg9G6APZuJFqyyF2r1nOtgfj9eODLeW2kIbZP91R1WCxBt8xsZq7Wftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719803993; c=relaxed/simple;
	bh=20owXG7+ITAeZso283pl9zsFJevavFpWp1z7qvQTLFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8vd9VfnUSDC4yC7M5hb+GOIQMr+Ase26x91iLRarJPNdHigmMXPuRN0biWfqZeRf42YpNjoCWWwqKyGN5Z8XZCiSm0EmQfqhX/lsBqMvzN4EepY3OjmUD8OE+IbjTREANKrlFQFKnZlnaDu7GZpQ8XdKYLD+flYk23wg/oOiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CFwryO+K; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: senozhatsky@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719803989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JYKZDodvrjDQDmo06M+nRwoR9WCeIcHzSHHV+4ORr8=;
	b=CFwryO+K25YtW+FELK27lJkKzheCewOv29EWdE0Y5huNDe32xuYcdLAZhbznqARLplInli
	Tsbx1emTMHTlOIREglT16vwOKGjjIXP1E1CtY8v4Yj06thR6XZW/9ftBCPDg5NueWC5c5e
	d3oNdho4Cxewc42FjK5GSbxrIx2K30M=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: minchan@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <6afcd23b-69bf-4ace-b489-3b500a8271df@linux.dev>
Date: Mon, 1 Jul 2024 11:19:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] zsmalloc: rename class stat mutators
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20240701031140.3756345-1-senozhatsky@chromium.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240701031140.3756345-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/1 11:11, Sergey Senozhatsky wrote:
> A cosmetic change.
> 
> o Rename class_stat_inc() and class_stat_dec() to class_stat_add()
>    and class_stat_sub() correspondingly. inc/dec are usually associated
>    with +1/-1 modifications, while zsmlloc can modify stats by up
>    to ->objs_per_zspage. Use add/sub (follow atomics naming).
> 
> o Rename zs_stat_get() to class_stat_read()
>    get() is usually associated with ref-counting and is paired with put().
>    zs_stat_get() simply reads class stat so rename to reflect it.
>    (This also follows atomics naming).
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>


