Return-Path: <linux-kernel+bounces-346589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC498C64D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FED1C21E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4C1CDA25;
	Tue,  1 Oct 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adamthiede.com header.i=@adamthiede.com header.b="pYEr9wyN"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F919D894
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812306; cv=none; b=oB79qxZqY0QjaA10hVLdQPH1TEkiNweDs1KaqdpcLT44/SIeRW2XOgi7mMGZhXBvqS8aIjwKgUY12Zy5Q2g6bzjLSbWtXZX+bupI9F5up0b8D2NMU+RGunUjLawxVQlcMS+EWYSeQ3xTobfIQs1tRDoXu/UkH1D8sn8+NNtap78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812306; c=relaxed/simple;
	bh=AA/5ZNImXG5czBPFTj6rzjiHuMPybhtYtg1wJnOkah0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5UIYHad7ZdflGwHUIOHZaSSkz2Ry2ZqTfWKY91P8eKYbzzg6RF8BunjoHJ0WsR+tJ7jCJ3u7ldJhrDaEObYOedCI77nof4u+fKb99HUM4Civ+7OBelSWCH8Yqjsl/ChxOOEi7xMKAqU4HZGfyfiNSgCXgH0XzsxD3FtaJjC4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adamthiede.com; spf=pass smtp.mailfrom=adamthiede.com; dkim=pass (2048-bit key) header.d=adamthiede.com header.i=@adamthiede.com header.b=pYEr9wyN; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adamthiede.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adamthiede.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XJ7qV3fYjz9spl;
	Tue,  1 Oct 2024 21:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adamthiede.com;
	s=MBO0001; t=1727812294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f56Ec7nkXAWaHidG9MVJC9xGOXG9fDXGRzEcMSTsWqs=;
	b=pYEr9wyNzJKbxau9z2yhPRGSveg8p2OlMBPoRMdrJbreWUeyf0cawPLpATQFhMoPNZHIl8
	HKP+hY2Gga5n/5JpsXDUWI2rr53El1bD3JbWaQ14J82g6pFK9mFedN1GwiSswqgL3osLwS
	HwzLZIl4nM73tBEmWHK2tAwGKWztU4tuw31PFBMd/YLi8cujGU9K9Nm0Es9DYt/FPUy4RG
	inSgmWK4KkQalUbRH09dqi4z1qJwpYIuuC5yke2E7RRm1yLehMbHSmkcvHxLDDzNkWfBfL
	y+kyQeVAKJMsqfrv8NPQK2z20L/JjLB/gqUMYV8mcx6H3q9mdTC4tOlOhgwtOQ==
Message-ID: <5975b361-c1b4-4c57-89d4-0d247ae99d8c@adamthiede.com>
Date: Tue, 1 Oct 2024 14:51:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 13/14] drm/mediatek: Support DRM plane alpha in OVL
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 =?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 "djkurtz@chromium.org" <djkurtz@chromium.org>,
 =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "littlecvr@chromium.org" <littlecvr@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
 <20240620-igt-v3-13-a9d62d2e2c7e@mediatek.com>
 <1a3af354-bd15-4219-960e-089b6a6e673c@adamthiede.com>
 <49df03e8b982cc5ee97e09ef9545c1d138c32178.camel@mediatek.com>
 <00ebe9ca262b6a95fd726e5be06334b1e923db02.camel@mediatek.com>
