Return-Path: <linux-kernel+bounces-437098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7819D9E8F22
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36ECF280C36
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCECE2165E2;
	Mon,  9 Dec 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhtR2TC0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E621638B;
	Mon,  9 Dec 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737747; cv=none; b=X32pdNalN7RbJd0JECItVGJGn4OMWYdGe2WzQj7sE1nNrNeJsPHuTJM6SoLfMLuu/75hEp0py4ObOTxYkqkhTkZ1daDeB/gNkQrj70h+V06t0WZOSqNrzQKHBRUj5rie8uC90Ze+J+MMXvUJ6lGGGDrPbVtjzBBfsPg+EMcGeDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737747; c=relaxed/simple;
	bh=y43p1uapSXC5fw7JnaqXHM4i71jrvsqwiDGw3bHTA2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeiscPIsjfi+e23l/BWMqQZa6gEvf0I+Gxp6mNa3F0qa6QgB98Ula1CzFHl1lE9e/yIf2xhSPDJ50UQMRhUCnhE47Fn2579jkxsbKJyLFWxxzfO6rHhzQr+wDbpI+fIzgpFWomP6KMEnP0KkUCIz4LAulACLG+YT2wFdIamUKso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhtR2TC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31B8C4CED1;
	Mon,  9 Dec 2024 09:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737746;
	bh=y43p1uapSXC5fw7JnaqXHM4i71jrvsqwiDGw3bHTA2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhtR2TC0vGiWpVSG8A097r4XibOSL4QZQ5XbNoI0MtPIYnb8DsbqX7nfOt7/FgKN+
	 +fFfWrFCmNKkBX+6W4V4trV1JxrqKKW4h79PaD+58P3Pz3ykbxtdGgYOoUiI8XgBQY
	 9f8E1EFlAFVJ7o6u0SDu1yO9F3XFZekcP9k67Os+L/f+a6x/MOYwQLflHToYbWC7Fq
	 SNYqL0RTPfrTZyPCs6PvFApCtCstKB9fYfHvjWiVJ6qvfQoemXOK77P8O/SF/Et+OK
	 bbdfUtdEiyMxQ+aRuWe6u7LZvsSJpMxLi9mDq7phcfJYuiaTPHF6WEhhBwA9cYfdWI
	 TU7K4YHRYO3Gw==
Date: Mon, 9 Dec 2024 10:49:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>, kernel@collabora.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 compatible for mt8390 evk
Message-ID: <mycrs2ekxznwcxkvthamvszftrt5t66shvopn5xpuhaldtsb4g@qv2kpx6yt2mv>
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
 <20241205-genio700-audio-output-v1-2-0e955c78c29e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241205-genio700-audio-output-v1-2-0e955c78c29e@collabora.com>

On Thu, Dec 05, 2024 at 09:13:55AM -0300, N=C3=ADcolas F. R. A. Prado wrote:
> Add a compatible for the MT8390 EVK. It is compatible with
> mediatek,mt8188-mt6359-evb so make that the fallback compatible.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml  | 14 ++++++++=
+-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


