Return-Path: <linux-kernel+bounces-441028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2368F9EC85D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1885518884CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BC81FA8FB;
	Wed, 11 Dec 2024 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlcB/ZRc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC51FA8C9;
	Wed, 11 Dec 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908022; cv=none; b=Vj4pCJH2N1reUg8NzvyPRWFzYNicwjEpTCn3pW68M6393xtInwFAjws6baWDGabSymlAIGkAjoaIrOQaYpWFVhONlsodHH+qCJ0nK0AefdPh6jpChUB01LSUJxirVz5BTYrUy43/pGeKpwJUDMCARtlyi0TQQrj6YZkyKUaIhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908022; c=relaxed/simple;
	bh=DiGUbD7xWdGFywNvLEFW1NGBQYsE/SozjDV/iopg888=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTZz0eQIv1fHEAv1zIxRoxLG1CBkDIQX47mznfBGfdZgdootns3qecGIbAsr3Z0/zQNUhJA5Yxuv9pxAu0f/VcNeTc4zwxnYz4+fH3ZWD447SxSZB+y02zM9DPpuLrISFJ2/KV/ftUn6Vz0oamaUxIEeYZ1pbkMc07LpE2JCsj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlcB/ZRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C1DC4CEE0;
	Wed, 11 Dec 2024 09:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733908021;
	bh=DiGUbD7xWdGFywNvLEFW1NGBQYsE/SozjDV/iopg888=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlcB/ZRcZbpjLdDUebZxf+cmjaVc5bPwsGUhWlfA8XJjphUyy8Z40dBOcAg5K/oDL
	 o5aRaOZ0ADHms6HUUgw52GuUdI2XOFk5fx/Emkfb0a1CwbDXyWNOixDTW3vMz/5P0d
	 MUCoHM+30GPRPbGsDTVH9K3QOJ0PwiKBqp/907t6Ovq9HUDdMSLCbC5VHKGJ5rh99A
	 BeQrteuMkW9VNzRzCM7lA7qBUa1DzBccgNW+AxTAMmQXgFS/27zrcHZYHpboy4JPf7
	 MDyVKEHjmlzeEsBrIesnDGZ2kaCTF0Vs5OZgQhGXy7F/AVrd1WumvmiN27zXzPA+4g
	 KoTEB6DENN3Zw==
Date: Wed, 11 Dec 2024 10:06:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, festevam@gmail.com, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, frank.li@nxp.com, aisheng.dong@nxp.com, daniel.baluta@gmail.com, 
	laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com, iuliana.prodan@nxp.com, 
	a.fatoum@pengutronix.de
Subject: Re: [PATCH v3 5/6] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for
 dsp
Message-ID: <l3z3mu5inmfc23v4mymtcb4gnzic5zupqfpcuk7vqeweluy5jn@c2b5ex4lkdgc>
References: <20241210125338.104959-1-daniel.baluta@nxp.com>
 <20241210125338.104959-6-daniel.baluta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210125338.104959-6-daniel.baluta@nxp.com>

On Tue, Dec 10, 2024 at 02:53:37PM +0200, Daniel Baluta wrote:
> Audio block control contains a set of registers some of them used for
> DSP configuration.
> 
> Drivers (rproc, SOF) are using fsl,dsp-ctrl property to access those
> registers in order to control the operations of the DSP (e.g for
> start, reset, etc).

This should have been implemented as reset controller, not syscon. It's
really poor choice to call everything syscon. It does not scale, does
not provide you runtime PM or probe ordering (device links). Quick look
at your drivers suggest that you have exacvtly that problems.

Best regards,
Krzysztof


