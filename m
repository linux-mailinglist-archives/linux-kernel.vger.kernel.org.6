Return-Path: <linux-kernel+bounces-261850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1A993BCE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32E11C211D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D616F260;
	Thu, 25 Jul 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="crF8gCOy"
Received: from msa.smtpout.orange.fr (msa-211.smtpout.orange.fr [193.252.23.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098A15F407;
	Thu, 25 Jul 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891543; cv=none; b=fFnLreRmcBdN4wl5uISK2sENncisyXn4izFMVXVv/UuaAIeWGxbZGhx2YKKKOYZO6t8GgAr9FiZU4zqOspL1aEBBHO2tftDOKB9e1HKcj1fNq2WOFYawh8HUHRd00TDybQv0TnjEyRvCqMNfQ4Fq3QUDuvlH4cGhQGs+V4Asrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891543; c=relaxed/simple;
	bh=YZd6tA85CguKZTmk0Pgj86zgbrOCzWZBkC62Uhly/vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1YsAZrmGm2qL/syYQkkQO+aOO2bvC8znDMwacQh/mxCp4y3iP25y4XIfC018NANDtu+6C99GK4DGvd1k4s95ZoJ2Nd1qVoOQOmVFVn7tpP8j7QpBjHXH0k+uaofauv9X8WIPBZK9MI/6EFmp4Hja9U6FlKu+qrKHtt3YJORK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=crF8gCOy; arc=none smtp.client-ip=193.252.23.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id WqtpsLSEM4i5oWqtqsHWIN; Thu, 25 Jul 2024 07:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721884824;
	bh=hwMuyIhmJ32IPBMOuuKYD6ayMobgt9HzyZEdivUOslI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=crF8gCOyFd9ePukIrq8yVymD89VPtc5iLZnAllVp6Qc31UGbCRCi5dhCzW4YJY2tM
	 4Pv5JINi+tvyh460w48mGEsuLnoLXTG/ZjTcLuKnkxaGQKfFMPNaNtjR+1I3jxvgy/
	 yyyy9/q/i4hEY43w6KR4DrkAbXrxx21K4ZYcZlpsNttwQ3n7c3UberhGv5oalF/xLv
	 stZrJDmYFt1h7CwGaF9O+ao5IuWXFGunCD4AnC4271UKOcgsQkJnQ3NUy+7HWRYAis
	 V/EVABEAP6P/qymyJF/5fiJP5u/xRCest38q+Usj43Wb48RznfPdW2yHXQo26UKFp3
	 ENSIxIm9SJxWQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 25 Jul 2024 07:20:24 +0200
X-ME-IP: 90.11.132.44
Message-ID: <b21dbdbe-c779-4593-9a6a-892ef1298adb@wanadoo.fr>
Date: Thu, 25 Jul 2024 07:20:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/tiny: Add driver for Sharp Memory LCD
To: lanzano.alex@gmail.com
Cc: airlied@gmail.com, conor+dt@kernel.org, daniel@ffwll.ch,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mehdi.djait@bootlin.com,
 mripard@kernel.org, robh@kernel.org, tzimmermann@suse.de
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240725004734.644986-3-lanzano.alex@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240725004734.644986-3-lanzano.alex@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/07/2024 à 02:47, Alex Lanzano a écrit :
> Add support for the monochrome Sharp Memory LCDs.
> 
> Signed-off-by: Alex Lanzano <lanzano.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   MAINTAINERS                         |   8 +
>   drivers/gpu/drm/tiny/Kconfig        |  20 +
>   drivers/gpu/drm/tiny/Makefile       |   1 +
>   drivers/gpu/drm/tiny/sharp-memory.c | 742 ++++++++++++++++++++++++++++
>   4 files changed, 771 insertions(+)
>   create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c
> 

Hi,

below a few comments, mostly cosmetic and 2 more interesting things 
related to error handling at the end.

Hope it helps.

CJ

...

> diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
> new file mode 100644
> index 000000000000..5e61e348ce3a
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> @@ -0,0 +1,742 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +#include <linux/kernel.h>

Is it really needed?

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/spi/spi.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/delay.h>
> +#include <linux/kthread.h>
> +#include <linux/bitrev.h>
> +#include <linux/pwm.h>
> +#include <linux/mutex.h>

Nitpick: usually, alphabetical order is preferred.

> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_damage_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_fb_dma_helper.h>

...

> +static inline void sharp_memory_set_tx_buffer_addresses(uint8_t *buffer,
> +							struct drm_rect clip,
> +							uint32_t pitch)
> +{
> +	for (uint32_t line = 0; line < clip.y2; ++line)
> +		buffer[line * pitch] = line + 1;
> +

Nitpick: No need for an empty line.

> +}
> +
> +static void sharp_memory_set_tx_buffer_data(uint8_t *buffer,
> +					    struct drm_framebuffer *fb,
> +					    struct drm_rect clip,
> +					    uint32_t pitch,
> +					    struct drm_format_conv_state *fmtcnv_state)
> +{
> +	int ret;
> +	struct iosys_map dst, vmap;
> +	struct drm_gem_dma_object *dma_obj = drm_fb_dma_get_gem_obj(fb, 0);
> +
> +	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
> +	if (ret)
> +		return;
> +
> +

Nitpick: No need for 2 newlines.

> +	iosys_map_set_vaddr(&dst, buffer);
> +	iosys_map_set_vaddr(&vmap, dma_obj->vaddr);
> +
> +	drm_fb_xrgb8888_to_mono(&dst, &pitch, &vmap, fb, &clip, fmtcnv_state);
> +
> +	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> +}

...

> +static void sharp_memory_plane_atomic_update(struct drm_plane *plane,
> +					     struct drm_atomic_state *state)
> +{
> +

Nitpick: No need for an empty line.

> +	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
> +	struct drm_plane_state *plane_state = plane->state;
> +	struct drm_format_conv_state fmtcnv_state = DRM_FORMAT_CONV_STATE_INIT;
> +	struct sharp_memory_device *smd;
> +	struct drm_rect rect;
> +
> +	smd = container_of(plane, struct sharp_memory_device, plane);
> +	if (!smd->crtc.state->active)
> +		return;
> +
> +
> +	if (drm_atomic_helper_damage_merged(old_state, plane_state, &rect))
> +		sharp_memory_fb_dirty(plane_state->fb, &rect, &fmtcnv_state);
> +
> +	drm_format_conv_state_release(&fmtcnv_state);
> +}

...

> +static void sharp_memory_crtc_enable(struct drm_crtc *crtc,
> +				     struct drm_atomic_state *state)
> +{
> +	struct pwm_state pwm_state;
> +	struct sharp_memory_device *smd = drm_to_sharp_memory_device(crtc->dev);
> +
> +	sharp_memory_clear_display(smd);
> +
> +	if (smd->enable_gpio)
> +		gpiod_set_value(smd->enable_gpio, 1);
> +
> +

Nitpick: No need for 2 newlines.

> +	switch (smd->vcom_mode) {
> +	case SHARP_MEMORY_SOFTWARE_VCOM:
> +		smd->sw_vcom_signal = kthread_run(sharp_memory_sw_vcom_signal_thread,
> +						  smd, "sw_vcom_signal");
> +		break;
> +
> +	case SHARP_MEMORY_EXTERNAL_VCOM:
> +		break;
> +
> +	case SHARP_MEMORY_PWM_VCOM:
> +		pwm_get_state(smd->pwm_vcom_signal, &pwm_state);
> +		pwm_state.period =    1000000000;
> +		pwm_state.duty_cycle = 100000000;
> +		pwm_state.enabled = true;
> +		pwm_apply_state(smd->pwm_vcom_signal, &pwm_state);
> +		break;
> +	}
> +}
> +
> +static void sharp_memory_crtc_disable(struct drm_crtc *crtc,
> +				      struct drm_atomic_state *state)
> +{
> +	struct sharp_memory_device *smd = drm_to_sharp_memory_device(crtc->dev);
> +
> +	sharp_memory_clear_display(smd);
> +
> +	if (smd->enable_gpio)
> +		gpiod_set_value(smd->enable_gpio, 0);
> +
> +

Nitpick: No need for 2 newlines.

> +	switch (smd->vcom_mode) {
> +	case SHARP_MEMORY_SOFTWARE_VCOM:
> +		kthread_stop(smd->sw_vcom_signal);
> +		break;
> +
> +	case SHARP_MEMORY_EXTERNAL_VCOM:
> +		break;
> +
> +	case SHARP_MEMORY_PWM_VCOM:
> +		pwm_disable(smd->pwm_vcom_signal);
> +		break;
> +	}
> +}

...

> +static const struct drm_connector_funcs sharp_memory_connector_funcs = {
> +	.reset = drm_atomic_helper_connector_reset,
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = drm_connector_cleanup,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +

Nitpick: No need for an empty line.

> +};
> +
> +static const struct drm_mode_config_funcs sharp_memory_mode_config_funcs = {
> +	.fb_create = drm_gem_fb_create_with_dirty,
> +	.atomic_check = drm_atomic_helper_check,
> +	.atomic_commit = drm_atomic_helper_commit,
> +};

...

> +static int sharp_memory_pipe_init(struct drm_device *dev,
> +				  struct sharp_memory_device *smd,
> +				  const uint32_t *formats, unsigned int format_count,
> +				  const uint64_t *format_modifiers)
> +{
> +	int ret;
> +	struct drm_encoder *encoder = &smd->encoder;
> +	struct drm_plane *plane = &smd->plane;
> +	struct drm_crtc *crtc = &smd->crtc;
> +	struct drm_connector *connector = &smd->connector;
> +
> +	drm_plane_helper_add(plane, &sharp_memory_plane_helper_funcs);
> +	ret = drm_universal_plane_init(dev, plane, 0,
> +				       &sharp_memory_plane_funcs,
> +				       formats, format_count,
> +				       format_modifiers,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret)
> +		return ret;
> +
> +
> +	drm_crtc_helper_add(crtc, &sharp_memory_crtc_helper_funcs);
> +	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
> +					&sharp_memory_crtc_funcs, NULL);
> +	if (ret)
> +		return ret;
> +
> +

Nitpick: No need for 2 newlines. (here and 2 other time just below)

> +	encoder->possible_crtcs = drm_crtc_mask(crtc);
> +	ret = drm_encoder_init(dev, encoder, &sharp_memory_encoder_funcs,
> +			       DRM_MODE_ENCODER_NONE, NULL);
> +	if (ret)
> +		return ret;
> +
> +
> +	ret = drm_connector_init(&smd->drm, &smd->connector,
> +				 &sharp_memory_connector_funcs,
> +				 DRM_MODE_CONNECTOR_SPI);
> +	if (ret)
> +		return ret;
> +
> +
> +	drm_connector_helper_add(&smd->connector,
> +				 &sharp_memory_connector_hfuncs);
> +
> +	return drm_connector_attach_encoder(connector, encoder);
> +}
> +
> +static int sharp_memory_init_pwm_vcom_signal(struct sharp_memory_device *smd)
> +{
> +	struct pwm_state state;
> +	struct device *dev = &smd->spi->dev;
> +
> +	smd->pwm_vcom_signal = devm_pwm_get(dev, NULL);
> +	if (IS_ERR(smd->pwm_vcom_signal)) {
> +		dev_err(dev, "Could not get pwm device\n");
> +		return PTR_ERR(smd->pwm_vcom_signal);

Called from probe() opnly,so could be return  dev_err_probe().

> +	}
> +
> +	pwm_init_state(smd->pwm_vcom_signal, &state);
> +	state.enabled = false;
> +	pwm_apply_state(smd->pwm_vcom_signal, &state);
> +
> +	return 0;
> +}
> +
> +static int sharp_memory_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct device *dev;
> +	struct sharp_memory_device *smd;
> +	enum sharp_memory_model model;
> +	struct drm_device *drm;
> +
> +	ret = spi_setup(spi);
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret, "Failed to setup spi device\n");
> +
> +	dev = &spi->dev;
> +	if (!dev->coherent_dma_mask) {
> +		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to set dma mask\n");
> +	}
> +
> +	smd = devm_drm_dev_alloc(&spi->dev, &sharp_memory_drm_driver,
> +				 struct sharp_memory_device, drm);
> +
> +	spi_set_drvdata(spi, smd);
> +
> +	smd->spi = spi;
> +	drm = &smd->drm;
> +	ret = drmm_mode_config_init(drm);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize drm config\n");
> +
> +

