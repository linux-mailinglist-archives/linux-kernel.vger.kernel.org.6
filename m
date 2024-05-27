Return-Path: <linux-kernel+bounces-191477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDB18D1019
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AC91C218D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F61667EE;
	Mon, 27 May 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="IGHQr9is"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC275161B58
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716848069; cv=none; b=FAf6uJgXtOR1oyhWpj+akq7oLi5URlfc4F60P9Vz8ffOkkcDZLh0NjZv/n3S4SFQXOzTXZr4vAkht2iFlIF0tdgDuN6a5NfMS4Lrlzlexckg2EhpiVc141i8mulV4Wd+StEdgQ2ylrD4rcT9ShBGGkCHVQ6TNBghJkxqoDHhBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716848069; c=relaxed/simple;
	bh=HXu8FO1ScNVR3jbl9HR/Vt1CMWulFYMmliuYqg76wkw=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRSvsMWF/DS+2wyGTgIoPKnuyvxwlPTZv8//sh5/Y3BwjheK6W6L8er1VGkd3j9k48Xq45dM12umgdxI8Xt8iW/piOWvX9QJjB6ynYTZnqG1Sc61aT8vhDpdZ4HT3MgrVYEFtu6j1dKs8Pn0oNmvAyChuFP88ukFRPf6UHvEPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=IGHQr9is; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1716848065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnZ/NUIKzPnirf4nzS8FsKuGvYh2MR991UL4fFHPwO0=;
	b=IGHQr9iszj6g7WZYaa2WxnCqObS9wjX+wmrILoqd0qwIfKD7ZV1Gy9wcIX0s3yRYOUw9g7
	spQvOraVGUghBymnz2UaYZZQa1Qh0T86Cd5SIYEb5lsQTuMQxsKPiZsAMz0PR8dsXNb6u4
	saUafCkEbA+yf0Ftk/AYo1iPgdym15rTqitQNvFfUXMANtcUR9UquykghQKNfFUuzJ0XqS
	tC0j1hpFWd1P82j3ZKHHH1kMDiR+26hAgjlFdTV4ATw4Yb6Ebpe/Iv2f3GX+gVIG5/AuPJ
	tK/B/po651uYGQ8hw3R0zls/uBmcy17wC6qxD8tZUf+sWgGMp9RTi/uL9BITpA==
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: hjc@rock-chips.com
X-Envelope-To: andy.yan@rock-chips.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 27 May 2024 19:13:59 -0300
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
Subject: Re: [PATCH v2 1/2] drm/rockchip: vop: clear DMA stop bit upon vblank
 on RK3066
To: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Cc: stable@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>, Andy Yan
	<andy.yan@rock-chips.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Message-Id: <BF06ES.TD22854ZPLB92@packett.cool>
In-Reply-To: <1817371.3VsfAaAtOV@diego>
References: <2024051930-canteen-produce-1ba7@gregkh>
	<20240527071736.21784-1-val@packett.cool> <1817371.3VsfAaAtOV@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT



On Mon, May 27 2024 at 22:43:18 +02:00:00, Heiko St=FCbner=20
<heiko@sntech.de> wrote:
> Hi Val,
>=20
> Am Montag, 27. Mai 2024, 09:16:33 CEST schrieb Val Packett:
>>  On the RK3066, there is a bit that must be cleared, otherwise
>>  the picture does not show up
>> on the display (at least for RGB).
>>=20
>>  Fixes: f4a6de8 ("drm: rockchip: vop: add rk3066 vop definitions")
>>  Cc: stable@vger.kernel.org
>>  Signed-off-by: Val Packett <val@packett.cool>
>>  ---
>>  v2: doing this on vblank makes more sense; added fixes tag
>=20
> can you give a rationale for this please?
>=20
> I.e. does this dma-stop bit need to be set on each vblank that happens
> to push this frame to the display somehow?


The only things I'm 100% sure about:

- that bit is called dma_stop in the Android kernel's header;
- without ever setting that bit to 1, it was getting set to 1 by the=20
chip itself, as logging the register on flush was showing a 1 in that=20
position (it was the only set bit - I guess others aren't readable=20
after cfg_done?);
- without clearing it "between" frames, the whole screen is always=20
filled with noise, the picture is not visible.

The rest is at least a bit (ha) speculative:

As I understand from what the name implies, the hardware sets it to=20
indicate that it has scanned out the frame and is waiting for=20
acknowledgment (clearing) to be able to scan out the next frame. I=20
guess it's a redundant synchronization mechanism that was removed in=20
later iterations of the VOP hardware block.

I've been trying to see if moving where I clear the bit affects the=20
sort-of-tearing-but-vertical glitches that sometimes happen, especially=20
early on after the system has just booted, but that seems to be=20
completely unrelated pixel clock craziness (the Android kernel runs the=20
screen at 66 fps, interestingly).

I'm fairly confident that both places are "correct". The reason I'm=20
more on the side of vblank now is that it made logical sense to me when=20
I thought about it more: acknowledging that the frame has been scanned=20
out is a reaction to the frame having been scanned out. It's a=20
consequence of *that* that the acknowledgment is required for the next=20
frame to be drawn.

Unless we can get the opinion of someone closely familiar with this=20
decade-old hardware, we only have this reasoning to go off of :)

~val
>=20



