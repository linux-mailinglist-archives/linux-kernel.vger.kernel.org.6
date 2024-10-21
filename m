Return-Path: <linux-kernel+bounces-374823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D59A70B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5853283933
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1AC1EF093;
	Mon, 21 Oct 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jx1wrq2m"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AC547A73;
	Mon, 21 Oct 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530631; cv=none; b=su8eyJp+pIVQrDOS5srBRbPl/H0N5TGKWMzNz1p2YG8D236WlwfYJa6oPqfYw53scGgXSKUwm+Nx9ZWuTiiosvJ23z3g8RBqx4eqS1RY76+LHAN1XmjWwkg29HIkU25aIhPGiyqQ8t12EU9jgkJqwBBZ6/N/a/nL+wgqQG4LW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530631; c=relaxed/simple;
	bh=1c4PdRriiS/iBNfIH4SwhgYqlrt7Y3TPuqnGiKSh1eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zogc4ZM9dUxd9IA+4akIk5vcKf+uCN3hP+9Syp4ZCOOfpbIjJlFVLwafC0iR2xn16x/A1dkjrUyfWQ4ahcViIC8jD+Jc1ro19F//FliXan3hcQa6h49H8eyOnNgMZFJ29s/0Y+HahKWCD6YHv8gjUVAssPvdfW8/bIzM7aN7ok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jx1wrq2m; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 2vtrtah4RQI3S2vtrtiuDL; Mon, 21 Oct 2024 19:09:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729530546;
	bh=mw2F5SJ/CHyQYWKNFVkI3SI/zipNvCqITe7rm4FQeuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jx1wrq2mL6gLmw2KideZ3NykWqIGyoSnkguxnch8WVCHaRBvt1cYFA7BJnCJssvaN
	 RIv8KymBkyLQENV5+kW1aonnV/FQ6BnoNn0LhwIZ0mi5CRBnVUfS/jipQOUKydZzZW
	 2lCTFQbqSvIU81reXWB6xO1U6FIFr+ITDGVlJ5KYh+guLrl+O8T2Ux51HtHSSulFLM
	 CzGXUDLvoASaHCLnlX5K/KCSdk8MA7zBrdVQsx6O+h3VALp+MvbsxTPI6vuiUUcdNY
	 QKqhcNMNnXADOxorX+9ueOeaSXQMumwtVRH7jRcH5F33yYRSpXFGOnbO8j5GGA7e/C
	 dtL0mT3DRDcOQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 21 Oct 2024 19:09:06 +0200
X-ME-IP: 90.11.132.44
Message-ID: <ab57dbee-59b8-4ec0-91dd-4818b6b28446@wanadoo.fr>
Date: Mon, 21 Oct 2024 19:08:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] ASoC: codecs: Add aw88081 amplifier driver
To: wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
 rf@opensource.cirrus.com, neil.armstrong@linaro.org,
 pierre-louis.bossart@linux.dev, luca.ceresoli@bootlin.com,
 wangweidong.a@awinic.com, arnd@arndb.de, quic_pkumpatl@quicinc.com,
 herve.codina@bootlin.com, masahiroy@kernel.org, shenghao-ding@ti.com,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, yijiangtao@awinic.com
References: <20241018094320.113477-1-wangweidong.a@awinic.com>
 <20241018094320.113477-3-wangweidong.a@awinic.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241018094320.113477-3-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/10/2024 à 11:43, 
wangweidong.a-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org a écrit :
> From: Weidong Wang <wangweidong.a-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> 
> The driver is for amplifiers aw88081 of Awinic Technology Corporation.
> The awinic AW88081 is an I2S/TDM input, high efficiency digital
> Smart K audio amplifier
> 
> Signed-off-by: Weidong Wang <wangweidong.a-tUEr1MkLeujQT0dZR+AlfA@public.gmane.org>
> ---

Hi,

...

> +
> +#include <linux/i2c.h>
> +#include <linux/firmware.h>

Sometimes, alphabecal order is prefered.

