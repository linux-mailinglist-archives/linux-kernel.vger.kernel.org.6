Return-Path: <linux-kernel+bounces-531819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E848EA44563
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3817A775
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE1E183CB0;
	Tue, 25 Feb 2025 16:04:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0967C186E2F;
	Tue, 25 Feb 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499487; cv=none; b=Bl9hh/6GPuoJEh381xhaGkZoZRSaP6PzWhQ7YbCWODurJB7t1A8PAWvY6j0JWzg/joYZ8RnXZlv230pu8ahsx22JgUUfKazL2gh05ZrvAHuEqS6u0vJFeLMnK50Aqg0uNGlqkRUdWryeom0kFdzYPoOK5LYVPGU02K1Z2bGW1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499487; c=relaxed/simple;
	bh=qrZ870n4A6ddjRrRVwpTT6oqfXra1m5qedaZr7lbk/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFsiwtUCv4lsO66pq/05RFUTL/ovD3in90nr1c84+esYSmGoRjvbt0bC3oj5hPpcbMzyDSK9XVUvp1CuV4uYIrQN6Eda5/ze4aWQ7mylXl8wsI1Ar0kGxzCkI4bk8TjONw1hebY2bgNEEy6drzS0VOziZYQ8K4qdY6quz2ThIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 728041BCB;
	Tue, 25 Feb 2025 08:05:00 -0800 (PST)
Received: from [192.168.7.252] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 741353F6A8;
	Tue, 25 Feb 2025 08:04:42 -0800 (PST)
Message-ID: <c8e89c26-2ae0-4928-a625-46a6b6efd88f@arm.com>
Date: Tue, 25 Feb 2025 16:04:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/10] arm64: dts: morello: Add support for fvp dts
Content-Language: en-GB
To: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com>
 <20250220180427.3382482-10-vincenzo.frascino@arm.com>
 <CACRpkdbZmQxtVqtc=Fw6kiOe3NdEE2mBHr2rKXLP76U7Dguhgg@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <CACRpkdbZmQxtVqtc=Fw6kiOe3NdEE2mBHr2rKXLP76U7Dguhgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

thank you for your review.

On 25/02/2025 15:31, Linus Walleij wrote:
> On Thu, Feb 20, 2025 at 7:05 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> 
>> The Morello architecture is an experimental extension to Armv8.2-A,
>> which extends the AArch64 state with the principles proposed in
>> version 7 of the Capability Hardware Enhanced RISC Instructions
>> (CHERI) ISA.
>>
>> Introduce Morello fvp dts.
>>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> This one has the PL110 graphics as well, right? (To be added
> later, just asking.)
> 

Yes I will add it later. This series focuses on the bare minimum to build the
infrastructure.

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

-- 
Regards,
Vincenzo


