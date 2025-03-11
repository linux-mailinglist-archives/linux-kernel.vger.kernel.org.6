Return-Path: <linux-kernel+bounces-556775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A54BA5CE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C8A3B266C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCC0263F30;
	Tue, 11 Mar 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iE433v9L"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447871E4928
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719547; cv=none; b=dKwSHp9wg+1PevaM+XKWr1s5cu6gJN+n3sDH2Suw5BvvpxPvQnbuvcqGXw6RqcxgBTOAGhD0n751BJZSf9Ss4jyeuuuEt9Fdcl6SXkBhYx0MZP3N90HOeGwS3YhIbvLjYpoYCXVxvCBLTXx+tXJRnnXADVGFvd20WdpMjP/GiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719547; c=relaxed/simple;
	bh=g9Dr5RFwe+3748yvUldOlrbFsi1pIRousif7xhhE6jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMzLrxtRy7QsA1WptThwdqJbSk87Xm+L0iLv8fKmpauB56B5l9mn4JISdw8YHCs9ho3/0f6aNhKldoFxWB432D8WgdcESX8aEXlsdSYTFg5350Rx5UqSDjxyKk5Wt9hno9x2MOss7tNmJKh0gQF3oJ8OnPRZuazUOqSuU8El8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iE433v9L; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741719543;
	bh=g9Dr5RFwe+3748yvUldOlrbFsi1pIRousif7xhhE6jo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iE433v9LI/VjSUbp5aw18W2Pk3m+DjCiSgoHjZmyKmr6aYUFg+4KkAjo9T6lZ0Hll
	 0BCCleFBneP9HscjH3EO0xe4FtuVDNpPvse/Oc2aEr2qG9eMEtAR+pZfuClABCyJDz
	 gWcFkjbojwRcDaESnrJQnp/o8rnbYyFz1yVBzPqbLD9dXC9hBO/HA2FelBhk05BiTA
	 NoU5YwWnDRijekqDWUniBXDUmO5uodZp6wSYD8qDExKIDyNGWRtkB1uVVeov/6+ZXD
	 /41JJnV9EnMHzpTku8tYe4BjDvCgkTk3fbVHNjT9rdMnMNLcqLhYv7kkrwRh6w1Cr0
	 mvzUBXn0MOXyQ==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B5D3817E0657;
	Tue, 11 Mar 2025 19:59:02 +0100 (CET)
Message-ID: <c6f4233f-4a66-44c2-b962-9c80352bb7e1@collabora.com>
Date: Tue, 11 Mar 2025 20:59:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/connector: hdmi: Use YUV420 output format as
 an RGB fallback
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-4-fbdb94f02562@collabora.com>
 <20250311-hypersonic-mature-leopard-d3afdc@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20250311-hypersonic-mature-leopard-d3afdc@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Maxime,

On 3/11/25 5:55 PM, Maxime Ripard wrote:
> Hi,
> 
> I think the first thing we need to address is that we will need to
> differentiate between HDMI 1.4 devices and HDMI 2.0.
> 
> It applies to YUV420, which is HDMI 2.0-only, and I guess your patches
> are good enough if you consider YUV420 support only

Yes, my intention was to get the very basic support for now.

, but scrambler setup
> for example is a thing we want to support in that infrastructure
> eventually, and is conditioned on HDMI 2.0 as well.

Right, the scrambler setup is actually among the next tasks I'll focus on,
e.g. this is still missing on dw-hdmi-qp side and I got it reworked a bit
according to your initial review.  It would probably make sense for me to
submit that and get some feedback before attempting to go for a generic
approach (still need to do a few more checks/improvements before).

