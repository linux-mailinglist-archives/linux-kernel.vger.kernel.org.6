Return-Path: <linux-kernel+bounces-440502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C63BA9EBF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A3A188979C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6A01F1934;
	Tue, 10 Dec 2024 23:16:22 +0000 (UTC)
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8F1CF7B8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872582; cv=none; b=ZxSXAT28ZyyUwXkxIsB8ZB3y/9oJXThiw1BEjMBIkJAsHmWj+qT1tbazD5O33TxD+aOdhNKBGDTbh47VAkXJEg9raBZxtCEp+L1iulqcENwOjYKCP1Ym7omOparP5hBU7gtlSqZRz5rORIlpQ/NyeRnAaiCN6pf5J0McCOExIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872582; c=relaxed/simple;
	bh=dfvK1PSJB+t7ksWSGvsN4NAaxU4zxU4s5270skPdnhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4YWkat1tKffuz4bDNBRDs9AtqF1QKhAuLpanclMNE4hmS7y/iAoYlB7QtzuAibL0HmdLRjHFMnG+AP6SUPRS6ydqhrE7iv+9rJ0USHclon1RbkNpJA5RTPT616Or4CuSRibLWQEjFd5rpTXpeOq7g6YdVfiQ+k+Be9JwFg07I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1DE241F983;
	Tue, 10 Dec 2024 23:21:19 +0100 (CET)
Date: Tue, 10 Dec 2024 23:21:17 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Mahadevan <quic_mahap@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] dt-bindings: msm/dp: add support for pixel clock to
 driver another stream
Message-ID: <56n4r7p63dtzjpafe5wdljwhlkhzahbct5tsocegivvhop4f6a@65pmfavnyqga>
References: <20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com>

On 2024-12-02 19:31:38, Abhinav Kumar wrote:
> On some MSM chipsets, the display port controller is capable of supporting
> two streams. To drive the second stream, the pixel clock for the corresponding
> stream needs to be enabled. In order to add the bindings for the pixel clock
> for the second stream, fixup the documentation of some of the bindings to
> clarify exactly which stream they correspond to, then add the new bindings.
> 
> In addition, to help out with reviews for dp-controller bindings, add myself
> as the maintainter.
> 
> This change was made on top of [1] which fixes a warning on the sa8775p
> bindings.
> 
> [1]: https://patchwork.freedesktop.org/patch/624068/
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> Abhinav Kumar (4):
>       dt-bindings: display: msm: dp-controller: document pixel clock stream
>       dt-bindings: display: msm: dp-controller: document clock parents better
>       dt-bindings: display/msm: add stream 1 pixel clock binding
>       dt-bindings: display: msm: dp: update maintainer entry

Simple nit: any reason why the third patch uses display/msm as subject prefix
while the other 3 patches separate with a colon and space?

- Marijn

>  .../bindings/display/msm/dp-controller.yaml        | 41 +++++++++++++++++++---
>  .../bindings/display/msm/qcom,sa8775p-mdss.yaml    |  9 +++--
>  2 files changed, 43 insertions(+), 7 deletions(-)
> ---
> base-commit: 798bb342e0416d846cf67f4725a3428f39bfb96b
> change-id: 20241202-dp_mst_bindings-7536ffc9ae2f
> 
> Best regards,
> -- 
> Abhinav Kumar <quic_abhinavk@quicinc.com>
> 

