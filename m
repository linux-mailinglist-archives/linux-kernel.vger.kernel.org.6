Return-Path: <linux-kernel+bounces-217359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BD590AEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F91C1C24CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADEC198857;
	Mon, 17 Jun 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKTzCiKT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508A19581F;
	Mon, 17 Jun 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629467; cv=none; b=L8aGzNQdPQRCozkQSC/PzBbGLjjBnXNef1fAgHW80UuGgxBcc5QTPrfBPdLLl+0udkT6ZkIo4I5tMrPffJcl42f7PSK2vXgkpJCTxhCgoIcNfGKNI5+dOGqXnbnZ6DKahbpdymYFiejh+1Dt4Sj2DcTsWEasRPGBcUmDQzVIWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629467; c=relaxed/simple;
	bh=+Bdh8xsBP73fuzL9slThefp5PjOqE0EOsDAMNdMjWrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAAZNQKy3FZ7TA8xkBLcBBVaRFtF7eYnHMr7Dt3NJIRqgNHGuDru0pZN2rFuXidqdj4NIZx1lkC7goxZrWXVX4qfwGQ19S7H8yQ9gRo1mghaF0ei6OLQbuIssuATnU+qHAXLqCUy/dkzWbarrCNeO+xDk/fVmsXbumoxZuV4tRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKTzCiKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5320C2BD10;
	Mon, 17 Jun 2024 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718629467;
	bh=+Bdh8xsBP73fuzL9slThefp5PjOqE0EOsDAMNdMjWrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKTzCiKT+QV6KxO1ZBWUsNbIfI+kqTNyofkRSgtmvIFuez3DAOLPtixy2o0iYPG6s
	 ty15QnWiCQLtV0YFAvic2b3vwvRkyfjTDWFfcEXv7fq9pUGh5sZtzK5TIPup3m3BvH
	 g6OME/AoF1geOrk5OfP9Uyw4Qdp1xRZ8e3F133o27FIKB24bmCVAQTvdtTb/cshPHb
	 32WTDRv7IlMt+pEn5b5PScLJiOSBYtg0CoZ+QpY2X94PX61hpw/Z+kanpGYEmGV97E
	 1Fp0JIb5OWkfaOLPv6Sc1o8bTNHLORtHZhjX1DAkXl1IrR9Rrnbb7rxAb06ap+ATP8
	 fFrie1YXb5heQ==
Date: Mon, 17 Jun 2024 14:04:22 +0100
From: Lee Jones <lee@kernel.org>
To: Kartik Agarwala <agarwala.kartik@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Mediatek MT6358 dt-binding documentation
 conversion and fixes
Message-ID: <20240617130422.GS3029315@google.com>
References: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>

On Mon, 17 Jun 2024, Kartik Agarwala wrote:

> The primary purpose behind this series is to convert the Mediatek
> MT6358 Audio Codec dt-binding documentation from txt to dt-schema.
> Additionally, it fixes the dts for some mediatek boards which were using
> this dt-binding but were missing the required `Avdd-supply` property.
> 
> I have also updated the parent PMIC txt documentation to 
> reference this binding. I have not added any new examples as the older
> example already has a codec node.
> 
> I have tested my patches against `mt8186-corsola-steelix-sku131072.dts`,
> `mt8186-corsola-steelix-sku131073.dts`, `mt8183-evb.dts`, and 
> `mt8183-pumpkin.dts`.
> 
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> To: Lee Jones <lee@kernel.org>
> Cc: linux-sound@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>

Please run your patches through scripts/checkpatch.pl.

-- 
Lee Jones [李琼斯]

