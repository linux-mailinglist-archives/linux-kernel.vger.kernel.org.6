Return-Path: <linux-kernel+bounces-265162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3F93ED74
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05D51C21BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2505B84E04;
	Mon, 29 Jul 2024 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tDoLvKKU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC3328B6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234486; cv=none; b=a0Hux8X7QlTRbJOs6lWzt2sxiAtzoBTjjO2OGzteE/wPKTuO7g+BP5W26Hmb+SGg1Z+XBFK26ooxKf/dvCuoTrAM7bqlxymiMEdy4CsX1Zws4mw52Cxxo0W522CO6+E0XXUYDniKXi59szPIAMGuNr5bcNIu/3X3eDDoLzvW1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234486; c=relaxed/simple;
	bh=c2Gb33yB6AGUPL7oB/bVbgijksIJQN8Vp6pPt6OQkXg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UoXT94cSIOwVNsCWPEVu94SUdEkZbwZYUw4o/rMg9+fAdcEqCEEY+cWSZjeXhh8wOgT4fYzhVfAfcF6p2IGduy3A1ThOO/geCaaelTaiLv8R837bDHyUuivVs5HpLgBZv1tTrazZe0+ivXsAHEGMQGzTU/mXQJDPCOaPB44bUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tDoLvKKU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722234477;
	bh=c2Gb33yB6AGUPL7oB/bVbgijksIJQN8Vp6pPt6OQkXg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=tDoLvKKUFH90Zfy4QS9BC3Q8oXlzM1iVsd4bWvx+NrYo5aa8ZvMRU2X2Dgo1TCwOl
	 BrHmLD8BRYw0WHcQcvtoe7SXbJgoEM2gZDOsQMvKuE+mB3sZZsunKwZAsNrxb5oToT
	 xp/gqCD456E+Fmlcab15zjZvWCR/uqFji4qV0cXAHOl+V/sCCyeth2nJFCBliEedPH
	 NghPSHqqMnUCfBz8fN0tYaRTOtrQs0DC2iyAzuc/vYlHVifRpsbyapUvaFI8Qg0yLX
	 iYBqqMx7MOF2v1kVu41W33xUHRkYViJbxDucAPR9b3K9TXQZ8mdwQGk8pv1vnhtDkv
	 zRe6Pf/5xmm2Q==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 51D4D37813E1;
	Mon, 29 Jul 2024 06:27:54 +0000 (UTC)
Message-ID: <c790e122-c656-4f2c-8f1d-6e405fc70233@collabora.com>
Date: Mon, 29 Jul 2024 11:57:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] drm/ci: rockchip: add tests for rockchip display
 driver
From: Vignesh Raman <vignesh.raman@collabora.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 deborah.brouwer@collabora.com, robdclark@gmail.com,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240724101015.523535-1-vignesh.raman@collabora.com>
 <20240724101015.523535-6-vignesh.raman@collabora.com>
 <CAPj87rMJUSRJ9G1uv-w5a_4qqS0R1dDaUEofoJf=ehbMszdfOw@mail.gmail.com>
 <27bd3884-51d8-454f-9ddc-6b5765fd744b@collabora.com>
