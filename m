Return-Path: <linux-kernel+bounces-230230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ABA917A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3661F23F64
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5121415DBB9;
	Wed, 26 Jun 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NJdrA4CJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77315820F;
	Wed, 26 Jun 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388200; cv=none; b=TQaecArPB4Z/eSRpSyvMuTTdjTcE+V0S3IwhVRYlKUasVLbKcaNVXsiFbOt3vbr+qs9i5+tNv7mteP8OUhWcNWD/FmXt7eO1qPGFW2y9p8f2Xf0OgmlvWO+Ezu5g8FDcFylPoXeSLXe2rFdSLCl6gpJ7iZfKv1sMShaMsKmgNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388200; c=relaxed/simple;
	bh=9QQfkTqGG0QhCMsMVbYtu53vc1iWZc7ZgkRrLlMchWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0wCCT0Nkg8GrIoDfaIi5jzGxv9HkTa+VzQWNr9xT5851+8WY8U8M4GHWA/nj0K0fdK3c3CcNR++K7RibQqahd7y4dq7fhDhFPOFxGh6F46PC+WONdc/FQLCdGtFyeWEyX4z5a15Btc8wUFcOyUl11s/lM3SZZ1zjHVCxMd+dNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NJdrA4CJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719388196;
	bh=9QQfkTqGG0QhCMsMVbYtu53vc1iWZc7ZgkRrLlMchWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NJdrA4CJL4+8nPwAEvW3sG2WdUSiZG76Na/Inya71e1MmguanYYNHJBnXQtO95jb0
	 KHtin9jIbd0OPkXU3JIipGO2OowdHWuJ73hW4oi0wTEawJmzJ+zUcLljq299J4kHmq
	 J8lbJOV7uQHyJ4tHJQNJ4IU1dNdJJ/gevVbhmOzYA6btbjd3LLahWKBOPgoPeOdjZD
	 XyENIzLuDe771IoEkneVqR26p2BtgRutpTghOsQ3YtdCKNmM2L+UfUDEPQe6K9F+pd
	 169Ef7pYgZb1SiJtDXFVkdqmiujX0qyafT9JUh9oumB3xZdcxeUBIfKQ+8DkcpJ86G
	 BXrQI1tjR+8Vw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D09A237810CD;
	Wed, 26 Jun 2024 07:49:55 +0000 (UTC)
