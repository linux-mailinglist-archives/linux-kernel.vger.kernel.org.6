Return-Path: <linux-kernel+bounces-169633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE29A8BCB87
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938721F2250F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD664142652;
	Mon,  6 May 2024 10:02:21 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194D4205F;
	Mon,  6 May 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989741; cv=none; b=N/Wgl1YXy/J46K3ufDvTANajMjJjeNMRq69DGOCSp+KJAc1LZ2tdsrG1DP4uRuh0DxYmf2+5qOGw7wvnuyGc7aBPf8cUjuLxYzp+Xz+k8AC1/CJUS6qnu4t1YS6fJrpEG7fmuHfPghJKEZ9NCFGq+QX6Mr6gZKQG4NkPPtE3KRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989741; c=relaxed/simple;
	bh=tcun4FHi8g+Dt8Q+5L+loMgKaWMENI5jp4Gw+JI3jMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=ls98F+Q08x2COT8MfdiNBc9GJ5ZgPEuFFwc1r9lgOZNvqJhZ/eYCMxh6zAHbraXF+0udvVhBBZEv9WV4pUHXyCziz80OXIrXw9VEPJci7msq5grUzsLZdeQZYtuZFbj1HuXYlt+gcdzxLbEKZSxFZAO/krXAi2McXE23/oZYjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 9D9976F4;
	Mon,  6 May 2024 12:02:16 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 May 2024 12:02:16 +0200
Message-Id: <D12H4GDJJEUF.1Y91H9RMUIX20@kernel.org>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Alexandre Mergnat" <amergnat@baylibre.com>, <chunkuang.hu@kernel.org>
Subject: Re: [PATCH v2 0/3] drm/mediatek: Add support for OF graphs
Cc: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
 <daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <matthias.bgg@gmail.com>,
 <shawn.sung@mediatek.com>, <yu-chang.lee@mediatek.com>,
 <ck.hu@mediatek.com>, <jitao.shi@mediatek.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <wenst@chromium.org>,
 <kernel@collabora.com>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com> <1fc23530-89ba-4e36-9e9a-a1289f56a9bc@baylibre.com> <608fdbde-ad06-45ec-9771-18aa9f002f2d@collabora.com>
In-Reply-To: <608fdbde-ad06-45ec-9771-18aa9f002f2d@collabora.com>

Hi Angelo,

On Tue Apr 30, 2024 at 1:33 PM CEST, AngeloGioacchino Del Regno wrote:
> >> This series was tested on MT8195 Cherry Tomato and on MT8395 Radxa
> >> NIO-12L with both hardcoded paths, OF graph support and partially
> >> hardcoded paths (meaning main display through OF graph and external
> >> display hardcoded, because of OVL_ADAPTOR).
> >=20
> > Is that make sense for you to add the DTS changes of these boards into =
this serie ?
> > I asked because, IMHO, that could help to understand the serie.
> >=20
>
> Yes and no... but I imagine that you're asking this because you're trying=
 to
> prepare something with a different SoC+board(s) combination :-)
>
> In that case, I'm preventively sorry because what follows here is not 100=
%
> perfectly tidy yet as I didn't mean to send the devicetree commits upstre=
am
> before this series got picked....
>
> ... but there you go - I'm sure that you won't mind and that the example =
will
> be more than good enough for you.

I've tested this series with the DSI0 output and it works. Nice! No
need for my DSI0 patch for the MT8395 anymore.

But I can't get it to work with the DisplayPort output, that is the
dp_intf1/dp_tx interface. I don' know how the pipeline have to look
like. The functional spec seems to be ambiguous on this. The text
seem to refer to the second vdosys but there is also a diagram where
you can use the first vdosys and dsc0. If you have any pointers for
me, I'm all ears :)

-michael