> On Tue, Mar 11, 2025 at 12:57:36PM +0200, Cristian Ciocaltea wrote:
>> Try to make use of YUV420 when computing the best output format and
>> RGB cannot be supported for any of the available color depths.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 69 +++++++++++++------------
>>  1 file changed, 35 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> index a70e204a8df3ac1c2d7318e81cde87a83267dd21..f2052781b797dd09b41127e33d98fe25408a9b23 100644
>> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> @@ -287,8 +287,9 @@ hdmi_try_format_bpc(const struct drm_connector *connector,
>>  	struct drm_device *dev = connector->dev;
>>  	int ret;
>>  
>> -	drm_dbg_kms(dev, "Trying %s output format\n",
>> -		    drm_hdmi_connector_get_output_format_name(fmt));
>> +	drm_dbg_kms(dev, "Trying %s output format with %u bpc\n",
>> +		    drm_hdmi_connector_get_output_format_name(fmt),
>> +		    bpc);
> 
> That part should be in a separate patch, it's independant of the rest.

Ack.

> 
>>  	if (!sink_supports_format_bpc(connector, info, mode, fmt, bpc)) {
>>  		drm_dbg_kms(dev, "%s output format not supported with %u bpc\n",
>> @@ -313,47 +314,22 @@ hdmi_try_format_bpc(const struct drm_connector *connector,
>>  }
>>  
>>  static int
>> -hdmi_compute_format(const struct drm_connector *connector,
>> -		    struct drm_connector_state *conn_state,
>> -		    const struct drm_display_mode *mode,
>> -		    unsigned int bpc)
>> -{
>> -	struct drm_device *dev = connector->dev;
>> -
>> -	/*
>> -	 * TODO: Add support for YCbCr420 output for HDMI 2.0 capable
>> -	 * devices, for modes that only support YCbCr420.
>> -	 */
>> -	if (hdmi_try_format_bpc(connector, conn_state, mode, bpc, HDMI_COLORSPACE_RGB)) {
>> -		conn_state->hdmi.output_format = HDMI_COLORSPACE_RGB;
>> -		return 0;
>> -	}
>> -
>> -	drm_dbg_kms(dev, "Failed. No Format Supported for that bpc count.\n");
>> -
>> -	return -EINVAL;
>> -}
>> -
>> -static int
>> -hdmi_compute_config(const struct drm_connector *connector,
>> -		    struct drm_connector_state *conn_state,
>> -		    const struct drm_display_mode *mode)
>> +hdmi_try_format(const struct drm_connector *connector,
>> +		struct drm_connector_state *conn_state,
>> +		const struct drm_display_mode *mode,
>> +		unsigned int max_bpc, enum hdmi_colorspace fmt)
>>  {
>>  	struct drm_device *dev = connector->dev;
>> -	unsigned int max_bpc = clamp_t(unsigned int,
>> -				       conn_state->max_bpc,
>> -				       8, connector->max_bpc);
>>  	unsigned int bpc;
>>  	int ret;
>>  
>>  	for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
>> -		drm_dbg_kms(dev, "Trying with a %d bpc output\n", bpc);
>> -
>> -		ret = hdmi_compute_format(connector, conn_state, mode, bpc);
>> -		if (ret)
>> +		ret = hdmi_try_format_bpc(connector, conn_state, mode, bpc, fmt);
>> +		if (!ret)
>>  			continue;
>>  
>>  		conn_state->hdmi.output_bpc = bpc;
>> +		conn_state->hdmi.output_format = fmt;
> 
> I guess it's a matter of semantics, but if it sets the value in the
> state, it doesn't try. Maybe the function should be named
> hdmi_compute_format_bpc then?

Good point!

> 
> That renaming should be in a separate patch too (possibly several).

Yes, I'll move all these preparatory changes into separate patch(es).

> 
>>  		drm_dbg_kms(dev,
>>  			    "Mode %ux%u @ %uHz: Found configuration: bpc: %u, fmt: %s, clock: %llu\n",
>> @@ -368,6 +344,31 @@ hdmi_compute_config(const struct drm_connector *connector,
>>  	return -EINVAL;
>>  }
>>  
>> +static int
>> +hdmi_compute_config(const struct drm_connector *connector,
>> +		    struct drm_connector_state *conn_state,
>> +		    const struct drm_display_mode *mode)
>> +{
>> +	unsigned int max_bpc = clamp_t(unsigned int,
>> +				       conn_state->max_bpc,
>> +				       8, connector->max_bpc);
>> +	int ret;
>> +
>> +	ret = hdmi_try_format(connector, conn_state, mode, max_bpc,
>> +			      HDMI_COLORSPACE_RGB);
>> +	if (!ret)
>> +		return 0;
>> +
>> +	if (connector->ycbcr_420_allowed)
>> +		ret = hdmi_try_format(connector, conn_state, mode, max_bpc,
>> +				      HDMI_COLORSPACE_YUV420);
> 
> I think that's conditioned on a few more things:

I've actually expected this! :-)

You've already raised some points during v1, but I preferred to restart the
discussion on updated code instead - sorry for taking so long to respin the
series.  In particular, I worked on [1] to improve handling of
ycbcr_420_allowed flag and fix some consistency issues with
HDMI_COLORSPACE_YUV420 advertised in drm_bridge->supported_formats.  Hence
I assumed it's now safe to rely exclusively on this flag to indicate the
connector is YUV420 capable, without doing any additional checks.

>   - That the driver supports HDMI 2.0

Probably I'm missing something obvious here, but is this necessary to
actually double-check ycbcr_420_allowed has been set correctly?

E.g. for bridges with DRM_BRIDGE_OP_HDMI set in drm_bridge->ops, the
framework does already adjust ycbcr_420_allowed, hence any additional
verification would be redundant.  When not making use of the framework,
drivers are not expected to set the flag if they are not HDMI 2.0 compliant
or not supporting YUV420, right? Are there any other use cases we need to
handle?

>   - That the display is an HDMI output

I think this should be handled by sink_supports_format_bpc() via:

    if (!info->is_hdmi &&
        (format != HDMI_COLORSPACE_RGB || bpc != 8)) {
            drm_dbg_kms(dev, "DVI Monitors require an RGB output at 8 bpc\n");
            return false;
    }

>   - That the mode is allowed YUV420 by the sink EDIDs

And that would be handled via the changes introduced by "drm/connector:
hdmi: Add support for YUV420 format verification".

>> +	else
>> +		drm_dbg_kms(connector->dev,
>> +			    "%s output format not allowed for connector\n",
>> +			    drm_hdmi_connector_get_output_format_name(HDMI_COLORSPACE_YUV420));
> 
> And I think we should keep the catch-all failure message we had.

IIRC, the rational for the change was to get rid of some redundancy, but
I'll recheck and make sure to keep that message in place.

Thanks,
Cristian

[1] https://patchwork.freedesktop.org/series/142679/


