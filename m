Return-Path: <linux-kernel+bounces-565016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFADA65F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3B3189EBDF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8991F583D;
	Mon, 17 Mar 2025 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="w2FTOwgj"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC21E1F4E47
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243369; cv=none; b=JipvwkZdw9meR/inixDur3eExyG6NZhe2B0jS5nONVIZmmVroIMqp6d+rtan1nW69JQzQRAcATTrSoY1+hVkiRsRGA0mOUrwICUMfFhRTxoOFAkpgfLLm/yNib+j9sS7llARfXsghUfdgk/fGIJqRa8M3H8bw668nXtbFMOgg3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243369; c=relaxed/simple;
	bh=8qPFDh43gwyc/vU6yBECnDYdonjw+7a7Fw9A7q7I1YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyOQDCSBnT57l1Hh9apfWVI3afl0UuYYznjhbgrvrqGGxFM2A4WGiHVTGSbfrABvukDx4EwNlBKdHSfkXX+DuvyyMJdmiSUj2mHXRwi1EBnx30Ba6fP9K6LOs7SsvR+KauhEY0K8+a3pNSnauKzkS+psd67GqajUoxVkiCoO+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=w2FTOwgj; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <8729ccb4-cdd2-48f7-a8d4-f55a24964bc4@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742243365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2gPp8ZZpEDOPhCSsNGFmD3VmlQ7JFSNt9SswdFFzlU=;
	b=w2FTOwgjsx7saoQwKyeyBl1fhl0fcyDSJgA2K/1oGFLpnKWZ5PG9HBkeFzaw/4Nlj2e0Hm
	xhsQRP06Q7vUiB36Y7CRl82oxq+MPGTZuDeFqjBCCH06LBE7qGgW8vSAI/FGdYm7V5Xj+A
	ww3ri5CC3UIlnHpe+jadeoV5FyUBtMoF860oFlg1/+QZTzbsjZBsu8XThWagzgP9qvCpyW
	kRzS27lH075qI+yf+CU5VuCp5Ziu+Tw1iWEmaAkL6YPQFxwJUIBhW4VchiL2IW4OjfKrc1
	lMtS9M3FIYRSltcyxWxu/It/unHJw44S8H3ZJN64e6jWXb7Ok89MIwJDdSGLXA==
Date: Mon, 17 Mar 2025 21:29:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] riscv: introduce asm/swab.h
To: Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com>
 <d964bf15-7172-448b-9aa1-72d5bf3e1695@ghiti.fr>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <d964bf15-7172-448b-9aa1-72d5bf3e1695@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/3/25 17:36, Alexandre Ghiti wrote:
>> We need a default implementation to fall back on, but there isn't any in
>> `asm-generic/swab.h`. Should I introduce a first patch moving
>> ___constant_swab<XX> into include/uapi/asm-generic/swab.h?
> 
> Yes, that or something else to avoid the code duplication.

Thanks for double checking. I figured as much but I ended up getting a
bit confused with the include directories.

>> +#if defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE)
> 
> NO_ALTERNATIVE does not exist to my knowledge, and you don't need to check for ALTERNATIVE as alternative-macros.h will do the right thing in that case.

It's a define hardcoded into drivers/firmware/efi/libstub/Makefile. It
was introduced in [1]. It helps avoid these types of warnings [2]:

  riscv64-unknown-linux-gnu-ld: warning: orphan section 
  `.init.alternative' from `./drivers/firmware/efi/libstub/riscv.stub.o' 
  being placed in section `.init.alternative'

Let me know if you think I should drop it.

[1] https://lore.kernel.org/all/20231031064553.2319688-3-xiao.w.wang@intel.com/
[2] https://lore.kernel.org/all/DM8PR11MB5751DA69DEEAAC9B06623E0BB80FA@DM8PR11MB5751.namprd11.prod.outlook.com/

> It would be nice to have some perf numbers too, maybe Bjorn will chime in :)
> 
> Thanks for your patch, looking forward the v2,

Thank you! 

