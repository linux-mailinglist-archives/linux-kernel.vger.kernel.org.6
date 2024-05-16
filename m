Return-Path: <linux-kernel+bounces-180726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B48C7257
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF9C1F2261F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791C26AFAE;
	Thu, 16 May 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="n+nkw9AU"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC13E49E;
	Thu, 16 May 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846424; cv=none; b=B0UAMPdr/HDyMjCJv0QCCL31Ut5G5cuWbvTr6lNXDAJ7p12FaoRv5ypqn79zywMXgH+/ug/N9ZckWQe1WIo6soUijj9ABBV2MJjbq50SSuObDvUUzaPuILjDjJdtiLqjupitTgzE83Kgbxpm09/MNWZUbK+F1SE12Dks/rqZMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846424; c=relaxed/simple;
	bh=9fSy4m7IFndF9uPlgLMzNmbf3zpZNt6Zla356Zods3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIRhMcCT0+LEya2NtXDE0Wsz6i7VDXtzjWm4bXkviWbPCofTWGmPiFTv5aHUIw8fDrwRMIdDuePYi5/FPgOK2DJ06UxVoanwwjLJ78J1cG8hUCb+n/j0vMTxvjvbbrnntJU2yjwde4H7j/wXMj/fKKRhdD2DLloxsR8iLNe7r7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=n+nkw9AU; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 45FBB1FE67;
	Thu, 16 May 2024 10:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1715846412;
	bh=9fSy4m7IFndF9uPlgLMzNmbf3zpZNt6Zla356Zods3M=; h=From:To:Subject;
	b=n+nkw9AUM5/VtOoI5cQjhYrdvZeg+o0A7gGkxcIhCvOrI7FhHIsjyhu2ZDxeWZ4iK
	 GZddQ9LQ9gPmC9LSyzQ+x94ykLFujfn7/5UqTdcsgIS63ihY/nkhlCe13Tw9aPH8ZX
	 ETdzNUJw2WfEGqtXEHhaCbsSnuUbpnPa1QhIB76XBifsm/IEss1pDURLrQXGPijWUM
	 svVBqMGUtWe7RJnEp92Frdm2kn17hBbL/CPlzRDREw6XueEmVwNTXd6ru3Z0waS9at
	 zgEXSCtBp0Ioi0DgzVjX6d6hw1goyuJFzcuSZPpQtODJWOay8w96iXpkDpblsrr9Rs
	 uLinG5P8CcbmQ==
Date: Thu, 16 May 2024 10:00:08 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2
 and PDK3
Message-ID: <20240516080008.GA9338@francesco-nb>
References: <20240514010706.245874-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514010706.245874-1-marex@denx.de>

Hello Marek,

On Tue, May 14, 2024 at 03:06:42AM +0200, Marek Vasut wrote:
> Enable HDMI output on i.MX8MP DHCOM PDK2 and PDK3. The I2C5 on PDK2 and
> I2C mux port 1 on PDK3 respectively are used in regular I2C mode instead
> of HDMI DDC mode to permit connection of other I2C devices on those buses.

Are you able to read the HDMI EDID with such configuration? I have the
patch ready for verdin imx8mp, I just did not have time to figure out
this last details.

Francesco


