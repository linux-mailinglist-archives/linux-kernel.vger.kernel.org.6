Return-Path: <linux-kernel+bounces-271042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740109448C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F0B1C24417
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AC116FF39;
	Thu,  1 Aug 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dIpJjCKA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1CDEEB3;
	Thu,  1 Aug 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505810; cv=none; b=JcJaEQE7yRb5JKL1OLv2URKhsO89sfLyWrCxPyV+ThUZ66IFuFDnRLhXoS2PqpkhkdcHA8FRKTpx3lDxia6S62DAsxLDnAMWvLDj69KkwaPylcNJak+67L7v9TtCjdn0ATeR8itLUpHe+AJpm/a9BVqQ9n4K5ammR+8fRDi/OXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505810; c=relaxed/simple;
	bh=++7YBygtyHrsIKH24UC+hO0yBDoc31paLAZPeS2iAeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPjM2t09EvSYpwKyHcFP7Qp7cbOHNA6ZHVmd26aqYXNydnnkkg8bZvkuMJWlvSJ1vvjlVy03vv2SMZEBJyA4JIK/M9wctgnD0YUgu65c1UwgCslKz2soHp9mrfmve7IFjbiw+NUFYduxnMhTTozSxuDqYovdFZImofIcFX2+W70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dIpJjCKA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722505806;
	bh=++7YBygtyHrsIKH24UC+hO0yBDoc31paLAZPeS2iAeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dIpJjCKAqtMZnaGMhWjBrKNVWJ+uLhaCBsWlNlDpsDy9pV1At1Ykqaf24L1+EGUa3
	 y2V8YSsQDVw/jTgmi+Y9i6yRMIBaK4dGoS4eiVdRgShNE4qyXyCQHouEA4UZ0TFfB5
	 cC/w5zcFw6k0QcDlrsOa9Bxu83HAhxd+zM9hwh+px/jhSKvzr2yTX4Dw6Clyze6/8R
	 X8mZdyI+UiIKaQXAHLMQmdF+X2LyAg00r0BlMyZU/QAgbl/8f4vbUJ71ynACX8+pW7
	 LNIovqrtThsU56K38SWNNX8fu7rbSoojnU8iDWJ8fJXT7CTpfw3tv22t4mcB6n52Zu
	 eFIo67TV5CylQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 47A71378220A;
	Thu,  1 Aug 2024 09:50:05 +0000 (UTC)
Message-ID: <aeeac627-2fce-45f2-b745-9e851a4dbd59@collabora.com>
Date: Thu, 1 Aug 2024 12:50:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andy Yan <andy.yan@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Luis de Arquer <ldearquer@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>,
 Robert Foss <rfoss@kernel.org>, devicetree@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-rockchip@lists.infradead.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Jonas Karlman <jonas@kwiboo.se>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20240801-b4-rk3588-bridge-upstream-v2-0-9fa657a4e15b@collabora.com>
 <20240801-b4-rk3588-bridge-upstream-v2-1-9fa657a4e15b@collabora.com>
 <172248345225.2862796.6921035362248469311.robh@kernel.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <172248345225.2862796.6921035362248469311.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 8/1/24 6:37 AM, Rob Herring (Arm) wrote:
>=20
> On Thu, 01 Aug 2024 05:25:52 +0300, Cristian Ciocaltea wrote:
>> Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1
>> Quad-Pixel (QP) TX controller IP.
>>
>> Since this is a new IP block, quite different from those used in the
>> previous generations of Rockchip SoCs, add a dedicated binding file.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../display/rockchip/rockchip,dw-hdmi-qp.yaml      | 188 ++++++++++++=
+++++++++
>>  1 file changed, 188 insertions(+)
>>
>=20
> My bot found errors running 'make dt_binding_check' on your patch:

This is because the referenced synopsys,dw-hdmi-qp.yaml is provided by a
separate patchset:

https://lore.kernel.org/lkml/20240801-dw-hdmi-qp-tx-v1-1-148f542de5fd@col=
labora.com/

> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/display/rockchip/rockchip,dw-hdmi-qp.example.dtb: hdmi@fde80000: False s=
chema does not allow {'compatible': ['rockchip,rk3588-dw-hdmi-qp'], 'reg'=
: [[0, 4259840000, 0, 131072]], 'clocks': [[4294967295, 528], [4294967295=
, 529], [4294967295, 530], [4294967295, 564], [4294967295, 594], [4294967=
295, 717]], 'clock-names': ['pclk', 'earc', 'ref', 'aud', 'hdp', 'hclk_vo=
1'], 'interrupts': [[0, 169, 4, 0], [0, 170, 4, 0], [0, 171, 4, 0], [0, 1=
72, 4, 0], [0, 360, 4, 0]], 'interrupt-names': ['avp', 'cec', 'earc', 'ma=
in', 'hpd'], 'phys': [[4294967295]], 'phy-names': ['hdmi'], 'power-domain=
s': [[4294967295, 26]], 'resets': [[4294967295, 462], [4294967295, 560]],=
 'reset-names': ['ref', 'hdp'], 'rockchip,grf': [[4294967295]], 'rockchip=
,vo1_grf': [[4294967295]], '#sound-dai-cells': 0, 'ports': {'#address-cel=
ls': 1, '#size-cells': 0, 'port@0': {'reg': [[0]], 'endpoint': {'remote-e=
ndpoint': [[4294967295]]}}, 'port@1': {'reg': [[1]]
>  , 'endpoint': {'remote-endpoint': [[4294967295]]}}}, '$nodename': ['hd=
mi@fde80000']}
> 	from schema $id: http://devicetree.org/schemas/display/rockchip/rockch=
ip,dw-hdmi-qp.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/display/rockchip/rockchip,dw-hdmi-qp.example.dtb: hdmi@fde80000: Unevalu=
ated properties are not allowed ('reg' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/display/rockchip/rockch=
ip,dw-hdmi-qp.yaml#
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2024=
0801-b4-rk3588-bridge-upstream-v2-1-9fa657a4e15b@collabora.com
>=20
> The base for the series is generally the latest rc1. A different depend=
ency
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to=

> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. No=
te
> that DT_SCHEMA_FILES can be set to your schema file to speed up checkin=
g
> your schema. However, it must be unset to test all examples with your s=
chema.
>=20

