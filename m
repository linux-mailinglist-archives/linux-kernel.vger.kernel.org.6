Return-Path: <linux-kernel+bounces-517925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDC4A38797
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13B01894973
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F0224AF0;
	Mon, 17 Feb 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a1VS6O25"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748121B199;
	Mon, 17 Feb 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806458; cv=none; b=lVV7ZAlRUanDVykEtzI1tRE5wo1Ynms2Qe+AioBQB93+Zwag1SyjE/2DbtKfSFWGZIqFO7H+nNf3Y1HPoI2SPEDpRGLx7APHFC8JhK5D4ZnbymVj5yjNfgRvSX3c5NzlATgDxoXR0kIOXq0tPMY9r6ypCLz+BmIIXslRtCEgPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806458; c=relaxed/simple;
	bh=lyGfHrjhZ3jptbHzIILAzBz3U/SLoQdMy2EzDU6nSXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2ogsJ6FavwxsYC6HTABFeXDD8rH70eRQZDZt7hs7cpTFBgm7QcKP7jpXDC47zopWM3/Vo6E0cDCpJBjuLMsBD91Dqo1gWtAsPLXIMgNPGzUzRoXBuGcaL6lnpY9qrmuJaz8qT0vu0Vw6gqZTFd7rA5Cqwb4QxxLjOjigab+gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a1VS6O25; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739806454;
	bh=lyGfHrjhZ3jptbHzIILAzBz3U/SLoQdMy2EzDU6nSXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a1VS6O25oIsd0ptLDudjGC9gQqK/8d9OW1uYWMPEwY/goXTIElKTAw6J5Juio8/qd
	 14MqJJ2qkXQa3WITW6nDmoWe6RO4oSIug3DhUgU31l33ycBd9NvI4/e2aD8YMM71px
	 exrlMpEQ3n42aZTu9NmpZclEvnAAjkb6bft7PAEdZEdfoBnQGwT5Mjb3hzGYoT7RxA
	 fD3i9IE7RFHdy67eG/+cqq0T3Y4ReU7vEzoJ+tPORmhgp47M6REl2ELw7S0R1laiop
	 fJI67ItULKckWvdchfZgmUh76Xd7TKaS8vti1ngdk8SpXwEhN5gDza0YADdtAkn+7k
	 ztQjn0KGh52XQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7D92817E1507;
	Mon, 17 Feb 2025 16:34:13 +0100 (CET)
Message-ID: <5d09d32b-d5cf-44a9-96de-30c8b5e23256@collabora.com>
Date: Mon, 17 Feb 2025 16:34:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 27/42] drm/mediatek: mtk_hdmi: Move output init to
 mtk_hdmi_register_audio_driver()
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "jie.qiu@mediatek.com" <jie.qiu@mediatek.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 =?UTF-8?B?TGV3aXMgTGlhbyAo5buW5p+P6YieKQ==?= <Lewis.Liao@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 =?UTF-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?= <TommyYL.Chen@mediatek.com>,
 =?UTF-8?B?SXZlcyBDaGVuamggKOmZs+S/iuW8mCk=?= <Ives.Chenjh@mediatek.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "junzhi.zhao@mediatek.com" <junzhi.zhao@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
 <20250211113409.1517534-28-angelogioacchino.delregno@collabora.com>
 <6378d714b5f5197b70aba1adaa6ca5d358aa2c41.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <6378d714b5f5197b70aba1adaa6ca5d358aa2c41.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/02/25 04:20, CK Hu (胡俊光) ha scritto:
> On Tue, 2025-02-11 at 12:33 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>>
>>
>> In preparation for moving the common bits of this driver, merge the
>> contents of mtk_hdmi_output_init in mtk_hdmi_register_audio_driver
>> function to aggregate all of the initial audio setup together in
>> the same function and to make it clear that all of the setup that
>> is performed in mtk_hdmi_output_init is specifically related only
>> to audio and not video.
>>
>> While at it, also remove the "%s driver bound to HDMI" debugging
>> print disguised as informative.
> 
> Previous reply only to Angelo, so re-replay to all agian.
> 
> This patch does not include print modification,
> After remove this message,
> 

Sorry, forgot to remove that, too many patches to care about :')

Removing for v7.

Thanks!
Angelo

> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> 
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_hdmi.c | 27 ++++++++-------------------
>>   1 file changed, 8 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> index e43dbcc0d068..98e8c186dff4 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> @@ -1025,20 +1025,6 @@ static int mtk_hdmi_setup_vendor_specific_infoframe(struct mtk_hdmi *hdmi,
>>          return 0;
>>   }
>>
>> -static int mtk_hdmi_output_init(struct mtk_hdmi *hdmi)
>> -{
>> -       struct hdmi_audio_param *aud_param = &hdmi->aud_param;
>> -
>> -       aud_param->aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
>> -       aud_param->aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
>> -       aud_param->aud_input_type = HDMI_AUD_INPUT_I2S;
>> -       aud_param->aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
>> -       aud_param->aud_mclk = HDMI_AUD_MCLK_128FS;
>> -       aud_param->aud_input_chan_type = HDMI_AUD_CHAN_TYPE_2_0;
>> -
>> -       return 0;
>> -}
>> -
>>   static void mtk_hdmi_audio_enable(struct mtk_hdmi *hdmi)
>>   {
>>          mtk_hdmi_hw_send_aud_packet(hdmi, true);
>> @@ -1617,6 +1603,7 @@ static void mtk_hdmi_unregister_audio_driver(void *data)
>>   static int mtk_hdmi_register_audio_driver(struct device *dev)
>>   {
>>          struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
>> +       struct hdmi_audio_param *aud_param = &hdmi->aud_param;
>>          struct hdmi_codec_pdata codec_data = {
>>                  .ops = &mtk_hdmi_audio_codec_ops,
>>                  .max_i2s_channels = 2,
>> @@ -1626,6 +1613,13 @@ static int mtk_hdmi_register_audio_driver(struct device *dev)
>>          };
>>          int ret;
>>
>> +       aud_param->aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
>> +       aud_param->aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
>> +       aud_param->aud_input_type = HDMI_AUD_INPUT_I2S;
>> +       aud_param->aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
>> +       aud_param->aud_mclk = HDMI_AUD_MCLK_128FS;
>> +       aud_param->aud_input_chan_type = HDMI_AUD_CHAN_TYPE_2_0;
>> +
>>          hdmi->audio_pdev = platform_device_register_data(dev,
>>                                                           HDMI_CODEC_DRV_NAME,
>>                                                           PLATFORM_DEVID_AUTO,
>> @@ -1668,11 +1662,6 @@ static int mtk_hdmi_probe(struct platform_device *pdev)
>>          mutex_init(&hdmi->update_plugged_status_lock);
>>          platform_set_drvdata(pdev, hdmi);
>>
>> -       ret = mtk_hdmi_output_init(hdmi);
>> -       if (ret)
>> -               return dev_err_probe(dev, ret,
>> -                                    "Failed to initialize hdmi output\n");
>> -
>>          ret = mtk_hdmi_register_audio_driver(dev);
>>          if (ret)
>>                  return dev_err_probe(dev, ret,
>> --
>> 2.48.1
>>
> 


