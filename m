Return-Path: <linux-kernel+bounces-281215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF994D468
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6862B1C2148B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702B2199380;
	Fri,  9 Aug 2024 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="UBELDXMH"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A63195F3A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220137; cv=none; b=UZB8aMfuwjcEZQoA53QxSIfjipkaBlT7FkGOLZnSu54STVuvzOoXTy/2VwdqUtfYRdwmODCSjiaig9Nbwrp8962mT+jHSbM+/pJcIjMGBpjy9WfE+yNn8rq5G8E3BspV4mbXSWIchPBuLzTnoww3C6WV1//5hp4ePU7Rw+uQq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220137; c=relaxed/simple;
	bh=VY9PE4eNE3Cxi3PC17boS00P/McmC5FaF7A8/yRTI/o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b8zVt4ERqBmcz4NsnFyJRTZGVH4yR9qeiYQJGyF5brO9Z3/Xsc2IoGv4gyJ5oxZ9XLDqVyMw63xxQ3iM8DX6IIXPwwEle+Q4+Pq5LbTHcU/oeEEd+ednbvVxW4Tq739BeJYTXktKpQyN2gkrTJLhyROvrvhu3dhhP6tDVFb9/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=UBELDXMH; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1723220133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3YQIqktxBdIIFcqZSYtEeGTQLWBvWkluBpPpmvl0vg=;
	b=UBELDXMHEVD1RfSvFdKIkTjpCItyWakTtX5Z53T/zPISvy16mn7htlKDEcNLyZzhXu/xHI
	FGcvlipRygRa2W8z5Q7TznppW3G0GWaa2nibUdFaR8B4YkIZSM2bY0ywHHfoR8Kzn6mer7
	+Z7e2ZHHP6TwqDIDzn9b9zV+gGAs8AbI8nyUJ5tJsMM14EHrKNXzXPHLyPkdiUB9rF4N52
	ooTxBx4S0Nt+uZnWbw08kkkRkNrW/++UNB1HnxHPgTYdur3+BG4Fnw2CyuzVYM8Y6avAub
	VTwO2//R2JneUuEiWUiY4yosVEu4HgxQD0LwpmRAo9kP+u6VnRFc9l1fZxr/iw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Aug 2024 18:15:26 +0200
Message-Id: <D3BIJXIKYD7N.238B8AE16Y5AI@cknow.org>
Cc: "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Elaine Zhang" <zhangqing@rock-chips.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <kernel@collabora.com>, "Sugar Zhang"
 <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: Add rk3576 reset definitions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Detlev Casanova" <detlev.casanova@collabora.com>,
 <linux-kernel@vger.kernel.org>
References: <20240809125553.3889-1-detlev.casanova@collabora.com>
 <20240809125553.3889-2-detlev.casanova@collabora.com>
In-Reply-To: <20240809125553.3889-2-detlev.casanova@collabora.com>
X-Migadu-Flow: FLOW_OUT

On Fri Aug 9, 2024 at 2:54 PM CEST, Detlev Casanova wrote:
> Add reset ID defines for rk3576.
>
> Compared to the downstream bindings this uses continous gapless
> reset IDs starting at 1 instead of register offsets as IDs, as
> introduced in the RK3588 bindings.
> ...
> ---
>  .../dt-bindings/reset/rockchip,rk3576-cru.h   | 564 ++++++++++++++++++
>  1 file changed, 564 insertions(+)
>  create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h
>
> diff --git a/include/dt-bindings/reset/rockchip,rk3576-cru.h b/include/dt=
-bindings/reset/rockchip,rk3576-cru.h
> new file mode 100644
> index 0000000000000..8c968af4888d5
> --- /dev/null
> +++ b/include/dt-bindings/reset/rockchip,rk3576-cru.h
> @@ -0,0 +1,564 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> + ...
> +
> +#ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3576_H
> +#define _DT_BINDINGS_RESET_ROCKCHIP_RK3576_H
> +
> +#define SRST_A_TOP_BIU			0
> +#define SRST_P_TOP_BIU			1

As requested you renumbered starting from '0', but the commit message
mentions "starting at 1". Same for patch 2 of this series.

