Return-Path: <linux-kernel+bounces-356918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3339968B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C67B26EBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99A192B86;
	Wed,  9 Oct 2024 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKgYsMYK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z8fcl5dO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BB192B74
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472970; cv=none; b=YezOv6/hD2isoIxoeiG2aX/d42uj1EeWUr9O7KxZr16+Zkr/Wdx3SSypGs20A9a8WxqVeqeKGi9j7GgJZh7SFOf5imDU9LsjYXrCQtr1X5yc60iaH9Fkd33Zeej54ubeb3/AGkNp4nbfERhEOxnUteZcX72HwiAHlK8Cg6YRhyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472970; c=relaxed/simple;
	bh=uT9LCY1MCBZrnW8l0+Mwci20AhBTdNYHv1VlrihsuyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S96pEziUzSmWa3Eo2qHDDTRVlPH44ivxkTCHefPhq+qwnQVZn6tgNBYrDbatKEy9A7PqqQVCiCSFFUzyUkY/MZi8Os5PypL+mo6rn7yhuLKFavaMWUF/Kb3rrj6n0Cci2hWWl1H9EJJG8AwL9/cgkGD43wa4VnDMZ2ZPJsAqjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKgYsMYK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z8fcl5dO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Oct 2024 13:22:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728472967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12VVtfi34hoIaDNJicNzt4xDRSn0X1vaAvqnNORMOKg=;
	b=xKgYsMYKKINC+ImwRaPbf59Yzx2cBYXk9e1rPXhWSzcl6EOh8Bp1n1ykNXQUK2BGCUc8yN
	2BhHq49BLHQrfGH11yFCQb8Fxvihk2gBoW+1cjCIJC0IbUyc7iD8Y4ZEts2lCnJpCcJgNz
	sJwPqp0Vz+60595aGEhi+vWVtIE7iJOsztsxOu9Wrch/RKfsjx/X2yaYJAfWm9ExIhbhFG
	fJFLeHa8H0IjSyFqtuxal4NQFD8J1Yir1EJqDFsyQ/A4soGL0E5qsa1c97CYlAYYIOJ0HL
	wXeCVhOu2aRXGcokIKezG91oOHz9CZLCZn42H2BpcC3M9DFHahTQBJ2oDLd3Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728472967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12VVtfi34hoIaDNJicNzt4xDRSn0X1vaAvqnNORMOKg=;
	b=z8fcl5dOfd/juBBCJS+RqIdXHGN2bRLsd8PRuMidEd4Xz51WUIJDthXgp6HrA7NvHKrsC0
	yFZ3wzW1wwMxWxBg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, x86-cpuid@lists.linux.dev
Cc: terry.bowman@amd.com, bp@alien8.de, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com
Subject: Re: [PATCH] tools/x86/kcpuid: Add extended CPUID leaf 0xc0000001
 support
Message-ID: <ZwZnhGfSPHTz64dm@lx-t490>
References: <20230530025922.4801-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530025922.4801-1-TonyWWang-oc@zhaoxin.com>

Hi Tony,

On Tue, 30 May 2023, Tony W Wang-oc wrote:
>
> CPUID leaf 0xc0000001 EDX bit2/3/6-13 are used by VIA/Cyrix/
> Centaur to defined CPU features.
>
> Zhaoxin use CPUID leaf 0xc0000001 EDX as:
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 0]  SM2
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 1]  SM2_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 4]  SM3 SM4
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 5]  SM3_EN SM4_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 16] PARALLAX
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 17] PARALLAX_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 20] TM3
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 21] TM3_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 22] RNG2
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 23] RNG2_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 25] PHE2
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 26] PHE2_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 27] RSA
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 28] RSA_EN
>

Just a short note.  I've added these bits to the x86-cpuid-db database:

    https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/tip/db/xml/leaf_c0000001.xml

And they're now part of the project's v2.0 release:

    https://lore.kernel.org/x86-cpuid/ZwU0HtmCTj2rF2T8@lx-t490

I shall send a kcpuid PQ with the updated CSV at a later step.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

