Return-Path: <linux-kernel+bounces-320088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DEA970603
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0511F22130
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DBB13C672;
	Sun,  8 Sep 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GCj7k49T"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DBB13635B;
	Sun,  8 Sep 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725786770; cv=none; b=WIXGO44BNXvGYTuOZRrJypEk//V5s8FSL+5IAmQfVlNv1hpcSIKx3CjnFVPTIU0AQp7OZs/u+2Ch55wSecmew1b/vm9Cte7f6OlrfvSDXYatXDEVPMO3KtXMYgfedht0M4UcpYanuKjSwuWBG1rQ+B3dm8M/x5V6GReBLM3jjQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725786770; c=relaxed/simple;
	bh=DG8z1BQmAAA0Lc71ZeDOdTuGe04gc7DnYCtpQRynvB0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BfQpAXXW17gn6niaAidEWFGYWocyOJTXG9gLAi7mCVHDhRXDfm3dmJeUlp+e22VY/jLpE+25WainRhiIsve1GG/wFqtTb74rxFxXcNmX2JxjNAHizkUIYnPu7QVBACv31HZkXjKsKcLto05ByMYG0NRFv8ysbHWkmp883oLiV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GCj7k49T; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725786702; x=1726391502; i=markus.elfring@web.de;
	bh=WCMJWEieh/sXV2CRivFT84rsK/t+kM3zpH1slTwVITk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GCj7k49Tx/Lbx9BOMox0uWwLn5BevksJ8proerqSJxEF6ETIuNFBL1hyXbXX+ouh
	 aQbtsnnttRHBarnvr0TNcVdsl0CAgCFLdNlNKHIiwlawR0yur6FWW08S2rKrjhnde
	 JAnPiL661yKYygz6Rn/Xst4cVb4suSX1FzZSTlTGf8/ZDsS6CwUIjDOKaqi/38WUl
	 BcyiqCI+BTCiOmjEa509/AHQmp1ZqUgu7tLtyZfyiSGexn5XPhff1Za5+2TZdZvlP
	 yWmmcdsiBWlsOBGjuVOZxKJ4LoW+Ww2hc0uDsv0HcJ6ovt0nKiDRUO70v30iL9Tif
	 StwdfmPS1INWbIgq/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3uS-1s87a02mnC-00mEdG; Sun, 08
 Sep 2024 11:11:42 +0200
Message-ID: <ab8a17d0-9505-4e81-b5ec-4a3025c48245@web.de>
Date: Sun, 8 Sep 2024 11:11:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Algea Cao <algea.cao@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Andy Yan <andy.yan@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Mark Yao <markyao0591@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexandre Arnoud <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>
References: <20240831-b4-rk3588-bridge-upstream-v5-2-9503bece0136@collabora.com>
Subject: Re: [PATCH v5 2/4] drm/bridge: synopsys: Add DW HDMI QP TX Controller
 support library
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240831-b4-rk3588-bridge-upstream-v5-2-9503bece0136@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PJluZpNkDXlZ3wkBX5/Gqh/OwUEU3EH/o63oMUDBKTJGS5rOy8l
 tLwTiwnKIsd0JwYJGqrZj40eP3l+rSCYh1XNNEcr3iyt0ouyCKinmqYbQhMRzBCstjxX4Hh
 CodzD4RfYB1DsHm1q1+vztQUEr8oK+KWPwJUzVHsCsEsRCcFyiq22MOdN8/XyNoeqbCxw09
 /7R1YQdoLWnNnrbOautug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RoHr7exywYI=;VDzCZb0+H1eula7sqILN1mFZDuw
 rzBqr//2R5GEMKkyiriv5zyZqUaS4/00MPyIZtZaMkHm+a2lDmymIwCLE2DbX2qd+5tBczgE8
 0BXJ1VpSKZhFwLLld6/yzGqWvmZ0wI5KGRTqyLd+AEcgn2aCEYePFeb51ACMkJFA3isHDBCzF
 pZG+jq8WWdMFEHop9PPBy/bQRzHqrXdMAjpIkzsPfSRg72vwQM0xQjItM1ePNPde0jbH/oDTd
 LflTRZxkbj4lZ0jc7tljIUwoPZOA4bRWPSEgXTubzuH3O9cLmN7TqBkP8Ar77kdnfBm3fdx5r
 WIE+uHxOq+DhETnKm4fFrlEPWtz1uvQ/K6a2t3LtvKM59ifQJZaQONxH3rSUS3sVSnt7/T6FS
 ldO0wJ0IhAlhP1ziHsqmmz8bv4laJ2jb/s42l0icSfIKr6rxc73SHfLy1pxFiRbknZjDXWIlg
 a2Lzdd0KP07/Rgq/E4/VFXCc2HgM6jEsTlvYxDZNXZZXuyECOetT/Ut9ms8Iatvi/vYAl6Dja
 y5BAqbzCh+clapxDa8Ek62E6cD6CK4e8u40h8L94gdIDrPBj7zfELurEC03KupzyMn2PTDae0
 6GSATlihwoboef7AvG1ExMmOYjBMkfK3uwscUD+u8037oMEMY0iWpOuQie20EswoN9rPzp5lz
 5Qjglihp0gwyi51kRHGbHoLX2tViqVCmwZ/agCygCpaU7O3KAXJoYZUrCZ3GL3PLBGMaUVogh
 ho8PJXJBeZGS8ltsLuAepk+W0+zRMaAxebaZsrjmcYx89pRbpRnVjmmeeoINdELpxtnpZX4Uo
 1yk6rGl8IIOCh1xgQ01u+2Sw==

=E2=80=A6
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -0,0 +1,708 @@
=E2=80=A6
> +static int dw_hdmi_qp_i2c_xfer(struct i2c_adapter *adap,
> +			       struct i2c_msg *msgs, int num)
> +{
=E2=80=A6
> +	mutex_lock(&i2c->lock);
=E2=80=A6
> +	dw_hdmi_qp_mod(hdmi, 0, I2CM_OP_DONE_MASK_N | I2CM_NACK_RCVD_MASK_N,
> +		       MAINUNIT_1_INT_MASK_N);
> +
> +	mutex_unlock(&i2c->lock);
> +
> +	return ret;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&i2c->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.11-rc6/source/include/linux/mutex.h#L1=
96

Regards,
Markus