> +#include <linux/regmap.h>
> +#include <sound/soc.h>
> +#include "aw88081.h"
> +#include "aw88395/aw88395_device.h"
> +
> +static const struct regmap_config aw88081_regmap_config = {
> +	.val_bits = 16,
> +	.reg_bits = 8,
> +	.max_register = AW88081_REG_MAX,
> +	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +};

...

> +static int aw88081_dev_check_syspll(struct aw_device *aw_dev)
> +{
> +	int ret;
> +
> +	ret = aw88081_dev_check_mode1_pll(aw_dev);
> +	if (ret) {
> +		dev_dbg(aw_dev->dev, "mode1 check iis failed try switch to mode2 check");
> +		ret = aw88081_dev_check_mode2_pll(aw_dev);
> +		if (ret) {
> +			dev_err(aw_dev->dev, "mode2 check iis failed");
> +			return ret;
> +		}
> +	}
> +
> +	return ret;

Here and in some other places, return 0; could be used to be more explicit.

> +}

...

> +static int aw88081_reg_update(struct aw88081 *aw88081, bool force)
> +{
> +	struct aw_device *aw_dev = aw88081->aw_pa;
> +	int ret;
> +
> +	if (force) {
> +		ret = regmap_write(aw_dev->regmap,
> +					AW88081_ID_REG, AW88081_SOFT_RESET_VALUE);
> +		if (ret)
> +			return ret;
> +
> +		ret = aw88081_dev_fw_update(aw88081);
> +		if (ret)
> +			return ret;
> +	} else {
> +		if (aw_dev->prof_cur != aw_dev->prof_index) {
> +			ret = aw88081_dev_fw_update(aw88081);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret = 0;

This else could be removed, and an explicit return 0; used below at the 
end of the function.

> +		}
> +	}
> +
> +	aw_dev->prof_cur = aw_dev->prof_index;
> +
> +	return ret;
> +}

...

> +static int aw88081_profile_info(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_info *uinfo)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(codec);
> +	char *prof_name, *name;
> +	int count, ret;
> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
> +	uinfo->count = 1;
> +
> +	count = aw88081->aw_pa->prof_info.count;
> +	if (count <= 0) {
> +		uinfo->value.enumerated.items = 0;
> +		return 0;
> +	}
> +
> +	uinfo->value.enumerated.items = count;
> +
> +	if (uinfo->value.enumerated.item >= count)
> +		uinfo->value.enumerated.item = count - 1;
> +
> +	name = uinfo->value.enumerated.name;
> +	count = uinfo->value.enumerated.item;
> +
> +	ret = aw88081_dev_get_prof_name(aw88081->aw_pa, count, &prof_name);
> +	if (ret) {
> +		strscpy(uinfo->value.enumerated.name, "null",
> +						strlen("null") + 1);

Np real use fot this hand computed length. Using the 2 parameters 
version of strscpy() should just be fine, I think.

> +		return 0;
> +	}
> +
> +	strscpy(name, prof_name, sizeof(uinfo->value.enumerated.name));

If  uinfo->value.enumerated.name was used directly as in the if block 
above, then 'name' could be removed and the 2 parameters only variant of 
strscpy() coulb be used instead, I think.

> +
> +	return 0;
> +}

...

> +static int aw88081_init(struct aw88081 *aw88081, struct i2c_client *i2c, struct regmap *regmap)
> +{
> +	struct aw_device *aw_dev;
> +	unsigned int chip_id;
> +	int ret;
> +
> +	/* read chip id */
> +	ret = regmap_read(regmap, AW88081_ID_REG, &chip_id);
> +	if (ret) {
> +		dev_err(&i2c->dev, "%s read chipid error. ret = %d", __func__, ret);
> +		return ret;
> +	}
> +	if (chip_id != AW88081_CHIP_ID) {
> +		dev_err(&i2c->dev, "unsupported device");
> +		return -ENXIO;
> +	}
> +
> +	dev_dbg(&i2c->dev, "chip id = %x\n", chip_id);
> +
> +	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
> +	if (!aw_dev)
> +		return -ENOMEM;
> +
> +	aw88081->aw_pa = aw_dev;
> +	aw_dev->i2c = i2c;
> +	aw_dev->regmap = regmap;
> +	aw_dev->dev = &i2c->dev;
> +	aw_dev->chip_id = AW88081_CHIP_ID;
> +	aw_dev->acf = NULL;
> +	aw_dev->prof_info.prof_desc = NULL;
> +	aw_dev->prof_info.count = 0;

No need to init here, and channel below, unless an explicit 0 is more 
informative than the kzalloc() above.

> +	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
> +	aw_dev->channel = 0;
> +	aw_dev->fw_status = AW88081_DEV_FW_FAILED;
> +	aw_dev->fade_step = AW88081_VOLUME_STEP_DB;
> +	aw_dev->volume_desc.ctl_volume = AW88081_VOL_DEFAULT_VALUE;
> +	aw_dev->volume_desc.mute_volume = AW88081_MUTE_VOL;
> +	aw88081_parse_channel_dt(aw88081);
> +
> +	return ret;
> +}

