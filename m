Return-Path: <linux-kernel+bounces-557038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F9FA5D2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C324F17A8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB122248B4;
	Tue, 11 Mar 2025 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bzASpKvK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C41E832A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741733697; cv=none; b=bRolyGfnVYyri3RxvJfdxRH51GO/WGspj/SAQyzSoHHGBVNUZaAZTwyIbIw+xIi9AToy5aQ+vOETeDAJwb1tgkbww4+OboMJqU2xbfU+M2eImg2VfAL0rv68B1pwZ72l88VButOph0KMO0o+gSIihP8czRQAly8J9/bbAFaL4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741733697; c=relaxed/simple;
	bh=5uCN2gUnMqBRLUI12+yMuoFkydjgSvocO+L4xvTi56s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEEKDmdtWEYBvyuq0DsgBABQos8Xq1ICQ7J43+KUapibXfgdEW5yzL1Rqze7q1F62ZHGbnPdAG4FzAF3JN3/KX0lGDC6CpXL5YmPeUuAL3I07Lcw74GTTRJ+BtWPoq+Hk+gEJOfVIyrFsA7XFbak6viiofue24M0fa/YU1XAkm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bzASpKvK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741733693;
	bh=5uCN2gUnMqBRLUI12+yMuoFkydjgSvocO+L4xvTi56s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bzASpKvK25uoUGW+Pws4jdhJSUP40zBblTM5G3N0hBfzA5HHc0WLhyoSWFjPrw1bF
	 fcqVuipGmxTyWCYsNECQ2YLt+N6q9kLJi0l1LqzCoqmQp6rGLoG6EOQ/EZZfsSZvbr
	 X8in7klZsQUKfYsSF7cwD0CvFenZWpLA0+QW+HYnino5c0Md10YqfTVZoSimK3jBQG
	 4/BTyQOcUMXDHfhkz5gzhPLZRzr+JnPFAB/2h93gRvVBWxGYyIY68/6CH+xFAdT4Mr
	 x912XA8P1E6ti8RLOTvF5EZs3ooE1sSpj+0oPqI4DLPmDOeq4wlXxMHFsBTtbpGlX5
	 qjbngGQfzW34w==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 10CC117E05A6;
	Tue, 11 Mar 2025 23:54:53 +0100 (CET)
Message-ID: <dca413e0-bad5-485d-9c77-402d806e97a5@collabora.com>
Date: Wed, 12 Mar 2025 00:54:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drm/tests: hdmi: Add limited range tests for
 YUV420 mode
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-6-fbdb94f02562@collabora.com>
 <20250311-burgundy-cat-of-diversity-b89681@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20250311-burgundy-cat-of-diversity-b89681@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 6:17 PM, Maxime Ripard wrote:
> On Tue, Mar 11, 2025 at 12:57:38PM +0200, Cristian Ciocaltea wrote:
>> Provide tests to verify that drm_atomic_helper_connector_hdmi_check()
>> helper behaviour when using YUV420 output format is to always set the
>> limited RGB quantization range to 'limited', no matter what the value of
>> Broadcast RGB property is.

[...]

> We need more tests than that to test the various combinations, whether
> the fallback to YUV420 should work or not depending on the EDID, the
> driver capabilities, YUV420-only vs YUV420-also, etc.

Some fallback tests were provided in the next patch, including checks like:

  KUNIT_ASSERT_TRUE(test, drm_mode_is_420_only(info, yuv420_only_mode));
  KUNIT_ASSERT_TRUE(test, drm_mode_is_420_also(info, preferred));

I'll try to further extend the test coverage.

Regards,
Cristian

