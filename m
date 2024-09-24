Return-Path: <linux-kernel+bounces-336908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00A984287
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515C2B267B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C260515382E;
	Tue, 24 Sep 2024 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFyUFJiC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9F15574F;
	Tue, 24 Sep 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170867; cv=none; b=bkAPFUUVEaOoLuzgYY3Gzx8E/x1PBqB1Dmg2af12Qu7feImiR3W/ZtdTUi2YPqa1FVFrMkFEyh3rdbESFhePUvPDTl/BcnPhviWFXZwr1k+EqjVrwpr39XVNBSPZq6Ir0vRqlFpYLm29SXpJOZBHJk8eE3r58xdxFQd7Ze4jbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170867; c=relaxed/simple;
	bh=9R/JeGA/tbNjcHBGgjfglgjkxBOJ7el7zfZvshWkQt4=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=IJXbFDgCK5UabZM1WQ2Iwo29WbAwhtGDvNdKeweHK3GI0XIRP9qPwijZDeA7WEP6YD9nemnLUT3aFrP/1+q4oVn904D+aHZvsDPJkEpVH81TLhV6o9RrXw5DHa60aP2ew56dmxpGsL7BQHJiWmIF0gKm2zyaT4sWcSniTIP9Cyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFyUFJiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE78C4CEC4;
	Tue, 24 Sep 2024 09:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727170866;
	bh=9R/JeGA/tbNjcHBGgjfglgjkxBOJ7el7zfZvshWkQt4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=sFyUFJiCVY1kqIuviL6F3RbN0r5ajQexdKXFZ4FrXsYJ5Ib7D5KIV+K1IfS8nr7mm
	 KZ+i+JKLl4cAu6BzG2uIP04AeKaMIMKZ80f+hbdNLpEhIU+uTz9qrnPY/KRB7JV9vr
	 PPilUygYW0bcjG1o1JMC8fcUpAcLAhLq2Qy11dH6H+a06sBcX8nUKe/MYXcXX3wKn/
	 yRONaDRJnBj2NSzWG05c0r9ZT19i6inklpqkzW9bpH8mQODa+1IvCeXXi8iEo2Vf2+
	 ME4xo9WrjExQ8kJ1bwyBWvjPj/AFNxS/d9YzEU3qzkstE4zxuLyYqa8dLN3R1lUZ56
	 tz/wJLeObopaQ==
Message-ID: <5c67dc9b6c0ef3942e933b4a0f7bb605@kernel.org>
Date: Tue, 24 Sep 2024 09:41:04 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Sandor Yu" <Sandor.yu@nxp.com>
Subject: Re: [PATCH v17 2/8] phy: Add HDMI configuration options
In-Reply-To: <c9c0c1c2e156731a46ffe0cfa3529e6f0e6a1e5f.1727159906.git.Sandor.yu@nxp.com>
References: <c9c0c1c2e156731a46ffe0cfa3529e6f0e6a1e5f.1727159906.git.Sandor.yu@nxp.com>
Cc: Laurent.pinchart@ideasonboard.com, Sandor.yu@nxp.com, airlied@gmail.com, alexander.stein@ew.tq-group.com, andrzej.hajda@intel.com, daniel@ffwll.ch, devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, festevam@gmail.com, jernej.skrabec@gmail.com, jonas@kwiboo.se, kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, mripard@kernel.org, neil.armstrong@linaro.org, oliver.brown@nxp.com, robh+dt@kernel.org, s.hauer@pengutronix.de, sam@ravnborg.org, shawnguo@kernel.org, vkoul@kernel.org, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 24 Sep 2024 15:36:47 +0800, Sandor Yu wrote:
> Allow HDMI PHYs to be configured through the generic
> functions through a custom structure added to the generic union.
> 
> The parameters added here are based on HDMI PHY
> implementation practices.  The current set of parameters
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

