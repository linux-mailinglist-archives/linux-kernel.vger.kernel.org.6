Return-Path: <linux-kernel+bounces-258257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D3393858D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6386E1F21182
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DED166317;
	Sun, 21 Jul 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cYLc4XD4"
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB71026AED
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721580578; cv=none; b=PTjTNdHwrWvPtpktX/74B2nrdrhiH3D9yYel0wrARfpUKqbePaYV+r6YiVu6Cl5dDnWIwZk+m/aWrrcvf5HJ731JY+aXQa2GTVgFVoNZagIb4L1aH+TgU0/Nzw196t6GTmDbqjnJwg+AV65NeJCz9hB1pxDYV44goM20Wa+bGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721580578; c=relaxed/simple;
	bh=zvRzlREeawXqJKfd4Teyd4qnwsRRHMn9xza2CyRaXNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MciOV8Y8hNb+4GtvBESkleSfw+XrPc31iznnrzCbM6JaNU+cMMSq5Nl4n6RaBs68FAJbu5FwpVhCUEredIJPCIJVLfeFZCOK6MucFniNWWTnNrUpYKSZ0kGoqGGgFFOHvCYWVz/8mSX1EQ19sJnuAVlD8l7zrnR0YwfLBZd/rlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cYLc4XD4; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id VZCLs1rcXnx6kVZCLsRyfl; Sun, 21 Jul 2024 18:14:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721578455;
	bh=I/piV9JbjlGXoNPHWPRA7QfnTh18wJNUP3H64VZRZmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=cYLc4XD4eExqEtUxOnEegeUzxFLklbGwdfPVF2ePZdC7M/Mk9HevfL4FUr5gKpMvu
	 ZDnbGU2+fN/Ttbwbs85vg1sZbedDc5KFJYJYycpuhhbAv2aet9ac/qDnTzLXiEzMCs
	 wwjQZ7RnaeSLBWv+W5kvSOoP3JQyxv23bwDMROquUZq/Ap1ZUyacQfvP37dlLVT12b
	 RQrabf9F+uNtbsCAH6qmKu2sX0LDUBZYuFjayPFJdRDFwk84OB+XU6leIVCgrgYY+n
	 KefcuoyFi6Fu8TgyM2AcuYy5Z5udDhrN6UMQtvZE+xcQRtEekJteRP93VQMXLs0Te+
	 P34blWYxEXh0w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 21 Jul 2024 18:14:15 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8b5a4a19-971a-4573-84ae-fd9d63fab799@wanadoo.fr>
Date: Sun, 21 Jul 2024 18:14:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] ALSA: hda/tas2781: Add tas2781 hda SPI driver
To: Baojun Xu <baojun.xu@ti.com>, tiwai@suse.de
Cc: robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 lgirdwood@gmail.com, perex@perex.cz, pierre-louis.bossart@linux.intel.com,
 kevin-lu@ti.com, shenghao-ding@ti.com, navada@ti.com, 13916275206@139.com,
 v-hampiholi@ti.com, v-po@ti.com, niranjan.hy@ti.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
 broonie@kernel.org, soyer@irl.hu
