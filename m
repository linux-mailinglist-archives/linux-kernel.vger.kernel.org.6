Return-Path: <linux-kernel+bounces-375614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BDA9A9831
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392F0282679
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC305A79B;
	Tue, 22 Oct 2024 05:15:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A70D2E401
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574128; cv=none; b=kPLOhkhK5q3TdSJEqQJ5nypbWVFnYn8qt3NLA8TZeVkq+R9WsHUYGmDhuemw6nGksmGBipBmJbveMX6n7Vyzv7T4a3zq7mTVhyJEXdmRzt9vuLH/SN5NI0VSx0neU7HXSNeS5urd9v291pdCBVC8R+rAN8d9fi9gd4/bdGrDQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574128; c=relaxed/simple;
	bh=k2YS0m28wtU4KXAWBjIbkRWgGrmUiPzW1MXjhUtEUkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFgLPVOWEGJVniI4Li1FtZ2U+XLEZLzLXOqH2mSqHJWw0zb/T1t1jHR1+zj5U+6t27t2jR3KneLGF0ZRWauI5e+DXSUKBG675MJUv/xLDUeFSugawS36qM41dhxdaeXlEE9S9wyMajQzVMaXUPZUFn9wcNATMtKH0qMvQRwkZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10973497;
	Mon, 21 Oct 2024 22:15:55 -0700 (PDT)
Received: from [10.163.41.149] (unknown [10.163.41.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B79CA3F528;
	Mon, 21 Oct 2024 22:15:23 -0700 (PDT)
Message-ID: <985895a4-04c3-49a4-88f6-25e2fc18a71e@arm.com>
Date: Tue, 22 Oct 2024 10:45:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Use str_on_off() helper function in report_meminit()
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241018103150.96824-2-thorsten.blum@linux.dev>
 <172926766252.1788036.5825981783630801187.b4-ty@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <172926766252.1788036.5825981783630801187.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/18/24 21:38, Mike Rapoport wrote:
> On Fri, 18 Oct 2024 12:31:51 +0200, Thorsten Blum wrote:
>> Remove hard-coded strings by using the helper function str_on_off().
>>
>>
> 
> Applied to for-next branch of memblock.git tree, thanks!
> 
> [1/1] mm: Use str_on_off() helper function in report_meminit()
>       commit: 4bb21dbb6728fbe6cb7e2f7dc7e5388962c4125b
> 
> tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
> branch: for-next

Actually there are multiple such instances which could be converted using these
helpers at once in a single patch rather doing in a piecemeal manner.

https://lore.kernel.org/linux-mm/a11f46f7-29bc-4242-bd8b-d316065607e2@arm.com/

