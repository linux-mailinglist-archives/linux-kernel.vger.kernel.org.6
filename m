Return-Path: <linux-kernel+bounces-545808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D361A4F1C2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60944188C517
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2232780EA;
	Tue,  4 Mar 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWzCgqyp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62F1FF1BF;
	Tue,  4 Mar 2025 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132103; cv=none; b=WgeZs5m08TA2IFtokmBvuQLnJl462TjREliOv1EjZQjJXmCwYplSc3TqWjKNyVefdGzOBlqdBmAs+96ErpeaHcPmvydZRU2H/DyDIvWlar76T/wRYSL5Ndb4BxaneDyBELUJGneahy1Mq3U6dRf8LBrP6BV9rB2DpGpUZoPvEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132103; c=relaxed/simple;
	bh=GwQMN2sTVl7WhSar32HtmnQ4Yzh2BIMYxg373QgeE7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsMPDyn5dx5KxKiXvFQXnISmr8dRlIAtzwKR0FHqGAGXPtH+YFvyCG2+JHELYSesiy03b9sO5mALnjKlUFmJrHva8k2PM11beRQbaaV+q/V7nHSxGfoiFla8SAqNKmZc+3sOGOlBG6cepADeaJS5vhi25my5dM5ba+5amYKQU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWzCgqyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35F3C4CEE5;
	Tue,  4 Mar 2025 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741132102;
	bh=GwQMN2sTVl7WhSar32HtmnQ4Yzh2BIMYxg373QgeE7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OWzCgqyp8y/+UYaqUQcZzU6Z3aNreE0DdjZJ57kxdI5YLzFXcQ31R1DIoyAVUrla4
	 S4cxQU8s663H6dvW2t9A08ExiQOXdbm1pF+zL8xh1/J6dMmJktHakaCA5qqka5OsPm
	 FYlb6c4dWIeUx/9kWVoTQGRg1V+pWciGFNPM3J7hy/D5pVhV51CyS3bt/jpThpsuvK
	 KRiIpsq/FtPzewxRoR1NnSeKwH1tmV7qIjLNICDx0uA4TRhBVf37thS7oFkazMO/YG
	 kNkIpckrmT2EsLhvlEPtyBqUZKTVbOb3tEg1rInMTV2khoLT6StZoyHZYEKRWBSw9q
	 WbPl1vLsV//wA==
Message-ID: <cd2b277b-52ce-40cb-b461-e67338fd9471@kernel.org>
Date: Tue, 4 Mar 2025 16:48:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/CoC: Spell out the TAB role in enforcement
 decisions
To: Steven Rostedt <rostedt@goodmis.org>, Shuah <shuah@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 gregkh@linuxfoundation.org, corbet@lwn.net, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, conduct@kernel.org,
 tab@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>
References: <20250304194813.11049-1-shuah@kernel.org>
 <20250304200947.GF30583@pendragon.ideasonboard.com>
 <2b3aad9e-5288-45d5-bcdd-9dbc4f7298b4@kernel.org>
 <20250304165528.2e9b336c@gandalf.local.home>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20250304165528.2e9b336c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 14:55, Steven Rostedt wrote:
> On Tue, 4 Mar 2025 14:43:13 -0700
> Shuah <shuah@kernel.org> wrote:
> 
>>> Without an explanation of the intent, the CoC and TAB would appear more
>>> opaque, especially given the tags present on v1 that shows the patch has
>>> been discussed behind closed doors.
>>
>> No decisions are made behind the closed doors. As mentioned above, the
>> document had inconsistent in when it described the TAB role. This patch
>> is fixing the inconsistency.
> 
> I guess this should have included a "Fixes" tag and described what it was fixing.
> 

My bad. I should have added one. Will do that for v2.

thanks,
-- Shuah

