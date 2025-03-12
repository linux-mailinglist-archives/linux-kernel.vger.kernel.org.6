Return-Path: <linux-kernel+bounces-557180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A8A5D49C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F7A67AAE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B718FC75;
	Wed, 12 Mar 2025 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A0Ki10Pk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D379EA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748789; cv=none; b=XGdxIO27RQ8qQYRMcAQhz4wCJ+TU/gBqNqs1nqkwtTnLVQnNzd/oITsYRMTtFcGVOSCs17SbmftbXPulxToStANbTjv1u16K02zjqsD6+N8/xpHha1z4qJFttexuFVfveUmcQBDbFNr3TUVnu9wbDkG8daMoW4h5p7oRdGo5Yz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748789; c=relaxed/simple;
	bh=NxWtveOedIz2/jaXP/aZXRUu4jabOktCckMz34Uj7Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z00+avGA/rqe7twdy5xbkaRlJxqXQWtWmLPmtbKhGmMuyNpl1n9EWsGyU7J5KVynRTrk2nEAutcwBRAkS0wWTokDuVeyrKGiLB86R/32TQGvkpKBxBFpP7susWwKTofcsusb7fGzA5aOcwGFrmS6w50mcOZ8MBrpuBNxNxhJti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A0Ki10Pk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741748785;
	bh=NxWtveOedIz2/jaXP/aZXRUu4jabOktCckMz34Uj7Wg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A0Ki10PkPRnhNcY+anxDKfZ6/+s2M3nM0tBtcH7SIcFvRM2pf3mzc1t3WEEp6PoBG
	 9gh1djWyHlPuYdu1XEJ+8HxyJvIkmYpLtp2Fi6a820oCDu5GNVNWmMAWPqWPyjsF7Z
	 4yVrqTCl/ZpxkWv0hZkfS38a7NREG/0MEO2aZT/4OiLleER18KpRSewwvEy5K4JVf8
	 mVcYSm4SVtVdh4ExCP4/vycPqc5dMhNsMN330824cfrSx+0+lVKywZ3fjWrA9rCo/u
	 08uhM2tVLp05OESS9mS+Cl2NM/xaBhq/XQINnVE1w/pnKbdGqAaiDFsV1FR4ZnR7mU
	 vFq+wstPl6pwQ==
Received: from [192.168.50.250] (unknown [171.76.87.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E94E17E0F83;
	Wed, 12 Mar 2025 04:06:22 +0100 (CET)
Message-ID: <46f78829-a65a-4cd9-b35a-7608e547096d@collabora.com>
Date: Wed, 12 Mar 2025 08:36:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] drm/ci: enable lockdep detection
To: Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 robdclark@gmail.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, valentine.burley@collabora.com,
 jani.nikula@linux.intel.com, dmitry.baryshkov@linaro.org,
 mripard@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org
References: <20250217053719.442644-1-vignesh.raman@collabora.com>
 <CAPj87rNUMDMUtrfV=8c_+T5VQ0FykjpR5JW5dgO4grYXpabSdQ@mail.gmail.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAPj87rNUMDMUtrfV=8c_+T5VQ0FykjpR5JW5dgO4grYXpabSdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 10/03/25 13:53, Daniel Stone wrote:
> Hi Vignesh,
> 
> On Mon, 17 Feb 2025 at 05:37, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>> This patch series enables lockdep detection in drm-ci. Any lockdep
>> failures will be shown as warnings in the pipeline. This series
>> also enables CONFIG_DEBUG_WW_MUTEX_SLOWPATH for mutex slowpath
>> debugging and refactors software-driver stage jobs.
>>
>> Test run with this series,
>> https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1366054
> 
> Series is:
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> 
> Please merge at will.

applied to drm-misc-next

Regards,
Vignesh

> 
> Cheers,
> Daniel


