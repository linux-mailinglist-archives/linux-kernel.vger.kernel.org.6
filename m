Return-Path: <linux-kernel+bounces-424400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597BC9DB3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD6B280AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C479014D444;
	Thu, 28 Nov 2024 08:40:46 +0000 (UTC)
Received: from mail-m1973182.qiye.163.com (mail-m1973182.qiye.163.com [220.197.31.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1D84A5E;
	Thu, 28 Nov 2024 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783246; cv=none; b=TWAbzKU6HJWB19q74wdtrlsk9P4wZhfskvWncHnl3dBljdwoahxryszkY3z5YxGVOXVAhIrhzgQZrEoxKEO4wo5PTuDOYrxCKh8Uxk+b9/nmzCrbYl/+fn8tVQh4yvfd2jMxmFwxBLj1M1I1w+RNSuXIvccNNf3XM3Fm7bMQG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783246; c=relaxed/simple;
	bh=w2Ang674l3xVJXig2G2WxQg6IdJriW3xKbVhfT9/pB0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Smz81CNdHvnajhuKVmZ5AaKHJPUDyhuNPqMZ68cRPXxYxnJPj5GFCffKizRUhM0UA7PG47zA8nuUJYt8v0VvEV2ENovc2R5CFpWW/qzSsCGjV2lgtJzoVn84YA+2kr+S+OPqRmI6zVAs67ag1wJZSx084sbk94zNXuLjm+3sQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com; spf=pass smtp.mailfrom=senarytech.com; arc=none smtp.client-ip=220.197.31.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from liubo (unknown [61.183.143.78])
	by smtp.qiye.163.com (Hmail) with ESMTP id 418c5dcf;
	Thu, 28 Nov 2024 16:25:22 +0800 (GMT+08:00)
From: <bo.liu@senarytech.com>
To: "'Takashi Iwai'" <tiwai@suse.de>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<feng.liu@senarytech.com>
References: <20241128060812.433362-1-bo.liu@senarytech.com> <874j3r6db8.wl-tiwai@suse.de>
In-Reply-To: <874j3r6db8.wl-tiwai@suse.de>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFYyXSBBTFNBOiBoZGEvY29uZXhhbnQ6IGZpeA==?=
	=?gb2312?B?IFo2ME1SMTAwIHN0YXJ0dXAgcG9wIGlzc3Vl?=
Date: Thu, 28 Nov 2024 16:25:22 +0800
Message-ID: <022d01db416f$116441c0$342cc540$@senarytech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMrWkn+9TygIvGGzZPRK0+dhYw6ywJv+I/3sBimmDA=
Content-Language: zh-cn
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0sfVkofHhgfGh1DTUJOQlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKQ0hVSk9IVUxDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a9371dff33709d9kunm418c5dcf
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6MSo5GTIuHSMIIjw3Hh8L
	HQgaCh9VSlVKTEhJTENJSElISk9JVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBSUNDTDcG

> On Thu, 28 Nov 2024 07:08:12 +0100,
> bo liu wrote:
> > 
> > When Z60MR100 startup, speaker will output a pop. To fix this issue, 
> > we mute codec by init verbs in bios when system startup, and set GPIO 
> > to low to unmute codec in codec driver when it loaded .
> > 
> > Signed-off-by: bo liu <bo.liu@senarytech.com>
> > ---
> >  sound/pci/hda/patch_conexant.c | 35 
> > ++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/sound/pci/hda/patch_conexant.c 
> > b/sound/pci/hda/patch_conexant.c index e851785ff058..62c53e64bcad 
> > 100644
> > --- a/sound/pci/hda/patch_conexant.c
> > +++ b/sound/pci/hda/patch_conexant.c
> > @@ -42,6 +42,7 @@ struct conexant_spec {
> >  	unsigned int gpio_led;
> >  	unsigned int gpio_mute_led_mask;
> >  	unsigned int gpio_mic_led_mask;
> > +	unsigned int gpio_unmute_bit_mask;
> >  	bool is_cx8070_sn6140;
> >  };
> >  
> > @@ -308,6 +309,7 @@ enum {
> >  	CXT_FIXUP_HP_MIC_NO_PRESENCE,
> >  	CXT_PINCFG_SWS_JS201D,
> >  	CXT_PINCFG_TOP_SPEAKER,
> > +	CXT_FIXUP_HP_A_U,
> >  };
> >  
> >  /* for hda_fixup_thinkpad_acpi() */
> > @@ -762,6 +764,24 @@ static void cxt_setup_mute_led(struct hda_codec
*codec,
> >  	}
> >  }
> >  
> > +static void cxt_setup_mute_gpio_and_unmute(struct hda_codec *codec,
> > +				unsigned int gpio_mute_mask)
> > +{
> > +	struct conexant_spec *spec = codec->spec;
> > +
> > +	if (gpio_mute_mask) {
> > +		spec->gpio_unmute_bit_mask = gpio_mute_mask;
>
> Any reason to store this in spec?  As far as I see the code below, it's
used only locally here, so it doesn't have to be stored there.

The purpose of adding this is to differentiate the configuration of the
LED_MUTE GPIO and to retain debugging information. Of course, this field can
be removed if desired.

> > +
> > +		//set gpio data to 0.

> Put a space after "//".

OK.

> > +		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
0);
> > +		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
> > +					spec->gpio_unmute_bit_mask);
> > +		snd_hda_codec_write(codec, 0x01, 0,
AC_VERB_SET_GPIO_DIRECTION,
> > +					spec->gpio_unmute_bit_mask);
> > +		snd_hda_codec_write(codec, 0x01, 0,
AC_VERB_SET_GPIO_STICKY_MASK, 0);
> > +	}
> > +}
> > +
> >  static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
> >  				const struct hda_fixup *fix, int action)  {
@@ -776,6 +796,15 @@ 
> > static void cxt_fixup_hp_zbook_mute_led(struct hda_codec *codec,
> >  		cxt_setup_mute_led(codec, 0x10, 0x20);  }
> >  
> > +static void cxt_fixup_hp_a_u(struct hda_codec *codec,
> > +			const struct hda_fixup *fix, int action) {
> > +	//Init vers in BIOS mute the spk/hp by set gpio high to avoid pop
noise,
> > +	//so need to unmute once by clearing the gpio data when runs into
the system.

> Ditto.


thanks,

Takashi


