Return-Path: <linux-kernel+bounces-248897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902EF92E362
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24381C20C09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7315574C;
	Thu, 11 Jul 2024 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="ylW4lySg"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD812C559;
	Thu, 11 Jul 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689859; cv=none; b=r7Uz+rEpHfsHTX1wjbqe9cKky2t8DeGErbq5VSjlO/xGbC97FhO1/lqxpbmRiWzAUQN7Mh72hfGnFe2tZOppRNy0a6mTbWKFKYvJ/k5uV0NOWfKa8WixUlLRzJvfadINklcvoDTcT0osNx7dNiD/f+38Cp+nGNx4jedIRNMckFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689859; c=relaxed/simple;
	bh=9NjQY4CFdRSSUMACoTljrQZ0Eu6KQjt/PB+PShVspRE=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=e+arHWYKnZzQcRUW8lbVMj3XDF8iduVuRIRrk88Ollp+92RfC2IbLAFUBdSBUuZBfi46V8bXEivMyz54ey8EZI9n0rei6dsbxW+cFZi7d2hOi8HbOcJLLcCvjJ0WlPncD45xAH572FCFKQIzqOyJX0MtXz5494C/MfmY23RnWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=ylW4lySg; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id EBB993B6D;
	Thu, 11 Jul 2024 11:24:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1720689849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=9NjQY4CFdRSSUMACoTljrQZ0Eu6KQjt/PB+PShVspRE=;
	b=ylW4lySgGjMOXcWA3D57Rlg3dbXLsLi6lD8Ujp4QTPKR3fGsa7gtjsmw8eqrWbYAJ48HgC
	+GbmuDCeNgyCqRkhsRYQ8litN8fDDEM/99hNMyzOA3TNVMp/ppxC6XcOMDXJivVBYuLrOQ
	E7N8boUaduoWml1xbC3bK2bPL0qZogEV2AfD5xg05036jXZ7ASzfsshNXTWAmg3W1anF/w
	mF2eigXeK3ys5PkY/YoOIsCWoKvZ8FqFeY+jFWU6M9lgeedMWSxCh+lEzri4FF2kV0YFY2
	bZ7Zj8nF/1j0J3vm+TP1jlg0TE8wKRxmP+/0S8f8MoS2g7KdZab2gOLsWYeMPw==
Content-Type: multipart/signed;
 boundary=bd03c224a37c17e60929764b4547fa19bcf92c44aa38a8278f30359b2966;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 11 Jul 2024 11:24:06 +0200
Message-Id: <D2MLN7389BYY.1HZAQPLQNKU5T@walle.cc>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 <chunkuang.hu@kernel.org>, <ck.hu@mediatek.com>
Subject: Re: [PATCH v8 0/3] drm/mediatek: Add support for OF graphs
Cc: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
 <daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <matthias.bgg@gmail.com>,
 <shawn.sung@mediatek.com>, <yu-chang.lee@mediatek.com>,
 <jitao.shi@mediatek.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <wenst@chromium.org>,
 <kernel@collabora.com>, <sui.jingfeng@linux.dev>
From: "Michael Walle" <michael@walle.cc>
X-Mailer: aerc 0.16.0
References: <20240618101726.110416-1-angelogioacchino.delregno@collabora.com> <d84f1469-e82a-42de-94a0-8ee0da0cba02@collabora.com> <eef10e9f-dac5-4a05-a79c-f8026f27f051@collabora.com>
In-Reply-To: <eef10e9f-dac5-4a05-a79c-f8026f27f051@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--bd03c224a37c17e60929764b4547fa19bcf92c44aa38a8278f30359b2966
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > We've got a bunch of series that are waiting for this to get upstreamed=
, including
> > the addition of support for MT8365-EVK (already on mailing lists), MT83=
95 Radxa
> > NIO 12L, MT8395 Kontron SBC i1200 (not on mailing lists yet, waiting fo=
r this to
> > get merged), other than some other conversion commits for other MediaTe=
k DTs from
> > myself.

Yes this is the missing piece to finally get DisplayPort output
working on our board.

-michael

--bd03c224a37c17e60929764b4547fa19bcf92c44aa38a8278f30359b2966
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZo+ktxEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+IKuAX91bBhsZ9n70IFStgrv2BIU/wzvYey5zSMd
wdN4kUkgilUQZFMEdQBBI9Rre4soOOABgKV3nro9rwqC5Qu3/YjtsfR4y9YZMmWS
dVPja70ZNJ1cDuh4I+gD19+V0Q4xPsz6ZQ==
=B681
-----END PGP SIGNATURE-----

--bd03c224a37c17e60929764b4547fa19bcf92c44aa38a8278f30359b2966--