References: <20240721142258.504-1-baojun.xu@ti.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240721142258.504-1-baojun.xu@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/07/2024 à 16:22, Baojun Xu a écrit :
> This patch was used to add TAS2781 devices on SPI support in sound/pci/hda.
> It use ACPI node descript about parameters of TAS2781 on SPI, it like:
>      Scope (_SB.PC00.SPI0)
>      {
>          Device (GSPK)
>          {
>              Name (_HID, "TXNW2781")  // _HID: Hardware ID
>              Method (_CRS, 0, NotSerialized)
>              {
>                  Name (RBUF, ResourceTemplate ()
>                  {
>                      SpiSerialBusV2 (...)
>                      SpiSerialBusV2 (...)
>                  }
>              }
>          }
>      }
> 
> And in platform/x86/serial-multi-instantiate.c, those spi devices will be
> added into system as a single SPI device, so TAS2781 SPI driver will
> probe twice for every single SPI device. And driver will also parser
> mono DSP firmware binary and RCA binary for itself.
> The code support Realtek as the primary codec.
> In patch version-10, add multi devices firmware binary support,
> to compatble with windows driver, they can share same firmware binary.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> 
> ---

Hi, a few nitpicks below, should they make sense and a v11 be sent.

Only one true question in tasdevice_load_block_kernel() about error 
handling.

CJ

...

> +struct tasdevice_priv {
> +	struct tasdevice_fw *cali_data_fmw;
> +	struct tasdevice_rca rcabin;
> +	struct tasdevice_fw *fmw;
> +	struct gpio_desc *reset;
> +	struct mutex codec_lock;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct tm tm;
> +
> +	const char *acpi_subsystem_id;
> +	unsigned char crc8_lkp_tbl[CRC8_TABLE_SIZE];
> +	unsigned char coef_binaryname[64];
> +	unsigned char rca_binaryname[64];
> +	unsigned char dev_name[32];
> +
> +	unsigned int err_code;
> +	bool is_loading;
> +	bool is_loaderr;
> +	int cur_book;
> +	int cur_prog;
> +	int cur_conf;
> +	int fw_state;
> +	int index;
> +	int irq;
> +	void *codec;
> +	bool force_fwload_status;
> +	bool playback_started;

If these bool were moved with the other ones, it could avoid some holes 
in the structure.

> +	unsigned int cali_data[CALIB_MAX];
> +	unsigned int cali_reg_array[CALIB_MAX];
> +
> +	int (*fw_parse_variable_header)(struct tasdevice_priv *tas_priv,
> +					const struct firmware *fmw,
> +					int offset);
> +	int (*fw_parse_program_data)(struct tasdevice_priv *tas_priv,
> +				     struct tasdevice_fw *tas_fmw,
> +				     const struct firmware *fmw, int offset);
> +	int (*fw_parse_configuration_data)(struct tasdevice_priv *tas_priv,
> +					   struct tasdevice_fw *tas_fmw,
> +					   const struct firmware *fmw,
> +					   int offset);
> +	int (*tasdevice_load_block)(struct tasdevice_priv *tas_priv,
> +				    struct tasdev_blk *block);
> +
> +	int (*save_calibration)(struct tasdevice_priv *tas_priv);
> +	void (*apply_calibration)(struct tasdevice_priv *tas_priv);
> +};

...

> +struct tasdevice_table {
> +	int reg;
> +	unsigned char data[8];
> +};
> +
> +static struct tasdevice_table tas2781_pre_reset_table[] = {

Nitpick: const? (I think that the compiler can guess it by its own)

> +	/* Values setting for pre-reset. */

Nitpick: Given the name of the array, is this comment useful?

> +	{ TASDEVICE_REG(0x00, 0x00, 0x02), {0x01, 0x1a, },},
> +	{ TASDEVICE_REG(0x00, 0x01, 0x37), {0x01, 0x3a, },},
> +	{ TASDEVICE_REG(0x00, 0xfd, 0x0d), {0x01, 0x0d, },},
> +	{ TASDEVICE_REG(0x00, 0xfd, 0x06), {0x01, 0xc1, },},
> +	{ TASDEVICE_REG(0x00, 0x01, 0x19), {0x01, 0xe0, },},
> +	{ TASDEVICE_REG(0x00, 0xfd, 0x0d), {0x01, 0x0d, },},
> +	{ TASDEVICE_REG(0x00, 0xfd, 0x06), {0x01, 0xd5, },},
> +	{ TASDEVICE_REG(0x00, 0x00, 0x00), {0x01, 0x00, },},
> +};
> +
> +static struct tasdevice_table tas2781_post_reset_table[] = {

Same 2 comemnts

> +	/* Values setting for post-reset. */
> +	{ TASDEVICE_REG(0x00, 0x01, 0x37), {0x01, 0x3a, },},
> +	{ TASDEVICE_REG(0x00, 0xfd, 0x0d), {0x01, 0x0d, },},
> +	{ TASDEVICE_REG(0x00, 0xfd, 0x06), {0x01, 0xc1, },},
> +	{ TASDEVICE_REG(0x00, 0xfd, 0x06), {0x01, 0xd5, },},
> +	{ TASDEVICE_REG(0x00, 0xfd, 0x0a), {0x01, 0x01, },},
> +	{ TASDEVICE_REG(0x00, 0x00, 0x00), {0x01, 0x00, },},
> +};

...

> +static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
> +{
> +	int j, rc;

Nitpick: i is more usual. (same things apply in some other places)

> +
> +	/*
> +	 * If no calibration data exist in tasdevice_priv *tas_priv,
> +	 * calibration apply will be ignored, and use default values
> +	 * in firmware binary, which was loaded during firmware download.
> +	 */
> +	if (tas_priv->cali_data[0] == 0)
> +		return;
> +	/*
> +	 * Calibration data was saved in tasdevice_priv *tas_priv as:
> +	 * unsigned int cali_data[CALIB_MAX];
> +	 * and every data (in 4 bytes) will be saved in register which in
> +	 * book 0, and page number in page_array[], offset was saved in
> +	 * rgno_array[].
> +	 */
> +	for (j = 0; j < CALIB_MAX; j++) {
> +		rc = tasdevice_spi_dev_bulk_write(tas_priv,
> +			tas_priv->cali_reg_array[j],
> +			(unsigned char *)&tas_priv->cali_data[j], 4);
> +		if (rc < 0)
> +			dev_err(tas_priv->dev,
> +				"chn %d calib %d bulk_wr err = %d\n",
> +				tas_priv->index, j, rc);
> +	}
> +}

...

> +/* Block process function. */
> +static int tasdevice_load_block_kernel(
> +	struct tasdevice_priv *tasdevice, struct tasdev_blk *block)
> +{
> +	const unsigned int blk_size = block->blk_size;
> +	unsigned char *data = block->data;
> +	unsigned int i, length;
> +
> +	for (i = 0, length = 0; i < block->nr_subblocks; i++) {
> +		int rc = tasdevice_process_block(tasdevice, data + length,
> +			block->dev_idx, blk_size - length);
> +		if (rc < 0) {
> +			dev_err(tasdevice->dev,
> +				"%s: %u %u sublock write error\n",
> +				__func__, length, blk_size);
> +			break;
> +		}
> +		length += rc;
> +		if (blk_size < length) {
> +			dev_err(tasdevice->dev, "%s: %u %u out of boundary\n",
> +				__func__, length, blk_size);
> +			break;
> +		}
> +	}

Should an error code be returned if we reach one of the break above?
This error code is checked by the callers, so it looks strange to me to 
always return 0.

> +
> +	return 0;
> +}

...

> +/*
> + * Return Code:
> + * true -- the registers are in the inblock yram
> + * false -- the registers are NOT in the inblock yram
> + */
> +static bool check_inblock_yram(struct tas_crc *cd, unsigned char book,
> +	unsigned char page, unsigned char reg, unsigned char len)
> +{
> +	bool in = false;
> +
> +	if (book == TAS2781_YRAM_BOOK1 || book == TAS2781_YRAM_BOOK2)
> +		in = check_inblock_yram_bk(cd, page, reg, len);
> +
> +	return in;
> +}

Nitpick: Add a new line?
If you agree, several other places above also needs to be updated.

> +/* yram page check. */

...

> +static int dspfw_default_callback(struct tasdevice_priv *tas_priv,
> +	unsigned int drv_ver, unsigned int ppcver)
> +{
> +	int rc = 0;
> +
> +	if (drv_ver == 0x100) {
> +		if (ppcver >= PPC3_VERSION) {
> +			tas_priv->fw_parse_variable_header =
> +				fw_parse_variable_header_kernel;
> +			tas_priv->fw_parse_program_data =
> +				fw_parse_program_data_kernel;
> +			tas_priv->fw_parse_configuration_data =
> +				fw_parse_configuration_data_kernel;
> +			tas_priv->tasdevice_load_block =
> +				tasdevice_load_block_kernel;
> +		} else {
> +			switch (ppcver) {
> +			case 0x00:

if it was:

		} else (ppcver == 0x00) {
			...
		} else {
		}

it would save 1 level of tabulation.

> +				tas_priv->fw_parse_variable_header =
> +					fw_parse_variable_header_git;
> +				tas_priv->fw_parse_program_data =
> +					fw_parse_program_data;
> +				tas_priv->fw_parse_configuration_data =
> +					fw_parse_configuration_data;
> +				tas_priv->tasdevice_load_block =
> +					tasdevice_load_block;
> +				break;
> +			default:
> +				dev_err(tas_priv->dev,
> +					"%s: PPCVer must be 0x0 or 0x%02x",
> +					__func__, PPC3_VERSION);
> +				dev_err(tas_priv->dev, " Current:0x%02x\n",
> +					ppcver);

Why spliting into 2 dev_err()?

> +				rc = -EINVAL;
> +				break;
> +			}
> +		}
> +	} else {
> +		dev_err(tas_priv->dev,
> +			"DrvVer must be 0x0, 0x230 or above 0x230 ");
> +		dev_err(tas_priv->dev, "current is 0x%02x\n", drv_ver);

Why spliting into 2 dev_err()?

The comment does not seem to match the test above (if (drv_ver == 0x100)).

> +		rc = -EINVAL;
> +	}
> +
> +	return rc;
> +}

