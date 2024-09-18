Return-Path: <linux-kernel+bounces-332802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADFC97BF03
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C03283992
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBBF1C985B;
	Wed, 18 Sep 2024 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXjuTYUh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85C172BDE;
	Wed, 18 Sep 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726675996; cv=none; b=N9E5XVi6qBdqoz+gxQPHxTyTY/NtSsiUWp7d7VDdExJ1ey9loe5ipez01pbPzM/TI4DUnX6QLWS3ksSkp5Ngx8GEFKOI4j/L25cGon6N4CUdxzk8m/BQPzSiJL/PCEQSJa1uSiMqXyr8ZpxKht/Qudiq99th8kGlyWHuN4idevM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726675996; c=relaxed/simple;
	bh=u1M8MKMhNRnijK3CL3rzuoog41ZY0dXAPy6BCeSJHuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbJNsAzBX88Fk2lTgIQvYSpPQ0550uKAY2D2O3DDO/qQRA8p9uLlcPxYdOSTk2gBtV6B55U+vouLbcwcWmz4qKMFQW/4+6aD5m0LwprU4zu/cc66Skaz1LMR5WpF27v2znzrunEnVPV91HhqahNacHOGsJy9eSSnGIJ/HSRXF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXjuTYUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037A1C4CEC2;
	Wed, 18 Sep 2024 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726675996;
	bh=u1M8MKMhNRnijK3CL3rzuoog41ZY0dXAPy6BCeSJHuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXjuTYUhL39XIqyWFC6xLoXn/kV2acdLKv4EN70nhxn1/Tu8PVpFBkW1o0SrSjRD8
	 ssfGoU+P2JAJoNE381z+yBucS16enc6dSFRD4ScwfcQoSBNO0QWgxJvJxIYu0SiyvL
	 aPcXnilxSDV4Nvl1IDSjmNnJuTKK0Oxbfx8xMlIZkn4dStsIknMqASV4BOEE+lpZPb
	 G9tXWwgdtDeh9y3M55t/j8qq+2VfY6Ff7H3JHikb0Eds1XGK3kwDgV9UfNYJ93QlUR
	 lJJSED/eacD2nC1JiW3xdoOeqjDQsBzG675JbzuLHuyDdnYHkCimJ+icMYs2gYtRRc
	 rGEdCneZ8phXQ==
Date: Wed, 18 Sep 2024 11:13:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-clk@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Chuan Liu <chuan.liu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: clock: add Amlogic A5 peripherals clock
 controller
Message-ID: <172667599449.1714611.1180499286206997006.robh@kernel.org>
References: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
 <20240914-a5-clk-v1-3-5ee2c4f1b08c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914-a5-clk-v1-3-5ee2c4f1b08c@amlogic.com>


On Sat, 14 Sep 2024 13:25:25 +0800, Xianwei Zhao wrote:
> From: Chuan Liu <chuan.liu@amlogic.com>
> 
> Add the peripherals clock controller dt-bindings for Amlogic A5 SoC family.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../clock/amlogic,a5-peripherals-clkc.yaml         | 126 +++++++++++++++++++
>  .../clock/amlogic,a5-peripherals-clkc.h            | 139 +++++++++++++++++++++
>  2 files changed, 265 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


