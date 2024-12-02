Return-Path: <linux-kernel+bounces-427383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9C59E004C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B0B163581
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8451D1FF5F3;
	Mon,  2 Dec 2024 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DWN/MTY4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6220D4EE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138140; cv=none; b=rKEjEglQTFeOUbMxfmw61nd7IfnS/BVHxFhLnKRobPB5/N0ebmN+FodKwAQg2vAgvH6rrSsOIglmo1P/I9YmfKj0HG4jCXK6ZAXfGTO5x59Cl1FO9nOcXWx1aWO1ypfp3ABawzvHV97NRG2T16YhuNVPh03zhul1hETyWIEtQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138140; c=relaxed/simple;
	bh=/QeHhfhilziC+tKs5rk2sxAmK+nX+OWMSeuDckThBhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buoHt3bFYZZu9WxfsZQNUBqNy+6rX9u9rFYIAug2TgiHfyjMQISV6c/8J68eNcS3jok4T9H9+U0uf7bkuHeSvLWNPLkgz66ur32fifMbI9NzoUTNfKFk012s3zU64CxhJVBbL9byZu/Dl6GUJJDZbQvtsdZJ0UA9hDRzqrN2aVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DWN/MTY4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733138137;
	bh=/QeHhfhilziC+tKs5rk2sxAmK+nX+OWMSeuDckThBhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DWN/MTY457C/SwCmI3CGTfyzltOykli6cVAIUNYldKE9L9olYgYM07rclEyVrvdNE
	 WIQoaiD5+8H11j+1iMhNpv26xj06jFYYSGXXlJ5WsXdToJ35axlkSMTo89gAHhyvLS
	 hj9V6QXX3EMDW16UdFhAALx7ofCa07TlrD6fpe7Eb4SaQcF0t5ltvGKw7RYE/KFvhF
	 nSdI+pAICBHOu9g32u3i73Cd+/0VgV09IOzXa+vL6NJz/YtKmCYx+9AmaPGEp3IG4l
	 1A+Ux416DdLc87F6NtaF+3Ey+HXsc6jsBhG3Lz+lZUbULswGF33Qj8sgAxK2l0HQto
	 81k1WeN6O57dw==
Received: from [192.168.1.90] (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F04CE17E3613;
	Mon,  2 Dec 2024 12:15:36 +0100 (CET)
Message-ID: <a00ba6bb-aa91-4ecf-a4e7-88d80e29dedc@collabora.com>
Date: Mon, 2 Dec 2024 13:15:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/connector: hdmi: Add support for YUV420 format
 verification
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
 <20241130-hdmi-conn-yuv-v1-2-254279a08671@collabora.com>
 <20241202-determined-sloppy-impala-2ca0f1@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20241202-determined-sloppy-impala-2ca0f1@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Maxime,

On 12/2/24 12:50 PM, Maxime Ripard wrote:
> On Sat, Nov 30, 2024 at 01:56:33AM +0200, Cristian Ciocaltea wrote:
>> Provide the necessary constraints verification in
>> sink_supports_format_bpc() in order to support handling of YUV420
>> output format.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 40 +++++++++++++++++++++++--
>>  1 file changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> index 0cbcee7e77cd8dff387044487ce28ee5748f5587..3a55881a544a519bb1254968db891c814f831a0f 100644
>> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> @@ -3,6 +3,7 @@
>>  #include <drm/drm_atomic.h>
>>  #include <drm/drm_connector.h>
>>  #include <drm/drm_edid.h>
>> +#include <drm/drm_modes.h>
>>  #include <drm/drm_print.h>
>>  
>>  #include <drm/display/drm_hdmi_helper.h>
>> @@ -114,6 +115,12 @@ sink_supports_format_bpc(const struct drm_connector *connector,
>>  		return false;
>>  	}
>>  
>> +	if (drm_mode_is_420_only(info, mode) && format != HDMI_COLORSPACE_YUV420) {
>> +		drm_dbg_kms(dev, "%s format unsupported by the sink for VIC%u.\n",
>> +			    drm_hdmi_connector_get_output_format_name(format), vic);
>> +		return false;
>> +	}
>> +
>>  	switch (format) {
>>  	case HDMI_COLORSPACE_RGB:
>>  		drm_dbg_kms(dev, "RGB Format, checking the constraints.\n");
>> @@ -144,9 +151,36 @@ sink_supports_format_bpc(const struct drm_connector *connector,
>>  		return true;
>>  
>>  	case HDMI_COLORSPACE_YUV420:
>> -		/* TODO: YUV420 is unsupported at the moment. */
>> -		drm_dbg_kms(dev, "YUV420 format isn't supported yet.\n");
>> -		return false;
>> +		drm_dbg_kms(dev, "YUV420 format, checking the constraints.\n");
>> +
>> +		if (!(info->color_formats & DRM_COLOR_FORMAT_YCBCR420)) {
>> +			drm_dbg_kms(dev, "Sink doesn't support YUV420.\n");
>> +			return false;
>> +		}
>> +
>> +		if (!drm_mode_is_420(info, mode)) {
>> +			drm_dbg_kms(dev, "Sink doesn't support YUV420 for VIC%u.\n", vic);
>> +			return false;
>> +		}
>> +
>> +		if (bpc == 10 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_30)) {
>> +			drm_dbg_kms(dev, "10 BPC but sink doesn't support Deep Color 30.\n");
>> +			return false;
>> +		}
>> +
>> +		if (bpc == 12 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_36)) {
>> +			drm_dbg_kms(dev, "12 BPC but sink doesn't support Deep Color 36.\n");
>> +			return false;
>> +		}
>> +
>> +		if (bpc == 16 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_48)) {
>> +			drm_dbg_kms(dev, "16 BPC but sink doesn't support Deep Color 48.\n");
>> +			return false;
>> +		}
>> +
>> +		drm_dbg_kms(dev, "YUV420 format supported in that configuration.\n");
>> +
>> +		return true;
> 
> We also need to check whether the source supports it or not.

I assumed the following check does already handle that:

	if (!(connector->hdmi.supported_formats & BIT(format))) {
		drm_dbg_kms(dev, "%s format unsupported by the connector.\n",

Is there anything else missing?

Thanks,
Cristian

