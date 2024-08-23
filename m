Return-Path: <linux-kernel+bounces-298123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580395C2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C011C21FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 01:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00113171A5;
	Fri, 23 Aug 2024 01:18:35 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27BA953
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724375915; cv=none; b=EBjI/82FQKaaBhW226zEq5AaYixYCytHMAt0LVDeZx6yvfkWw3riJWwra/5TZnbUsULANpapYE8uOuK2pCqIfNTtxtFavoX3d1w3TwBMyWZGbYGTG85vNUVOKASxk21SxgqWXwSNpYpvm1FmnMx6z0UYO2mBM6UQH3o1Z3hoDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724375915; c=relaxed/simple;
	bh=z9MU2wBA4Pom46l7PkbE40XSM+iyYBF7GxdGq5vLIEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HHvNjtfMpiyfd6nzphsFiCE+AGYfQkXKkxjiKp8QwqjuOWiUbqphhPDZFB2hny5Gy07GqEKcm4XsYsRBxLKR5x8scawWl8ltV4+mt7XgnoRRXvRwRSa+6pxAJnD8BaEGIIUGib/iBHljKQXM9A7/+NT9UYteU1VXlzIZO1UUEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wqhyh0PdNzyQxW;
	Fri, 23 Aug 2024 09:18:04 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DC13180106;
	Fri, 23 Aug 2024 09:18:28 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Aug 2024 09:18:27 +0800
Message-ID: <8de17606-7fa5-ea3b-301b-9cb4eeee0c33@huawei.com>
Date: Fri, 23 Aug 2024 09:18:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v2 RESEND] drm/amd/display: Remove unused
 dcn35_fpga_funcs
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <nicholas.kazlauskas@amd.com>, <Charlene.Liu@amd.com>,
	<chiahsuan.chung@amd.com>, <hamza.mahfooz@amd.com>, <sungjoon.kim@amd.com>,
	<syed.hassan@amd.com>, <roman.li@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240822015819.3356282-1-ruanjinjie@huawei.com>
 <CADnq5_Pm9GHaFWLUniQ608CNMPMSBpNdh2JW9-AcKyEM18KE9Q@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CADnq5_Pm9GHaFWLUniQ608CNMPMSBpNdh2JW9-AcKyEM18KE9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/23 2:01, Alex Deucher wrote:
> On Thu, Aug 22, 2024 at 5:20 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> dcn35_fpga_funcs is not used anywhere, remove it.
> 
> This will lead to warnings about unused functions.  The fpga specific
> functions should be removed as well.  I'd suggest compile testing your
> changes first to catch these types of warnings.

Thank you!, I noticed these warnings later and it is too late, I'll send
out a new version today.

> 
> Alex
> 
> 
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v2:
>> - Remove it instead of making it static.
>> ---
>>  .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
>> index e2d906327e2e..15977c2d256d 100644
>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
>> @@ -1068,13 +1068,6 @@ static struct clk_mgr_funcs dcn35_funcs = {
>>         .is_ips_supported = dcn35_is_ips_supported,
>>  };
>>
>> -struct clk_mgr_funcs dcn35_fpga_funcs = {
>> -       .get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
>> -       .update_clocks = dcn35_update_clocks_fpga,
>> -       .init_clocks = dcn35_init_clocks_fpga,
>> -       .get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
>> -};
>> -
>>  void dcn35_clk_mgr_construct(
>>                 struct dc_context *ctx,
>>                 struct clk_mgr_dcn35 *clk_mgr,
>> --
>> 2.34.1
>>

