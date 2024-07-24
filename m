Return-Path: <linux-kernel+bounces-260524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E323C93AA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129991C22D09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E01079F4;
	Wed, 24 Jul 2024 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="cfDVnVua"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56712613D;
	Wed, 24 Jul 2024 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784060; cv=none; b=b1eaESjONCRDEc4C1HUlerNeuq3xl2f39db1Pc7sYD2glPOzN+Wrcp8I/nSvzgUD4Z0qMVbxzu/RUo0MoXPvch6wlUMst3AbJ/cUTy3R5s0nmKAy3+IRBUBfw5xo4HBtCNd3Lby7PAJId5AQEvl+NTJyUGGtOryd0CxHgG/DxJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784060; c=relaxed/simple;
	bh=y+m76mFEsY3Q9C9QjxuvzqsISxCmrIqDOXIL+B3UGuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YCqZ7/WuPr6N5PQfR1EWHPPGg0k4he4rfaA0m20WovzizDMTXpmvVKvTbfq3GkjPpmqSikqC0t1iAQN7JpS2RXjIgfVi8WOncKnd6cPHaCuLjCwkH6XGRmHrlLy1hDTxTkm0cm1CFafg+o7ecuRKqpV7hBm6uoitKMsnZqrT8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=cfDVnVua; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0CA61100008;
	Wed, 24 Jul 2024 04:20:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0CA61100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1721784044;
	bh=q2ckd34mx4TWbRYSYcwBCcSeAj+nSLVFIxnsrndcMhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=cfDVnVuarZUxe4kbQmR3LDS6MxjZR0t6PW+YMPzwdn2zhKWUJm8nSahLnengd5Cxy
	 PWji54tyeB1FnsRH4j+hR1E5a2y1DkuTeJAd2mLbKB3cOz2OAoG2PrayT4Lj0Q5oBq
	 asUYoWmBbtor0IE58smdjDSB3jwOR763YD3eqdgDbOGuZ4I3MSfNs477AIMyICUYiD
	 Q7Phg6IsKfE2N5rqzpNGOrXu/jT6tv4w/sc3AdagNFWZEVWY7ysix5dA14KbIqaRRU
	 myPlxsGpA3QYbIm2HhpI/HB5/1USvP6eX1k4+aJXxh6pzqK2o7paACiylQYgXPGMrU
	 yu54tZS2zIrkg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 24 Jul 2024 04:20:43 +0300 (MSK)
