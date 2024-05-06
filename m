Return-Path: <linux-kernel+bounces-169875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51768BCEC7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229571C21943
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715F17640D;
	Mon,  6 May 2024 13:17:42 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715761DA5F;
	Mon,  6 May 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001462; cv=none; b=XzPB6fzVyGRNYXc5KF4sEUdTVU9FOfIbivUQ+oAIfQvLVtBmknHEe30vWNjz+BB5aGXwTi/F2SGzwE8XOtGHr/yiQrJue1EI4ooLExerjsEnSZXiSvgp7p/918MLBTgoji43ZplmmKxkfd4fZa1CVyNGZtdUvUsbsltfO990jQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001462; c=relaxed/simple;
	bh=HIXTVl8kM/Ev/X0RFJHVrWc7b3X0LrMCQP132ExmKbQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=gzl6b8yzfF74EwkywOsCoPKoL9UUmXi2U5T2rNtFRUTk/a+7/dDgqbD9ewTgqjqU4qprKAroM6vc20761oxAGVX/K7rkTi8Fabn6qRTz74ja1dW5gxnzurcRa0yPFvRjJKhy6YjoDZDv3tpYYSo/2iY9VQBHRAFiDGraaXQtM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 267831A7;
	Mon,  6 May 2024 15:17:37 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 May 2024 15:17:36 +0200
Message-Id: <D12LA0QKEFRQ.68TZEVQZ7FJB@kernel.org>
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
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Alexandre Mergnat" <amergnat@baylibre.com>, <chunkuang.hu@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com> <1fc23530-89ba-4e36-9e9a-a1289f56a9bc@baylibre.com> <608fdbde-ad06-45ec-9771-18aa9f002f2d@collabora.com> <D12H4GDJJEUF.1Y91H9RMUIX20@kernel.org> <50be68dc-b86a-4334-9f83-43c6fda2c271@collabora.com> <1b8fa907-b48f-4ebe-bc17-3de1d7c0d062@collabora.com>
In-Reply-To: <1b8fa907-b48f-4ebe-bc17-3de1d7c0d062@collabora.com>

Hi Angelo,

On Mon May 6, 2024 at 1:22 PM CEST, AngeloGioacchino Del Regno wrote:
> > The problem with this is that you need DDP_COMPONENT_DRM_OVL_ADAPTOR...=
 which is
> > a software thing and not HW, so that can't be described in devicetree.
> >=20
> > The only thing this series won't deal with is exactly that.
>
> Sorry, no, I got confused.
>
> The series *does* already deal with that, as the pipeline is built before=
 the check
> for OVL_ADAPTOR components, so that will get probed.

Are you sure? Because who is actually adding the OVL_ADAPTOR to the
path? It looks like your patch will walk the graph and add all the
components according to their compatible string. And since the
OVL_ADAPTOR is virtual and doesn't have a node..

-michael

