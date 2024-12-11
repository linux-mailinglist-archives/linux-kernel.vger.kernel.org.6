Return-Path: <linux-kernel+bounces-442288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246499EDA40
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE04167A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AF31F2C2D;
	Wed, 11 Dec 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AotVFeh7"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2B1F2399
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956577; cv=none; b=n4+w2BZ/5ktP3R9CSdyY3nokNz9mNE/ldaIZ8mGPByATN6ZsfaxpJ2Eh+P+tcFmGg//P19R8sN5jFz1zks12IFF5BqOhGmGslZWvGjLa6635v4EmPASrMjmv5XjoHPWndBUXL6ah6L/OWgYq6kXLk39HxeAkdrJeB2AnoQWalfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956577; c=relaxed/simple;
	bh=46uNigFnqQ+HGjFJ1/cgRpYGSgDGzUb7F5mIc33pXPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5ICT2U+0qsD3WHtgJ/VzFz9yS/axRKcXWcusiWdEoK4mLhQCLtmIXSkampPunWtLXjeqyxnuebatdM0dMlLm/ZGYM05BPwEAw7ToUfi4Z1T2d7L5M8OWSUDDvSVsKih4QKIPlvPRYW0ksxKubqvpM61CgCKaARhkWE/awtO4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AotVFeh7; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0Z5EkRMXSAAd6VugPHXUkDoDDuWALwNmWHDkbsYItPc=; b=AotVFeh7Uqefi7l5uxK5YZHyxa
	LJqoG7294B3siZZpD5zpe1Trm8d4i4ZBxNwapkO6TuelRgWreIJkHj6Lc8G6hHTJIJ+jFzokKg9kE
	XLBjBZGlZwbBSVh9C5pSBXyjDlUcwKETMbMrkap0J2DlitMy2g9Rg2oKDJ+O7GGxSVYFMzcHQ9Lk2
	yrHvPIhqhkAXpdFHM6rmE/w6TCqQ5v2KvCtvoN1iwA8mPl4LREPlr99zmhDCPe4M5mh5G46FDrT2w
	gfTjqDi+YwTDPNOM+o1bGL0gYOfAR/8D6y4WznmkH2KPVettO1IUwoh63VZBF5F4VmO9fLvRnH/ga
	smdqt0Sg==;
Received: from [179.118.189.35] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tLVJ1-0025cH-AI; Wed, 11 Dec 2024 23:35:43 +0100
Message-ID: <6221fc3d-0b1a-4e91-9e34-a32f3c77b63f@igalia.com>
Date: Wed, 11 Dec 2024 19:35:36 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/2] drm/atomic: Ease async flip restrictions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, Simon Ser <contact@emersion.fr>,
 joshua@froggi.es, Xaver Hugl <xaver.hugl@gmail.com>,
 Daniel Stone <daniel@fooishbar.org>, ville.syrjala@linux.intel.com,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20241211-tonyk-async_flip-v10-0-6b1ff04847c2@igalia.com>
 <ouyulceg7zrnjirg2yf4qbgp5pfovz4y6hq5v6e573yx7ih5qe@uqqne6yq27wl>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <ouyulceg7zrnjirg2yf4qbgp5pfovz4y6hq5v6e573yx7ih5qe@uqqne6yq27wl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dmitry,

Em 11/12/2024 16:35, Dmitry Baryshkov escreveu:
> On Wed, Dec 11, 2024 at 12:25:07AM -0300, André Almeida wrote:
>> Hi,
>>
>> The goal of this work is to find a nice way to allow amdgpu to perform
>> async page flips in the overlay plane as well, not only on the primary
>> one. Currently, when using the atomic uAPI, this is the only type of
>> plane allowed to do async flips, and every driver accepts it.
>>
>> This patchset re-uses the per-plane function atomic_async_check() to
>> this purpose, so drivers can allow different plane types. There's a
>> `bool flip` parameter so the atomic_async_check() can do different
>> decisions if it's a complete page flip or a plane update.
>>
>> igt test: https://lore.kernel.org/igt-dev/20241211031820.115844-1-andrealmeid@igalia.com/
>>
>> Changelog
>>   v9: https://lore.kernel.org/r/20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com
>>   - Add a 'flip' flag to indicate where the atomic_async_check() is being called from.
> 
> I think something went wrong. There is no changelog for v10 and also no
> tags that you've got for v9.
> 

I have type the numbers wrongly, this is the changelog for v10, but I 
forgot the tags, I will send a v11 with the correct changelog and tags.

Thanks!