...

> +static int aw88081_request_firmware_file(struct aw88081 *aw88081)
> +{
> +	const struct firmware *cont = NULL;
> +	int ret;
> +
> +	aw88081->aw_pa->fw_status = AW88081_DEV_FW_FAILED;
> +
> +	ret = request_firmware(&cont, AW88081_ACF_FILE, aw88081->aw_pa->dev);
> +	if (ret)
> +		return dev_err_probe(aw88081->aw_pa->dev, ret,
> +					"load [%s] failed!", AW88081_ACF_FILE);
> +
> +	dev_dbg(aw88081->aw_pa->dev, "loaded %s - size: %zu\n",
> +			AW88081_ACF_FILE, cont ? cont->size : 0);
> +
> +	aw88081->aw_cfg = devm_kzalloc(aw88081->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
> +	if (!aw88081->aw_cfg) {
> +		release_firmware(cont);
> +		return -ENOMEM;
> +	}
> +	aw88081->aw_cfg->len = (int)cont->size;
> +	memcpy(aw88081->aw_cfg->data, cont->data, cont->size);
> +	release_firmware(cont);
> +
> +	ret = aw88395_dev_load_acf_check(aw88081->aw_pa, aw88081->aw_cfg);
> +	if (ret) {
> +		dev_err(aw88081->aw_pa->dev, "load [%s] failed !", AW88081_ACF_FILE);

return dev_err_probe() to be consistent and less verbose.

> +		return ret;
> +	}
> +
> +	mutex_lock(&aw88081->lock);
> +	/* aw device init */
> +	ret = aw88081_dev_init(aw88081, aw88081->aw_cfg);
> +	if (ret)
> +		dev_err(aw88081->aw_pa->dev, "dev init failed");

return dev_err_probe() to be consistent?

> +	mutex_unlock(&aw88081->lock);
> +
> +	return ret;
> +}


...

> +static int aw88081_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct aw88081 *aw88081;
> +	int ret;
> +
> +	ret = i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C);
> +	if (!ret)
> +		return dev_err_probe(&i2c->dev, -ENXIO, "check_functionality failed");
> +
> +	aw88081 = devm_kzalloc(&i2c->dev, sizeof(*aw88081), GFP_KERNEL);
> +	if (!aw88081)
> +		return -ENOMEM;
> +
> +	mutex_init(&aw88081->lock);
> +
> +	i2c_set_clientdata(i2c, aw88081);
> +
> +	aw88081->regmap = devm_regmap_init_i2c(i2c, &aw88081_regmap_config);
> +	if (IS_ERR(aw88081->regmap)) {
> +		ret = PTR_ERR(aw88081->regmap);
> +		return dev_err_probe(&i2c->dev, ret, "failed to init regmap: %d\n", ret);

No need to repeat 'ret' at theend of the message.

> +	}
> +
> +	/* aw pa init */
> +	ret = aw88081_init(aw88081, i2c, aw88081->regmap);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_snd_soc_register_component(&i2c->dev,
> +			&soc_codec_dev_aw88081,
> +			aw88081_dai, ARRAY_SIZE(aw88081_dai));
> +	if (ret)
> +		dev_err(&i2c->dev, "failed to register aw88081: %d", ret);

dev_err_probe() to be consistent?

> +
> +	return ret;
> +}

...

CJ

