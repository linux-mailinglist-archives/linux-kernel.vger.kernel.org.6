Return-Path: <linux-kernel+bounces-317954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A03596E602
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8403D1C21A49
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE41B2EC3;
	Thu,  5 Sep 2024 22:59:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159FF14F121;
	Thu,  5 Sep 2024 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725577174; cv=none; b=tsUcqQHbA5K5sdbP4Mwct5SPFAVHzKN6jjOabwYW56ls18v4wvVu/zaa2/lpM40+rXgLbK+XOde+gFc1b8RB80Y6cKjeMJH0JbtkmdMksaCJBrOw9EmrIZnGmpe+3Bq0x8+U3mKQIeFskUGR5ESOMfK3O/QgLl9XBvMEFmFiG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725577174; c=relaxed/simple;
	bh=IVj1CpJpWrMZkbLOmAh8pJn8rBEU5hLsJM2ZdHrtno8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoVeHRLc+oVhHzPAg44NLmPm1FbXsQ8hkNYdlcFRw+tLkuPuvo5K846ejjmiN2WbQ1XMi0CJDMbOtcEFNa92wYjsers4NZf86KLwhecx4T9oQ5dn+BBLJYDTBUnjN/XOjl1eULP2zZDHfMgWXQU8EkpSEFbkwROwGpAK1SsgNVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88308DA7;
	Thu,  5 Sep 2024 15:59:57 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 393F13F73B;
	Thu,  5 Sep 2024 15:59:29 -0700 (PDT)
Date: Thu, 5 Sep 2024 23:58:47 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] NanoPi NEO Plus2: Fix regulators and assign them
Message-ID: <20240905235847.3b4b1374@minigeek.lan>
In-Reply-To: <20240905-nanopi-neo-plus2-regfix-v3-0-1895dff59598@gmail.com>
References: <20240905-nanopi-neo-plus2-regfix-v3-0-1895dff59598@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Sep 2024 19:37:09 +0200
Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com> wrote:

Hi Kry=C5=A1tof,

thanks for the follow-up!

> Just minor changes based on feedback.
>=20
> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>

There is no need for a Signed-off-by: in the cover letter.
But you are supposed to add any tags, like my "Reviewed-by", to a new
revision.
I guess unfortunately you missed the v6.12 merge window by an hour or
so, but in any case I hope Chen-Yu can copy in the tags when applying.

> ---
> Changes in v3:
> - Renamed patches - added prefix.
> - Remove the patch that added regulator to emmc.
> - Link to v2: https://lore.kernel.org/r/20240827-nanopi-neo-plus2-regfix-=
v2-0-497684ec82c7@gmail.com

Thanks for the changelog, that's helpful. Ideally you would stack this
up with the changes from previous revisions, so listing the changes
from v1 .. v2 here as well.

Cheers,
Andre

>=20
> ---
> Kry=C5=A1tof =C4=8Cern=C3=BD (2):
>       arm64: dts: allwinner: H5: NanoPi Neo Plus2: Fix regulators
>       arm64: dts: allwinner: H5: NanoPi NEO Plus2: Use regulators for pio
>=20
>  .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   | 37 ++++++++++++++++=
++++++
>  1 file changed, 37 insertions(+)
> ---
> base-commit: 6f923748057a4f6aa187e0d5b22990d633a48d12
> change-id: 20240827-nanopi-neo-plus2-regfix-b60116ce12ca
>=20
> Best regards,