...

> +/* DSP firmware program load function. */
> +int tasdevice_spi_select_tuningprm_cfg(void *context, int prm_no,
> +	int cfg_no, int rca_conf_no)
> +{
> +	struct tasdevice_priv *tas_priv = context;
> +	struct tasdevice_rca *rca = &tas_priv->rcabin;
> +	struct tasdevice_config_info **cfg_info = rca->cfg_info;
> +	struct tasdevice_fw *tas_fmw = tas_priv->fmw;
> +	struct tasdevice_prog *program;
> +	struct tasdevice_config *conf;
> +	int prog_status = 0;
> +	int status;
> +
> +	if (!tas_fmw) {
> +		dev_err(tas_priv->dev, "%s: Firmware is NULL\n", __func__);
> +		return 0;
> +	}
> +
> +	if (cfg_no >= tas_fmw->nr_configurations) {
> +		dev_err(tas_priv->dev,
> +			"%s: cfg(%d) is not in range of conf %u\n",
> +			__func__, cfg_no, tas_fmw->nr_configurations);
> +		return 0;
> +	}
> +
> +	if (prm_no >= tas_fmw->nr_programs) {
> +		dev_err(tas_priv->dev,
> +			"%s: prm(%d) is not in range of Programs %u\n",
> +			__func__, prm_no, tas_fmw->nr_programs);
> +		return 0;
> +	}
> +
> +	if (rca_conf_no >= rca->ncfgs ||
> +	    rca_conf_no < 0 ||
> +	    !cfg_info) {
> +		dev_err(tas_priv->dev,
> +			"conf_no:%d should be in range from 0 to %u\n",
> +			rca_conf_no, rca->ncfgs-1);
> +		return 0;
> +	}
> +
> +	if (prm_no >= 0	&&
> +	   (tas_priv->cur_prog != prm_no ||
> +	    tas_priv->force_fwload_status)) {
> +		tas_priv->cur_conf = -1;
> +		tas_priv->is_loading = true;
> +		prog_status++;
> +	}
> +
> +	if (prog_status) {
> +		program = &tas_fmw->programs[prm_no];
> +		tasdevice_load_data(tas_priv, &program->dev_data);
> +		if (tas_priv->is_loaderr == false &&
> +		    tas_priv->is_loading == true) {
> +			struct tasdevice_fw *cal_fmw =
> +				tas_priv->cali_data_fmw;
> +
> +			if (cal_fmw) {
> +				struct tasdevice_calibration
> +					*cal = cal_fmw->calibrations;
> +
> +				if (cal)
> +					load_calib_data(tas_priv,
> +						&cal->dev_data);
> +			}
> +			tas_priv->cur_prog = prm_no;
> +		}
> +

Nitpick: Unneeded extra new line.

> +	}
> +
> +	if (cfg_no &&
> +	   (cfg_no != tas_priv->cur_conf) &&
> +	   (tas_priv->is_loaderr == false)) {
> +		status++;
> +		tas_priv->is_loading = true;
> +	} else {
> +		tas_priv->is_loading = false;
> +	}
> +	if (status) {
> +		conf = &tas_fmw->configs[cfg_no];
> +		status = 0;
> +		tasdevice_load_data(tas_priv, &conf->dev_data);
> +		if (tas_priv->is_loaderr == true) {
> +			status |= 1 << 4;
> +		} else if (tas_priv->is_loaderr == false &&
> +			   tas_priv->is_loading == true) {
> +			tas_priv->cur_conf = cfg_no;
> +		}
> +	} else {
> +		dev_dbg(tas_priv->dev, "%s: Unneeded loading dsp conf %d\n",
> +			__func__, cfg_no);
> +	}
> +
> +	return prog_status;
> +}
> +
> +/* DSP firmware program load interface function. */
> +int tasdevice_spi_prmg_load(void *context, int prm_no)

