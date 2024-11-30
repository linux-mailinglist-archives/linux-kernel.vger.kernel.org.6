Return-Path: <linux-kernel+bounces-426415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBBB9DF2BC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 20:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC445280D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E46B1A9B3E;
	Sat, 30 Nov 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WPQTCV2v"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3C132103
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732993534; cv=none; b=X3ufzCJrH+oW3c/rO6F+BNUpOZnAryjPYRuwifrtIwXvocLf/rq5pe5R31pGnVL0dBpk0OkLi5RAIT6f202A52L91a2VjW7mWhlYyRNsxrDSdtX7+3ilaRk5z+na6pF+7wZ/qrfWdustGA5pQ2UeEvjxbfUg1+Bi+k35YSYCLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732993534; c=relaxed/simple;
	bh=ek7RYw4xwoblLAdujwbp98Ocgk+BFMHHW7AT1mVVMPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wrw6Mm0lnUT1833GIiYL5OL8tgbV7snPhSlP9q2jiObgFFLOVK5ViGSYp7uk0lSJz2qNPqAuUPB+kftVjey358BZKwkwJzZVyVD0/R26pLV2+g4TseSwkmYVMzBMRInD86ZzcfqEAV/2n33bFL7oGDr2Kl2zlRMe1+VGeOyJDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WPQTCV2v; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732993530;
	bh=ek7RYw4xwoblLAdujwbp98Ocgk+BFMHHW7AT1mVVMPM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WPQTCV2vOisCQKF9yGCv5IBGziCapwnmPdq+DL1aWJ5mBdkef2AsWBAVXKN0+gUuB
	 UBDJ7qbvWLGFYgXRB5WMImheW6xO/pmpqg2S9VemtfshUfF/uj8w02yJPZ8z5CYqQm
	 AVcF+Vfbx/94H0YAf6H7B9DsKTdalBeiNNyyH9UOXEIMLYExy1Q02GmqLJqkRRMsiH
	 A+OGDzTUoGEjCmCJfjNehv21ZCDzSldoWVckB2eLPGPT5/gpqD3YnFfVSFLWArOsVA
	 96W/UEg6zryf+vex9wAbMKphy/bX7uiStkPXDXoyqi9QDoDcukbi8q0JnHQmlipGaD
	 jYw3vihyvP3Hg==
Received: from [192.168.1.90] (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 90CBD17E37C5;
	Sat, 30 Nov 2024 20:05:30 +0100 (CET)
Message-ID: <ca8c796e-fa89-412e-acdc-2515efeb6ca5@collabora.com>
Date: Sat, 30 Nov 2024 21:05:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drm/connector: hdmi: Allow using the YUV420 output
 format
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
 <6hcjgagu7hvbnn6rp5znwjxeaa6wqkeecgvvqkzvtma2ni6mfz@lrbmtbogkzgm>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <6hcjgagu7hvbnn6rp5znwjxeaa6wqkeecgvvqkzvtma2ni6mfz@lrbmtbogkzgm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/24 10:38 AM, Dmitry Baryshkov wrote:
> On Sat, Nov 30, 2024 at 01:56:31AM +0200, Cristian Ciocaltea wrote:
>> Provide the basic support to enable using YUV420 as an RGB fallback when
>> computing the best output format and color depth.
> 
> The HDMI Connector functionality has pretty good KUnit coverage. Please
> expand KUnits to cover your patches too.

Sure, will handle this in v2.

Thanks for reviewing,
Cristian

