Return-Path: <linux-kernel+bounces-350754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97943990917
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50145281F42
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA181C82F7;
	Fri,  4 Oct 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rD0CgGFY"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB21E377D;
	Fri,  4 Oct 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059056; cv=none; b=b1R2xuCR1gBrbA878Xs7N2p4yd5Ej9uuCxVRkuxOb67BR2LSC+BYrb2yWmycayiKzjuT6+DSpyvgCxMyP450bkk6qVtdksQBbJV+Qh68Umbxn9fTVhz2dtBWEDMEWus2ijufjRRTU3gReV1jSjcvBLndpfFf07lBwioCEIi9GyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059056; c=relaxed/simple;
	bh=Jgjffirx4+b6N67EonfgS9HkhD2Hun1SamPTDROda94=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hUeXl9/U+89+mSmuymqBFXzFA9Sz1w3rYsfDwINW+8lka20N7nR7Z4O1C67Nl9o+5AfzMsn18bfHXRa/LKctdIj953vu4+Pv0FF5Eg/w+Tmf7NNYcgI8pHMHqve2X8VTDLYgAz6cSARYPmB365lQ5jkiBsqNGrl9VmXd3UQPBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rD0CgGFY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8A80C20DB370;
	Fri,  4 Oct 2024 09:24:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A80C20DB370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728059054;
	bh=zH4HWDuKPn0rkCzJoxxLd5gXWSkBIlKuXlvAFlVEkQc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rD0CgGFYk7frjGx7B1X+CMR+4spcBlOXdtHAFFkbbS5eFnXFt/Wb22itvv3vrGiUl
	 gjm4QhMTdOYLeBIa+AbQTREmcRu3fCcS678rZ2HpWs4WKhuSjufCyVcEY+5HchmTXP
	 uFaut2ElQW0G4Q8XmzLUqpMxPf32hNYHr2iu/Evw=
Message-ID: <f64f2cb8-de7a-4131-a0ae-e986b4857777@linux.microsoft.com>
Date: Fri, 4 Oct 2024 09:24:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, James More <james.morse@arm.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Subscribe Microsoft Azure Cobalt 100 to erratum
 3194386
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Rob Herring <robh@kernel.org>,
 D Scott Phillips <scott@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241003225239.321774-1-eahariha@linux.microsoft.com>
 <172804243078.2676985.11423830386246877637.b4-ty@arm.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <172804243078.2676985.11423830386246877637.b4-ty@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/2024 4:47 AM, Catalin Marinas wrote:
> On Thu, 03 Oct 2024 22:52:35 +0000, Easwar Hariharan wrote:
>> Add the Microsoft Azure Cobalt 100 CPU to the list of CPUs suffering
>> from erratum 3194386 added in commit 75b3c43eab59 ("arm64: errata:
>> Expand speculative SSBS workaround")
>>
>>
> 
> Applied to arm64 (for-next/fixes), thanks!
> 
> [1/1] arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386
>       https://git.kernel.org/arm64/c/3eddb108abe3
> 

Thanks for queuing, I just saw that I typoed James' last name in the CC
of the commit message. i.e. it needs s/More/Morse/


I'll let you decide if it needs fixing up.

Thanks,
Easwar

