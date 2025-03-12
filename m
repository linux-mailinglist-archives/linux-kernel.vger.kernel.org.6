Return-Path: <linux-kernel+bounces-557796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA85A5DDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CAE97AD483
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8858E24291B;
	Wed, 12 Mar 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="D/UFUKhG"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9E78F32
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785903; cv=pass; b=LoqvmUQkucUZx8aTioEYeG0Y/i84Fk4peVXkzumju691pEdSHrMSJqgMQ6rj4zbZYbKoRVumm6PiM2WiKv0nwt/1b1nSM0Rc4UBR389JknyNvabSEUc6NQD/gKIBOhLP02qgwI6Y97Cn/ey68bdFjXXbUWtOQzP3v601WE2+waA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785903; c=relaxed/simple;
	bh=hLu17MWewNAkrCmOPiFU0LnsZECIatECY63qMJ9ANhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9q5HvasuwH0orFImlg2IcND3hB0ZvgE6YRauQ2Gm2TNN6zF9DFTO/nNhuSwUmc4u54pqFkWnCULWTHJ+qFWkH8y3nTwF8RxsQVSFl5ZL44txZHVh4rk01N/M6UtnS8zqO+vlYZMNL0koz99vMwxOnC5NiqYJ0lhPqeEV3mnZLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=D/UFUKhG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741785874; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KQ2P/C6BtkYsueq4akRJPsp2naRHaM7GZ9RL9q/HknxMqsZ/t5EvSXen297LmjxH4CUXZHk7qFgYS0Q2NIGXE2V5uMsCi7o5G3kZuOQ43ORA71hSJJLHp4vgfH3mDCh2oIVbkOSE/JPvQ/P3NThah7EoXKW4HKltNqtwVClsc5E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741785874; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zATmQj0XyB7/VoZzjPmz0V+W644epir4Rl4IGnvK18o=; 
	b=BXsSNOEqCeOufLJNWTjNcx3/6+LmMi2c3f59FFUK7kSGQQyDsVqVKD8CU04rMN2uSt2kgvrui/1WgqHpOF/jnVGpMkwy/GE0vCbkRETpaeFgpuQcrgFiV9LvpHRaRcD6QxhcGneqmXcb+G9tY2lP1e80YuEdXjjV5KAsgJ+rvNo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741785874;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zATmQj0XyB7/VoZzjPmz0V+W644epir4Rl4IGnvK18o=;
	b=D/UFUKhGVuHLpq0HvEd/liwgMeVn13FHRlBLaLu7IOARHB62GAz0tEKwquyBZfNx
	rJ2Vw+kG2SEajG9072z1u05X2ZmvLxXX/A+92OmcHrofUcR9mGZjrAMwUUpYXYKHSHz
	nb7bowQoGRkqA24ygY9kQEUESaft6X0CN82kJ1A8=
Received: by mx.zohomail.com with SMTPS id 1741785871899734.2310655484773;
	Wed, 12 Mar 2025 06:24:31 -0700 (PDT)
Message-ID: <3aca6477-6014-4c24-8aa6-6c601fc54a32@collabora.com>
Date: Wed, 12 Mar 2025 10:24:24 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] drm/panfrost: Unify panfrost_mmu_enable/disable
 common code
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
 <20250310195921.157511-4-ariel.dalessandro@collabora.com>
 <20250311085158.37329b0c@collabora.com>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20250311085158.37329b0c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Boris,

On 3/11/25 4:51 AM, Boris Brezillon wrote:
> On Mon, 10 Mar 2025 16:59:18 -0300
> Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:
> 
>> Both these functions write to MMU_AS_CONTROL register in the same way.
>> Define a common _panfrost_mmu_as_control_write function with the shared
>> code.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_mmu.c | 33 ++++++++++++-------------
>>   1 file changed, 16 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> index 294f86b3c25e7..31df3a96f89bd 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> @@ -121,38 +121,37 @@ static int mmu_hw_do_operation(struct panfrost_device *pfdev,
>>   	return ret;
>>   }
>>   
>> -static void panfrost_mmu_enable(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
>> +static void
>> +_panfrost_mmu_as_control_write(struct panfrost_device *pfdev, u32 as_nr,
>> +			       u64 transtab, u64 memattr)
> 
> I'm honestly not convinced this is needed. Let's just stick to
> panfrost_mmu_enable/disable().

Ok, will drop in v2.

Thanks!

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