Received: from [192.168.20.2] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jul 2024 04:20:43 +0300
Message-ID: <f6b7f390-cf76-420f-801b-928f3b1ce51b@salutedevices.com>
Date: Wed, 24 Jul 2024 04:18:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] reset: amlogic: add auxiliary reset driver support
To: Jerome Brunet <jbrunet@baylibre.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>
References: <20240718095755.3511992-1-jbrunet@baylibre.com>
 <20240718095755.3511992-10-jbrunet@baylibre.com>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240718095755.3511992-10-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186690 [Jul 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/23 17:33:00 #26132980
X-KSMG-AntiVirus-Status: Clean, skipped



On 7/18/24 12:57, Jerome Brunet wrote:
> Add support for the reset controller present in the audio clock
> controller of the g12 and sm1 SoC families, using the auxiliary bus.
> 
> This is expected to replace the driver currently present directly
> within the related clock driver.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/reset/amlogic/Kconfig               |   8 ++
>  drivers/reset/amlogic/Makefile              |   1 +
>  drivers/reset/amlogic/reset-meson-aux.c     | 136 ++++++++++++++++++++
>  drivers/reset/amlogic/reset-meson-core.c    |  25 +++-
>  drivers/reset/amlogic/reset-meson-pltf.c    |   3 +
>  drivers/reset/amlogic/reset-meson.h         |   4 +
>  include/soc/amlogic/meson-auxiliary-reset.h |  23 ++++
>  7 files changed, 198 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/reset/amlogic/reset-meson-aux.c
>  create mode 100644 include/soc/amlogic/meson-auxiliary-reset.h
> 
> diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kconfig
> index 04c7be0f3165..ee1c7620a2b1 100644
> --- a/drivers/reset/amlogic/Kconfig
> +++ b/drivers/reset/amlogic/Kconfig
> @@ -11,6 +11,14 @@ config RESET_MESON
>  	help
>  	  This enables the reset platform driver for Amlogic SoCs.
>  
> +config RESET_MESON_AUX
> +	tristate "Meson Reset Platform Driver"

Is it correct? I suppose you mean "... Auxiliary Driver", because there
is another "Meson Reset Platform Driver" several lines above.

> +	depends on ARCH_MESON || COMPILE_TEST
> +	select AUXILIARY_BUS
> +	select RESET_MESON_CORE
> +	help
> +	  This enables the reset auxiliary driver for Amlogic SoCs.
> +
>  config RESET_MESON_AUDIO_ARB
>  	tristate "Meson Audio Memory Arbiter Reset Driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/Makefile
> index 0f8f9121b566..5d53a4b11ed9 100644
> --- a/drivers/reset/amlogic/Makefile
> +++ b/drivers/reset/amlogic/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_RESET_MESON) += reset-meson-pltf.o
> +obj-$(CONFIG_RESET_MESON_AUX) += reset-meson-aux.o
>  obj-$(CONFIG_RESET_MESON_CORE) += reset-meson-core.o
>  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
> diff --git a/drivers/reset/amlogic/reset-meson-aux.c b/drivers/reset/amlogic/reset-meson-aux.c
> new file mode 100644
> index 000000000000..caf26eb67c14
> --- /dev/null
> +++ b/drivers/reset/amlogic/reset-meson-aux.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * Amlogic Meson Reset Auxiliary driver
> + *
> + * Copyright (c) 2024 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +
> +#include "reset-meson.h"
> +#include <soc/amlogic/meson-auxiliary-reset.h>
> +
> +static DEFINE_IDA(meson_rst_aux_ida);
> +
> +struct meson_reset_adev {
> +	struct auxiliary_device adev;
> +	struct regmap *map;
> +};
> +
> +#define to_meson_reset_adev(_adev) \
> +	container_of((_adev), struct meson_reset_adev, adev)
> +
> +static const struct meson_reset_param meson_g12a_audio_param = {
> +	.reset_ops	= &meson_reset_toggle_ops,
> +	.reset_num	= 26,
> +	.level_offset	= 0x24,
> +};
> +
> +static const struct meson_reset_param meson_sm1_audio_param = {
> +	.reset_ops	= &meson_reset_toggle_ops,
> +	.reset_num	= 39,
> +	.level_offset	= 0x28,
> +};
> +
> +static const struct auxiliary_device_id meson_reset_aux_ids[] = {
> +	{
> +		.name = "axg-audio-clkc.rst-g12a",
> +		.driver_data = (kernel_ulong_t)&meson_g12a_audio_param,
> +	}, {
> +		.name = "axg-audio-clkc.rst-sm1",
> +		.driver_data = (kernel_ulong_t)&meson_sm1_audio_param,
> +	}, {}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, meson_reset_aux_ids);
> +
> +static int meson_reset_aux_probe(struct auxiliary_device *adev,
> +				 const struct auxiliary_device_id *id)
> +{
> +	const struct meson_reset_param *param =
> +		(const struct meson_reset_param *)(id->driver_data);
> +	struct meson_reset_adev *raux =
> +		to_meson_reset_adev(adev);
> +
> +	return meson_reset_probe(&adev->dev, raux->map, param);
> +}
> +
> +static struct auxiliary_driver meson_reset_aux_driver = {
> +	.probe		= meson_reset_aux_probe,
> +	.id_table	= meson_reset_aux_ids,
> +};
> +module_auxiliary_driver(meson_reset_aux_driver);
> +
> +static void meson_rst_aux_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +	struct meson_reset_adev *raux =
> +		to_meson_reset_adev(adev);
> +
> +	ida_free(&meson_rst_aux_ida, adev->id);
> +	kfree(raux);
> +}
> +
> +static void meson_rst_aux_unregister_adev(void *_adev)
> +{
> +	struct auxiliary_device *adev = _adev;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +int devm_meson_rst_aux_register(struct device *dev,
> +				struct regmap *map,
> +				const char *adev_name)
> +{
> +	struct meson_reset_adev *raux;
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	raux = kzalloc(sizeof(*raux), GFP_KERNEL);
> +	if (!raux)
> +		return -ENOMEM;
> +
> +	ret = ida_alloc(&meson_rst_aux_ida, GFP_KERNEL);
> +	if (ret < 0)
> +		goto raux_free;
> +
> +	raux->map = map;
> +
> +	adev = &raux->adev;
> +	adev->id = ret;
> +	adev->name = adev_name;
> +	adev->dev.parent = dev;
> +	adev->dev.release = meson_rst_aux_release;
> +	device_set_of_node_from_dev(&adev->dev, dev);
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret)
> +		goto ida_free;
> +
> +	ret = __auxiliary_device_add(adev, dev->driver->name);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(dev, meson_rst_aux_unregister_adev,
> +					adev);
> +
> +ida_free:
> +	ida_free(&meson_rst_aux_ida, adev->id);
> +raux_free:
> +	kfree(raux);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_meson_rst_aux_register);
> +
> +MODULE_DESCRIPTION("Amlogic Meson Reset Auxiliary driver");
> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_IMPORT_NS(MESON_RESET);
> diff --git a/drivers/reset/amlogic/reset-meson-core.c b/drivers/reset/amlogic/reset-meson-core.c
> index 5e23f3212e6d..1e5883b27c30 100644
> --- a/drivers/reset/amlogic/reset-meson-core.c
> +++ b/drivers/reset/amlogic/reset-meson-core.c
> @@ -86,12 +86,33 @@ static int meson_reset_deassert(struct reset_controller_dev *rcdev,
>  	return meson_reset_level(rcdev, id, false);
>  }
>  
> -static const struct reset_control_ops meson_reset_ops = {
> +static int meson_reset_level_toggle(struct reset_controller_dev *rcdev,
> +				    unsigned long id)
> +{
> +	int ret;
> +
> +	ret = meson_reset_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	return meson_reset_deassert(rcdev, id);
> +}
> +
> +const struct reset_control_ops meson_reset_ops = {
>  	.reset		= meson_reset_reset,
>  	.assert		= meson_reset_assert,
>  	.deassert	= meson_reset_deassert,
>  	.status		= meson_reset_status,
>  };
> +EXPORT_SYMBOL_NS_GPL(meson_reset_ops, MESON_RESET);
> +
> +const struct reset_control_ops meson_reset_toggle_ops = {
> +	.reset		= meson_reset_level_toggle,
> +	.assert		= meson_reset_assert,
> +	.deassert	= meson_reset_deassert,
> +	.status		= meson_reset_status,
> +};
> +EXPORT_SYMBOL_NS_GPL(meson_reset_toggle_ops, MESON_RESET);
>  
>  int meson_reset_probe(struct device *dev, struct regmap *map,
>  		      const struct meson_reset_param *param)
> @@ -106,7 +127,7 @@ int meson_reset_probe(struct device *dev, struct regmap *map,
>  	data->map = map;
>  	data->rcdev.owner = dev->driver->owner;
>  	data->rcdev.nr_resets = param->reset_num;
> -	data->rcdev.ops = &meson_reset_ops;
> +	data->rcdev.ops = data->param->reset_ops;
>  	data->rcdev.of_node = dev->of_node;
>  
>  	return devm_reset_controller_register(dev, &data->rcdev);
> diff --git a/drivers/reset/amlogic/reset-meson-pltf.c b/drivers/reset/amlogic/reset-meson-pltf.c
> index 97e933b4aa34..2bc3ea42c6ec 100644
> --- a/drivers/reset/amlogic/reset-meson-pltf.c
> +++ b/drivers/reset/amlogic/reset-meson-pltf.c
> @@ -16,6 +16,7 @@
>  #include "reset-meson.h"
>  
>  static const struct meson_reset_param meson8b_param = {
> +	.reset_ops	= &meson_reset_ops,
>  	.reset_num	= 256,
>  	.reset_offset	= 0x0,
>  	.level_offset	= 0x7c,
> @@ -23,6 +24,7 @@ static const struct meson_reset_param meson8b_param = {
>  };
>  
>  static const struct meson_reset_param meson_a1_param = {
> +	.reset_ops	= &meson_reset_ops,
>  	.reset_num	= 96,
>  	.reset_offset	= 0x0,
>  	.level_offset	= 0x40,
> @@ -30,6 +32,7 @@ static const struct meson_reset_param meson_a1_param = {
>  };
>  
>  static const struct meson_reset_param meson_s4_param = {
> +	.reset_ops	= &meson_reset_ops,
>  	.reset_num	= 192,
>  	.reset_offset	= 0x0,
>  	.level_offset	= 0x40,
> diff --git a/drivers/reset/amlogic/reset-meson.h b/drivers/reset/amlogic/reset-meson.h
> index c2e8a5cf2e46..5ab2ac9ab2e5 100644
> --- a/drivers/reset/amlogic/reset-meson.h
> +++ b/drivers/reset/amlogic/reset-meson.h
> @@ -12,6 +12,7 @@
>  #include <linux/reset-controller.h>
>  
>  struct meson_reset_param {
> +	const struct reset_control_ops *reset_ops;
>  	unsigned int reset_num;
>  	unsigned int reset_offset;
>  	unsigned int level_offset;
> @@ -21,4 +22,7 @@ struct meson_reset_param {
>  int meson_reset_probe(struct device *dev, struct regmap *map,
>  		      const struct meson_reset_param *param);
>  
> +extern const struct reset_control_ops meson_reset_ops;
> +extern const struct reset_control_ops meson_reset_toggle_ops;
> +
>  #endif /* __MESON_RESET_CORE_H */
> diff --git a/include/soc/amlogic/meson-auxiliary-reset.h b/include/soc/amlogic/meson-auxiliary-reset.h
> new file mode 100644
> index 000000000000..f70dd864ef6a
> --- /dev/null
> +++ b/include/soc/amlogic/meson-auxiliary-reset.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_AMLOGIC_MESON_AUX_RESET_H
> +#define __SOC_AMLOGIC_MESON_AUX_RESET_H
> +
> +#include <linux/err.h>
> +
> +struct device;
> +struct regmap;
> +
> +#if IS_ENABLED(CONFIG_RESET_MESON_AUX)
> +int devm_meson_rst_aux_register(struct device *dev,
> +				struct regmap *map,
> +				const char *adev_name);
> +#else
> +static inline int devm_meson_rst_aux_register(struct device *dev,
> +					      struct regmap *map,
> +					      const char *adev_name)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif /* __SOC_AMLOGIC_MESON_AUX_RESET_H */

-- 
Best regards
Jan Dakinevich

