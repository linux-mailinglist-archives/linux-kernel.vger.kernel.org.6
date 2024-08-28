Return-Path: <linux-kernel+bounces-305324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B8E962CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F9AFB2138D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551921A38EA;
	Wed, 28 Aug 2024 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OMkBP1Bz"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845815B12F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860068; cv=none; b=HMrZwhU9GDg3X/fPQ2UcZGg67W2j4Ho0R8lF4Sl09oTNWaOL9cUz+/CtzVOwbHz1TtrO3nKE/Ki0U0EAB8wG1y/tCAuNyx2rkoE33/8V+T6KTa2tBrvnAaJVo5yhx7fbWMfs5Mr6kQt09Ji4axP7BDjEdhBUFwsBNjcXFeCdZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860068; c=relaxed/simple;
	bh=+eDNQvy/mIUBT2nppQrAVs+/fqkckiZ4bdjuGe4a45g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqHukGBfMsf6gRfIrej9oSnqFE4ZcjYiyTuPTAkqJMN70UJjBiNxFn+0ljLD9Z5u1XzgnxA4cLMvVLie4KoUlc7diVTEoa+jReRyudhB66bDgWC2OKXWvxk5/M//M9DyJh5A43xGjJshn9e1w/G+/VNo3uD4EVD37j2Z6uusUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OMkBP1Bz; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1724860033;
	bh=SJgbPbqzc7SahFIo0tT8HzBFaK2pKFosnheCBPu7Z8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OMkBP1BzHq7Nydk+9qgbCnMk/mSPMlQIEdw/yh+p3YeL9DoH0nDbVXSsRJmhLV2V3
	 kXZS0VHLXhGM0fk0IlbaNI0vw2qGTFiMJenkiG0AIYcd2S5zYXer0uJVfxtpEbClGF
	 3CSTqqfFET7B/Iouom+1WJmbd7RR8nXOychGKP6g=
X-QQ-mid: bizesmtp82t1724860025tr78hzhh
X-QQ-Originating-IP: NBBWYtTDQvWJrkvX2ybfoykKoh0AM7tmnMshH1rKKO0=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 28 Aug 2024 23:47:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11183564941434698686
Message-ID: <D25D5E6FB683DA94+808c82a3-546f-4289-b531-fa24d7278879@uniontech.com>
Date: Wed, 28 Aug 2024 23:47:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: disable amdgpu_dpm on THTF-SW831-1W-DS25_MB board
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, lijo.lazar@amd.com,
 mario.limonciello@amd.com, le.ma@amd.com, Jun.Ma2@amd.com,
 hamza.mahfooz@amd.com, andrealmeid@igalia.com, wenlunpeng@uniontech.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, guanwentao@uniontech.com, zhanjun@uniontech.com
References: <3EA7C2B9E8C4D00A+20240828105938.37674-1-wangyuli@uniontech.com>
 <CADnq5_P42A81D_VufAdSkwVwC08ZRiT=6XAS3oHmSH325ygbow@mail.gmail.com>
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
Disposition-Notification-To: WangYuli <wangyuli@uniontech.com>
In-Reply-To: <CADnq5_P42A81D_VufAdSkwVwC08ZRiT=6XAS3oHmSH325ygbow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1


On 2024/8/28 23:30, Alex Deucher wrote:
> On Wed, Aug 28, 2024 at 7:28 AM WangYuli <wangyuli@uniontech.com> wrote:
>
> This will disable dpm on all devices that you might install on this
> platform.  If this is specific to a particular platform and board
> combination, it might be better to check the platform in the
> dpm_init() code for the specific chip that is problematic.
> Additionally, disabling dpm will result in boot clocks which means
> performance will be very low.
>
> Alex

This motherboard model doesn't have combinations with different 
platforms or chipsets now.Their model numbers are unique,so it seems 
unnecessary to add extra judgment.


-- 
WangYuli