Message-ID: <b838b9a9-0ce3-40a5-b7a5-d1c825a0fa20@collabora.com>
Date: Wed, 26 Jun 2024 09:49:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: Allow setting readable driver names
 through kconfig
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240625-mt8195-driver-name-too-long-v1-1-8573b43a9868@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240625-mt8195-driver-name-too-long-v1-1-8573b43a9868@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/06/24 22:23, Nícolas F. R. A. Prado ha scritto:
> Commit c8d18e440225 ("ASoC: core: clarify the driver name
> initialization") introduced an error message when driver names are
> automatically generated and result in truncated names.
> 
> For example, this error message is printed on mt8195-cherry-tomato-rev2:
> 
>    mt8195_mt6359 mt8195-sound: ASoC: driver name too long 'sof-mt8195_r1019_5682' -> 'sof-mt8195_r101'
> 
> Since that truncated driver name is already used by userspace (eg UCM),
> it can't be unconditionally updated.
> 
> As suggested by Jaroslav, update the driver name but hide it behind a
> kernel config option, which Linux distributions can enable once the
> corresponding support in userspace audio configuration software lands.
> This ensures that audio doesn't regress, while still allowing the error
> to be fixed.

I can propose the following plan of action for such a rename:
  1. Temporarily have both UCMs
  2. Wait until distros update their packages
  3. Change the name in kernel without extra config options
  4. Remove the now deprecated UCMs

...that's requiring a bit of time, yes, but I think this is the best way to
ensure that no breakage happens in the meantime for any users.

Anyone disagreeing? Does anyone have any better idea?

Cheers,
Angelo

> 
> Suggested-by: Jaroslav Kysela <perex@perex.cz>
> Link: https://lore.kernel.org/all/8d0ccf4a-a6d9-f914-70a9-c2ad55af3a04@perex.cz
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   sound/soc/mediatek/Kconfig                         | 10 ++++++++++
>   sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |  3 +++
>   sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |  3 +++
>   sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 13 ++++++++++++-
>   sound/soc/mediatek/mt8186/mt8186-mt6366.c          | 16 +++++++++++++++-
>   sound/soc/mediatek/mt8188/mt8188-mt6359.c          |  7 ++++++-
>   sound/soc/mediatek/mt8195/mt8195-mt6359.c          |  7 ++++++-
>   7 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 5a8476e1ecca..396d558bc75b 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -281,6 +281,16 @@ config SND_SOC_MT8195
>   	  Select Y if you have such device.
>   	  If unsure select "N".
>   
> +config SND_SOC_MTK_READABLE_DRIVER_NAME
> +	bool "Readable driver name for MediaTek sound cards"
> +	help
> +	  This explicitly sets the driver name for the MediaTek sound cards to
> +	  prevent it from potentially being truncated and harder to read. The
> +	  new names require support in the audio configuration userspace
> +	  utilities (like UCM), so only select this once they have been updated
> +	  to support the new names to ensure working audio.
> +	  If unsure select "N".
> +
>   config SND_SOC_MT8195_MT6359
>   	tristate "ASoC Audio driver for MT8195 with MT6359 and I2S codecs"
>   	depends on I2C && GPIOLIB
> diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
> index 4ed06c269065..9155bb29c0a2 100644
> --- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
> +++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
> @@ -173,6 +173,9 @@ static struct snd_soc_codec_conf mt8173_rt5650_rt5514_codec_conf[] = {
>   
>   static struct snd_soc_card mt8173_rt5650_rt5514_card = {
>   	.name = "mtk-rt5650-rt5514",
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = "mtk-rt5514",
> +#endif
>   	.owner = THIS_MODULE,
>   	.dai_link = mt8173_rt5650_rt5514_dais,
>   	.num_links = ARRAY_SIZE(mt8173_rt5650_rt5514_dais),
> diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
> index 763067c21153..212b36a0559f 100644
> --- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
> +++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
> @@ -229,6 +229,9 @@ static struct snd_soc_codec_conf mt8173_rt5650_rt5676_codec_conf[] = {
>   
>   static struct snd_soc_card mt8173_rt5650_rt5676_card = {
>   	.name = "mtk-rt5650-rt5676",
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = "mtk-rt5676",
> +#endif
>   	.owner = THIS_MODULE,
>   	.dai_link = mt8173_rt5650_rt5676_dais,
>   	.num_links = ARRAY_SIZE(mt8173_rt5650_rt5676_dais),
> diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
> index f848e14b091a..2664e3d14fec 100644
> --- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
> +++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
> @@ -19,6 +19,8 @@
>   #include "../common/mtk-afe-platform-driver.h"
>   #include "mt8183-afe-common.h"
>   
> +#define DRIVER_NAME "mt8183_da7219"
> +
>   #define DA7219_CODEC_DAI "da7219-hifi"
>   #define DA7219_DEV_NAME "da7219.5-001a"
>   #define RT1015_CODEC_DAI "rt1015-aif"
> @@ -649,6 +651,9 @@ static const struct snd_soc_dapm_route mt8183_da7219_max98357_dapm_routes[] = {
>   
>   static struct snd_soc_card mt8183_da7219_max98357_card = {
>   	.name = "mt8183_da7219_max98357",
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = DRIVER_NAME,
> +#endif
>   	.owner = THIS_MODULE,
>   	.controls = mt8183_da7219_max98357_snd_controls,
>   	.num_controls = ARRAY_SIZE(mt8183_da7219_max98357_snd_controls),
> @@ -706,6 +711,9 @@ static const struct snd_soc_dapm_route mt8183_da7219_rt1015_dapm_routes[] = {
>   
>   static struct snd_soc_card mt8183_da7219_rt1015_card = {
>   	.name = "mt8183_da7219_rt1015",
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = DRIVER_NAME,
> +#endif
>   	.owner = THIS_MODULE,
>   	.controls = mt8183_da7219_rt1015_snd_controls,
>   	.num_controls = ARRAY_SIZE(mt8183_da7219_rt1015_snd_controls),
> @@ -723,6 +731,9 @@ static struct snd_soc_card mt8183_da7219_rt1015_card = {
>   
>   static struct snd_soc_card mt8183_da7219_rt1015p_card = {
>   	.name = "mt8183_da7219_rt1015p",
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = DRIVER_NAME,
> +#endif
>   	.owner = THIS_MODULE,
>   	.controls = mt8183_da7219_max98357_snd_controls,
>   	.num_controls = ARRAY_SIZE(mt8183_da7219_max98357_snd_controls),
> @@ -875,7 +886,7 @@ MODULE_DEVICE_TABLE(of, mt8183_da7219_max98357_dt_match);
>   
>   static struct platform_driver mt8183_da7219_max98357_driver = {
>   	.driver = {
> -		.name = "mt8183_da7219",
> +		.name = DRIVER_NAME,
>   #ifdef CONFIG_OF
>   		.of_match_table = mt8183_da7219_max98357_dt_match,
>   #endif
> diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366.c b/sound/soc/mediatek/mt8186/mt8186-mt6366.c
> index 771d53611c2a..29f17dfb8f1b 100644
> --- a/sound/soc/mediatek/mt8186/mt8186-mt6366.c
> +++ b/sound/soc/mediatek/mt8186/mt8186-mt6366.c
> @@ -31,6 +31,8 @@
>   #include "mt8186-afe-gpio.h"
>   #include "mt8186-mt6366-common.h"
>   
> +#define DRIVER_NAME "mt8186_mt6366"
> +
>   #define RT1019_CODEC_DAI	"HiFi"
>   #define RT1019_DEV0_NAME	"rt1019p"
>   
> @@ -1119,6 +1121,9 @@ mt8186_mt6366_rt1019_rt5682s_controls[] = {
>   
>   static struct snd_soc_card mt8186_mt6366_da7219_max98357_soc_card = {
>   	.name = "mt8186_da7219_max98357",
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = DRIVER_NAME,
> +#endif
>   	.owner = THIS_MODULE,
>   	.dai_link = mt8186_mt6366_rt1019_rt5682s_dai_links,
>   	.num_links = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_dai_links),
> @@ -1134,6 +1139,9 @@ static struct snd_soc_card mt8186_mt6366_da7219_max98357_soc_card = {
>   
>   static struct snd_soc_card mt8186_mt6366_rt1019_rt5682s_soc_card = {
>   	.name = "mt8186_rt1019_rt5682s",
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = DRIVER_NAME,
> +#endif
>   	.owner = THIS_MODULE,
>   	.dai_link = mt8186_mt6366_rt1019_rt5682s_dai_links,
>   	.num_links = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_dai_links),
> @@ -1149,6 +1157,9 @@ static struct snd_soc_card mt8186_mt6366_rt1019_rt5682s_soc_card = {
>   
>   static struct snd_soc_card mt8186_mt6366_rt5682s_max98360_soc_card = {
>   	.name = "mt8186_rt5682s_max98360",
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = DRIVER_NAME,
> +#endif
>   	.owner = THIS_MODULE,
>   	.dai_link = mt8186_mt6366_rt1019_rt5682s_dai_links,
>   	.num_links = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_dai_links),
> @@ -1164,6 +1175,9 @@ static struct snd_soc_card mt8186_mt6366_rt5682s_max98360_soc_card = {
>   
>   static struct snd_soc_card mt8186_mt6366_rt5650_soc_card = {
>   	.name = "mt8186_rt5650",
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = DRIVER_NAME,
> +#endif
>   	.owner = THIS_MODULE,
>   	.dai_link = mt8186_mt6366_rt1019_rt5682s_dai_links,
>   	.num_links = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_dai_links),
> @@ -1380,7 +1394,7 @@ MODULE_DEVICE_TABLE(of, mt8186_mt6366_dt_match);
>   
>   static struct platform_driver mt8186_mt6366_driver = {
>   	.driver = {
> -		.name = "mt8186_mt6366",
> +		.name = DRIVER_NAME,
>   #if IS_ENABLED(CONFIG_OF)
>   		.of_match_table = mt8186_mt6366_dt_match,
>   #endif
> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> index eba6f4c445ff..2640981a2463 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> @@ -23,6 +23,8 @@
>   #include "../common/mtk-dsp-sof-common.h"
>   #include "../common/mtk-soc-card.h"
>   
> +#define DRIVER_NAME "mt8188_mt6359"
> +
>   #define CKSYS_AUD_TOP_CFG	0x032c
>    #define RG_TEST_ON		BIT(0)
>    #define RG_TEST_TYPE		BIT(2)
> @@ -1240,6 +1242,9 @@ static void mt8188_fixup_controls(struct snd_soc_card *card)
>   }
>   
>   static struct snd_soc_card mt8188_mt6359_soc_card = {
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = DRIVER_NAME,
> +#endif
>   	.owner = THIS_MODULE,
>   	.dai_link = mt8188_mt6359_dai_links,
>   	.num_links = ARRAY_SIZE(mt8188_mt6359_dai_links),
> @@ -1392,7 +1397,7 @@ MODULE_DEVICE_TABLE(of, mt8188_mt6359_dt_match);
>   
>   static struct platform_driver mt8188_mt6359_driver = {
>   	.driver = {
> -		.name = "mt8188_mt6359",
> +		.name = DRIVER_NAME,
>   		.of_match_table = mt8188_mt6359_dt_match,
>   		.pm = &snd_soc_pm_ops,
>   	},
> diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> index ca8751190520..da406cbb40f6 100644
> --- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> @@ -26,6 +26,8 @@
>   #include "mt8195-afe-clk.h"
>   #include "mt8195-afe-common.h"
>   
> +#define DRIVER_NAME "mt8195_mt6359"
> +
>   #define RT1011_SPEAKER_AMP_PRESENT		BIT(0)
>   #define RT1019_SPEAKER_AMP_PRESENT		BIT(1)
>   #define MAX98390_SPEAKER_AMP_PRESENT		BIT(2)
> @@ -1231,6 +1233,9 @@ static struct snd_soc_codec_conf max98390_codec_conf[] = {
>   };
>   
>   static struct snd_soc_card mt8195_mt6359_soc_card = {
> +#if IS_ENABLED(CONFIG_SND_SOC_MTK_READABLE_DRIVER_NAME)
> +	.driver_name = DRIVER_NAME,
> +#endif
>   	.owner = THIS_MODULE,
>   	.dai_link = mt8195_mt6359_dai_links,
>   	.num_links = ARRAY_SIZE(mt8195_mt6359_dai_links),
> @@ -1530,7 +1535,7 @@ MODULE_DEVICE_TABLE(of, mt8195_mt6359_dt_match);
>   
>   static struct platform_driver mt8195_mt6359_driver = {
>   	.driver = {
> -		.name = "mt8195_mt6359",
> +		.name = DRIVER_NAME,
>   		.of_match_table = mt8195_mt6359_dt_match,
>   		.pm = &snd_soc_pm_ops,
>   	},
> 
> ---
> base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
> change-id: 20240625-mt8195-driver-name-too-long-095a030a2e86
> 
> Best regards,




