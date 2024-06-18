Return-Path: <linux-kernel+bounces-218452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A8290C00B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7EC2812BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FDDA3F;
	Tue, 18 Jun 2024 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="nTyZ13zS";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Bjy5q/OS"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96B360
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669103; cv=none; b=M1nIOvgbkTOGqjZsDFbUReUDTxlAQRirD4Wr3UjiAJIldyXFPZ+NtjTcxpPbpU9up1Y9UsyrsYMZTu8sfnCZpwlUmX2TD/54n8BR0HunUso0qtuvTPUVMb938HwmcwY6a1qW/lCrrVk3cPe8jWAdo++nK4tP6VACS47YKaUHtq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669103; c=relaxed/simple;
	bh=TKA2C043TkCUGXnV0SbvDBVxmP0XE7myxN4MUMYbCJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmyUycxwPRq1ISiQRUBCb60yno7+v52vNDhHCnJ7UD/5VwI1JLSrDlv+4ya3LwKRgQSfmG3vUyED6/0dljQ7fsNl1jEiYfm8yOC+IYhFCdgP507iNnME6oeGzIxEF7xV8SW2AtENAuzKqj3dU8ItExI6bencXIXZRESGfyPLUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=nTyZ13zS; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Bjy5q/OS; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1718669100;
	bh=TKA2C043TkCUGXnV0SbvDBVxmP0XE7myxN4MUMYbCJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTyZ13zSV1xy2D0V9wrmiHKETjbqBilxCREcL2+XF4LZGIszKOBc+6xQIoepxm2NU
	 War3Yf1tC30isr/EJJ+drTL4yCvYyglbq89o4nMbAzOmx6dSd7BIsRthjyWzjD4ZQP
	 ax6HpXMdhtGbzepPoF1VSn+9BS9CHQUYtLD6oOX2uDKH2Fe1/i7F9kseX6icwctATp
	 /xSR2Nm4TR4fpi5O7lgSMSn3HkYYt9A5nUvg1mlTLSGL2l5dVQRnwVO8b77X2sNKbc
	 9zew8da/RIuaBFki0aKrrXVgy0G0BQ+pObc+s8C1nBV6gkn4z9lA5BGDCsLVCj4s3z
	 jR3bIvPmsYK1A==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 8FEE96FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:05:00 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=Bjy5q/OS;
	dkim-atps=neutral
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 39B66A77
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:04:58 +0900 (JST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6e79f0ff303so3974988a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1718669097; x=1719273897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Xe63nUyIwv36+7xnvrOAI6BQO79Yhtze7l/OyxIXbI=;
        b=Bjy5q/OSbvSdTaZr2ccDxrZ86X+tiKPw2hmirohXgU6T3c6wKLBGdMQ2eVs5okpGj0
         YuMDnZDSaOgnC8ehzVN6tWxR/yy54jj7wLYZ9Dm1607Src3FVDesbaGwc0E9UPr5Scg7
         WalwhrO9o+AQnxzPk52Yywxf/w7BlbwR+5Ab12p+IPOLv1Fk+CqlTkBf0YpHcaGsrTe2
         ZLL5LQMC4VcG7/TZaxLa7yJoeoSve10d4Ijap9Lovm/Vajz2izuWyLlRZIA6UmNLLfRU
         NRh0UIyS0VUR8IyTuFCjB96scY3YmcP1Jy35Y1sUQDFORetg1CNNAFcWt/dTwAkM9aMw
         8W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718669097; x=1719273897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Xe63nUyIwv36+7xnvrOAI6BQO79Yhtze7l/OyxIXbI=;
        b=t6tGN+lD9baiM1rewRtV8FH8ydaGA+UbHshOTPDaT5AVwioL4Axhhh8qJ/kkWB4NdA
         Yv6Sfk6wzLRNrLnCfV6WCCbxf0m/OvVuGlGUqsb3S0ahlCY04PKjTFSpLmTklnZ4D4wn
         ApLsErppwT0laU1HD+nX2nLKGQM1plGGsDue2VfzYz8zaMCJ1e/N2t8RGDoBgs0wJOTm
         K31L7RG2gtlHPxDMHyU1t80muF+UhSbcvZeVZAvFgkkknEWxrY26BWTh2eHk9Wva9VuF
         zOsysgPxX8L0caZ1UZ6sdkiYl4bHigyZO2f2iRQ7qW0xnGSZHm2jSLVzbSxgMBA8StKW
         1n8A==
X-Forwarded-Encrypted: i=1; AJvYcCWsfsej0bsuatNea5ANOCy2D+kmw2tqaimAQ1Z1hnsbSHecLFIjchD7aFSFjz6X4I1Q+q84fJPisf791MwuH7tLvKUynMacCH1E9r4u
X-Gm-Message-State: AOJu0Yx4CLqhUgPdoY/BMZqcI47shOWf58q0qYFlRzqdVuSds5d8Dp1p
	261kfA4EJWE69EuWAAsc03SMaK8HY77860ORyX4/i2WaelhSa3NnJyfSCnOwJCaBSu/Tof4mP6J
	M7oIo2C1HXPZFlYcXgUcGMnsS+vcJ8DoU7EEADlv/SNUxCtkWRZTj6zNRL+UrKbU=
X-Received: by 2002:a05:6a20:7344:b0:1b0:1a02:4136 with SMTP id adf61e73a8af0-1bae7e28efcmr12053011637.8.1718669097079;
        Mon, 17 Jun 2024 17:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaJwsOB5qRcAEyY5B6LLeGzmT4mUY+ApOshTQERXeBYQ+t83Lc16Ao0Q3gXge9N9DbP6gkbw==
X-Received: by 2002:a05:6a20:7344:b0:1b0:1a02:4136 with SMTP id adf61e73a8af0-1bae7e28efcmr12052978637.8.1718669096600;
        Mon, 17 Jun 2024 17:04:56 -0700 (PDT)
Received: from pc-0182.atmarktech (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a7602690sm11894540a91.28.2024.06.17.17.04.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2024 17:04:56 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1sJMLG-00ACZX-1h;
	Tue, 18 Jun 2024 09:04:54 +0900
Date: Tue, 18 Jun 2024 09:04:44 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: Re: drm/bridge/imx8mp-hdmi-tx: Allow inexact pixel clock frequencies
 (Was: [PATCH V8 10/12] drm/bridge: imx: add bridge wrapper driver for
 i.MX8MP DWC HDMI)
Message-ID: <ZnDPHN_sSaWR7KKp@atmark-techno.com>
References: <22a3f5266260dd3915269ae3eec7724f7537eb55.camel@pengutronix.de>
 <CAHCN7xJt+1WGFYeBii1jUDEg9OU176f0AA+rMkXCqNQrfq=XWg@mail.gmail.com>
 <ZnDKovBokBu5D_eb@atmark-techno.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnDKovBokBu5D_eb@atmark-techno.com>

Dominique MARTINET wrote on Tue, Jun 18, 2024 at 08:45:38AM +0900:
> I'm thinking the last few values just affect a very small % of the
> values, but would need to check with a proper scope if I can get a hold
> of the clock line...
> Does any of you happen to have any datasheet for these registers,
> or should we consider them to be magic values?

Answering to myself on this point, the registers are properly described
in the iMX8MP reference manual...
I don't make much sense of it at this point (what's SDC..?), but I guess
it does sound likely we could generate the values with some work.

I'll wait for replies a bit first in case one of you understands this
better than I (which is quite likely!), but can give this a few more
hours to help.

-- 
Dominique