Content-Language: en-US
From: Adam Thiede <me@adamthiede.com>
Autocrypt: addr=me@adamthiede.com; keydata=
 xsBNBF+n+90BCAC2ZRLVcvdXDgfY7EppN05eNor3U7/eeiNCCEIWZkYLhikUEP1ReLGBkXpK
 Pc70hfnKAKkCoth3IwhDty9WXMNU+iLNei4ieb2luW+UqluR6xIUIA+txahMU9YcjVaQTKf/
 yZWO4yl6pfBPCxC2UdPZKBAdGoi5NnE0ABFNbhBETQhhBic533lZn33ByupfI3acECnQdjgQ
 llCUpDbw4I+S/N1iFiEHcbMXH7ZB00e3IYNorZ1E9v7p++5rDY1fQ9gXpieg1vFKwSq1NJWo
 9xx336YjaTUbX0EwrdKd9l8AktA3yRjckaK5TAcwSQaDtHvhpbl4ebvPhtwHh699MroXABEB
 AAHNH0FkYW0gVGhpZWRlIDxtZUBhZGFtdGhpZWRlLmNvbT7CwI4EEwEIADgCGwMFCwkIBwIG
 FQoJCAsCBBYCAwECHgECF4AWIQQtG9pGQ7sz3tf8M/kC7fV9o/vRzgUCZL1HxQAKCRAC7fV9
 o/vRzgyRB/wLqRCvvWhQCMgvzeKvru9wcXquhb77K8H/ByLbfiT8YBuP3lZFVh0IQhgO9Ylk
 fIoOJE4V+jjxyOnO2d9xjGbvAmmR6yT0gfLzSVWqrC4k+V9MWLv43nrNzxt41dvo5j824FAl
 X+zaiRZCdO8Jtxg5Elpiop2SKLi1utX1Z8i6YZh+ccJZlchUBAGUTk+D4UjK7vUcjLWT96ya
 CtdtTfXyw36CvGOPEWfc6++Kkl/5sgej1i7biPYzu/r0vssaQYTXKSrv6Cfa3Maa89ASiTtv
 q4qmhLnJeCrPxWlRAf6LEizeBEkOasYni2u8sp4wBezEq45Ozu45sfPkqLpPolG7zsBNBF+n
 +90BCADBRt+vrToRBEG580n77S99qSEkbKD+oJtCVyovnjMNkg0K9UG68LIeCX/ezngiV1M8
 JISvw5iFOuUFqGX/1hLl9wgt/YpuIrgWOp8XxkotavTCloLDvQmufJPO1L8bnnA+WgP2YgVZ
 5MJTj/t4DI+yQgysEjsH8aurHO2uuqgJE+xK+2dy6Cl/wskuGxObksSPmmFH5PH0Joziwrtl
 61ouLE2XwKbkMgIGEKkbFgbfwz3/QuLZGBni+OOtLzXeZ9wNTW/AHUPy6S9U4F+5z6/09fVT
 tTH0cvrgAGjbASlYx2VqGONXAsxCfjulq6ryJBFlPLp949c/JTTgOojukCSbABEBAAHCwHYE
 GAEIACACGwwWIQQtG9pGQ7sz3tf8M/kC7fV9o/vRzgUCZL1H0gAKCRAC7fV9o/vRzlamCACs
 vHw+0heTm+BfC3S8DUST6889gidIIwdqBep1ByzetCph7Bq8Y8BlT5YTX0u/bSKkxCzFgeTm
 vC341Q09ST2XjLAl1ZTdzGhH9gcgYyOw34pr5fPQRJLB392mPzD8YReRzciNbhWzj+DLgeVe
 ouyfGajd6jDjkf4FEq+trQLGZhpfsKn3JnDbzBUs945D50l/vz9q/QN3qZO+H4F6g8ZeMnqo
 FOEFN26xVtdEDr+0DNFsbgKmEzs675kdAY78ZZdbEetX/FSknxJ+FK1ZW3J7Yswwulj34AXP
 LB49Mk8Ot7fo6mdt0DkV11JS9LmKxKvpY+KTlrKG+i7pVCSZvVUx
