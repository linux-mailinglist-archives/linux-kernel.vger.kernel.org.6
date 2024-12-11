Return-Path: <linux-kernel+bounces-441096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F039EC95D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22EC285CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DB1C1F22;
	Wed, 11 Dec 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="zTnDDMAH"
Received: from qs51p00im-qukt01080502.me.com (qs51p00im-qukt01080502.me.com [17.57.155.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C6236FB6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910138; cv=none; b=PMkhfd/52Z3OpG7KEyfjjhVfGsBu8L17vKQrcuSlBmmJp5JpBK+TVlPPFf1nsI0FqbeARWeJowoKkTswctVBe0kckUpw8FvCZKOc4mp/BV7EWhP+JSbWIVNGT9GZx/mrySD7u8Th47VlLnjjm6jNH/5EFTYMVCNOAJpP9967VUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910138; c=relaxed/simple;
	bh=F0tDbAiyUW0ypcYIWfgC7IJ8bUbLF1zDbzI7A6KxjyQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gzXyPwmOcbA6B9Q2O7ELTU8JKFZJ8qIc8v7bnQQq74qvvtU6dkb14DFiDRZBlfIPwtXzvUu6WEuDjWXtvFeTMJvT8OlO1pWkmy5IGzewD9UyYJe2IZxO/tY+w1NUJL0S4Ik/Gu+2N0agKvIpKbMAjayzbxYrxfC6GQL7xPXbyuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=zTnDDMAH; arc=none smtp.client-ip=17.57.155.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1733910135; bh=fq9JIGFqDS16sxn3B26QdkQ1K0WJfrg2r7kx5NZceXw=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:
	 x-icloud-hme;
	b=zTnDDMAH4Ey+MDZrcO8bYh3Wah8y9FtqGwW70+h1f9Z+CiMufChJPkVHKyfIl1hxN
	 ca6Hua3p1jSGQ2r3ELcrSfgdegVVJt3J4BANb79TEGQUMwXICzGWcms0mVMbsjvwVn
	 FYin/Tt6Rz2j1NalN8GiSAjn0BZzZlTbJZa2I3/UN5zFvG8oH7ursC8k9I5jzciYFG
	 8HzRRK0AC1SpQzCWO/ny0avQf7q71SwrS47V/gOoah1y94s70X0cU+AefLouGnRQdv
	 OSj5WqpFp+LwE+ZJr0wuphCWt65gYU4aTtJbkyaLYLp8sCdGrOCWIRdqIiIu90fXN9
	 u2C/dPT+E1IdQ==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080502.me.com (Postfix) with ESMTPSA id BD6064E401BB;
	Wed, 11 Dec 2024 09:42:12 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: [PATCH v2 0/4] Add support for HDMI1 output on RK3588 SoC
From: Alexandre ARNOUD <aarnoud@me.com>
In-Reply-To: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
Date: Wed, 11 Dec 2024 10:42:10 +0100
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 kernel@collabora.com,
 dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC29D61C-317D-4F82-AF42-EA3D705B0632@me.com>
References: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: Apple Mail (2.3696.120.41.1.10)
X-Proofpoint-ORIG-GUID: uroVR0O5J6T4E2ZKwd7zwAfbk9YM3ttp
X-Proofpoint-GUID: uroVR0O5J6T4E2ZKwd7zwAfbk9YM3ttp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_09,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 clxscore=1011 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412110073

Hello Cristian,

> On 11 Dec 2024, at 12:06 AM, Cristian Ciocaltea =
<cristian.ciocaltea@collabora.com> wrote:
>=20
> Changes in v2:
> - Override hdmi1 pinctrl-0 on rock-5b as it requires hdmim0_tx1_cec
>  instead of hdmim2_tx1_cec (fixes a pin conflict when enabling
>  CONFIG_SPI_ROCKCHIP_SFC)
> - Link to v1: =
https://lore.kernel.org/r/20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabor=
a.com
>=20
> ---
> Cristian Ciocaltea (4):
>      drm/rockchip: dw_hdmi_qp: Add support for RK3588 HDMI1 output
>      arm64: dts: rockchip: Add PHY node for HDMI1 TX port on RK3588
>      arm64: dts: rockchip: Add HDMI1 node on RK3588
>      arm64: dts: rockchip: Enable HDMI1 on rock-5b
>=20
> arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi  |  62 ++++++++++++
> arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts |  44 ++++++++-
> drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c  | 119 =
+++++++++++++++++++-----
> 3 files changed, 200 insertions(+), 25 deletions(-)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241207-rk3588-hdmi1-704cbb7cd75f

Tested-by: Alexandre ARNOUD <aarnoud@me.com>

Works perfectly on Rock-5B, thanks for your work.

Regards,

Alex=