This always called with prm_no = 0 and the returned value is never 
checked/used.

Does it make sense to simplify things?

> +{
> +	struct tasdevice_priv *tas_priv = context;
> +	struct tasdevice_fw *tas_fmw = tas_priv->fmw;
> +	struct tasdevice_prog *program;
> +	struct tasdevice_config *conf;
> +	int prog_status = 0;
> +
> +	if (!tas_fmw) {
> +		dev_err(tas_priv->dev, "%s: Firmware is NULL\n", __func__);
> +		return 0;
> +	}
> +
> +	if (prm_no >= tas_fmw->nr_programs) {
> +		dev_err(tas_priv->dev,
> +			"%s: prm(%d) is not in range of Programs %u\n",
> +			__func__, prm_no, tas_fmw->nr_programs);
> +		return 0;
> +	}
> +
> +	if (prm_no >= 0) {
> +		tas_priv->cur_conf = 0;
> +		tas_priv->is_loading = true;
> +		prog_status++;
> +	}
> +	if (prog_status) {
> +		program = &tas_fmw->programs[prm_no];
> +		tasdevice_load_data(tas_priv, &program->dev_data);
> +		tas_priv->cur_prog = prm_no;
> +	}
> +	if (prog_status) {

Nitpick: Why testing again and not merging with the lines above?

> +		conf = &tas_fmw->configs[tas_priv->cur_conf];
> +		tasdevice_load_data(tas_priv, &conf->dev_data);
> +	}
> +
> +	return prog_status;
> +}
> +
> +/* DSP firmware program switch interface function. */
> +void tasdevice_spi_tuning_switch(void *context, int state)
> +{
> +	struct tasdevice_priv *tas_priv = context;
> +	int profile_cfg_id = tas_priv->rcabin.profile_cfg_id;
> +
> +	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
> +		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
> +		return;
> +	}
> +
> +	if (state == 0) {
> +		tasdevice_spi_select_cfg_blk(tas_priv, profile_cfg_id,
> +			TASDEVICE_BIN_BLK_PRE_POWER_UP);
> +	} else {
> +		tasdevice_spi_select_cfg_blk(tas_priv, profile_cfg_id,
> +			TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
> +	}

Nitpick: { } could be dropped on both branch.

> +}