In-Reply-To: <00ebe9ca262b6a95fd726e5be06334b1e923db02.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/24 13:02, Jason-JH Lin (林睿祥) wrote:
> On Tue, 2024-10-01 at 08:55 +0000, CK Hu (胡俊光) wrote:
>> Hi, Jason:
>> 
>> Would you clarify this problem?
>> 
> 
> OK~
> 
>> Regards,
>> CK
>> 
>> On Mon, 2024-09-30 at 12:48 -0500, Adam Thiede wrote:
>> >   
>> > External email : Please do not click links or open attachments
>> > until you have verified the sender or the content.
>> >  On 6/19/24 11:38, Hsiao Chien Sung via B4 Relay wrote:
>> > > From: Hsiao Chien Sung <shawn.sung@mediatek.com>
>> > > 
>> > > Set the plane alpha according to DRM plane property.
>> > > 
>> > > Reviewed-by: CK Hu <ck.hu@mediatek.com>
>> > > Reviewed-by: AngeloGioacchino Del Regno <
>> > > angelogioacchino.delregno@collabora.com>
>> > > Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek
>> > > SoC MT8173.")
>> > > Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
>> > > ---
>> > >   drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 6 ++++--
>> > >   1 file changed, 4 insertions(+), 2 deletions(-)
>> > > 
>> > > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>> > > b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>> > > index 943db4f1bd6b..4b370bc0746d 100644
>> > > --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>> > > +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>> > > @@ -458,8 +458,10 @@ void mtk_ovl_layer_config(struct device
>> > > *dev, unsigned int idx,
>> > >   }
>> > >   
>> > >   con = ovl_fmt_convert(ovl, fmt);
>> > > -if (state->base.fb && state->base.fb->format->has_alpha)
>> > > -con |= OVL_CON_AEN | OVL_CON_ALPHA;
>> > > +if (state->base.fb) {
>> > > +con |= OVL_CON_AEN;
>> > > +con |= state->base.alpha & OVL_CON_ALPHA;
> 
> Hi Adam,
> 
> Could you print out the "fmt", "state->base.fb->format-
>>has_alpha", "state->base.alpha" and "con" here?
> 
> pr_info("fmt:0x%x, has_alpha:0x%x, alpha:0x%x, con:0x%x \n",
>          fmt, state->base.fb->format->has_alpha,
>          state->base.alpha, con);
> 
> I'm not sure if it's the color format setting problem, maybe there is
> something wire configuration here, such as XRGB8888 with alpha or
> ARGB8888 without alpha.
> 
> So I want these information to compare with my MT8188. Thanks!
> 
> Regards,
> Jason-JH.Lin
> 
Jason, thank you for your timely reply. I added the code you provided to 
my patch, and now get this line on endless repeat in dmesg:

fmt:0x34325258, has_alpha:0x0, alpha:0xffff, con:0x2000

This line also shows up sometimes in there, but I have no idea what 
triggers it.

fmt:0x34325241, has_alpha:0x1, alpha:0xffff, con:0x21ff

Does that help?

-Adam

>> > > +}
>> > >   
>> > >   /* CONST_BLD must be enabled for XRGB formats although the
>> > > alpha channel
>> > >    * can be ignored, or OVL will still read the value from
>> > > memory.
>> > > 
>> > 
>> > Hello, I believe that this commit has caused a problem for my
>> > Lenovo 
>> > C330 Chromebook running postmarketOS.
>> > 
>> > With kernel 6.11 this device didn't show any text on the tty or
>> > splash 
>> > screen during booting, but graphical environments (wayland, xorg)
>> > do 
>> > appear. With a few bisects I found it to be this commit. With it 
>> > reverted I'm able to get text on the tty again.
>> > 
>> > The kernel config is here: 
>> > 
> https://gitlab.com/adamthiede/pmaports/-/tree/mt8173-611/device/community/linux-postmarketos-mediatek-mt8173/
>> > To be perfectly clear, this device is not running Chrome OS.
>> > 
>> > I'm still rather new at this so it's also likely I got something
>> > wrong 
>> > or have a bad configuration option. If there is any more
>> > information I 
>> > can provide please let me know. Thank you.
>> > 
>> > - Adam Thiede
> 
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!


