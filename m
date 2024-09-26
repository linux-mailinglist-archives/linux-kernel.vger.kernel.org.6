Return-Path: <linux-kernel+bounces-340098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F677986E89
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C069282DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05314600C;
	Thu, 26 Sep 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LV89bLfj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61291C6A1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338246; cv=none; b=lbKlKyJv2M21z/qin/S9Jm2VbTmcm38cVaV4sEru/7fEkAYAh8odMr8Cmc2zjUZlyJu+uzXaQRb445DK5HG0SRr+MgdvGcMxGkQDfQ9umVPjFwAsvOoACHyPw8JGT93s7yinUAeEd+RIESQOAdK6D4g/DnCFXxKp3wZy3WAeLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338246; c=relaxed/simple;
	bh=mpknqu/aGncqnYkzTF0IhaQtCxsVeZdJz3an7zMjF3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMOY+54sFg7NmMvspN8KNYvzdqKcDY8xpRT17sJRhrV/dkMtA30Ca+YexzWKKiyeGZNPziamGQnM8R8pjwyDm/oumYJB3WCYvX/Le8meIOvwqRxIfXwjpsZXVFEmt1o+ZPqf0qgsTj158s5oqAbO2x0fSpzrH+yQ4LDZJY88G9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LV89bLfj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727338243;
	bh=mpknqu/aGncqnYkzTF0IhaQtCxsVeZdJz3an7zMjF3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LV89bLfjwWA/vqb26BLMqbU8r1neW7dHo0j2RhNssvsPtYklWJAFsZ7kP9aOO5Tzh
	 lcOVxQM8+s70FDF5o91f6OpACrxcMEOffdbJNQ9iwz5GSno+wPov884EQ3CFeDLssw
	 nid3qZWp2QTd8gV23TLxKSMwPra8SSsW9ARnX5tOzzeqT3JV9RRJ2hK6FrJ76+VGBO
	 dwUMlCm9RPfjwnTartynuheFkkUcWeKlX8yPhYf6gZhQbrouTKhFSfaCGGJGURPIQe
	 o7iLhjoIMMXmTQG77GhDEQxGdQTTkMfwNkxXRAxWpMn9MrWO2kErd4dqAZakCYQ50f
	 BWnoK0MJq9ZMw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6415717E1048;
	Thu, 26 Sep 2024 10:10:42 +0200 (CEST)
Message-ID: <5d3e7f6f-1980-4afb-9559-ad23d5779393@collabora.com>
Date: Thu, 26 Sep 2024 10:10:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] drm/bridge: it6505: fix HDCP KSV list did not
 read correctly.
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Kenneth Hung <Kenneth.hung@ite.com.tw>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Allen Chen <allen.chen@ite.com.tw>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
 <20240926075018.22328-4-Hermes.Wu@ite.com.tw>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240926075018.22328-4-Hermes.Wu@ite.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/09/24 09:50, Hermes Wu ha scritto:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When running the HDCP CTS test on UNIGRAF DPR-100.
> KSV list must be read from DPCD with 5 byte boundary.
> 
> The original aux operation using AUX_NATIVE_READ can not read back the
> KSV list correctly.
> Change to CMD_AUX_GET_KSV_LIST operaction.
> 
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>   drivers/gpu/drm/bridge/ite-it6505.c | 46 +++++++++++++++++++++--------
>   1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 82986f28f653..143d58ed1b0e 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1188,6 +1188,35 @@ static int it6505_get_edid_block(void *data, u8 *buf, unsigned int block,
>   	return 0;
>   }
>   
> +static int it6505_get_ksvlist(struct it6505 *it6505, u8 *buf, size_t len)
> +{
> +	int i, request_size, ret;
> +	struct device *dev = it6505->dev;
> +	enum aux_cmd_reply reply;

struct device *dev = it6505->dev;
enum aux_cmd_reply reply;
int request_size, ret;
int i = 0;

> +
> +	for (i = 0; i < len; ) {

do {

> +		request_size = min_t(int, (int)len - i, 15);
> +
> +		ret = it6505_aux_do_transfer(it6505, CMD_AUX_GET_KSV_LIST,
> +					     DP_AUX_HDCP_KSV_FIFO,
> +					     buf + i, request_size, &reply);
> +
> +		DRM_DEV_DEBUG_DRIVER(dev, "request_size = %d, ret =%d", request_size, ret);
> +		if (ret < 0)
> +			return ret;
> +
> +		i += request_size;
> +	}

} while (i < len);

> +
> +	DRM_DEV_DEBUG_DRIVER(dev, "ksv read cnt = %d down_stream_cnt=%d ", i, i / 5);
> +
> +	for (i = 0 ; i < len; i += 5)

Add braces to this loop, otherwise if DRM_DEV_DEBUG_DRIVER() suddenly becomes
empty (because of some configuration option in the future, etc) you'll get build
breakages.

> +		DRM_DEV_DEBUG_DRIVER(dev, "ksv[%d] = %02X%02X%02X%02X%02X",
> +				     i / 5, buf[i], buf[i + 1], buf[i + 2], buf[i + 3], buf[i + 4]);
> +
> +	return len;
> +}
> +
>   static void it6505_variable_config(struct it6505 *it6505)
>   {
>   	it6505->link_rate_bw_code = HBR;
> @@ -1969,7 +1998,7 @@ static int it6505_setup_sha1_input(struct it6505 *it6505, u8 *sha1_input)
>   {
>   	struct device *dev = it6505->dev;
>   	u8 binfo[2];
> -	int down_stream_count, i, err, msg_count = 0;
> +	int down_stream_count, err, msg_count = 0;
>   
>   	err = it6505_get_dpcd(it6505, DP_AUX_HDCP_BINFO, binfo,
>   			      ARRAY_SIZE(binfo));
> @@ -1994,18 +2023,11 @@ static int it6505_setup_sha1_input(struct it6505 *it6505, u8 *sha1_input)
>   			down_stream_count);
>   		return 0;
>   	}
> +	err =  it6505_get_ksvlist(it6505, sha1_input, down_stream_count * 5);
> +	if (err < 0)
> +		return err;
>   
> -	for (i = 0; i < down_stream_count; i++) {
> -		err = it6505_get_dpcd(it6505, DP_AUX_HDCP_KSV_FIFO +
> -				      (i % 3) * DRM_HDCP_KSV_LEN,
> -				      sha1_input + msg_count,
> -				      DRM_HDCP_KSV_LEN);
> -
> -		if (err < 0)
> -			return err;
> -
> -		msg_count += 5;
> -	}
> +	msg_count += down_stream_count * 5;
>   
>   	it6505->hdcp_down_stream_count = down_stream_count;
>   	sha1_input[msg_count++] = binfo[0];