Content-Language: en-US
In-Reply-To: <27bd3884-51d8-454f-9ddc-6b5765fd744b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 26/07/24 15:37, Vignesh Raman wrote:
> Hi Daniel,
> 
> On 26/07/24 13:06, Daniel Stone wrote:
>> Hi Vignesh,
>>
>> On Wed, 24 Jul 2024 at 11:12, Vignesh Raman 
>> <vignesh.raman@collabora.com> wrote:
>>> For rockchip rk3288 and rk3399, the display driver is rockchip
>>> and gpu driver is panfrost. Currently, in drm-ci for rockchip
>>> rk3288 and rk3399, only the gpu driver is tested. Refactor
>>> the existing rockchip jobs to test both display and gpu driver
>>> and update xfails.
>>
>> Could you also please add RK3588 in a new series (no need to hold this
>> one up), with Rockchip KMS and Panthor GPU? You can use the
>> rk3588-rock5-b device type in LAVA.
> 
> Sure. I Will add and send it in a new series.
> 
>>
>>> diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt 
>>> b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
>>> index cf3a747f7cec..826cca5efbff 100644
>>> --- a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
>>> +++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
>>
>> This is in the wrong patch?
> 
> Yes, this needs to be dropped. Thanks for pointing that out.
> 
>>
>>> +++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
>>> @@ -0,0 +1,71 @@
>>> +# Suspend to RAM seems to be broken on this machine
>>> +.*suspend.*
>>> +
>>> +# Too unstable, machine ends up hanging after lots of Oopses
>>> +kms_cursor_legacy.*
>>> +
>>> +# Started hanging the machine on Linux 5.19-rc2:
>>> +#
>>> +# [IGT] kms_plane_lowres: executing
>>> +# [IGT] kms_plane_lowres: starting subtest pipe-F-tiling-y
>>> +# [IGT] kms_plane_lowres: exiting, ret=77
>>
>> ret 77 is a pure skip here, as you'd expect from a pipe F test,
>> because Rockchip doesn't have six CRTCs.
>>
>>> +# Console: switching to colour frame buffer device 170x48
>>> +# rockchip-drm display-subsystem: [drm] *ERROR* flip_done timed out
>>> +# rockchip-drm display-subsystem: [drm] *ERROR* [CRTC:35:crtc-0] 
>>> commit wait timed out
>>> +# BUG: spinlock bad magic on CPU#3, kms_plane_lowre/482
>>> +# 8<--- cut here ---
>>> +# Unable to handle kernel paging request at virtual address 7812078e
>>> +# [7812078e] *pgd=00000000
>>> +# Internal error: Oops: 5 [#1] SMP ARM
>>> +# Modules linked in:
>>> +# CPU: 3 PID: 482 Comm: kms_plane_lowre Tainted: G        W         
>>> 5.19.0-rc2-323596-g00535de92171 #1
>>> +# Hardware name: Rockchip (Device Tree)
>>> +# Process kms_plane_lowre (pid: 482, stack limit = 0x1193ac2b)
>>> +#  spin_dump from do_raw_spin_lock+0xa4/0xe8
>>> +#  do_raw_spin_lock from wait_for_completion_timeout+0x2c/0x120
>>> +#  wait_for_completion_timeout from drm_crtc_commit_wait+0x18/0x7c
>>> +#  drm_crtc_commit_wait from 
>>> drm_atomic_helper_wait_for_dependencies+0x44/0x168
>>> +#  drm_atomic_helper_wait_for_dependencies from commit_tail+0x34/0x180
>>> +#  commit_tail from drm_atomic_helper_commit+0x164/0x18c
>>> +#  drm_atomic_helper_commit from drm_atomic_commit+0xac/0xe4
>>> +#  drm_atomic_commit from drm_client_modeset_commit_atomic+0x23c/0x284
>>> +#  drm_client_modeset_commit_atomic from 
>>> drm_client_modeset_commit_locked+0x60/0x1c8
>>> +#  drm_client_modeset_commit_locked from 
>>> drm_client_modeset_commit+0x24/0x40
>>> +#  drm_client_modeset_commit from drm_fbdev_client_restore+0x58/0x94
>>> +#  drm_fbdev_client_restore from drm_client_dev_restore+0x70/0xbc
>>> +#  drm_client_dev_restore from drm_release+0xf4/0x114
>>> +#  drm_release from __fput+0x74/0x240
>>> +#  __fput from task_work_run+0x84/0xb4
>>> +#  task_work_run from do_exit+0x34c/0xa20
>>> +#  do_exit from do_group_exit+0x34/0x98
>>
>> So this is pointing to the error being that, when a client exits, the
>> kernel attempts to restore fbdev and then it's broken. Pinning
>> pipe-F-tiling-y as specifically responsible for this seems quite odd
>> to me, given that it doesn't do anything but only skips. Is that maybe
>> just because it's the last test running in the kms_plane_lowres group
>> before it exits? Or does it occur more wildly on other test groups?
> 
> This was skipped for Linux 5.19-rc2. I will remove from skips and will 
> check the behavior.

This is for panfrost driver (rk3288). All kms tests are skipped for 
gpu-only driver. Will remove the other kms tests in this file as we have
separate skips file for rockchip driver now.

>>
>>> +tools_test@tools_test,Fail
>>
>> I keep noticing this failing everywhere. What's up with that? Have you
>> reported these logs to the igt list?
> 
> I will check this issue and report to igt developers.

tools_test is a wrapper for running tools/intel_reg and 
tools/intel_l3_parity. So skip these tests on non-intel platforms.


Regards,
Vignesh

