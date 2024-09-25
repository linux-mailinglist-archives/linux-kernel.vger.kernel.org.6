Return-Path: <linux-kernel+bounces-338200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E9A9854AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20551C22D13
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB10157E78;
	Wed, 25 Sep 2024 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ijiJ2y4S"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04715575D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250969; cv=none; b=aUGqdmYvg5y9FPK7tvHX3nkTnvT7zHAkXFWzovcm3bPYRgkJeYW91Iz4aL4ueY5/U0Qd7MbdAg8Usw/ANsYkX9F1Jxv2+2L/Wke9qYl/MoTY0h7nbz9swFZSMjGxKc6mJPUgIUan1P9Hf24QOSAwgHVpQco2Hz8m4RzpP5k3I44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250969; c=relaxed/simple;
	bh=8rBq9ww54YFGlOfKO4Zl+DxnCSha2HMVZu4m+AA1R5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2q3uV2e83X1ektt6eOXGbpbcBiUu8RDCR0SVc43RyGUX1j1ysX8q79epNN0ssH+9lld/g0wLiipBazDVte8PjMOZ0hnxuZDXAL9snqFbgUXla0KXv+J7AXs/TN5vt1d9QCJKBQt19d1kdOXzQWDJGGiw2EDFvXpe0vgbzQtRUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ijiJ2y4S; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XD8Df6zQKz9vPn;
	Wed, 25 Sep 2024 09:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1727250963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onVo/v24+EbC9FlkeB86Dyfwrerky1m5SM4rsIpdSWo=;
	b=ijiJ2y4ST/2YlAhQl7ZFhLMvzwlICXfqsvrErN1CS3H/k8cNKbx+iLaTE5TrKN4kOAXa6B
	npjt6AGLzrOFnWvhFKzT8qiufPo5U1bf3zoujvK1VgekRe3GtoP5LPzEjFzg42Ad7UuTyc
	FHfE6MS3eBAFJefOshtzRZZoH7Vz7qT06pOppIShigfRfRTV0zxwg21nskaMLrLwp3D1G3
	Oi/3Kv+SluuDzHuhUwiNeFmCje8oMAhMvVjG2MUP0ekTFMEQQ/TeQho9OLMEo/n81C6vOc
	gXURhWGN3A/AmnIvuJioo7/myuZYGwfOEZ+kn/UHuznackaohv5XWmqGgqcexw==
Message-ID: <00d08df9-346c-4710-8c08-615ba78b1bfc@mailbox.org>
Date: Wed, 25 Sep 2024 09:55:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
To: Alex Deucher <alexdeucher@gmail.com>,
 Jocelyn Falempe <jfalempe@redhat.com>
Cc: Lu Yao <yaolu@kylinos.cn>, ckoenig.leichtzumerken@gmail.com,
 daniel@ffwll.ch, Xinhui.Pan@amd.com, airlied@gmail.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, srinivasan.shanmugam@amd.com,
 sunil.khatri@amd.com
References: <20240802071752.116541-1-yaolu@kylinos.cn>
 <20240812060914.102614-1-yaolu@kylinos.cn>
 <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
 <16352ae0-7e61-440d-8c04-7ec912f9bf9a@redhat.com>
 <CADnq5_O7njHcvu0ejvVPPKF7szsbEQ8oFfHr9GTyD+zAe2EJ8g@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA, de-CH-frami
In-Reply-To: <CADnq5_O7njHcvu0ejvVPPKF7szsbEQ8oFfHr9GTyD+zAe2EJ8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b788623744381aa2b1c
X-MBO-RS-META: kfh9ss8g1pu87zd81xepx9byrc1scg7k

On 2024-09-24 16:02, Alex Deucher wrote:
> On Fri, Sep 20, 2024 at 11:36 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> On 17/09/2024 15:21, Alex Deucher wrote:
>>> On Mon, Aug 12, 2024 at 2:10 AM Lu Yao <yaolu@kylinos.cn> wrote:
>>>>
>>>> Add support for the drm_panic module, which displays a pretty user
>>>> friendly message on the screen when a Linux kernel panic occurs.
>>>>
>>>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
>>>
>>> Patch looks good to me.  Any chance you want to convert the other
>>> non-DC dce files (dce_v8_0.c, dce_v10_0.c, dce_v11_0.c) while you are
>>> at it?
>>
>> I've made a similar patch in amdgpu_dm_plane.c, and it works on a Radeon
>> pro w6400.
>> But it only works when I'm in a VT terminal (so the framebuffer is
>> linear and CPU accessible).
>> When under Gnome/Wayland, the flag AMDGPU_GEM_CREATE_NO_CPU_ACCESS is
>> set, so that means I can't vmap it ?
> 
> It just means that the application does not need CPU access.  Whether
> or not the CPU can access the buffer or not depends on the size of the
> PCI BAR.  E.g., if the driver or bios has resized the PCI BAR, then
> the CPU can access the entire BAR, but if not you are generally
> limited to the first 256M of framebuffer.

FWIW, it's also possible to access all of VRAM via MMIO indirect registers. That'll be slower than a direct CPU map, it might be acceptable for drm_panic though, at least as a fallback.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

