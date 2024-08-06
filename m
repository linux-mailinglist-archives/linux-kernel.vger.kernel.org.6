Return-Path: <linux-kernel+bounces-275731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DF6948927
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642431C226DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C895A1BBBE6;
	Tue,  6 Aug 2024 06:07:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4FE2CA5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924422; cv=none; b=ok0jM5LpiUopI6YSQSFzr2SiYZ3oDLZya83DiJg0SpDfUN4g8oV7Hw9PjJyOm2Rc+wAcx+ajAnnPZYKsbbHvizHpZWlx8KDx/S5FSgFkDckJms27JdMMKwC1SkVHeoFXtJFmXg7XhyymhE1HQn5oZOdwEgAaQ0i2cv7p0d5JpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924422; c=relaxed/simple;
	bh=z0AEY60fyT9QlUh25vE1qVxmLJCcNWTcbkZfieTLX4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2Z/TLWL0WURrBe8kRyoKATctWLktCyGGdJKh+fca+Qzf0wo1SzX06TLcma6Eps3BNFTweu6Ya/40J66h0wDXHsDrcxQbMsSgbPHBdGcDRyreGNVrmaN0qBQOS1Y/BGqN8cs0fglgv3BPhV0VoC5Pp++v9xhNTMjJAnmpmg7/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AA2B106F;
	Mon,  5 Aug 2024 23:07:25 -0700 (PDT)
Received: from [10.163.54.208] (unknown [10.163.54.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7E33F5A1;
	Mon,  5 Aug 2024 23:06:53 -0700 (PDT)
Message-ID: <828c808c-7635-414c-887b-090678bcc7f7@arm.com>
Date: Tue, 6 Aug 2024 11:36:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] arm64: mm: Remove unused declaration early_io_map()
To: Catalin Marinas <catalin.marinas@arm.com>,
 Yue Haibing <yuehaibing@huawei.com>
Cc: will@kernel.org, ardb@kernel.org, msalter@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240805140038.1366033-1-yuehaibing@huawei.com>
 <ZrDn0bt7sBm4CkzC@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZrDn0bt7sBm4CkzC@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/5/24 20:25, Catalin Marinas wrote:
> On Mon, Aug 05, 2024 at 10:00:38PM +0800, Yue Haibing wrote:
>> Commit bf4b558eba92 ("arm64: add early_ioremap support") removed the
>> implementation but leave declaration.
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> The '-next' in the subject confused me a bit. We normally use it when we
> fix something that's in linux-next only. Anyway, the patch looks good
> for 6.12.

Right, this did not require an -next tag in there as the patch can be
applied on latest mainline release i.e v6.11-rc2.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

