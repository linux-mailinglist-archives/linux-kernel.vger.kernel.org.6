Return-Path: <linux-kernel+bounces-361362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06699A738
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71D51F23F14
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0081194124;
	Fri, 11 Oct 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWYwKt36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B618E02D;
	Fri, 11 Oct 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659422; cv=none; b=PW57Ys0GZitbi9C8g7us1mN3PPGk0HnlbHWiM0g/UC9BcM3F1ZsxyqP1hZf0HqkJfom0CDp+bSfg/lRpWxIIBXH4JqvM/vPalne8km/8+mXDGIo1sv4WAgL8N7TK6N6tXbKiXYPU6N/ylVNH7P40L7fOuHCz14ItZZVEx2kmwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659422; c=relaxed/simple;
	bh=ZU2g8GXMhK2mCBChQNinMtGNp7JF9hb84Aw7s2vufK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0WL6mb0zyYNvvQ82bJduZED634smdpYuiDccS2Vc8Vvo/RfCvRqASRW8VDCgKQYkN7rjs8bGHL69M5R2e5zTb47knfya5lbiIdP/S4i2uedhUvB3JxgcR17rUZ98kebBLyvMUjjjlpZ2V80Q3keUR4GjBDlX7eJQGQSCv1GFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWYwKt36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCF6C4CEC3;
	Fri, 11 Oct 2024 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728659421;
	bh=ZU2g8GXMhK2mCBChQNinMtGNp7JF9hb84Aw7s2vufK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWYwKt360LCebFiMVhxFSos5SgFlwEij3Rm2bJZyUmn/QednxSeynRgsTiekX8tS6
	 BKYCRK4vWjduVTcU+cL+h/gJPEgHSdH8ZMLVge2sJxCvpJMiJqLNnUyJAVbXcZ5zoG
	 YumUduPP28Z3jsVgiYS1M1wuAPeJLxYDWOJotOfQECkQ4+q7ZLKpFz4QFVlqlHHisW
	 IOfg+YCEFK8NZftl6kngcvqe1guJK8nYj+C84/0hIfmb+PJyd3pBFl9bzUop+oUnoE
	 sJJQjXJJHikUCoKeDNXcuhXXWH690xNnXrF/oMqTPFcC2PjyEYyQ8yvpQfr9BJkY/z
	 x01GrBRNpWOVw==
Date: Fri, 11 Oct 2024 10:10:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: frank.li@nxp.com, aisheng.dong@nxp.com, linux-clk@vger.kernel.org,
	ye.li@nxp.com, linux-arm-kernel@lists.infradead.org,
	festevam@gmail.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
	mturquette@baylibre.com, shawnguo@kernel.org, abelvesa@kernel.org,
	conor+dt@kernel.org, ping.bai@nxp.com, linux-kernel@vger.kernel.org,
	s.hauer@pengutronix.de, sboyd@kernel.org, kernel@pengutronix.de,
	krzk+dt@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: Add i.MX91 clock support
Message-ID: <172865941878.2417451.3899149145187240529.robh@kernel.org>
References: <20241011045736.308338-1-pengfei.li_1@nxp.com>
 <20241011045736.308338-2-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011045736.308338-2-pengfei.li_1@nxp.com>


On Thu, 10 Oct 2024 21:57:34 -0700, Pengfei Li wrote:
> i.MX91 has similar Clock Control Module(CCM) design as i.MX93.
> Add a new compatible string for i.MX91.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