Nitpick: No need for 2 newlines.

> +	smd->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> +	if (smd->enable_gpio == NULL)
> +		dev_warn(&spi->dev, "Enable gpio not defined\n");
> +
> +

Nitpick: No need for 2 newlines.

> +	/*
> +	 * VCOM is a signal that prevents DC bias from being built up in
> +	 * the panel resulting in pixels being forever stuck in one state.
> +	 *
> +	 * This driver supports three different methods to generate this
> +	 * signal depending on EXTMODE pin:
> +	 *
> +	 * SOFTWARE_VCOM (EXTMODE = L) - This method uses a kthread to
> +	 * periodically send a "maintain display" message to the display,
> +	 * toggling the vcom bit on and off with each message
> +	 *
> +	 * EXTERNAL_VCOM (EXTMODE = H) - This method relies on an external
> +	 * clock to generate the signal on the EXTCOMM pin
> +	 *
> +	 * PWM_VCOM (EXTMODE = H) - This method uses a pwm device to generate
> +	 * the signal on the EXTCOMM pin
> +	 *
> +	 */
> +	smd->vcom = 0;
> +	if (device_property_read_u32(&spi->dev, "vcom-mode", &smd->vcom_mode))
> +		return dev_err_probe(dev, ret, "Unable to find vcom-mode node in device tree\n");

ret is 0 at this point, so we return 'sucess'.
Is it what is expected?

> +
> +

Nitpick: No need for 2 newlines.

> +	switch (smd->vcom_mode) {
> +	case SHARP_MEMORY_SOFTWARE_VCOM:
> +	case SHARP_MEMORY_EXTERNAL_VCOM:
> +		/* No init is needed for these two modes */
> +		break;
> +
> +	case SHARP_MEMORY_PWM_VCOM:
> +		ret = sharp_memory_init_pwm_vcom_signal(smd);

...

> +	smd->tx_buffer_size = (SHARP_MODE_PERIOD +
> +			       (SHARP_ADDR_PERIOD + (smd->mode->hdisplay) + SHARP_DUMMY_PERIOD) *
> +			       smd->mode->vdisplay) / 8;
> +
> +	smd->tx_buffer = devm_kzalloc(&spi->dev, smd->tx_buffer_size, GFP_KERNEL);

Error handling?

> +
> +	mutex_init(&smd->tx_mutex);
> +
> +	drm->mode_config.min_width = smd->mode->hdisplay;
> +	drm->mode_config.max_width = smd->mode->hdisplay;
> +	drm->mode_config.min_height = smd->mode->vdisplay;
> +	drm->mode_config.max_height = smd->mode->vdisplay;

...

CJ


